#!/usr/bin/env node
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createClient } from '@supabase/supabase-js';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');

function loadEnv() {
  const env = {};
  for (const line of readFileSync(resolve(root, '.env'), 'utf8').split('\n')) {
    const m = line.match(/^([A-Z0-9_]+)=(.*)$/);
    if (m) env[m[1]] = m[2].replace(/^['"]|['"]$/g, '');
  }
  return env;
}

const env = loadEnv();
const supabase = createClient(env.PUBLIC_SUPABASE_URL, env.PUBLIC_SUPABASE_ANON_KEY, {
  db: { schema: 'public' }
});

const QUESTIONS = [
  'Manakah pernyataan yang benar?',
  'Berdasarkan artikel ini, pernyataan manakah yang benar?',
  'Pernyataan manakah yang sesuai dengan isi artikel?'
];

const SENT_LEN_MIN = 30;
const SENT_LEN_MAX = 150;

function shuffle(arr) {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

function factBlocks(content) {
  if (!Array.isArray(content)) return [];
  return content
    .filter((b) => b.type === 'fact' && b.data?.text?.trim())
    .map((b) => b.data.text.trim());
}

function statements(content) {
  if (!Array.isArray(content)) return [];
  const out = [];
  for (const b of content) {
    if (b.type === 'fact' && b.data?.text?.trim()) out.push(b.data.text.trim());
    else if (b.type === 'paragraph' && b.data?.text?.trim()) {
      const text = b.data.text.trim();
      for (const s of text.split(/(?<=[.!?])\s+/)) {
        const t = s.trim();
        if (t.length >= SENT_LEN_MIN && t.length <= SENT_LEN_MAX) out.push(t);
      }
    } else if (b.type === 'list' && Array.isArray(b.data?.items)) {
      for (const item of b.data.items) {
        const t = String(item).trim();
        if (t.length >= SENT_LEN_MIN && t.length <= SENT_LEN_MAX) out.push(t);
      }
    }
  }
  return out;
}

async function main() {
  const { data: articles, error: errA } = await supabase
    .from('articles')
    .select('id, title, slug, content')
    .eq('status', 'PUBLISHED');
  if (errA) throw new Error(`gagal ambil artikel: ${errA.message}`);

  const { data: quizzes, error: errQ } = await supabase
    .from('quizzes')
    .select('id, article_id, title');
  if (errQ) throw new Error(`gagal ambil kuis: ${errQ.message}`);

  mkdirSync(resolve(root, 'scripts/data'), { recursive: true });
  writeFileSync(
    resolve(root, 'scripts/data/articles.json'),
    JSON.stringify(articles, null, 2)
  );

  const quizByArticle = new Set(quizzes.filter((q) => q.article_id).map((q) => q.article_id));
  const missing = articles.filter((a) => !quizByArticle.has(a.id));

  const pool = articles.flatMap((a) => statements(a.content));
  const rows = [];

  for (const a of missing) {
    const s = [...new Set(statements(a.content))].slice(0, QUESTIONS.length);
    if (s.length < 3) continue;

    const qs = s.map((stmt, i) => {
      const distractors = shuffle(pool.filter((f) => f !== stmt))
        .slice(0, 3)
        .map((f) => f.slice(0, 120));
      const options = shuffle([stmt, ...distractors]).map((label, pos) => ({
        label: label.slice(0, 120),
        is_correct: label === stmt,
        position: pos + 1
      }));
      return { question: QUESTIONS[i % QUESTIONS.length], options };
    });

    rows.push({ slug: a.slug, title: a.title, questions: qs });
  }

  const lines = [
    '-- ==========================================================',
    '-- KUIS OTOMATIS untuk artikel yang belum punya kuis',
    `-- Di-generasi ${new Date().toISOString()} oleh scripts/generate-quizzes.mjs`,
    '-- Jalankan di Supabase SQL Editor (idempoten, on conflict do nothing).',
    '-- ==========================================================',
    ''
  ];

  for (const r of rows) {
    lines.push(`insert into public.quizzes (title, description, article_id)`);
    lines.push(`  values (${sql(r.title)}, 'Tanya jawab seputar artikel ini.',`);
    lines.push(`    (select id from public.articles where slug = '${r.slug}'))`);
    lines.push(`on conflict (title) do nothing;`);
    lines.push('');
    lines.push(`insert into public.quiz_questions (quiz_id, question, position)`);
    lines.push(`select q.id, x.question, x.position`);
    lines.push(`from public.quizzes q`);
    lines.push(`cross join (values`);
    r.questions.forEach((q, i) => {
      lines.push(`  (${i + 1}, ${sql(q.question)})${i < r.questions.length - 1 ? ',' : ''}`);
    });
    lines.push(`) as x(position, question)`);
    lines.push(`where q.article_id = (select id from public.articles where slug = '${r.slug}')`);
    lines.push(`on conflict (quiz_id, position) do nothing;`);
    lines.push('');
    lines.push(`insert into public.quiz_options (question_id, label, is_correct, position)`);
    lines.push(`select qq.id, x.label, x.is_correct, x.position`);
    lines.push(`from public.quiz_questions qq`);
    lines.push(`join public.quizzes q on q.id = qq.quiz_id`);
    lines.push(`cross join (values`);
    r.questions.forEach((q, qi) => {
      q.options.forEach((o, oi) => {
        lines.push(
          `  (${qi + 1}, ${sql(o.label)}, ${o.is_correct ? 'true' : 'false'}, ${o.position})` +
            (qi === r.questions.length - 1 && oi === q.options.length - 1 ? '' : ',')
        );
      });
    });
    lines.push(`) as x(qposition, label, is_correct, position)`);
    lines.push(`where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = '${r.slug}')`);
    lines.push(`on conflict (question_id, position) do nothing;`);
    lines.push('');
  }

  const out = resolve(root, 'docs/quizzes_generated.sql');
  writeFileSync(out, lines.join('\n'));

  for (const r of rows) {
    if (r.questions.length !== 3) throw new Error(`kuis ${r.slug}: jumlah soal ${r.questions.length} != 3`);
    for (const q of r.questions) {
      if (q.options.length !== 4) throw new Error(`soal "${q.question}" (${r.slug}): opsi ${q.options.length} != 4`);
      const correct = q.options.filter((o) => o.is_correct);
      if (correct.length !== 1) throw new Error(`soal "${q.question}" (${r.slug}): benar ${correct.length} != 1`);
    }
  }

  console.log(`artikel: ${articles.length} | sudah ada kuis: ${articles.length - missing.length} | belum: ${missing.length}`);
  console.log(`fakta < 3 (dilewati): ${missing.length - rows.length} | kuis dibuat: ${rows.length}`);
  console.log(`SQL  : ${out}`);
  console.log(`JSON : ${resolve(root, 'scripts/data/articles.json')}`);
}

function sql(s) {
  return `'${s.replace(/'/g, "''")}'`;
}

main().catch((e) => {
  console.error(e.message);
  process.exit(1);
});
