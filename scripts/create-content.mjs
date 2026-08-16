#!/usr/bin/env node
// 1 API untuk insert konten baru: artikel + sekejap fakta + kuis (dengan soal & opsi).
// Pakai:
//   node scripts/create-content.mjs [path-ke-spec.json]
// Spec default: scripts/content/new.json
// Butuh SUPABASE_SERVICE_ROLE_KEY di .env (Project Settings > API > service_role).
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
if (!env.SUPABASE_SERVICE_ROLE_KEY) {
  console.error('SUPABASE_SERVICE_ROLE_KEY tidak ada di .env');
  console.error('Isi dari Supabase: Project Settings > API > service_role (JANGAN di-commit).');
  process.exit(1);
}

const supabase = createClient(env.PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY, {
  db: { schema: 'public' }
});

function slugify(s) {
  return s
    .toLowerCase()
    .replace(/[^a-z0-9\s-]/g, '')
    .trim()
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .slice(0, 80);
}

async function main() {
  const specPath = resolve(root, process.argv[2] ?? 'scripts/content/new.json');
  const spec = JSON.parse(readFileSync(specPath, 'utf8'));

  const { data: cat } = await supabase.from('categories').select('id').eq('slug', spec.category).maybeSingle();
  if (!cat) throw new Error(`kategori '${spec.category}' tidak ditemukan`);

  const slug = spec.slug || slugify(spec.title);
  const { data: dup } = await supabase.from('articles').select('id, slug').eq('slug', slug).maybeSingle();
  if (dup) throw new Error(`artikel dengan slug '${slug}' sudah ada (id ${dup.id}) — pindahkan spec lalu jalankan lagi`);

  const { data: article, error: errArt } = await supabase
    .from('articles')
    .insert({
      author_name: spec.author_name ?? 'Sekta',
      category_id: cat.id,
      title: spec.title,
      slug,
      excerpt: spec.excerpt ?? '',
      cover_image: spec.cover_image ?? '',
      content: spec.content ?? [],
      read_time_minutes: spec.read_time_minutes ?? Math.max(1, Math.round((spec.content?.length ?? 4) / 3)),
      status: spec.status ?? 'PUBLISHED',
      published_at: new Date().toISOString()
    })
    .select('id')
    .single();
  if (errArt) throw new Error(`gagal insert artikel: ${errArt.message}`);
  const articleId = article.id;
  console.log(`✔ artikel  : ${slug} (id ${articleId})`);

  if (spec.sources?.length) {
    const { error: errSrc } = await supabase.from('sources').insert(
      spec.sources.map((s) => ({ article_id: articleId, title: s.title, url: s.url ?? '', publisher: s.publisher ?? '' }))
    );
    if (errSrc) throw new Error(`gagal insert sumber: ${errSrc.message}`);
    console.log(`✔ sumber   : ${spec.sources.length}`);
  }

  if (spec.fact) {
    const { error: errFact } = await supabase.from('sekejap_facts').insert({
      fact: spec.fact,
      article_id: articleId
    });
    if (errFact) throw new Error(`gagal insert fakta: ${errFact.message}`);
    console.log(`✔ fakta    : "${spec.fact.slice(0, 50)}..."`);
  }

  if (spec.quiz) {
    const q = spec.quiz;
    const { data: quiz, error: errQuiz } = await supabase
      .from('quizzes')
      .insert({ article_id: articleId, title: q.title ?? spec.title, description: q.description ?? '' })
      .select('id')
      .single();
    if (errQuiz) throw new Error(`gagal insert kuis: ${errQuiz.message}`);

    for (let i = 0; i < q.questions.length; i++) {
      const qq = q.questions[i];
      const { data: qrow, error: errQ } = await supabase
        .from('quiz_questions')
        .insert({ quiz_id: quiz.id, question: qq.question, position: i + 1 })
        .select('id')
        .single();
      if (errQ) throw new Error(`gagal insert soal ${i + 1}: ${errQ.message}`);
      const correct = qq.options.filter((o) => o.is_correct).length;
      if (correct !== 1) throw new Error(`soal "${qq.question}": harus tepat 1 opsi benar (ada ${correct})`);
      const { error: errO } = await supabase.from('quiz_options').insert(
        qq.options.map((o, j) => ({ question_id: qrow.id, label: o.label, is_correct: o.is_correct, position: j + 1 }))
      );
      if (errO) throw new Error(`gagal insert opsi soal ${i + 1}: ${errO.message}`);
    }
    console.log(`✔ kuis     : ${q.questions.length} soal (id ${quiz.id})`);
  }

  // Self-check
  const { count: artCount } = await supabase.from('articles').select('*', { count: 'exact', head: true }).eq('id', articleId);
  const { count: quizCount } = await supabase.from('quizzes').select('*', { count: 'exact', head: true }).eq('article_id', articleId);
  if (artCount !== 1) throw new Error('self-check gagal: artikel tidak ditemukan');
  if (spec.quiz && quizCount !== 1) throw new Error('self-check gagal: kuis tidak ditemukan');

  mkdirSync(dirname(specPath), { recursive: true });
  writeFileSync(resolve(root, `scripts/content/done-${slug}.json`), JSON.stringify({ ...spec, slug }, null, 2));
  console.log(`\nSelesai! Lihat di ${env.PUBLIC_SUPABASE_URL} dan https://sekta.my.id/article/${slug}`);
}

main().catch((e) => {
  console.error(`✖ ${e.message}`);
  process.exit(1);
});
