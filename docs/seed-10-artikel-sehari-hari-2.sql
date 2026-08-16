-- ============================================================
-- SEKTA — SEED 10 ARTIKEL SEHARI-HARI BATCH 2 (+ kuis & fakta)
-- ============================================================
-- Jalankan di Supabase Dashboard → SQL Editor → Run.
-- Idempoten: artikel via slug, fakta via kolom unik, kuis via judul.
-- Kategori: manusia, sains, fakta-unik.

insert into public.articles (author_name, category_id, title, slug, excerpt, cover_image, content, read_time_minutes, status, published_at) values
(
  'Sekta',
  (select id from public.categories where slug = 'manusia'),
  'Kenapa Kita Cegukan? Refleks Kecil yang Mengganggu',
  'kenapa-kita-cegukan',
  'Cegukan datang tiba-tiba dan hilang sendiri — tapi apa yang sebenarnya terjadi di dalam tubuh?',
  'https://upload.wikimedia.org/wikipedia/commons/1/16/Diafragma_ademhaling.gif?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled',
  '[{"type":"paragraph","data":{"text":"Cegukan datang tanpa undangan: tiba-tiba \"hik\", lalu hilang sendiri. Meski sering dialami, mekanismenya masih mengejutkan banyak orang."}},{"type":"heading","data":{"text":"Refleks yang Tidak Disengaja"}},{"type":"paragraph","data":{"text":"Cegukan terjadi saat diafragma — otot utama pernapasan — berkontraksi tiba-tiba dan pita suara menutup cepat. Udara tersumbat sehingga muncul suara \"hik\" yang khas."}},{"type":"fact","data":{"text":"Cegukan terpanjang dalam sejarah tercatat berlangsung 68 tahun. Pemiliknya, Charles Osborne, mulai cegukan tahun 1922 dan baru berhenti tahun 1990."}},{"type":"list","data":{"items":["Makan terlalu cepat atau terlalu kenyang memicu cegukan","Makanan pedas dan minuman bersoda juga pemicu umum","Cegukan bayi di dalam kandungan sudah mulai terjadi di trimester akhir"]}},{"type":"quote","data":{"text":"Cegukan adalah pengingat bahwa tubuh punya refleks yang bekerja di luar kendali kita."}},{"type":"paragraph","data":{"text":"Menahan napas sebentar, menelan, atau meminum air perlahan sering membantu menghentikannya. Kalau cegukan tak kunjung berhenti berhari-hari, saatnya konsultasi ke dokter."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:22.668Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'manusia'),
  'Mengapa Wajah Merah saat Malu?',
  'mengapa-wajah-merah-saat-malu',
  'Tersipu adalah bahasa tubuh paling jujur — dan fenomena yang ternyata sangat langka di dunia hewan.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Blushing_girl_0001.jpg/960px-Blushing_girl_0001.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Semua orang pernah merasakannya: wajah terasa panas dan memerah saat melakukan kesalahan di depan banyak orang. Ini bukan sekadar malu — ada mekanisme tubuh di baliknya."}},{"type":"heading","data":{"text":"Adrenalin dan Pembuluh Darah"}},{"type":"paragraph","data":{"text":"Saat malu, otak memicu pelepasan adrenalin. Pembuluh darah di wajah melebar sehingga lebih banyak darah mengalir, dan kulit pun tampak memerah."}},{"type":"fact","data":{"text":"Tersipu karena malu hampir unik untuk manusia — hampir tidak ada hewan lain yang menunjukkan respons sosial seperti ini."}},{"type":"list","data":{"items":["Pelebaran pembuluh darah membuat wajah terasa panas","Tersipu bisa menular dalam kelompok","Wajah memerah juga bisa muncul karena marah atau olahraga"]}},{"type":"quote","data":{"text":"Wajah memerah adalah sinyal sosial yang sulit dipalsukan."}},{"type":"paragraph","data":{"text":"Para peneliti menduga tersipu berevolusi sebagai sinyal jujur yang menunjukkan rasa menyesal dan memperbaiki hubungan sosial."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:23.567Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Kenapa Susu Bisa Basi dan Berbau Asam?',
  'kenapa-susu-bisa-basi',
  'Susu yang ditinggalkan di suhu ruang berubah asam dalam hitungan jam — inilah biang keladinya.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Bowl_milk_glass.jpg/960px-Bowl_milk_glass.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Semua susu pada akhirnya akan basi — hanya masalah waktu. Yang menentukan cepat-lambatnya adalah suhu dan bakteri di sekitarnya."}},{"type":"heading","data":{"text":"Kerja Bakteri Asam Laktat"}},{"type":"paragraph","data":{"text":"Bakteri asam laktat mengubah laktosa (gula susu) menjadi asam laktat. Asam inilah yang membuat susu berbau asam, menggumpal, dan rasanya masam."}},{"type":"fact","data":{"text":"Pasteurisasi tidak membuat susu awet selamanya — ia hanya membunuh sebagian besar bakteri sehingga susu bertahan lebih lama di lemari es."}},{"type":"list","data":{"items":["Suhu hangat mempercepat perkembangbiakan bakteri","Susu basi menggumpal karena protein mengendap oleh asam","Susu UHT bertahan lebih lama karena dipanaskan lebih tinggi"]}},{"type":"quote","data":{"text":"Basi adalah kerja keras bakteri yang berubah menjadi masalah dapur."}},{"type":"paragraph","data":{"text":"Selama belum berbau asam atau menggumpal, susu masih aman. Begitu asam, buang saja — tubuhmu tidak butuh bakteri ekstra."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:24.220Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'manusia'),
  'Mengapa Gigi Bisa Berlubang?',
  'mengapa-gigi-bisa-berlubang',
  'Gigi punya lapisan terkeras di tubuh — tapi bakteri dan gula tetap bisa menang.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Dental_Caries_Cavity_2.JPG/960px-Dental_Caries_Cavity_2.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Enamel gigi adalah jaringan paling keras di tubuh manusia — lebih keras dari tulang. Namun gigi tetap bisa berlubang. Bagaimana bisa?"}},{"type":"heading","data":{"text":"Asam yang Ditimbulkan Bakteri"}},{"type":"paragraph","data":{"text":"Bakteri di mulut mengubah sisa gula menjadi asam. Asam itu perlahan melarutkan mineral enamel, lalu menembus dentin, dan akhirnya sampai ke pulpa yang berisi saraf — itulah saat gigi terasa ngilu."}},{"type":"fact","data":{"text":"Karies gigi adalah salah satu penyakit paling umum di dunia, bahkan mengalahkan banyak penyakit lainnya dalam jumlah penderita."}},{"type":"list","data":{"items":["Sikat gigi membantu menghilangkan plak sebelum menjadi asam","Air liur membantu menetralkan asam di mulut","Fluoride memperkuat enamel melawan asam"]}},{"type":"quote","data":{"text":"Gigi bukan musuh gula — musuh sebenarnya adalah asam hasil kerja bakteri."}},{"type":"paragraph","data":{"text":"Menjaga mulut bersih, mengurangi gula, dan rutin ke dokter gigi adalah kunci mencegah lubang sejak dini."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:25.283Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'manusia'),
  'Kenapa Badan Menggigil Saat Demam?',
  'kenapa-badan-menggigil-saat-demam',
  'Menggigil bukan karena kedinginan — itu cara tubuh menaikkan suhunya sendiri.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Symptoms-fever.jpg/960px-Symptoms-fever.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Saat demam mulai, kamu justru menggigil padahal tubuhmu panas. Ini terlihat kontradiktif, tapi sebenarnya sangat masuk akal."}},{"type":"heading","data":{"text":"Suhu yang Dinaikkan Suka-Suka Otak"}},{"type":"paragraph","data":{"text":"Hipotalamus di otak menaikkan \"pengaturan suhu\" tubuh saat melawan infeksi. Karena suhu tubuh masih di bawah angka itu, tubuh merasa \"dingin\" dan menggigil untuk menghasilkan panas."}},{"type":"fact","data":{"text":"Menggigil bisa menghasilkan panas hingga tiga sampai lima kali lebih banyak daripada kondisi normal."}},{"type":"list","data":{"items":["Menggigil adalah kerja otot yang menghasilkan panas","Obat penurun panas menggeser set point kembali normal","Suhu tubuh naik membantu melawan kuman"]}},{"type":"quote","data":{"text":"Menggigil saat demam bukan tanda kedinginan — ia adalah mekanisme pemanasan dari dalam."}},{"type":"paragraph","data":{"text":"Berpakaian nyaman dan cukup minum membantu tubuh melewati demam. Kalau demam sangat tinggi atau berhari-hari, segera periksakan ke tenaga medis."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:26.540Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Mengapa Gelas Dingin Berembun?',
  'mengapa-gelas-dingin-berembun',
  'Tetesan air di gelas es bukan bocor — itu uap udara yang kembali menjadi cair.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Lovelight_Texture_-29_Golden_Water_Droplets_Condensation_on_Glass_%286133977658%29.jpg/960px-Lovelight_Texture_-29_Golden_Water_Droplets_Condensation_on_Glass_%286133977658%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Es teh dingin di hari panas pasti \"berkeringat\". Padahal gelasnya tidak bocor — dan tetesan itu bahkan tidak selalu dari air minummu."}},{"type":"heading","data":{"text":"Perjalanan Uap Menjadi Cair"}},{"type":"paragraph","data":{"text":"Udara di sekitarmu mengandung uap air. Saat menyentuh permukaan gelas yang dingin, uap kehilangan energi, mengembun, dan berubah menjadi tetesan air di luar gelas."}},{"type":"fact","data":{"text":"Proses ini bernama kondensasi — fenomena yang sama saat embun pagi terbentuk di daun atau kaca buram di ruang mandi."}},{"type":"list","data":{"items":["Makin dingin gelas, makin cepat embun terbentuk","Udara lembap memperbanyak tetesan","Makin cepat uap mengembun di tempat yang lebih dingin dari titik embun"]}},{"type":"quote","data":{"text":"Setiap tetes di gelas es adalah uap udara yang pulang menjadi cair."}},{"type":"paragraph","data":{"text":"Letakkan gelas di atas tatakan, dan perhatikan: tetesan itu adalah cuaca mini yang sedang terjadi di meja makanmu."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:27.619Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'fakta-unik'),
  'Kenapa Tulang Kita Berbunyi "Krek"?',
  'kenapa-tulang-berbunyi-krek',
  'Bunyi krek saat menggerakkan jari atau leher biasanya bukan tanda patah tulang.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Macaca_sylvanus_feet_and_hands.JPG/960px-Macaca_sylvanus_feet_and_hands.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Pernah mendengar bunyi \"krek\" saat bangun pagi atau menggerakkan leher? Tenang, sebagian besar bunyi itu normal dan tidak berbahaya."}},{"type":"heading","data":{"text":"Gas yang Lepas di Sendi"}},{"type":"paragraph","data":{"text":"Antara tulang ada cairan sendi yang mengandung gas terlarut. Saat sendi diregangkan, tekanannya turun dan gas membentuk gelembung yang pecah — itulah sumber bunyi krek."}},{"type":"fact","data":{"text":"Bunyi krek pada jari bukan tanda radang sendi. Penelitian besar gagal menemukan hubungannya dengan nyeri sendi."}},{"type":"list","data":{"items":["Cairan sendi disebut cairan sinovial","Setelah berbunyi, butuh waktu beberapa menit untuk bunyi lagi","Krek berulang disertai nyeri atau bengkak perlu diperiksa"]}},{"type":"quote","data":{"text":"Krek di persendian sering kali hanya ucapan selamat pagi dari gas nitrogen."}},{"type":"paragraph","data":{"text":"Yang perlu diwaspadai adalah krek yang datang bersama nyeri, bengkak, atau bunyi yang \"terkunci\" — itu tanda untuk bertanya ke dokter."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:28.652Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Mengapa Makanan Manis Membuat Ketagihan?',
  'mengapa-makanan-manis-membuat-ketagihan',
  'Gula bukan sekadar rasa — ia berbicara langsung ke pusat kesenangan otak.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/3D_printed_sugar_cube.gk.jpg/960px-3D_printed_sugar_cube.gk.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Satu potong kue saja tidak pernah cukup. Bukan karena kurang nafsu — ada jalur kimia di otak yang membuat kita menginginkan lebih."}},{"type":"heading","data":{"text":"Dopamin dan Sinyal Bahagia"}},{"type":"paragraph","data":{"text":"Gula memicu pelepasan dopamin, neurotransmiter yang membuat kita merasa senang. Jalur ini sama dengan yang diaktifkan oleh hal-hal menyenangkan lain — itulah mengapa manis terasa \"kecanduan\"."}},{"type":"fact","data":{"text":"Penelitian pada hewan menunjukkan gula bisa memicu sinyal dopamin berulang, menyerupai pola yang terlihat pada kecanduan zat."}},{"type":"list","data":{"items":["Gula alami dari buah disertai serat yang memperlambat penyerapan","Gula tambahan pada minuman cepat terserap dan cepat memicu lonjakan","Lonjakan gula diikuti penurunan yang membuat kita lapar lagi"]}},{"type":"quote","data":{"text":"Manis adalah bahasa yang dipahami otak sebelum lidah sempat menerjemahkannya."}},{"type":"paragraph","data":{"text":"Bukan berarti gula harus dihindari total — cukup kenali polanya, dan pilih sumber manis yang datang bersama serat dan nutrisi."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:29.509Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'fakta-unik'),
  'Kenapa Hidung Meler Saat Makan Pedas?',
  'kenapa-hidung-meler-saat-makan-pedas',
  'Hidung meler saat makan pedas bukan gangguan — itu sistem pertahanan tubuh yang sedang bekerja.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Capsicum_baccatum_in_Sa%C3%BAde_flea_market%2C_S%C3%A3o_Paulo%2C_Brazil.jpg/960px-Capsicum_baccatum_in_Sa%C3%BAde_flea_market%2C_S%C3%A3o_Paulo%2C_Brazil.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Sepiring sambal bisa membuat mata berair dan hidung ikut meler. Ternyata keduanya adalah satu sistem pertahanan yang sama."}},{"type":"heading","data":{"text":"Lendir yang Bertugas Menjaga"}},{"type":"paragraph","data":{"text":"Capsaicin dari cabe merangsang saraf yang memerintahkan produksi lendir berlebih. Tubuh mencoba \"membilas\" zat yang dianggap mengganggu — hasilnya hidungmu meler."}},{"type":"fact","data":{"text":"Tubuh memproduksi sekitar 1,5 liter lendir setiap hari, sebagian besar tertelan tanpa kita sadari."}},{"type":"list","data":{"items":["Lendir menangkap debu dan kuman sebelum masuk paru-paru","Susu membantu karena proteinnya mengikat capsaicin","Makin pedas, makin deras produksi lendirnya"]}},{"type":"quote","data":{"text":"Hidung meler saat makan pedas adalah cara tubuh berkata \"ini terlalu ekstrem, kubersihkan dulu\"."}},{"type":"paragraph","data":{"text":"Jadi bukan kebetulan hidung ikut \"menangis\" saat mulut terbakar — keduanya saling membantu menjaga tubuhmu."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:30.141Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'manusia'),
  'Mengapa Mata Sering Berkedut?',
  'mengapa-mata-sering-berkedut',
  'Kelopak mata yang berkedut sendiri biasanya bukan pertanda apa-apa — tapi ada pemicunya.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Eye_iris.jpg/960px-Eye_iris.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
  '[{"type":"paragraph","data":{"text":"Kelopak mata tiba-tiba berkedut selama beberapa detik lalu berhenti. Banyak orang mengaitkannya dengan mitos — padahal ada penjelasan medisnya."}},{"type":"heading","data":{"text":"Myokimia, Bukan Mistis"}},{"type":"paragraph","data":{"text":"Kedutan kelopak mata disebut myokymia — kontraksi kecil otot di kelopak yang tidak terkendali. Penyebabnya biasanya kelelahan, stres, atau kafein berlebih."}},{"type":"fact","data":{"text":"Myokymia hampir selalu tidak berbahaya dan hilang sendiri dalam hitungan hari tanpa pengobatan."}},{"type":"list","data":{"items":["Kurang tidur adalah pemicu paling umum","Mengurangi kafein bisa menghentikan kedutan","Kedutan yang menyebar ke seluruh wajah perlu diperiksa"]}},{"type":"quote","data":{"text":"Berkedutnya kelopak mata adalah kode sederhana: istirahat, minum air, dan kurangi kopi."}},{"type":"paragraph","data":{"text":"Kalau kedutan bertahan berminggu-minggu atau menyebar ke bagian wajah lain, konsultasikan ke dokter untuk memastikan semuanya normal."}}]'::jsonb,
  3,
  'PUBLISHED',
  '2026-08-16T13:33:30.750Z'
)
on conflict (slug) do nothing;

-- ---------- SEKEJAP FAKTA ----------
insert into public.sekejap_facts (fact, article_id) values
('Cegukan terpanjang yang tercatat berlangsung 68 tahun tanpa henti.', (select id from public.articles where slug = 'kenapa-kita-cegukan')),
('Tersipu malu hampir tidak ditemukan pada hewan lain — ini keunikan manusia.', (select id from public.articles where slug = 'mengapa-wajah-merah-saat-malu')),
('Susu basi terjadi karena bakteri mengubah gula laktosa menjadi asam laktat.', (select id from public.articles where slug = 'kenapa-susu-bisa-basi')),
('Enamel gigi adalah jaringan paling keras yang dimiliki tubuh manusia.', (select id from public.articles where slug = 'mengapa-gigi-bisa-berlubang')),
('Menggigil saat demam bisa menghasilkan panas hingga 3-5 kali lipat dari normal.', (select id from public.articles where slug = 'kenapa-badan-menggigil-saat-demam')),
('Embun di gelas dingin adalah uap air di udara yang mengembun kembali menjadi cair.', (select id from public.articles where slug = 'mengapa-gelas-dingin-berembun')),
('Bunyi krek di jari berasal dari gelembung gas nitrogen yang pecah di cairan sendi.', (select id from public.articles where slug = 'kenapa-tulang-berbunyi-krek')),
('Gula memicu pelepasan dopamin di otak — jalur yang sama dengan hal-hal menyenangkan.', (select id from public.articles where slug = 'mengapa-makanan-manis-membuat-ketagihan')),
('Tubuh manusia memproduksi sekitar 1,5 liter lendir setiap hari.', (select id from public.articles where slug = 'kenapa-hidung-meler-saat-makan-pedas')),
('Kelopak mata yang berkedut disebut myokymia dan hampir selalu tidak berbahaya.', (select id from public.articles where slug = 'mengapa-mata-sering-berkedut'))
on conflict (fact) do nothing;

-- ---------- SUMBER ----------
insert into public.sources (article_id, title, url, publisher) values
((select id from public.articles where slug = 'kenapa-kita-cegukan'), 'Hiccup', 'https://en.wikipedia.org/wiki/Hiccup', 'Wikipedia'),
((select id from public.articles where slug = 'mengapa-wajah-merah-saat-malu'), 'Blushing', 'https://en.wikipedia.org/wiki/Blushing', 'Wikipedia'),
((select id from public.articles where slug = 'kenapa-susu-bisa-basi'), 'Sour milk', 'https://en.wikipedia.org/wiki/Sour_milk', 'Wikipedia'),
((select id from public.articles where slug = 'mengapa-gigi-bisa-berlubang'), 'Tooth decay', 'https://en.wikipedia.org/wiki/Tooth_decay', 'Wikipedia'),
((select id from public.articles where slug = 'kenapa-badan-menggigil-saat-demam'), 'Fever', 'https://en.wikipedia.org/wiki/Fever', 'Wikipedia'),
((select id from public.articles where slug = 'mengapa-gelas-dingin-berembun'), 'Condensation', 'https://en.wikipedia.org/wiki/Condensation', 'Wikipedia'),
((select id from public.articles where slug = 'kenapa-tulang-berbunyi-krek'), 'Cracking joints', 'https://en.wikipedia.org/wiki/Cracking_joints', 'Wikipedia'),
((select id from public.articles where slug = 'mengapa-makanan-manis-membuat-ketagihan'), 'Sugar and the brain', 'https://en.wikipedia.org/wiki/Sugar_addiction', 'Wikipedia'),
((select id from public.articles where slug = 'kenapa-hidung-meler-saat-makan-pedas'), 'Capsaicin', 'https://en.wikipedia.org/wiki/Capsaicin', 'Wikipedia'),
((select id from public.articles where slug = 'mengapa-mata-sering-berkedut'), 'Fasciculation', 'https://en.wikipedia.org/wiki/Fasciculation', 'Wikipedia')
on conflict (article_id, title) do nothing;

-- ---------- KUIS ----------
insert into public.quizzes (title, description, article_id)
  values ('Kuis: Kenapa Kita Cegukan? Refleks Kecil yang Mengganggu', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-kita-cegukan'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Apa penyebab langsung munculnya cegukan?'),
  (2, 'Suara "hik" pada cegukan muncul karena...'),
  (3, 'Manakah pernyataan yang benar tentang cegukan?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-kita-cegukan')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kontraksi diafragma yang tiba-tiba', true, 1),
  (1, 'Kekurangan vitamin C', false, 2),
  (1, 'Terlalu banyak minum air', false, 3),
  (1, 'Aliran darah ke kepala meningkat', false, 4),
  (2, 'Pita suara menutup cepat saat udara tersumbat', true, 1),
  (2, 'Lidah bergetar karena dingin', false, 2),
  (2, 'Tulang rusuk bergeser', false, 3),
  (2, 'Gigi mengatup tanpa sengaja', false, 4),
  (3, 'Makan terlalu cepat bisa memicunya', true, 1),
  (3, 'Cegukan hanya terjadi saat tidur', false, 2),
  (3, 'Cegukan menandakan penyakit jantung', false, 3),
  (3, 'Cegukan tidak bisa dihentikan dengan cara apa pun', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-kita-cegukan')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Mengapa Wajah Merah saat Malu?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'mengapa-wajah-merah-saat-malu'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Wajah merah saat malu disebabkan oleh...'),
  (2, 'Apa fungsi evolusioner tersipu?'),
  (3, 'Manakah pernyataan yang benar?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'mengapa-wajah-merah-saat-malu')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Adrenalin melebarkan pembuluh darah wajah', true, 1),
  (1, 'Kekurangan oksigen di kulit', false, 2),
  (1, 'Suhu tubuh naik karena demam', false, 3),
  (1, 'Alergi terhadap lingkungan', false, 4),
  (2, 'Menjadi sinyal jujur untuk memperbaiki hubungan sosial', true, 1),
  (2, 'Menakuti pemangsa', false, 2),
  (2, 'Membuat lawan bicara menyerah', false, 3),
  (2, 'Menjaga suhu tubuh tetap hangat', false, 4),
  (3, 'Tersipu hampir unik untuk manusia', true, 1),
  (3, 'Semua hewan ikut tersipu saat malu', false, 2),
  (3, 'Tersipu terjadi karena otot wajah mengecil', false, 3),
  (3, 'Wajah merah selalu tanda demam', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'mengapa-wajah-merah-saat-malu')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Kenapa Susu Bisa Basi dan Berbau Asam?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-susu-bisa-basi'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Penyebab utama susu menjadi basi adalah...'),
  (2, 'Mengapa susu basi menggumpal?'),
  (3, 'Apa fungsi pasteurisasi?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-susu-bisa-basi')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Bakteri mengubah laktosa menjadi asam laktat', true, 1),
  (1, 'Udara dingin merusak protein', false, 2),
  (1, 'Vitamin hilang terkena cahaya', false, 3),
  (1, 'Susu terlalu lama di lemari es', false, 4),
  (2, 'Protein mengendap karena pengaruh asam', true, 1),
  (2, 'Bakteri membekukan susu', false, 2),
  (2, 'Kandungan lemak memadat', false, 3),
  (2, 'Susu kehilangan airnya', false, 4),
  (3, 'Membunuh sebagian besar bakteri agar susu tahan lebih lama', true, 1),
  (3, 'Menambahkan rasa manis', false, 2),
  (3, 'Membuat susu selalu segar tanpa batas waktu', false, 3),
  (3, 'Menghilangkan semua kandungan lemak', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-susu-bisa-basi')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Mengapa Gigi Bisa Berlubang?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'mengapa-gigi-bisa-berlubang'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Proses gigi berlubang dimulai dari...'),
  (2, 'Bahan apa yang memperkuat enamel melawan asam?'),
  (3, 'Manakah pernyataan yang benar?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'mengapa-gigi-bisa-berlubang')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Bakteri mengubah gula menjadi asam yang melarutkan enamel', true, 1),
  (1, 'Gigi mengeras karena terlalu banyak kalsium', false, 2),
  (1, 'Sikat gigi terlalu keras mengikis gigi', false, 3),
  (1, 'Kekurangan vitamin D langsung melubangi gigi', false, 4),
  (2, 'Fluoride', true, 1),
  (2, 'Kafein', false, 2),
  (2, 'Asam sitrat', false, 3),
  (2, 'Garam meja', false, 4),
  (3, 'Air liur membantu menetralkan asam di mulut', true, 1),
  (3, 'Gigi berlubang tidak bisa dicegah', false, 2),
  (3, 'Enamel lebih lunak dari tulang', false, 3),
  (3, 'Bakteri tidak berperan dalam kerusakan gigi', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'mengapa-gigi-bisa-berlubang')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Kenapa Badan Menggigil Saat Demam?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-badan-menggigil-saat-demam'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Kenapa tubuh menggigil saat demam?'),
  (2, 'Apa fungsi kenaikan suhu saat demam?'),
  (3, 'Bagaimana obat penurun panas bekerja?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-badan-menggigil-saat-demam')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Hipotalamus menaikkan pengaturan suhu sehingga tubuh berusaha memanaskan diri', true, 1),
  (1, 'Tubuh kehilangan banyak air', false, 2),
  (1, 'Vitamin C berlebih membuat otot menegang', false, 3),
  (1, 'Darah mengental karena dingin', false, 4),
  (2, 'Membantu tubuh melawan infeksi', true, 1),
  (2, 'Mempercepat pertumbuhan bakteri', false, 2),
  (2, 'Mengurangi kebutuhan tidur', false, 3),
  (2, 'Meningkatkan produksi keringat saja', false, 4),
  (3, 'Menurunkan set point suhu di hipotalamus', true, 1),
  (3, 'Membekukan darah', false, 2),
  (3, 'Menyedot panas lewat kulit', false, 3),
  (3, 'Menonaktifkan otot penggigil', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-badan-menggigil-saat-demam')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Mengapa Gelas Dingin Berembun?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'mengapa-gelas-dingin-berembun'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Tetesan air di luar gelas dingin berasal dari...'),
  (2, 'Apa nama proses ini?'),
  (3, 'Manakah yang membuat gelas lebih cepat berembun?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'mengapa-gelas-dingin-berembun')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Uap air di udara yang mengembun', true, 1),
  (1, 'Air minum yang merembes keluar', false, 2),
  (1, 'Retakan pada gelas', false, 3),
  (1, 'Es yang mencair di dalam gelas', false, 4),
  (2, 'Kondensasi', true, 1),
  (2, 'Evaporasi', false, 2),
  (2, 'Sublimasi', false, 3),
  (2, 'Filtrasi', false, 4),
  (3, 'Udara yang lembap dan gelas yang dingin', true, 1),
  (3, 'Udara sangat kering', false, 2),
  (3, 'Gelas yang panas', false, 3),
  (3, 'Kandungan gula dalam minuman', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'mengapa-gelas-dingin-berembun')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Kenapa Tulang Kita Berbunyi "Krek"?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-tulang-berbunyi-krek'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Bunyi "krek" pada sendi berasal dari...'),
  (2, 'Apa nama cairan pelumas di sendi?'),
  (3, 'Manakah yang benar tentang krek sendi?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-tulang-berbunyi-krek')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Gelembung gas nitrogen yang pecah di cairan sendi', true, 1),
  (1, 'Pergeseran tulang yang patah', false, 2),
  (1, 'Tendon yang putus', false, 3),
  (1, 'Aliran darah yang tersumbat', false, 4),
  (2, 'Cairan sinovial', true, 1),
  (2, 'Cairan serebrospinal', false, 2),
  (2, 'Plasma darah', false, 3),
  (2, 'Getah bening', false, 4),
  (3, 'Krek jari tidak terbukti menyebabkan radang sendi', true, 1),
  (3, 'Krek selalu tanda patah tulang', false, 2),
  (3, 'Krek hanya terjadi pada orang tua', false, 3),
  (3, 'Bunyi krek berarti sendi rusak permanen', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-tulang-berbunyi-krek')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Mengapa Makanan Manis Membuat Ketagihan?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'mengapa-makanan-manis-membuat-ketagihan'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Mengapa makanan manis terasa "membuat ketagihan"?'),
  (2, 'Apa kelebihan gula alami dari buah?'),
  (3, 'Manakah yang benar tentang gula tambahan?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'mengapa-makanan-manis-membuat-ketagihan')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Gula memicu pelepasan dopamin di otak', true, 1),
  (1, 'Gula menumpuk di otot', false, 2),
  (1, 'Gula membuat pembuluh darah menyempit', false, 3),
  (1, 'Gula mematikan reseptor rasa lainnya', false, 4),
  (2, 'Datang bersama serat yang memperlambat penyerapan', true, 1),
  (2, 'Tidak mengandung kalori sama sekali', false, 2),
  (2, 'Langsung diserap seluruhnya oleh lambung', false, 3),
  (2, 'Membuat tubuh tidak perlu insulin', false, 4),
  (3, 'Cepat terserap dan bisa memicu lonjakan gula darah', true, 1),
  (3, 'Selalu aman dalam jumlah berapa pun', false, 2),
  (3, 'Hanya ditemukan di minuman soda', false, 3),
  (3, 'Tidak berpengaruh pada rasa lapar', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'mengapa-makanan-manis-membuat-ketagihan')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Kenapa Hidung Meler Saat Makan Pedas?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-hidung-meler-saat-makan-pedas'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Kenapa makan pedas membuat hidung meler?'),
  (2, 'Mengapa susu lebih efektif meredakan pedas daripada air?'),
  (3, 'Apa fungsi utama lendir di saluran napas?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-hidung-meler-saat-makan-pedas')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Capsaicin merangsang produksi lendir untuk membilas', true, 1),
  (1, 'Pedas menyebabkan dehidrasi', false, 2),
  (1, 'Keringat mengalir ke hidung', false, 3),
  (1, 'Alergi terhadap cabe', false, 4),
  (2, 'Protein susu mengikat capsaicin', true, 1),
  (2, 'Susu lebih dingin dari air', false, 2),
  (2, 'Susu mengandung gula', false, 3),
  (2, 'Susu mengencerkan lambung', false, 4),
  (3, 'Menangkap debu dan kuman', true, 1),
  (3, 'Menghasilkan oksigen', false, 2),
  (3, 'Memanaskan makanan', false, 3),
  (3, 'Mengunyah makanan', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-hidung-meler-saat-makan-pedas')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kuis: Mengapa Mata Sering Berkedut?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'mengapa-mata-sering-berkedut'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Nama medis untuk kedutan kelopak mata adalah...'),
  (2, 'Apa pemicu paling umum mata berkedut?'),
  (3, 'Kapan kedutan mata perlu diperiksa dokter?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'mengapa-mata-sering-berkedut')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Myokymia', true, 1),
  (1, 'Miopia', false, 2),
  (1, 'Migrain', false, 3),
  (1, 'Katarak', false, 4),
  (2, 'Kelelahan dan kurang tidur', true, 1),
  (2, 'Makan buah berlebihan', false, 2),
  (2, 'Terlalu banyak minum air', false, 3),
  (2, 'Angin malam', false, 4),
  (3, 'Saat menyebar ke seluruh wajah atau bertahan berminggu-minggu', true, 1),
  (3, 'Saat terjadi sekali dalam sebulan', false, 2),
  (3, 'Saat berlangsung satu detik', false, 3),
  (3, 'Tidak perlu pernah', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'mengapa-mata-sering-berkedut')
on conflict (question_id, position) do nothing;

