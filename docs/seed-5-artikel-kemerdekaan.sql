-- ============================================================
-- SEKTA — SEED 5 ARTIKEL KEMERDEKAAN (bahasa ramah anak) + kuis & fakta
-- ============================================================
-- Jalankan di Supabase Dashboard → SQL Editor → Run.
-- Idempoten: artikel via slug, fakta via kolom unik, kuis via judul.

insert into public.articles (author_name, category_id, title, slug, excerpt, cover_image, content, read_time_minutes, status, published_at) values
(
  'Sekta',
  (select id from public.categories where slug = 'sejarah'),
  'Cerita Proklamasi: Hari Indonesia Mengucapkan "Merdeka!"',
  'proklamasi-kemerdekaan-indonesia',
  'Tanggal 17 Agustus 1945, Indonesia menyatakan merdeka. Ini cerita singkatnya untukmu.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Indonesia_declaration_of_independence_17_August_1945.jpg/960px-Indonesia_declaration_of_independence_17_August_1945.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Setiap tanggal 17 Agustus, seluruh Indonesia merayakan hari kemerdekaan. Tapi tahukah kamu apa yang terjadi pertama kali saat Indonesia menyatakan merdeka?"}},{"type":"heading","data":{"text":"Pagi Hari yang Bersejarah"}},{"type":"paragraph","data":{"text":"Pada 17 Agustus 1945, Ir. Soekarno membacakan teks proklamasi di Jalan Pegangsaan Timur 56, Jakarta. Di depan banyak orang, ia mengucapkan bahwa Indonesia sudah merdeka."}},{"type":"fact","data":{"text":"Proklamasi dibacakan pukul 10.00 pagi, dan begitu selesai, bendera Merah Putih dikibarkan diiringi lagu Indonesia Raya."}},{"type":"list","data":{"items":["Teks proklamasi ditulis pada malam harinya","Proklamasi menandakan Indonesia bebas dari penjajahan","Setiap tahun hari ini dirayakan sebagai Hari Kemerdekaan"]}},{"type":"quote","data":{"text":"Kemerdekaan adalah hadiah yang diperjuangkan, bukan hadiah yang jatuh dari langit."}},{"type":"paragraph","data":{"text":"Sekarang, setiap 17 Agustus kita memperingati hari besar ini dengan upacara, lomba, dan rasa bangga menjadi anak Indonesia."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T14:26:47.599Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sejarah'),
  'Bendera Merah Putih: Warna yang Punya Arti',
  'arti-bendera-merah-putih',
  'Merah berarti berani, putih berarti suci. Yuk kenalan dengan Sang Saka Merah Putih!',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Province_Flag_Map_Indonesia_Map.png/960px-Province_Flag_Map_Indonesia_Map.png?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Kamu pasti sering melihat bendera Merah Putih berkibar saat upacara. Ternyata kedua warnanya punya arti yang dalam, lho."}},{"type":"heading","data":{"text":"Dua Warna, Banyak Makna"}},{"type":"paragraph","data":{"text":"Merah melambangkan keberanian, putih melambangkan kesucian. Keduanya bersama-sama mengingatkan kita untuk berani berbuat baik dan selalu jujur."}},{"type":"fact","data":{"text":"Nama Sang Saka Merah Putih berarti bendera pusaka. Bendera pusaka asli yang dikibarkan tahun 1945 kini disimpan di Istana Merdeka."}},{"type":"list","data":{"items":["Bendera Merah Putih dikibarkan setiap upacara hari Senin","Warna merah = berani","Warna putih = suci dan jujur"]}},{"type":"quote","data":{"text":"Dua warna sederhana yang menceritakan semangat sebuah bangsa."}},{"type":"paragraph","data":{"text":"Saat bendera dikibarkan, kita berdiri tegak dan memberi hormat sebagai tanda cinta pada tanah air."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T14:26:48.689Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sejarah'),
  'Lagu Indonesia Raya: Nyanyian Kebanggaan Kita',
  'lagu-indonesia-raya',
  'Siapa yang menciptakan lagu Indonesia Raya, dan kapan pertama kali dinyanyikan?',
  'https://upload.wikimedia.org/wikipedia/commons/4/4f/IndonesiaRaya-SinPo1928.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled',
  '[{"type":"paragraph","data":{"text":"Saat upacara, kita menyanyikan lagu Indonesia Raya. Tapi siapa sebenarnya pencipta lagu yang membanggakan ini?"}},{"type":"heading","data":{"text":"Diciptakan oleh Seorang Pemuda"}},{"type":"paragraph","data":{"text":"Lagu Indonesia Raya diciptakan oleh Wage Rudolf Supratman. Pertama kali diperdengarkan pada Kongres Pemuda 28 Oktober 1928, hari lahirnya Sumpah Pemuda."}},{"type":"fact","data":{"text":"Saat itu, lagu ini dimainkan dengan biola, dan seluruh ruangan ikut berdiri karena terharu mendengarnya."}},{"type":"list","data":{"items":["Lagu Indonesia Raya punya tiga stanza","Stanza pertama adalah yang paling sering kita nyanyikan","Indonesia Raya menjadi simbol semangat persatuan"]}},{"type":"quote","data":{"text":"Satu tanah air, satu bangsa, satu bahasa: Indonesia."}},{"type":"paragraph","data":{"text":"Setiap kali lagu ini berkumandang, kita berdiri tegak dan bernyanyi dengan bangga sebagai anak Indonesia."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T14:26:49.469Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sejarah'),
  'Soekarno dan Hatta: Dua Tokoh Proklamator',
  'soekarno-hatta-proklamator',
  'Dua nama penting di balik kemerdekaan Indonesia. Kenali mereka, yuk!',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Soekarno-Hatta_Airport_aerial_view.jpg/960px-Soekarno-Hatta_Airport_aerial_view.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Pernah dengar nama Soekarno dan Mohammad Hatta? Mereka adalah dua tokoh yang paling berjasa saat Indonesia merdeka."}},{"type":"heading","data":{"text":"Mereka Membacakan Kemerdekaan"}},{"type":"paragraph","data":{"text":"Ir. Soekarno menjadi presiden pertama Indonesia dan Mohammad Hatta menjadi wakil presiden pertama. Berdua mereka membacakan dan menandatangani teks proklamasi."}},{"type":"fact","data":{"text":"Teks proklamasi diketik oleh Sayuti Melik di rumah Laksamana Maeda, setelah disusun Soekarno, Hatta, dan Achmad Soebardjo."}},{"type":"list","data":{"items":["Soekarno dijuluki Bapak Proklamator","Hatta juga dikenal sebagai Bapak Koperasi Indonesia","Mereka dibantu banyak pejuang lain yang tak kalah hebat"]}},{"type":"quote","data":{"text":"Bersatu kita teguh, bercerai kita runtuh."}},{"type":"paragraph","data":{"text":"Perjuangan mereka mengajarkan bahwa bekerja sama dan pantang menyerah adalah kunci meraih impian."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T14:26:50.402Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sejarah'),
  'Apa Arti Merdeka untuk Kita?',
  'makna-kemerdekaan-untuk-anak',
  'Merdeka bukan hanya tentang upacara dan lomba. Ini artinya untuk kehidupan sehari-harimu.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Pengibaran_Bendera_Merah_Putih%2C_Peringatan_Hari_Proklamasi_Kemerdekaan_Indonesia.jpg/960px-Pengibaran_Bendera_Merah_Putih%2C_Peringatan_Hari_Proklamasi_Kemerdekaan_Indonesia.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Setiap Agustus kita ramai dengan upacara dan lomba. Tapi apa sebenarnya arti kata \"merdeka\" untuk kita?"}},{"type":"heading","data":{"text":"Merdeka dalam Kehidupan Sehari-hari"}},{"type":"paragraph","data":{"text":"Merdeka berarti bebas. Bebas belajar, bebas bermain, bebas menyampaikan pendapat — selama tidak merugikan orang lain. Semua itu hadiah dari perjuangan para pahlawan."}},{"type":"fact","data":{"text":"Dahulu, banyak anak tidak bisa sekolah dengan bebas. Sekarang semua anak Indonesia berhak mendapat pendidikan."}},{"type":"list","data":{"items":["Bersekolah dan belajar dengan giat adalah cara menghargai kemerdekaan","Menolong teman dan menjaga kebersihan juga bentuk cinta tanah air","Hormati bendera dan lagu kebangsaan saat upacara"]}},{"type":"quote","data":{"text":"Kemerdekaan bukan akhir, melainkan awal untuk terus belajar dan berbuat baik."}},{"type":"paragraph","data":{"text":"Jadi, cara paling sederhana merayakan kemerdekaan adalah menjadi anak yang rajin, jujur, dan bangga menjadi orang Indonesia."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T14:26:51.376Z'
)
on conflict (slug) do nothing;

-- ---------- SEKEJAP FAKTA ----------
insert into public.sekejap_facts (fact, article_id) values
('Proklamasi kemerdekaan Indonesia dibacakan pada 17 Agustus 1945 pukul 10.00 pagi.', (select id from public.articles where slug = 'proklamasi-kemerdekaan-indonesia')),
('Merah pada bendera berarti berani, putih berarti suci.', (select id from public.articles where slug = 'arti-bendera-merah-putih')),
('Lagu Indonesia Raya pertama kali diperdengarkan pada 28 Oktober 1928.', (select id from public.articles where slug = 'lagu-indonesia-raya')),
('Teks proklamasi diketik oleh Sayuti Melik setelah disusun para tokoh di rumah Laksamana Maeda.', (select id from public.articles where slug = 'soekarno-hatta-proklamator')),
('Merdeka berarti bebas belajar, bermain, dan menyampaikan pendapat.', (select id from public.articles where slug = 'makna-kemerdekaan-untuk-anak'))
on conflict (fact) do nothing;

-- ---------- SUMBER ----------
insert into public.sources (article_id, title, url, publisher) values
((select id from public.articles where slug = 'proklamasi-kemerdekaan-indonesia'), 'Proclamation of Indonesian Independence', 'https://en.wikipedia.org/wiki/Proclamation_of_Indonesian_Independence', 'Wikipedia'),
((select id from public.articles where slug = 'arti-bendera-merah-putih'), 'Flag of Indonesia', 'https://en.wikipedia.org/wiki/Flag_of_Indonesia', 'Wikipedia'),
((select id from public.articles where slug = 'lagu-indonesia-raya'), 'Indonesia Raya', 'https://en.wikipedia.org/wiki/Indonesia_Raya', 'Wikipedia'),
((select id from public.articles where slug = 'soekarno-hatta-proklamator'), 'Sukarno', 'https://en.wikipedia.org/wiki/Sukarno', 'Wikipedia'),
((select id from public.articles where slug = 'makna-kemerdekaan-untuk-anak'), 'Independence Day (Indonesia)', 'https://en.wikipedia.org/wiki/Independence_Day_(Indonesia)', 'Wikipedia')
on conflict (article_id, title) do nothing;

-- ---------- KUIS ----------
insert into public.quizzes (title, description, article_id)
  values ('Kuis: Cerita Proklamasi: Hari Indonesia Mengucapkan "Merdeka!"', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'proklamasi-kemerdekaan-indonesia'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Kapan Indonesia memproklamasikan kemerdekaannya?'),
  (2, 'Siapa yang membacakan teks proklamasi?'),
  (3, 'Di mana proklamasi dibacakan?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'proklamasi-kemerdekaan-indonesia')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, '17 Agustus 1945', true, 1),
  (1, '17 Agustus 1946', false, 2),
  (1, '28 Oktober 1945', false, 3),
  (1, '1 Juni 1945', false, 4),
  (2, 'Ir. Soekarno', true, 1),
  (2, 'Sayuti Melik', false, 2),
  (2, 'Laksamana Maeda', false, 3),
  (2, 'Mohammad Yamin', false, 4),
  (3, 'Jalan Pegangsaan Timur 56, Jakarta', true, 1),
  (3, 'Rumah Laksamana Maeda', false, 2),
  (3, 'Istana Merdeka', false, 3),
  (3, 'Monas', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'proklamasi-kemerdekaan-indonesia')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Bendera Merah Putih: Warna yang Punya Arti', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'arti-bendera-merah-putih'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Merah pada bendera Indonesia melambangkan...'),
  (2, 'Putih pada bendera Indonesia melambangkan...'),
  (3, 'Apa nama lain bendera pusaka Indonesia?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'arti-bendera-merah-putih')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Keberanian', true, 1),
  (1, 'Kesedihan', false, 2),
  (1, 'Kesucian', false, 3),
  (1, 'Kekayaan', false, 4),
  (2, 'Kesucian dan kejujuran', true, 1),
  (2, 'Keberanian', false, 2),
  (2, 'Kegembiraan', false, 3),
  (2, 'Kekuatan', false, 4),
  (3, 'Sang Saka Merah Putih', true, 1),
  (3, 'Sang Saka Garuda', false, 2),
  (3, 'Panji Kesatria', false, 3),
  (3, 'Trisula Merah', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'arti-bendera-merah-putih')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Lagu Indonesia Raya: Nyanyian Kebanggaan Kita', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'lagu-indonesia-raya'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Siapa pencipta lagu Indonesia Raya?'),
  (2, 'Kapan Indonesia Raya pertama kali diperdengarkan?'),
  (3, 'Acara apa yang melahirkan Sumpah Pemuda?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'lagu-indonesia-raya')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Wage Rudolf Supratman', true, 1),
  (1, 'Ir. Soekarno', false, 2),
  (1, 'Mohammad Hatta', false, 3),
  (1, 'Sayuti Melik', false, 4),
  (2, '28 Oktober 1928', true, 1),
  (2, '17 Agustus 1945', false, 2),
  (2, '1 Juni 1945', false, 3),
  (2, '20 Mei 1908', false, 4),
  (3, 'Kongres Pemuda', true, 1),
  (3, 'Upacara bendera', false, 2),
  (3, 'Rapat Raksasa', false, 3),
  (3, 'Perayaan panen', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'lagu-indonesia-raya')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Soekarno dan Hatta: Dua Tokoh Proklamator', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'soekarno-hatta-proklamator'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Siapa presiden pertama Indonesia?'),
  (2, 'Siapa wakil presiden pertama Indonesia?'),
  (3, 'Siapa yang mengetik teks proklamasi?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'soekarno-hatta-proklamator')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Ir. Soekarno', true, 1),
  (1, 'Mohammad Hatta', false, 2),
  (1, 'Achmad Soebardjo', false, 3),
  (1, 'W.R. Supratman', false, 4),
  (2, 'Mohammad Hatta', true, 1),
  (2, 'Soekarno', false, 2),
  (2, 'Sayuti Melik', false, 3),
  (2, 'Laksamana Maeda', false, 4),
  (3, 'Sayuti Melik', true, 1),
  (3, 'W.R. Supratman', false, 2),
  (3, 'Mohammad Yamin', false, 3),
  (3, 'Soekarno', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'soekarno-hatta-proklamator')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Apa Arti Merdeka untuk Kita?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'makna-kemerdekaan-untuk-anak'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Apa arti kata "merdeka"?'),
  (2, 'Cara paling sederhana menghargai kemerdekaan adalah...'),
  (3, 'Siapa yang memperjuangkan kemerdekaan Indonesia?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'makna-kemerdekaan-untuk-anak')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Bebas', true, 1),
  (1, 'Kaya', false, 2),
  (1, 'Pandai', false, 3),
  (1, 'Kuat', false, 4),
  (2, 'Rajin belajar dan berbuat baik', true, 1),
  (2, 'Bermalas-malasan', false, 2),
  (2, 'Mengabaikan upacara', false, 3),
  (2, 'Membuang sampah sembarangan', false, 4),
  (3, 'Para pahlawan bersama seluruh rakyat', true, 1),
  (3, 'Hanya satu orang', false, 2),
  (3, 'Orang asing', false, 3),
  (3, 'Para guru saja', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'makna-kemerdekaan-untuk-anak')
on conflict (question_id, position) do nothing;

