// Seed: 5 artikel kemerdekaan Indonesia (bahasa ramah anak) + kuis + fakta.
// Insert via service role, lalu tulis docs/seed-5-artikel-kemerdekaan.sql (idempoten).
import { createClient } from '@supabase/supabase-js';
import { writeFileSync } from 'node:fs';

const URL = 'https://ynhfcdbbhhsjnynynddd.supabase.co';
const SERVICE = process.env.SUPABASE_SERVICE_ROLE_KEY;
const sb = createClient(URL, SERVICE);

const ARTICLES = [
  {
    title: 'Cerita Proklamasi: Hari Indonesia Mengucapkan "Merdeka!"',
    slug: 'proklamasi-kemerdekaan-indonesia',
    excerpt: 'Tanggal 17 Agustus 1945, Indonesia menyatakan merdeka. Ini cerita singkatnya untukmu.',
    category: 'sejarah',
    imgKeyword: 'proclamation of independence indonesia',
    blocks: [
      { t: 'paragraph', text: 'Setiap tanggal 17 Agustus, seluruh Indonesia merayakan hari kemerdekaan. Tapi tahukah kamu apa yang terjadi pertama kali saat Indonesia menyatakan merdeka?' },
      { t: 'heading', text: 'Pagi Hari yang Bersejarah' },
      { t: 'paragraph', text: 'Pada 17 Agustus 1945, Ir. Soekarno membacakan teks proklamasi di Jalan Pegangsaan Timur 56, Jakarta. Di depan banyak orang, ia mengucapkan bahwa Indonesia sudah merdeka.' },
      { t: 'fact', text: 'Proklamasi dibacakan pukul 10.00 pagi, dan begitu selesai, bendera Merah Putih dikibarkan diiringi lagu Indonesia Raya.' },
      { t: 'list', items: ['Teks proklamasi ditulis pada malam harinya', 'Proklamasi menandakan Indonesia bebas dari penjajahan', 'Setiap tahun hari ini dirayakan sebagai Hari Kemerdekaan'] },
      { t: 'quote', text: 'Kemerdekaan adalah hadiah yang diperjuangkan, bukan hadiah yang jatuh dari langit.' },
      { t: 'paragraph', text: 'Sekarang, setiap 17 Agustus kita memperingati hari besar ini dengan upacara, lomba, dan rasa bangga menjadi anak Indonesia.' }
    ],
    source: ['Proclamation of Indonesian Independence', 'https://en.wikipedia.org/wiki/Proclamation_of_Indonesian_Independence'],
    fact: 'Proklamasi kemerdekaan Indonesia dibacakan pada 17 Agustus 1945 pukul 10.00 pagi.',
    quiz: [
      { q: 'Kapan Indonesia memproklamasikan kemerdekaannya?', opts: [['17 Agustus 1945', true], ['17 Agustus 1946', false], ['28 Oktober 1945', false], ['1 Juni 1945', false]] },
      { q: 'Siapa yang membacakan teks proklamasi?', opts: [['Ir. Soekarno', true], ['Sayuti Melik', false], ['Laksamana Maeda', false], ['Mohammad Yamin', false]] },
      { q: 'Di mana proklamasi dibacakan?', opts: [['Jalan Pegangsaan Timur 56, Jakarta', true], ['Rumah Laksamana Maeda', false], ['Istana Merdeka', false], ['Monas', false]] }
    ]
  },
  {
    title: 'Bendera Merah Putih: Warna yang Punya Arti',
    slug: 'arti-bendera-merah-putih',
    excerpt: 'Merah berarti berani, putih berarti suci. Yuk kenalan dengan Sang Saka Merah Putih!',
    category: 'sejarah',
    imgKeyword: 'flag of indonesia',
    blocks: [
      { t: 'paragraph', text: 'Kamu pasti sering melihat bendera Merah Putih berkibar saat upacara. Ternyata kedua warnanya punya arti yang dalam, lho.' },
      { t: 'heading', text: 'Dua Warna, Banyak Makna' },
      { t: 'paragraph', text: 'Merah melambangkan keberanian, putih melambangkan kesucian. Keduanya bersama-sama mengingatkan kita untuk berani berbuat baik dan selalu jujur.' },
      { t: 'fact', text: 'Nama Sang Saka Merah Putih berarti bendera pusaka. Bendera pusaka asli yang dikibarkan tahun 1945 kini disimpan di Istana Merdeka.' },
      { t: 'list', items: ['Bendera Merah Putih dikibarkan setiap upacara hari Senin', 'Warna merah = berani', 'Warna putih = suci dan jujur'] },
      { t: 'quote', text: 'Dua warna sederhana yang menceritakan semangat sebuah bangsa.' },
      { t: 'paragraph', text: 'Saat bendera dikibarkan, kita berdiri tegak dan memberi hormat sebagai tanda cinta pada tanah air.' }
    ],
    source: ['Flag of Indonesia', 'https://en.wikipedia.org/wiki/Flag_of_Indonesia'],
    fact: 'Merah pada bendera berarti berani, putih berarti suci.',
    quiz: [
      { q: 'Merah pada bendera Indonesia melambangkan...', opts: [['Keberanian', true], ['Kesedihan', false], ['Kesucian', false], ['Kekayaan', false]] },
      { q: 'Putih pada bendera Indonesia melambangkan...', opts: [['Kesucian dan kejujuran', true], ['Keberanian', false], ['Kegembiraan', false], ['Kekuatan', false]] },
      { q: 'Apa nama lain bendera pusaka Indonesia?', opts: [['Sang Saka Merah Putih', true], ['Sang Saka Garuda', false], ['Panji Kesatria', false], ['Trisula Merah', false]] }
    ]
  },
  {
    title: 'Lagu Indonesia Raya: Nyanyian Kebanggaan Kita',
    slug: 'lagu-indonesia-raya',
    excerpt: 'Siapa yang menciptakan lagu Indonesia Raya, dan kapan pertama kali dinyanyikan?',
    category: 'sejarah',
    imgKeyword: 'indonesia raya',
    blocks: [
      { t: 'paragraph', text: 'Saat upacara, kita menyanyikan lagu Indonesia Raya. Tapi siapa sebenarnya pencipta lagu yang membanggakan ini?' },
      { t: 'heading', text: 'Diciptakan oleh Seorang Pemuda' },
      { t: 'paragraph', text: 'Lagu Indonesia Raya diciptakan oleh Wage Rudolf Supratman. Pertama kali diperdengarkan pada Kongres Pemuda 28 Oktober 1928, hari lahirnya Sumpah Pemuda.' },
      { t: 'fact', text: 'Saat itu, lagu ini dimainkan dengan biola, dan seluruh ruangan ikut berdiri karena terharu mendengarnya.' },
      { t: 'list', items: ['Lagu Indonesia Raya punya tiga stanza', 'Stanza pertama adalah yang paling sering kita nyanyikan', 'Indonesia Raya menjadi simbol semangat persatuan'] },
      { t: 'quote', text: 'Satu tanah air, satu bangsa, satu bahasa: Indonesia.' },
      { t: 'paragraph', text: 'Setiap kali lagu ini berkumandang, kita berdiri tegak dan bernyanyi dengan bangga sebagai anak Indonesia.' }
    ],
    source: ['Indonesia Raya', 'https://en.wikipedia.org/wiki/Indonesia_Raya'],
    fact: 'Lagu Indonesia Raya pertama kali diperdengarkan pada 28 Oktober 1928.',
    quiz: [
      { q: 'Siapa pencipta lagu Indonesia Raya?', opts: [['Wage Rudolf Supratman', true], ['Ir. Soekarno', false], ['Mohammad Hatta', false], ['Sayuti Melik', false]] },
      { q: 'Kapan Indonesia Raya pertama kali diperdengarkan?', opts: [['28 Oktober 1928', true], ['17 Agustus 1945', false], ['1 Juni 1945', false], ['20 Mei 1908', false]] },
      { q: 'Acara apa yang melahirkan Sumpah Pemuda?', opts: [['Kongres Pemuda', true], ['Upacara bendera', false], ['Rapat Raksasa', false], ['Perayaan panen', false]] }
    ]
  },
  {
    title: 'Soekarno dan Hatta: Dua Tokoh Proklamator',
    slug: 'soekarno-hatta-proklamator',
    excerpt: 'Dua nama penting di balik kemerdekaan Indonesia. Kenali mereka, yuk!',
    category: 'sejarah',
    imgKeyword: 'soekarno',
    blocks: [
      { t: 'paragraph', text: 'Pernah dengar nama Soekarno dan Mohammad Hatta? Mereka adalah dua tokoh yang paling berjasa saat Indonesia merdeka.' },
      { t: 'heading', text: 'Mereka Membacakan Kemerdekaan' },
      { t: 'paragraph', text: 'Ir. Soekarno menjadi presiden pertama Indonesia dan Mohammad Hatta menjadi wakil presiden pertama. Berdua mereka membacakan dan menandatangani teks proklamasi.' },
      { t: 'fact', text: 'Teks proklamasi diketik oleh Sayuti Melik di rumah Laksamana Maeda, setelah disusun Soekarno, Hatta, dan Achmad Soebardjo.' },
      { t: 'list', items: ['Soekarno dijuluki Bapak Proklamator', 'Hatta juga dikenal sebagai Bapak Koperasi Indonesia', 'Mereka dibantu banyak pejuang lain yang tak kalah hebat'] },
      { t: 'quote', text: 'Bersatu kita teguh, bercerai kita runtuh.' },
      { t: 'paragraph', text: 'Perjuangan mereka mengajarkan bahwa bekerja sama dan pantang menyerah adalah kunci meraih impian.' }
    ],
    source: ['Sukarno', 'https://en.wikipedia.org/wiki/Sukarno'],
    fact: 'Teks proklamasi diketik oleh Sayuti Melik setelah disusun para tokoh di rumah Laksamana Maeda.',
    quiz: [
      { q: 'Siapa presiden pertama Indonesia?', opts: [['Ir. Soekarno', true], ['Mohammad Hatta', false], ['Achmad Soebardjo', false], ['W.R. Supratman', false]] },
      { q: 'Siapa wakil presiden pertama Indonesia?', opts: [['Mohammad Hatta', true], ['Soekarno', false], ['Sayuti Melik', false], ['Laksamana Maeda', false]] },
      { q: 'Siapa yang mengetik teks proklamasi?', opts: [['Sayuti Melik', true], ['W.R. Supratman', false], ['Mohammad Yamin', false], ['Soekarno', false]] }
    ]
  },
  {
    title: 'Apa Arti Merdeka untuk Kita?',
    slug: 'makna-kemerdekaan-untuk-anak',
    excerpt: 'Merdeka bukan hanya tentang upacara dan lomba. Ini artinya untuk kehidupan sehari-harimu.',
    category: 'sejarah',
    imgKeyword: 'kemerdekaan indonesia',
    blocks: [
      { t: 'paragraph', text: 'Setiap Agustus kita ramai dengan upacara dan lomba. Tapi apa sebenarnya arti kata "merdeka" untuk kita?' },
      { t: 'heading', text: 'Merdeka dalam Kehidupan Sehari-hari' },
      { t: 'paragraph', text: 'Merdeka berarti bebas. Bebas belajar, bebas bermain, bebas menyampaikan pendapat — selama tidak merugikan orang lain. Semua itu hadiah dari perjuangan para pahlawan.' },
      { t: 'fact', text: 'Dahulu, banyak anak tidak bisa sekolah dengan bebas. Sekarang semua anak Indonesia berhak mendapat pendidikan.' },
      { t: 'list', items: ['Bersekolah dan belajar dengan giat adalah cara menghargai kemerdekaan', 'Menolong teman dan menjaga kebersihan juga bentuk cinta tanah air', 'Hormati bendera dan lagu kebangsaan saat upacara'] },
      { t: 'quote', text: 'Kemerdekaan bukan akhir, melainkan awal untuk terus belajar dan berbuat baik.' },
      { t: 'paragraph', text: 'Jadi, cara paling sederhana merayakan kemerdekaan adalah menjadi anak yang rajin, jujur, dan bangga menjadi orang Indonesia.' }
    ],
    source: ['Independence Day (Indonesia)', 'https://en.wikipedia.org/wiki/Independence_Day_(Indonesia)'],
    fact: 'Merdeka berarti bebas belajar, bermain, dan menyampaikan pendapat.',
    quiz: [
      { q: 'Apa arti kata "merdeka"?', opts: [['Bebas', true], ['Kaya', false], ['Pandai', false], ['Kuat', false]] },
      { q: 'Cara paling sederhana menghargai kemerdekaan adalah...', opts: [['Rajin belajar dan berbuat baik', true], ['Bermalas-malasan', false], ['Mengabaikan upacara', false], ['Membuang sampah sembarangan', false]] },
      { q: 'Siapa yang memperjuangkan kemerdekaan Indonesia?', opts: [['Para pahlawan bersama seluruh rakyat', true], ['Hanya satu orang', false], ['Orang asing', false], ['Para guru saja', false]] }
    ]
  }
];

const esc = (s) => String(s).replaceAll("'", "''");

async function imageFor(article) {
  const q = encodeURIComponent(article.imgKeyword);
  const u = `https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrsearch=${q}&gsrnamespace=6&gsrlimit=4&prop=imageinfo&iiprop=url&iiurlwidth=900&format=json`;
  try {
    const res = await fetch(u);
    const j = await res.json();
    const pages = j?.query?.pages ?? {};
    const candidates = Object.values(pages)
      .map((p) => p?.imageinfo?.[0]?.thumburl ?? p?.imageinfo?.[0]?.url)
      .filter((x) => x && !/\.svg(\.|$)/i.test(x) && !/\.tif(f)?(\.|$)/i.test(x) && !/\.pdf/i.test(x));
    if (candidates.length) return candidates[0];
  } catch { /* fallback ke logo */ }
  return '/assets/images/logo.png';
}

function contentJson(article) {
  return JSON.stringify(article.blocks.map((b) =>
    b.t === 'list'
      ? { type: 'list', data: { items: b.items } }
      : { type: b.t, data: { text: b.text } }
  ));
}

function genSQL(inserted) {
  const rows = inserted
    .map(
      (a) => `(
  'Sekta',
  (select id from public.categories where slug = '${a.category}'),
  '${esc(a.title)}',
  '${a.slug}',
  '${esc(a.excerpt)}',
  ${a.image ? `'${a.image}'` : 'null'},
  '${esc(a.content)}'::jsonb,
  3,
  'PUBLISHED',
  '${a.publishedAt}'
)`
    )
    .join(',\n');
  const facts = inserted
    .map((a) => `('${esc(a.fact)}', (select id from public.articles where slug = '${a.slug}'))`)
    .join(',\n');
  const sources = inserted
    .map((a) => `((select id from public.articles where slug = '${a.slug}'), '${esc(a.source[0])}', '${a.source[1]}', 'Wikipedia')`)
    .join(',\n');
  let quizzes = '';
  for (const a of inserted) {
    quizzes += `\ninsert into public.quizzes (title, description, article_id)
  values ('Kuis: ${esc(a.title)}', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = '${a.slug}'))
on conflict (title) do nothing;\n`;
    quizzes += `\ninsert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  ${a.quiz.map((x, i) => `(${i + 1}, '${esc(x.q)}')`).join(',\n  ')}
) as x(position, question)
where q.article_id = (select id from public.articles where slug = '${a.slug}')
on conflict (quiz_id, position) do nothing;\n`;
    quizzes += `\ninsert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  ${a.quiz
    .map((x, qi) => x.opts.map(([label, correct], oi) => `(${qi + 1}, '${esc(label)}', ${correct}, ${oi + 1})`).join(',\n  '))
    .join(',\n  ')}
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = '${a.slug}')
on conflict (question_id, position) do nothing;\n`;
  }
  return `-- ============================================================
-- SEKTA — SEED 5 ARTIKEL KEMERDEKAAN (bahasa ramah anak) + kuis & fakta
-- ============================================================
-- Jalankan di Supabase Dashboard → SQL Editor → Run.
-- Idempoten: artikel via slug, fakta via kolom unik, kuis via judul.

insert into public.articles (author_name, category_id, title, slug, excerpt, cover_image, content, read_time_minutes, status, published_at) values
${rows}
on conflict (slug) do nothing;

-- ---------- SEKEJAP FAKTA ----------
insert into public.sekejap_facts (fact, article_id) values
${facts}
on conflict (fact) do nothing;

-- ---------- SUMBER ----------
insert into public.sources (article_id, title, url, publisher) values
${sources}
on conflict (article_id, title) do nothing;

-- ---------- KUIS ----------${quizzes}
`;
}

async function main() {
  const { data: existing } = await sb.from('articles').select('slug');
  const have = new Set((existing ?? []).map((r) => r.slug));
  const todo = ARTICLES.filter((a) => !have.has(a.slug));
  console.log(`Total baru: ${todo.length}/${ARTICLES.length}`);

  const { data: cats } = await sb.from('categories').select('id, slug');
  const catId = new Map((cats ?? []).map((c) => [c.slug, c.id]));

  const inserted = [];
  for (const a of todo) {
    const image = await imageFor(a);
    const publishedAt = new Date().toISOString();
    const content = contentJson(a);
    const { data, error } = await sb
      .from('articles')
      .insert({
        author_name: 'Sekta',
        category_id: catId.get(a.category),
        title: a.title,
        slug: a.slug,
        excerpt: a.excerpt,
        cover_image: image,
        content: JSON.parse(content),        read_time_minutes: 3,
        status: 'PUBLISHED',
        published_at: publishedAt
      })
      .select('id')
      .single();
    if (error) throw error;
    inserted.push({ ...a, image, content, publishedAt, id: data.id });
    console.log(`  + ${a.slug} (img: ${image === '/assets/images/logo.png' ? 'logo' : 'ok'})`);
  }

  for (const a of inserted) {
    await sb.from('sources').insert({ article_id: a.id, title: a.source[0], url: a.source[1], publisher: 'Wikipedia' }).then(({ error }) => { if (error) throw error; });
    await sb.from('sekejap_facts').insert({ fact: a.fact, article_id: a.id }).then(({ error }) => { if (error) throw error; });
    const { data: quiz, error: qerr } = await sb.from('quizzes').insert({ title: `Kuis: ${a.title}`, description: 'Tanya jawab seputar artikel ini.', article_id: a.id }).select('id').single();
    if (qerr) throw qerr;
    for (const [qi, q] of a.quiz.entries()) {
      const { data: qq, error: qqerr } = await sb.from('quiz_questions').insert({ quiz_id: quiz.id, question: q.q, position: qi + 1 }).select('id').single();
      if (qqerr) throw qqerr;
      for (const [oi, [label, correct]] of q.opts.entries()) {
        const { error: oerr } = await sb.from('quiz_options').insert({ question_id: qq.id, label, is_correct: correct, position: oi + 1 });
        if (oerr) throw oerr;
      }
    }
    console.log(`  ~ quiz ${quiz.id} untuk ${a.slug}`);
  }

  if (inserted.length) {
    const fs = inserted.map((a) => ({
      slug: a.slug, title: a.title, excerpt: a.excerpt, category: a.category, image: a.image,
      content: a.content, fact: a.fact, source: a.source, quiz: a.quiz, publishedAt: a.publishedAt
    }));
    writeFileSync('docs/seed-5-artikel-kemerdekaan.sql', genSQL(fs), 'utf8');
    console.log('SQL ditulis ke docs/seed-5-artikel-kemerdekaan.sql');
  }
  console.log(`Selesai. ${inserted.length} artikel baru.`);
}

main().catch((e) => { console.error('FAIL:', e); process.exit(1); });
