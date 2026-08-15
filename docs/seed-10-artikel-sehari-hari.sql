-- ============================================================
-- SEKTA — SEED 10 ARTIKEL SEHARI-HARI (random facts harian)
-- ============================================================
-- Cara pakai:
--   1. Buka Supabase Dashboard → SQL Editor → New query
--   2. Salin seluruh isi file ini → Run
--
-- Aman diulang (idempotent): artikel unik via slug (on conflict do nothing),
-- fakta via kolom unik, sumber via (article_id, title).
-- Tidak menyentuh tabel lain dan tidak mengubah data produksi yang ada.
--
-- Kategori yang dipakai: fakta-unik, sains, manusia, hewan, kopi.
-- ============================================================

insert into public.articles (author_name, category_id, title, slug, excerpt, cover_image, content, read_time_minutes, status, published_at) values
(
  'Sekta',
  (select id from public.categories where slug = 'fakta-unik'),
  'Madu yang Tak Pernah Basi',
  'madu-tak-pernah-basi',
  'Makanan satu-satunya yang praktis tidak bisa rusak — bahkan madu 3.000 tahun masih aman dimakan.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Runny_hunny.jpg/1280px-Runny_hunny.jpg',
  '[
    {"type":"paragraph","data":{"text":"Pernah lihat madu mengkristal dan mengira sudah rusak? Tenang, madu hampir tidak mungkin basi — inilah salah satu keajaiban kecil di dapurmu."}},
    {"type":"heading","data":{"text":"Rahasia Keawetan Madu"}},
    {"type":"paragraph","data":{"text":"Madu mengandung sedikit air dan sangat asam. Ditambah enzim yang dihasilkan lebah, kondisi ini membuat bakteri dan jamur kesulitan bertahan hidup. Itulah sebabnya madu bisa bertahan begitu lama."}},
    {"type":"fact","data":{"text":"Arkeolog pernah menemukan madu berusia sekitar 3.000 tahun di makam Mesir — dan kabarnya masih bisa dimakan."}},
    {"type":"list","data":{"items":["Kadar air yang rendah menyulitkan mikroba","Tingkat keasamannya tinggi","Enzim dari lebah menghasilkan hidrogen peroksida alami"]}},
    {"type":"quote","data":{"text":"Madu adalah satu-satunya makanan yang praktis tidak pernah basi."}},
    {"type":"paragraph","data":{"text":"Kalau madumu mengkristal, jangan dibuang — rendam stoplesnya di air hangat dan ia akan kembali cair seperti semula."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-11T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Setiap Pisang yang Kamu Makan Sedikit Radioaktif',
  'pisang-sedikit-radioaktif',
  'Pisang mengandung potassium-40, isotop yang bersifat radioaktif — tapi jangan khawatir.',
  'https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg',
  '[
    {"type":"paragraph","data":{"text":"Setiap pisang yang kamu makan mengandung potassium-40, isotop kalium yang bersifat radioaktif. Tenang, itu sangat aman."}},
    {"type":"heading","data":{"text":"Aman, Tapi Sedikit Bercahaya"}},
    {"type":"paragraph","data":{"text":"Radiasi dari satu pisang sangat kecil — sekitar 0,1 microsievert. Kamu perlu makan ratusan ribu pisang sekaligus untuk mengalami efek yang berbahaya bagi tubuh."}},
    {"type":"fact","data":{"text":"Para ilmuwan bahkan memakai istilah banana equivalent dose untuk menjelaskan tingkat radiasi kecil kepada publik."}},
    {"type":"list","data":{"items":["Tubuhmu membutuhkan kalium untuk saraf dan otot","Radiasi alami dari lingkungan jauh lebih besar dari pisang","Naik pesawat memberi radiasi lebih tinggi daripada makan pisang"]}},
    {"type":"quote","data":{"text":"Makan pisang membuatmu sedikit bercahaya — tapi jangan khawatir."}},
    {"type":"paragraph","data":{"text":"Tubuhmu sudah terbiasa mengelola kalium dengan baik. Pisang tetap buah sehat yang boleh kamu nikmati setiap hari."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-12T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Kenapa Cabe Terasa Pedas? Ternyata Otak Sedang Tertipu',
  'kenapa-cabe-terasa-pedas',
  'Lidah tidak punya sensor pedas — capsaicin mengecoh reseptor panas di otak.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Madame_Jeanette_and_other_chillies.jpg/1280px-Madame_Jeanette_and_other_chillies.jpg',
  '[
    {"type":"paragraph","data":{"text":"Lidahmu tidak punya sensor rasa pedas. Lalu kenapa makan cabe terasa panas membakar?"}},
    {"type":"heading","data":{"text":"Trik Menipu Otak"}},
    {"type":"paragraph","data":{"text":"Senyawa capsaicin dalam cabe menempel pada reseptor TRPV1 yang biasanya aktif saat terkena panas. Otak pun dibohongi dan mengira mulut sedang terbakar, padahal suhunya normal."}},
    {"type":"fact","data":{"text":"Burung tidak merasakan pedas sama sekali — ini trik cabe agar bijinya disebar burung, bukan dikunyah mamalia."}},
    {"type":"list","data":{"items":["Skala Scoville mengukur tingkat kepedasan","Susu lebih efektif meredakan pedas daripada air","Cabe terpedas di dunia mencapai jutaan satuan Scoville"]}},
    {"type":"quote","data":{"text":"Pedas bukan rasa — ia adalah sensasi panas yang sedang mengecoh otak."}},
    {"type":"paragraph","data":{"text":"Justru rasa aman dari situasi yang tampak berbahaya inilah yang membuat banyak orang ketagihan pedas."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-13T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'manusia'),
  'Tubuhmu 60 Persen Air',
  'tubuh-60-persen-air',
  'Otak, jantung, bahkan tulangmu menyimpan banyak air — dan kamu hanya bertahan beberapa hari tanpanya.',
  'https://upload.wikimedia.org/wikipedia/commons/a/ad/Clean_water_for_a_village_in_West_Lombok_%2810686572086%29.jpg',
  '[
    {"type":"paragraph","data":{"text":"Sekitar 60 persen tubuh orang dewasa terdiri dari air — dan angka itu bukan sekadar statistik."}},
    {"type":"heading","data":{"text":"Air di Dalam Dirimu"}},
    {"type":"paragraph","data":{"text":"Otak dan jantungmu mengandung sekitar 73 persen air, paru-paru 83 persen, bahkan tulangmu masih menyimpan 31 persen."}},
    {"type":"fact","data":{"text":"Manusia bisa bertahan berminggu-minggu tanpa makanan, tetapi hanya sekitar 3-7 hari tanpa air."}},
    {"type":"list","data":{"items":["Darah sebagian besar terdiri dari air","Air mengatur suhu tubuh lewat keringat","Ginjal menyaring puluhan liter cairan setiap hari"]}},
    {"type":"quote","data":{"text":"Dua pertiga tubuhmu adalah air — kamu pada dasarnya makhluk yang sebagian besar terdiri dari air."}},
    {"type":"paragraph","data":{"text":"Saat merasa haus, itu artinya tubuh sudah mulai kekurangan — minumlah sebelum sinyal itu tiba."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-14T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'manusia'),
  'Menguap yang Menular — dan Bukan Hanya karena Ngantuk',
  'menguap-menular',
  'Membaca artikel ini saja bisa membuatmu menguap. Itu bukan kebetulan.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Yawning_koala_bear_%283589381656%29_%28cropped%29.jpg/1280px-Yawning_koala_bear_%283589381656%29_%28cropped%29.jpg',
  '[
    {"type":"paragraph","data":{"text":"Membaca kata menguap saja bisa membuatmu menguap. Itulah kekuatan menguap yang menular — dan anehnya, kamu baru saja menguap, bukan?"}},
    {"type":"heading","data":{"text":"Lebih dari Sekadar Ngantuk"}},
    {"type":"paragraph","data":{"text":"Menguap diperkirakan membantu mendinginkan otak yang mulai panas. Orang lebih jarang menguap di ruangan dingin, dan itu bukan sekadar rasa bosan."}},
    {"type":"fact","data":{"text":"Hampir semua hewan vertebrata menguap — bahkan kelelawar menguap bersama-sama dalam kelompoknya."}},
    {"type":"list","data":{"items":["Menguap bisa menular ke anjing peliharaanmu","Bayi di dalam kandungan dilaporkan ikut menguap","Manusia menguap ribuan kali seumur hidup"]}},
    {"type":"quote","data":{"text":"Menguap adalah pengingat bahwa tubuh dan otak adalah satu sistem yang saling menjaga."}},
    {"type":"paragraph","data":{"text":"Kalau temanmu menguap dan kamu ikut menguap, itu bukan sekadar kebetulan — otakmu sedang bersimpati."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-15T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'fakta-unik'),
  'Stroberi Bukan Berry — Tapi Pisang, Tomat, dan Timun Adalah Berry',
  'stroberi-bukan-berry',
  'Definisi berry dalam botani ternyata jauh berbeda dari yang kamu kira.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Garden_strawberry_%28Fragaria_%C3%97_ananassa%29_single2.jpg/1280px-Garden_strawberry_%28Fragaria_%C3%97_ananassa%29_single2.jpg',
  '[
    {"type":"paragraph","data":{"text":"Dalam botani, stroberi bukan berry. Pisang, tomat, dan timun justru termasuk berry. Apa yang terjadi?"}},
    {"type":"heading","data":{"text":"Berry Menurut Sains"}},
    {"type":"paragraph","data":{"text":"Berry botani adalah buah berdaging yang berasal dari satu bunga dan bijinya tertanam di dalam daging buah. Stroberi berasal dari bunga dengan banyak ovarium, dan titik-titik di permukaannya sebenarnya adalah buah-buah kecil bernama achene."}},
    {"type":"fact","data":{"text":"Setiap titik kuning kecil di permukaan stroberi adalah buah sejati yang berisi satu biji."}},
    {"type":"list","data":{"items":["Pisang termasuk berry","Stroberi termasuk aggregate fruit","Tomat dan timun juga termasuk berry"]}},
    {"type":"quote","data":{"text":"Semakin dalam kita belajar, semakin rumit hal yang tampak sederhana."}},
    {"type":"paragraph","data":{"text":"Jadi lain kali makan stroberi, ingat: kamu sedang menikmati kumpulan buah-buah mini yang tersusun rapi."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'hewan'),
  'Kupu-kupu Mengecap Rasa dengan Kaki',
  'kupu-kupu-mengecap-dengan-kaki',
  'Kaki kupu-kupu adalah sensor rasa paling peka — hinggap saja sudah langsung menilai.',
  'https://upload.wikimedia.org/wikipedia/commons/3/3d/Fesoj_-_Papilio_machaon_%28by%29.jpg',
  '[
    {"type":"paragraph","data":{"text":"Kupu-kupu tidak mencicipi makanan dengan mulut. Mereka mencicipi dengan kaki."}},
    {"type":"heading","data":{"text":"Sensor Rasa di Ujung Kaki"}},
    {"type":"paragraph","data":{"text":"Di kaki kupu-kupu terdapat sel-sel sensilla yang peka terhadap rasa. Begitu hinggap di atas daun, mereka langsung tahu apakah daun itu cocok untuk makan atau bertelur."}},
    {"type":"fact","data":{"text":"Beberapa spesies kupu-kupu bisa melihat sinar ultraviolet — dunia terlihat jauh lebih berwarna bagi mereka."}},
    {"type":"list","data":{"items":["Mulut kupu-kupu berbentuk belalai untuk menghisap nektar","Ulat berubah menjadi kupu-kupu lewat metamorfosis total","Sebagian kupu-kupu terbang ribuan kilometer saat migrasi"]}},
    {"type":"quote","data":{"text":"Keindahan sayap kupu-kupu menyembunyikan sensor paling peka di ujung kakinya."}},
    {"type":"paragraph","data":{"text":"Jadi saat kupu-kupu hinggap di bahumu, bisa jadi ia sedang mencicipi kamu."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-17T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Efek Mpemba: Saat Air Panas Beku Lebih Cepat dari Air Dingin',
  'efek-mpemba-air-panas-membeku',
  'Fenomena yang ditemukan seorang siswa SMP dan masih misterius bagi para fisikawan.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Ice_Block%2C_Canal_Park%2C_Duluth_%2832752478892%29.jpg/1280px-Ice_Block%2C_Canal_Park%2C_Duluth_%2832752478892%29.jpg',
  '[
    {"type":"paragraph","data":{"text":"Pernah mendengar air panas bisa membeku lebih cepat daripada air dingin? Fenomena itu bernama efek Mpemba."}},
    {"type":"heading","data":{"text":"Misteri dari Siswa SMP"}},
    {"type":"paragraph","data":{"text":"Pada 1963, siswa SMP Tanzania bernama Erasto Mpemba mengamati es krim buatannya membeku lebih cepat saat adonannya panas. Gurunya tidak percaya, sampai seorang fisikawan memverifikasinya."}},
    {"type":"fact","data":{"text":"Nama efek ini diambil dari Erasto Mpemba, remaja yang pertama kali menelitinya secara ilmiah."}},
    {"type":"list","data":{"items":["Hingga kini mekanismenya masih diperdebatkan","Diduga terkait penguapan, konveksi, dan gas terlarut","Belum semua ilmuwan sepakat efek ini selalu terjadi"]}},
    {"type":"quote","data":{"text":"Kadang pertanyaan sederhana dari seorang anak sekolah mengguncang dunia fisika."}},
    {"type":"paragraph","data":{"text":"Sampai sekarang, efek Mpemba tetap menjadi misteri manis dalam perdebatan para fisikawan."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-18T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'kopi'),
  'Kenapa Kopi Membuatmu Melek: Bukan karena Energi',
  'kopi-membuat-melek',
  'Kafein tidak memberi tenaga — ia memblokir sinyal lelah di otakmu.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Latte_and_dark_coffee.jpg/1280px-Latte_and_dark_coffee.jpg',
  '[
    {"type":"paragraph","data":{"text":"Kopi tidak memberi energi. Ia justru memblokir sinyal lelah di otak."}},
    {"type":"heading","data":{"text":"Balik Layar Kafein"}},
    {"type":"paragraph","data":{"text":"Sepanjang hari otak menumpuk adenosin, molekul yang membuatmu mengantuk. Kafein masuk dan menempati reseptor adenosin, sehingga sinyal lelah tidak tersampaikan. Kamu tidak benar-benar segar — kamu hanya tidak mendengar teriakan lelahmu."}},
    {"type":"fact","data":{"text":"Setengah kafein yang kamu minum butuh sekitar 6 jam untuk hilang dari tubuh."}},
    {"type":"list","data":{"items":["Kopi adalah salah satu komoditas paling banyak diperdagangkan di dunia","Kopi tanpa kafein pun masih mengandung sedikit kafein","Efek kafein mulai terasa sekitar 15-30 menit setelah diminum"]}},
    {"type":"quote","data":{"text":"Kopi bukan mematikan alarm tidur — ia menutup telinga dari suara kantuk."}},
    {"type":"paragraph","data":{"text":"Jadi di pagi hari, secangkir kopi tidak memberi tenaga, melainkan menunda panggilan tidur tubuhmu."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-19T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'fakta-unik'),
  'Jamur Lebih Dekat ke Manusia daripada Tumbuhan',
  'jamur-lebih-dekat-ke-hewan',
  'Di pohon kehidupan, jamur adalah kerabat dekatmu — dan organisme terbesar di dunia.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Sparrige_Sch%C3%BCppling_%28Pholiota_squarrosa%29.jpg/1280px-Sparrige_Sch%C3%BCppling_%28Pholiota_squarrosa%29.jpg',
  '[
    {"type":"paragraph","data":{"text":"Secara evolusi, jamur lebih dekat kekerabatannya dengan hewan — termasuk manusia — dibandingkan dengan tumbuhan."}},
    {"type":"heading","data":{"text":"Keluarga yang Tak Terduga"}},
    {"type":"paragraph","data":{"text":"Jamur tidak berfotosintesis seperti tumbuhan. Seperti hewan, mereka menyerap makanan dari lingkungan, dan susunan genetiknya pun lebih mirip dengan kita."}},
    {"type":"fact","data":{"text":"Organisme hidup terbesar di dunia adalah jamur — jaringannya di Oregon membentang seluas hampir 1.000 hektar."}},
    {"type":"list","data":{"items":["Yang terlihat di permukaan hanyalah buahnya, sebagian besar tubuh jamur ada di dalam tanah","Jamur berperan penting mengurai material","Banyak obat penting, termasuk antibiotik, berasal dari jamur"]}},
    {"type":"quote","data":{"text":"Setiap kali makan jamur, secara silsilah kamu sedang menyantap sepupu jauh."}},
    {"type":"paragraph","data":{"text":"Jadi jangan keliru menaruh jamur di kelompok sayuran — di pohon kehidupan, mereka berdiri lebih dekat ke kamu."}}
  ]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-20T09:00:00Z'
)
on conflict (slug) do nothing;

-- ---------- SEKEJAP FAKTA ----------
insert into public.sekejap_facts (fact, article_id) values
  ('Madu tidak pernah basi — madu 3.000 tahun di makam Mesir masih bisa dimakan.', (select id from public.articles where slug = 'madu-tak-pernah-basi')),
  ('Setiap pisang yang dimakan mengandung sedikit radiasi alami.', (select id from public.articles where slug = 'pisang-sedikit-radioaktif')),
  ('Cabe terasa pedas karena capsaicin mengecoh reseptor panas di otak.', (select id from public.articles where slug = 'kenapa-cabe-terasa-pedas')),
  ('Tubuh manusia dewasa sekitar 60 persen terdiri dari air.', (select id from public.articles where slug = 'tubuh-60-persen-air')),
  ('Menguap bisa menular dan membantu mendinginkan otak.', (select id from public.articles where slug = 'menguap-menular')),
  ('Stroberi bukan berry, tetapi pisang, tomat, dan timun adalah berry.', (select id from public.articles where slug = 'stroberi-bukan-berry')),
  ('Kupu-kupu mencicipi rasa dengan kakinya.', (select id from public.articles where slug = 'kupu-kupu-mengecap-dengan-kaki')),
  ('Efek Mpemba: air panas kadang membeku lebih cepat daripada air dingin.', (select id from public.articles where slug = 'efek-mpemba-air-panas-membeku')),
  ('Kafein membuat melek dengan memblokir sinyal lelah, bukan memberi energi.', (select id from public.articles where slug = 'kopi-membuat-melek')),
  ('Jamur secara evolusi lebih dekat ke hewan daripada tumbuhan.', (select id from public.articles where slug = 'jamur-lebih-dekat-ke-hewan'))
on conflict (fact) do nothing;

-- ---------- SUMBER ----------
insert into public.sources (article_id, title, url, publisher) values
  ((select id from public.articles where slug = 'madu-tak-pernah-basi'), 'Honey', 'https://en.wikipedia.org/wiki/Honey', 'Wikipedia'),
  ((select id from public.articles where slug = 'pisang-sedikit-radioaktif'), 'Banana equivalent dose', 'https://en.wikipedia.org/wiki/Banana_equivalent_dose', 'Wikipedia'),
  ((select id from public.articles where slug = 'kenapa-cabe-terasa-pedas'), 'Capsaicin', 'https://en.wikipedia.org/wiki/Capsaicin', 'Wikipedia'),
  ((select id from public.articles where slug = 'tubuh-60-persen-air'), 'Body water', 'https://en.wikipedia.org/wiki/Body_water', 'Wikipedia'),
  ((select id from public.articles where slug = 'menguap-menular'), 'Yawn', 'https://en.wikipedia.org/wiki/Yawn', 'Wikipedia'),
  ((select id from public.articles where slug = 'stroberi-bukan-berry'), 'Strawberry', 'https://en.wikipedia.org/wiki/Strawberry', 'Wikipedia'),
  ((select id from public.articles where slug = 'kupu-kupu-mengecap-dengan-kaki'), 'Butterfly', 'https://en.wikipedia.org/wiki/Butterfly', 'Wikipedia'),
  ((select id from public.articles where slug = 'efek-mpemba-air-panas-membeku'), 'Mpemba effect', 'https://en.wikipedia.org/wiki/Mpemba_effect', 'Wikipedia'),
  ((select id from public.articles where slug = 'kopi-membuat-melek'), 'Caffeine', 'https://en.wikipedia.org/wiki/Caffeine', 'Wikipedia'),
  ((select id from public.articles where slug = 'jamur-lebih-dekat-ke-hewan'), 'Mushroom', 'https://en.wikipedia.org/wiki/Mushroom', 'Wikipedia')
on conflict (article_id, title) do nothing;
