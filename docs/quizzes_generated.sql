-- ==========================================================
-- KUIS OTOMATIS untuk artikel yang belum punya kuis
-- Di-generasi 2026-08-15T07:35:43.299Z oleh scripts/generate-quizzes.mjs
-- Jalankan di Supabase SQL Editor (idempoten, on conflict do nothing).
-- ==========================================================

insert into public.quizzes (title, description, article_id)
  values ('Misteri Pembangunan Piramida Mesir yang Belum Terpecahkan', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'misteri-piramida-mesir'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'misteri-piramida-mesir')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Saat efek habis, rasa lelah bisa datang sekaligus', false, 1),
  (1, 'Misi Apollo 11 berangkat dari Kennedy Space Center', false, 2),
  (1, 'Hingga kini, tidak ada satu pun teori yang disepakati penuh.', false, 3),
  (1, 'Piramida Agung Giza adalah satu-satunya keajaiban dunia kuno yang masih berdiri.', true, 4),
  (2, 'Kecerdasan buatan tidak lagi menjadi bahan cerita fiksi ilmiah.', false, 1),
  (2, 'Pelangi terlihat melengkung karena semua titik yang memantulkan cahaya ke matamu berada pada lingkaran sudut yang sama.', false, 2),
  (2, 'Indonesia terkenal dengan Arabika Gayo dari Aceh dan Robusta dari berbagai daerah lain.', false, 3),
  (2, 'Namun bagaimana nenek moyang membangunnya tanpa teknologi modern masih menjadi perdebatan.', true, 4),
  (3, 'Para ilmuwan belum sepenuhnya sepakat mengapa kita menguap.', false, 1),
  (3, 'Sejumlah ahli menduga para pekerja menarik balok batu raksasa di atas ramping pasir yang licin.', true, 2),
  (3, 'Namun bagaimana nenek moyang membangunnya tanpa teknologi modern masih menjadi perdebatan.', false, 3),
  (3, 'Fenomena itu bernama efek Mpemba.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'misteri-piramida-mesir')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Negara Terkecil di Dunia yang Jarang Diketahui', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'negara-terkecil-di-dunia'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'negara-terkecil-di-dunia')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kamu mungkin mengira jari mengerut karena menyerap air.', false, 1),
  (1, 'Vatikan, dengan luas sekitar 0,44 kilometer persegi, adalah negara berdaulat terkecil di dunia.', true, 2),
  (1, 'Cahaya biru lebih mudah tersebar oleh molekul udara karena memiliki panjang gelombang yang lebih pendek.', false, 3),
  (1, 'Keduanya respons evolusioner untuk kondisi basah', false, 4),
  (2, 'Tenang, madu hampir tidak mungkin basi — inilah salah satu keajaiban kecil di dapurmu.', false, 1),
  (2, 'Yaman menjadi gerbang penyebaran kopi ke dunia', false, 2),
  (2, 'Ia dikelilingi kota Roma, Italia, dan menjadi pusat Gereja Katolik.', true, 3),
  (2, 'Diperkirakan melibatkan puluhan ribu pekerja', false, 4),
  (3, 'Negara lain yang tak kalah kecil: Monako (2 km²) dan Nauru (21 km²).', false, 1),
  (3, 'Tidak punya bandara maupun stasiun kereta sendiri', true, 2),
  (3, 'Cahaya biru lebih mudah tersebar oleh molekul udara karena memiliki panjang gelombang yang lebih pendek.', false, 3),
  (3, 'Mengalirkan air keluar sehingga jari mencengkeram lebih baik', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'negara-terkecil-di-dunia')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Apa Itu Antimateri? Penjelasan Sederhana', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'apa-itu-antimateri'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'apa-itu-antimateri')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kamu mungkin mengira jari mengerut karena menyerap air.', false, 1),
  (1, 'Nama efek ini diambil dari Erasto Mpemba, remaja yang pertama kali menelitinya secara ilmiah.', false, 2),
  (1, 'Setiap partikel di alam semesta memiliki kembaran yang disebut antipartikel.', true, 3),
  (1, 'Setengah kafein yang kamu minum butuh sekitar 6 jam untuk hilang dari tubuh.', false, 4),
  (2, 'Pekerjaan yang paling terdampak bukan yang paling kompleks, melainkan yang paling berulang.', false, 1),
  (2, 'Antipartikel punya muatan berlawanan, tapi massa yang sama persis.', true, 2),
  (2, 'Ulat berubah menjadi kupu-kupu lewat metamorfosis total', false, 3),
  (2, 'Namun bagaimana nenek moyang membangunnya tanpa teknologi modern masih menjadi perdebatan.', false, 4),
  (3, 'Membuat antimateri di laboratorium sangat sulit dan boros energi.', true, 1),
  (3, 'Manusia bisa bertahan berminggu-minggu tanpa makanan, tetapi hanya sekitar 3-7 hari tanpa air.', false, 2),
  (3, 'Malaria sendiri menyumbang ratusan ribu kematian, mayoritas anak-anak di bawah lima tahun.', false, 3),
  (3, 'Salinitas danau bisa mencapai sekitar 380 gram garam per liter', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'apa-itu-antimateri')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Bagaimana AI Akan Mengubah Cara Kita Bekerja?1', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'bagaimana-ai-mengubah-cara-kerja'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'bagaimana-ai-mengubah-cara-kerja')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kecerdasan buatan tidak lagi menjadi bahan cerita fiksi ilmiah.', true, 1),
  (1, 'Nama efek ini diambil dari Erasto Mpemba, remaja yang pertama kali menelitinya secara ilmiah.', false, 2),
  (1, 'Sepanjang hari otak menumpuk adenosin, molekul yang membuatmu mengantuk.', false, 3),
  (1, 'Jari yang mengerut terbukti membantu mencengkeram benda basah lebih mantap.', false, 4),
  (2, 'Saat gurita berenang, jantung utama justru berhenti berdetak — itulah sebabnya ia lebih suka merangkak.', false, 1),
  (2, 'Dari menulis ringkasan sampai mengoreksi kode, AI sudah menjadi rekan kerja sehari-hari.', true, 2),
  (2, 'Proses fermentasi alami mengurangi rasa pahit', false, 3),
  (2, 'Kopi tanpa kafein pun masih mengandung sedikit kafein', false, 4),
  (3, 'Membaca kata menguap saja bisa membuatmu menguap.', false, 1),
  (3, 'Justru itulah yang membuatnya tetap misterius dan menarik untuk diselidiki.', false, 2),
  (3, 'Hingga kini, tidak ada satu pun teori yang disepakati penuh.', false, 3),
  (3, 'Pekerjaan yang paling terdampak bukan yang paling kompleks, melainkan yang paling berulang.', true, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'bagaimana-ai-mengubah-cara-kerja')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Mengapa Tidur Sangat Penting bagi Otak?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'mengapa-tidur-penting'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'mengapa-tidur-penting')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Mata uangnya Euro, posnya diurus Italia', false, 1),
  (1, 'Air mengatur suhu tubuh lewat keringat', false, 2),
  (1, 'Saat kamu tidur, otak tidak ikut mati.', true, 3),
  (1, 'Hormon pertumbuhan disekresikan saat tidur dalam', false, 4),
  (2, 'Ia justru bekerja keras: membersihkan racun, mengkonsolidasikan memori, dan memperbaiki jaringan.', true, 1),
  (2, 'Jika Gunung Everest ditaruh di sana, puncaknya masih berada lebih dari satu kilometer di bawah permukaan laut.', false, 2),
  (2, 'Menurut NOAA, air laut rata-rata hanya mengandung emas sekitar satu gram per 100 juta ton air.', false, 3),
  (2, 'Swiss Water Process dikembangkan untuk menghilangkan kafein dengan air murni', false, 4),
  (3, 'Ketika tidur nyenyak, sistem glimfatik otak aktif membersihkan protein beta-amiloid yang berkaitan dengan penyakit Alzhe', true, 1),
  (3, 'Saat gurita berenang, jantung utama justru berhenti berdetak — itulah sebabnya ia lebih suka merangkak.', false, 2),
  (3, 'Tidak punya bandara maupun stasiun kereta sendiri', false, 3),
  (3, 'Kabar kurang menarik: konsentrasinya sangat, sangat encer.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'mengapa-tidur-penting')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Danau Retba: Danau Pink di Senegal yang Super Asin', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'danau-pink-senegal'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'danau-pink-senegal')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Warna pink danau paling kuat terlihat di musim kemarau saat salinitas naik.', false, 1),
  (1, 'Tekanan di sana mencapai jutaan kali tekanan atmosfer', false, 2),
  (1, 'Di dekat ibu kota Senegal, Dakar, terdapat danau yang tampak seperti air stroberi raksasa: Danau Retba.', true, 3),
  (1, 'Stroberi berasal dari bunga dengan banyak ovarium, dan titik-titik di permukaannya sebenarnya adalah buah-buah kecil ber', false, 4),
  (2, 'Keasamannya menghambat pertumbuhan mikroorganisme', false, 1),
  (2, 'Antipartikel punya muatan berlawanan, tapi massa yang sama persis.', false, 2),
  (2, 'Salinitas danau bisa mencapai sekitar 380 gram garam per liter', true, 3),
  (2, 'Bentuk itu adalah hasil pasti dari bagaimana cahaya dibiaskan di dalam tetesan air.', false, 4),
  (3, 'Orang dewasa disarankan tidur 7–9 jam per malam. Kurang dari 6 jam secara konsisten dikaitkan dengan penurunan daya inga', false, 1),
  (3, 'Jauh lebih asin daripada air laut biasa', true, 2),
  (3, 'Neil Armstrong keluar dari modul Apollo 11 dan menjadi manusia pertama yang menginjakkan kaki di permukaan Bulan.', false, 3),
  (3, 'Emosi dan suasana hati diproses ulang saat bermimpi', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'danau-pink-senegal')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Sejarah Singkat Penemuan Internet', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'sejarah-singkat-internet'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'sejarah-singkat-internet')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Berry botani adalah buah berdaging yang berasal dari satu bunga dan bijinya tertanam di dalam daging buah.', false, 1),
  (1, 'Cahaya biru lebih mudah tersebar oleh molekul udara karena memiliki panjang gelombang yang lebih pendek.', false, 2),
  (1, 'Pernah merasa langsung segar setelah seteguk kopi?', false, 3),
  (1, 'Internet lahir dari proyek ARPANET milik Departemen Pertahanan Amerika pada akhir 1960-an.', true, 4),
  (2, 'Pada 1989, Tim Berners-Lee mengajukan sistem hypertext yang kelak menjadi World Wide Web.', false, 1),
  (2, 'Tujuannya sederhana: menghubungkan komputer antar kampus agar data tetap bisa dikirim saat sebagian jaringan rusak.', true, 2),
  (2, 'Itulah kenapa saat matahari terbenam, langit berubah jingga dan merah.', false, 3),
  (2, 'Sekitar 60 persen tubuh orang dewasa terdiri dari air — dan angka itu bukan sekadar statistik.', false, 4),
  (3, 'Pada 1989, Tim Berners-Lee mengajukan sistem hypertext yang kelak menjadi World Wide Web.', true, 1),
  (3, 'Batu diangkut dari tambang sejauh ratusan kilometer', false, 2),
  (3, 'Justru itulah yang membuatnya tetap misterius dan menarik untuk diselidiki.', false, 3),
  (3, 'Saat efek habis, rasa lelah bisa datang sekaligus', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'sejarah-singkat-internet')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Madu yang Tak Pernah Basi', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'madu-tak-pernah-basi'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'madu-tak-pernah-basi')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Beberapa toples madu yang ditemukan di makam Mesir kuno bahkan masih aman dikonsumsi.', false, 1),
  (1, 'Kurang tidur berarti sampah itu menumpuk.', false, 2),
  (1, 'Misi Vostok 1 hanya berlangsung 108 menit.', false, 3),
  (1, 'Pernah lihat madu mengkristal dan mengira sudah rusak?', true, 4),
  (2, 'Saat bertahan, tardigrade mengerut jadi bentuk seperti tong dan memperlambat metabolisme hingga nyaris berhenti.', false, 1),
  (2, 'Tenang, madu hampir tidak mungkin basi — inilah salah satu keajaiban kecil di dapurmu.', true, 2),
  (2, 'Jauh lebih asin daripada air laut biasa', false, 3),
  (2, 'Beberapa toples madu yang ditemukan di makam Mesir kuno bahkan masih aman dikonsumsi.', false, 4),
  (3, 'Ditambah enzim yang dihasilkan lebah, kondisi ini membuat bakteri dan jamur kesulitan bertahan hidup.', false, 1),
  (3, 'Radiasi dari satu pisang sangat kecil — sekitar 0,1 microsievert.', false, 2),
  (3, 'Jauh lebih asin daripada air laut biasa', false, 3),
  (3, 'Madu mengandung sedikit air dan sangat asam.', true, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'madu-tak-pernah-basi')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Setiap Pisang yang Kamu Makan Sedikit Radioaktif', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'pisang-sedikit-radioaktif'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'pisang-sedikit-radioaktif')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kedai kopi pertama di Eropa dibuka di Venesia sekitar 1645', false, 1),
  (1, 'Jari yang mengerut terbukti membantu mencengkeram benda basah lebih mantap.', false, 2),
  (1, 'Radiasi dari satu pisang sangat kecil — sekitar 0,1 microsievert.', false, 3),
  (1, 'Setiap pisang yang kamu makan mengandung potassium-40, isotop kalium yang bersifat radioaktif.', true, 4),
  (2, 'Sampai sekarang, efek Mpemba tetap menjadi misteri manis dalam perdebatan para fisikawan.', false, 1),
  (2, 'Pernah merasa langsung segar setelah seteguk kopi?', false, 2),
  (2, 'Radiasi dari satu pisang sangat kecil — sekitar 0,1 microsievert.', true, 3),
  (2, 'Hewan seperti anjing juga bisa ikut menguap', false, 4),
  (3, 'Kamu perlu makan ratusan ribu pisang sekaligus untuk mengalami efek yang berbahaya bagi tubuh.', true, 1),
  (3, 'Saat gurita berenang, jantung utama justru berhenti berdetak — itulah sebabnya ia lebih suka merangkak.', false, 2),
  (3, 'Kopi punya lebih banyak cerita daripada sekadar kafein.', false, 3),
  (3, 'Kerutan di ujung jari dikendalikan oleh sistem saraf simpatik.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'pisang-sedikit-radioaktif')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Tubuhmu 60 Persen Air', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'tubuh-60-persen-air'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'tubuh-60-persen-air')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Sekitar 60 persen tubuh orang dewasa terdiri dari air — dan angka itu bukan sekadar statistik.', true, 1),
  (1, 'Saat efek habis, rasa lelah bisa datang sekaligus', false, 2),
  (1, 'Fenomena itu bernama efek Mpemba.', false, 3),
  (1, 'Dari sana kopi menyebar ke seluruh dunia Arab, lalu Eropa lewat pelabuhan Venesia.', false, 4),
  (2, 'Ia justru bekerja keras: membersihkan racun, mengkonsolidasikan memori, dan memperbaiki jaringan.', false, 1),
  (2, 'Bentuk itu adalah hasil pasti dari bagaimana cahaya dibiaskan di dalam tetesan air.', false, 2),
  (2, 'Para penambang mengumpulkan garam sambil berdiri di dalam air', false, 3),
  (2, 'Otak dan jantungmu mengandung sekitar 73 persen air, paru-paru 83 persen, bahkan tulangmu masih menyimpan 31 persen.', true, 4),
  (3, 'Manusia bisa bertahan berminggu-minggu tanpa makanan, tetapi hanya sekitar 3-7 hari tanpa air.', true, 1),
  (3, 'Inti dalam padat, sebagian besar besi dan nikel', false, 2),
  (3, 'Efek kafein mulai terasa sekitar 15-30 menit setelah diminum', false, 3),
  (3, 'Semakin dalam kamu masuk ke Bumi, semakin panas suhunya.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'tubuh-60-persen-air')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Stroberi Bukan Berry — Tapi Pisang, Tomat, dan Timun Adalah Berry', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'stroberi-bukan-berry'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'stroberi-bukan-berry')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Dalam botani, stroberi bukan berry.', true, 1),
  (1, 'Ia justru memblokir sinyal lelah di otak.', false, 2),
  (1, 'Begitu hinggap di atas daun, mereka langsung tahu apakah daun itu cocok untuk makan atau bertelur.', false, 3),
  (1, 'Hingga kini, tidak ada satu pun teori yang disepakati penuh.', false, 4),
  (2, 'Saat merasa haus, itu artinya tubuh sudah mulai kekurangan — minumlah sebelum sinyal itu tiba.', false, 1),
  (2, 'Itulah kenapa saat matahari terbenam, langit berubah jingga dan merah.', false, 2),
  (2, 'Pisang, tomat, dan timun justru termasuk berry.', true, 3),
  (2, 'Diperkirakan melibatkan puluhan ribu pekerja', false, 4),
  (3, 'Tanpa koreksi 38 mikrodetik per hari, kesalahan posisi GPS bisa mencapai sekitar 10 kilometer per hari.', false, 1),
  (3, 'Berry botani adalah buah berdaging yang berasal dari satu bunga dan bijinya tertanam di dalam daging buah.', true, 2),
  (3, 'Saat bertahan, tardigrade mengerut jadi bentuk seperti tong dan memperlambat metabolisme hingga nyaris berhenti.', false, 3),
  (3, 'Satelit secara rutin disinkronkan dan dikoreksi secara matematis supaya posisi yang kamu lihat tetap akurat hingga hitun', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'stroberi-bukan-berry')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kupu-kupu Mengecap Rasa dengan Kaki', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kupu-kupu-mengecap-dengan-kaki'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kupu-kupu-mengecap-dengan-kaki')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Memiliki tiga jantung dan sembilan otak', false, 1),
  (1, 'Kecerdasan buatan tidak lagi menjadi bahan cerita fiksi ilmiah.', false, 2),
  (1, 'Diduga terkait penguapan, konveksi, dan gas terlarut', false, 3),
  (1, 'Kupu-kupu tidak mencicipi makanan dengan mulut.', true, 4),
  (2, 'Teori lain menautkan menguap yang menular dengan empati.', false, 1),
  (2, 'Bayi dan orang dengan beberapa kondisi tertentu jarang terpengaruh', false, 2),
  (2, 'Di kaki kupu-kupu terdapat sel-sel sensilla yang peka terhadap rasa.', true, 3),
  (2, 'Naik pesawat memberi radiasi lebih tinggi daripada makan pisang', false, 4),
  (3, 'Hingga kini mekanismenya masih diperdebatkan', false, 1),
  (3, 'Kafein masuk dan menempati reseptor adenosin, sehingga sinyal lelah tidak tersampaikan.', false, 2),
  (3, 'Madu mengandung sedikit air dan sangat asam.', false, 3),
  (3, 'Begitu hinggap di atas daun, mereka langsung tahu apakah daun itu cocok untuk makan atau bertelur.', true, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kupu-kupu-mengecap-dengan-kaki')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kenapa Kopi Membuatmu Melek: Bukan karena Energi', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kopi-membuat-melek'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kopi-membuat-melek')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Ginjal menyaring puluhan liter cairan setiap hari', false, 1),
  (1, 'Kurang tidur berarti sampah itu menumpuk.', false, 2),
  (1, 'Mulut kupu-kupu berbentuk belalai untuk menghisap nektar', false, 3),
  (1, 'Ia justru memblokir sinyal lelah di otak.', true, 4),
  (2, 'Pernah mendengar air panas bisa membeku lebih cepat daripada air dingin?', false, 1),
  (2, 'Air mengatur suhu tubuh lewat keringat', false, 2),
  (2, 'Sepanjang hari otak menumpuk adenosin, molekul yang membuatmu mengantuk.', true, 3),
  (2, 'Saat efek habis, rasa lelah bisa datang sekaligus', false, 4),
  (3, 'Efek kafein mulai terasa sekitar 15 menit dan bertahan 4–6 jam di dalam tubuh.', false, 1),
  (3, 'Memori jangka pendek dipindahkan ke memori jangka panjang', false, 2),
  (3, 'Kafein masuk dan menempati reseptor adenosin, sehingga sinyal lelah tidak tersampaikan.', true, 3),
  (3, 'Saat bertahan, tardigrade mengerut jadi bentuk seperti tong dan memperlambat metabolisme hingga nyaris berhenti.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kopi-membuat-melek')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kenapa Cabe Terasa Pedas? Ternyata Otak Sedang Tertipu', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-cabe-terasa-pedas'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-cabe-terasa-pedas')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Itu bukan kebetulan — menguap dikenal sangat menular.', false, 1),
  (1, 'Lidahmu tidak punya sensor rasa pedas.', true, 2),
  (1, 'Radiasi alami dari lingkungan jauh lebih besar dari pisang', false, 3),
  (1, 'Ia punya tiga jantung, sembilan otak, dan darah berwarna biru karena mengandung tembaga, bukan zat besi.', false, 4),
  (2, 'Manusia bisa bertahan berminggu-minggu tanpa makanan, tetapi hanya sekitar 3-7 hari tanpa air.', false, 1),
  (2, 'Setengah kafein yang kamu minum butuh sekitar 6 jam untuk hilang dari tubuh.', false, 2),
  (2, 'Lalu kenapa makan cabe terasa panas membakar?', true, 3),
  (2, 'Memori jangka pendek dipindahkan ke memori jangka panjang', false, 4),
  (3, 'Senyawa capsaicin dalam cabe menempel pada reseptor TRPV1 yang biasanya aktif saat terkena panas.', true, 1),
  (3, 'Stroberi termasuk aggregate fruit', false, 2),
  (3, 'Madu murni dikenal sebagai salah satu makanan yang hampir tidak pernah basi.', false, 3),
  (3, 'Menguap diperkirakan membantu mendinginkan otak yang mulai panas.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-cabe-terasa-pedas')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Efek Mpemba: Saat Air Panas Beku Lebih Cepat dari Air Dingin', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'efek-mpemba-air-panas-membeku'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'efek-mpemba-air-panas-membeku')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kalau madumu mengkristal, jangan dibuang — rendam stoplesnya di air hangat dan ia akan kembali cair seperti semula.', false, 1),
  (1, 'Pernah mendengar air panas bisa membeku lebih cepat daripada air dingin?', true, 2),
  (1, 'Namun bagaimana nenek moyang membangunnya tanpa teknologi modern masih menjadi perdebatan.', false, 3),
  (1, 'Kopi adalah buah kedua paling banyak diperdagangkan setelah minyak', false, 4),
  (2, 'Tekanan di dasar palung lebih dari 1.000 kali tekanan atmosfer di permukaan', false, 1),
  (2, 'Fenomena itu bernama efek Mpemba.', true, 2),
  (2, 'Air bisa saja dipakai untuk mengurangi gesekan, sehingga memindahkan batu seberat ribuan kilogram menjadi lebih ringan.', false, 3),
  (2, '1969 — ARPANET mengirim pesan pertama', false, 4),
  (3, 'Sampai sekarang, efek Mpemba tetap menjadi misteri manis dalam perdebatan para fisikawan.', false, 1),
  (3, 'Skala Scoville mengukur tingkat kepedasan', false, 2),
  (3, 'Pada 1963, siswa SMP Tanzania bernama Erasto Mpemba mengamati es krim buatannya membeku lebih cepat saat adonannya panas', true, 3),
  (3, 'Sebagian besar pekerjaan masa depan belum tercipta — kombinasi manusia + AI adalah keterampilan baru yang paling dicari.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'efek-mpemba-air-panas-membeku')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Menguap yang Menular — dan Bukan Hanya karena Ngantuk', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'menguap-menular'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'menguap-menular')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Gagarin mengawali hari itu dengan kata-kata: "Poyekhali!" — "Ayo berangkat!"', false, 1),
  (1, 'Justru itulah yang membuatnya tetap misterius dan menarik untuk diselidiki.', false, 2),
  (1, '1969 — ARPANET mengirim pesan pertama', false, 3),
  (1, 'Membaca kata menguap saja bisa membuatmu menguap.', true, 4),
  (2, 'Pada 20 Juli 1969, dunia berhenti sejenak.', false, 1),
  (2, 'Itulah kekuatan menguap yang menular — dan anehnya, kamu baru saja menguap, bukan?', true, 2),
  (2, 'Saat merasa haus, itu artinya tubuh sudah mulai kekurangan — minumlah sebelum sinyal itu tiba.', false, 3),
  (2, 'Belum semua ilmuwan sepakat efek ini selalu terjadi', false, 4),
  (3, 'Menguap diperkirakan membantu mendinginkan otak yang mulai panas.', true, 1),
  (3, 'Indonesia terkenal dengan Arabika Gayo dari Aceh dan Robusta dari berbagai daerah lain.', false, 2),
  (3, 'Pernahkah kamu menatap ke atas pada hari yang cerah dan bertanya-tanya mengapa hamparan luas itu berwarna biru?', false, 3),
  (3, 'Ilmuwan mencatat aroma kopi dapat meningkatkan kewaspadaan pada sebagian orang.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'menguap-menular')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Jamur Lebih Dekat ke Manusia daripada Tumbuhan', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'jamur-lebih-dekat-ke-hewan'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'jamur-lebih-dekat-ke-hewan')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kecerdasan buatan tidak lagi menjadi bahan cerita fiksi ilmiah.', false, 1),
  (1, 'Bentuk itu adalah hasil pasti dari bagaimana cahaya dibiaskan di dalam tetesan air.', false, 2),
  (1, 'Bandingkan dengan bintang terdekat setelah matahari, Proxima Centauri, yang cahayanya butuh lebih dari 4 tahun untuk sam', false, 3),
  (1, 'Secara evolusi, jamur lebih dekat kekerabatannya dengan hewan — termasuk manusia — dibandingkan dengan tumbuhan.', true, 4),
  (2, 'Jamur tidak berfotosintesis seperti tumbuhan.', true, 1),
  (2, 'Studi modern 2023 menghitung lebih konservatif, sekitar 14 ribu ton', false, 2),
  (2, 'Ia punya tiga jantung, sembilan otak, dan darah berwarna biru karena mengandung tembaga, bukan zat besi.', false, 3),
  (2, 'Tapi ada satu masalah: jam di satelit berjalan berbeda dengan jam di Bumi.', false, 4),
  (3, 'Seperti hewan, mereka menyerap makanan dari lingkungan, dan susunan genetiknya pun lebih mirip dengan kita.', true, 1),
  (3, 'Efek kafein mulai terasa sekitar 15-30 menit setelah diminum', false, 2),
  (3, 'Permukaan matahari sendiri bersuhu sekitar 5.500 derajat Celsius.', false, 3),
  (3, 'Jika matahari tiba-tiba padam, kita baru akan tahu 8 menit 20 detik kemudian.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'jamur-lebih-dekat-ke-hewan')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kenapa Langit Berwarna Biru?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-langit-berwarna-biru'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-langit-berwarna-biru')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Keduanya sangat berbeda — dari rasa sampai kandungan kafeinnya.', false, 1),
  (1, 'Pernahkah kamu menatap ke atas pada hari yang cerah dan bertanya-tanya mengapa hamparan luas itu berwarna biru?', true, 2),
  (1, 'Kamu tidak benar-benar segar — kamu hanya tidak mendengar teriakan lelahmu.', false, 3),
  (1, 'Pada 1963, siswa SMP Tanzania bernama Erasto Mpemba mengamati es krim buatannya membeku lebih cepat saat adonannya panas', false, 4),
  (2, 'Harganya lebih mahal karena lebih sulit ditanam dan lebih rentan hama.', false, 1),
  (2, 'Tekanan di dasar palung lebih dari 1.000 kali tekanan atmosfer di permukaan', false, 2),
  (2, 'Jawabannya terletak pada interaksi menarik antara cahaya matahari dan atmosfer Bumi kita.', true, 3),
  (2, 'Sampai sekarang, efek Mpemba tetap menjadi misteri manis dalam perdebatan para fisikawan.', false, 4),
  (3, 'Kini muncul alternatif etis yang meniru proses fermentasi luwak di laboratorium, tanpa melibatkan hewan sama sekali.', false, 1),
  (3, 'Nama efek ini diambil dari Erasto Mpemba, remaja yang pertama kali menelitinya secara ilmiah.', false, 2),
  (3, 'Bayi dan orang dengan beberapa kondisi tertentu jarang terpengaruh', false, 3),
  (3, 'Cahaya matahari, yang tampak putih bagi kita, sebenarnya terdiri dari semua warna pelangi.', true, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-langit-berwarna-biru')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Arabika vs Robusta: Beda Biji, Beda Karakter', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'arabika-vs-robusta'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'arabika-vs-robusta')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, '1991 — World Wide Web dibuka untuk umum', false, 1),
  (1, 'Kalau kamu membeli kopi biji, dua nama yang hampir selalu muncul adalah Arabika dan Robusta.', true, 2),
  (1, 'Robusta biasanya lebih murah dan sering dipakai kopi instan', false, 3),
  (1, 'Berita pendaratan di Bulan diterima langsung oleh ratusan juta orang lewat siaran televisi langsung.', false, 4),
  (2, 'Kerutan di ujung jari dikendalikan oleh sistem saraf simpatik.', false, 1),
  (2, 'Keduanya sangat berbeda — dari rasa sampai kandungan kafeinnya.', true, 2),
  (2, 'Kafein bentuknya sangat mirip adenosin, sehingga ia menempati reseptor yang sama — dan menghentikan sinyal lelah masuk.', false, 3),
  (2, 'Kopi punya lebih banyak cerita daripada sekadar kafein.', false, 4),
  (3, 'Arabika tumbuh di dataran tinggi dan menghasilkan rasa yang lebih kompleks: asam cerah, aroma floral, dan nuansa manis.', true, 1),
  (3, 'Neil Armstrong keluar dari modul Apollo 11 dan menjadi manusia pertama yang menginjakkan kaki di permukaan Bulan.', false, 2),
  (3, 'Sepanjang hari otak menumpuk adenosin, molekul yang membuatmu mengantuk.', false, 3),
  (3, 'Merah selalu di bagian luar pelangi, ungu di dalam', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'arabika-vs-robusta')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kopi Luwak: Sejarah dan Kontroversi di Baliknya', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kopi-luwak-sejarah-kontroversi'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kopi-luwak-sejarah-kontroversi')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Jarak rata-rata Bumi ke matahari sekitar 149,6 juta kilometer.', false, 1),
  (1, 'Kini muncul alternatif etis yang meniru proses fermentasi luwak di laboratorium, tanpa melibatkan hewan sama sekali.', false, 2),
  (1, 'Kopi Luwak lahir dari kebetulan: musang luwak (palm civet) memakan buah kopi matang, dan bijinya keluar utuh setelah mel', true, 3),
  (1, 'Bayi di dalam kandungan dilaporkan ikut menguap', false, 4),
  (2, 'Tenang, madu hampir tidak mungkin basi — inilah salah satu keajaiban kecil di dapurmu.', false, 1),
  (2, 'Ginjal menyaring puluhan liter cairan setiap hari', false, 2),
  (2, 'Mulut kupu-kupu berbentuk belalai untuk menghisap nektar', false, 3),
  (2, 'Fermentasi alami ini memberi rasa yang lebih halus dan berkurang asamnya.', true, 4),
  (3, 'Bandingkan dengan bintang terdekat setelah matahari, Proxima Centauri, yang cahayanya butuh lebih dari 4 tahun untuk sam', false, 1),
  (3, 'Kopi Luwak bisa dijual dengan harga ratusan ribu hingga jutaan rupiah per kilogram.', true, 2),
  (3, '1983 — Protokol TCP/IP diadopsi', false, 3),
  (3, 'Pelangi selalu tampak melengkung, bukan karena kebetulan.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kopi-luwak-sejarah-kontroversi')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kenapa Kopi Bikin Melek? Ini Sains Kafein', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-kopi-bikin-melek'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-kopi-bikin-melek')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Nama efek ini diambil dari Erasto Mpemba, remaja yang pertama kali menelitinya secara ilmiah.', false, 1),
  (1, 'Para ilmuwan bahkan memakai istilah banana equivalent dose untuk menjelaskan tingkat radiasi kecil kepada publik.', false, 2),
  (1, 'Hari ini kopi adalah salah satu komoditas paling diperdagangkan di dunia, dan Indonesia menjadi salah satu produsen terb', false, 3),
  (1, 'Pernah merasa langsung segar setelah seteguk kopi?', true, 4),
  (2, 'Sejumlah ahli menduga para pekerja menarik balok batu raksasa di atas ramping pasir yang licin.', false, 1),
  (2, 'Matahari tak pernah menembus sampai ke sini', false, 2),
  (2, 'Studi modern 2023 menghitung lebih konservatif, sekitar 14 ribu ton', false, 3),
  (2, 'Kafein memang bekerja cepat, tapi cara kerjanya justru berlawanan dengan apa yang kita kira.', true, 4),
  (3, 'Tidak punya kerangka sehingga bisa melewati celah sempit', false, 1),
  (3, 'Yaman menjadi gerbang penyebaran kopi ke dunia', false, 2),
  (3, 'Hanya nyamuk betina yang menggigit untuk kebutuhan protein telur', false, 3),
  (3, 'Di otak ada senyawa adenosin yang menumpuk sepanjang hari dan membuat kita mengantuk.', true, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-kopi-bikin-melek')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Sejarah Kopi: Dari Etiopia Hingga Secangkir Hangat Hari Ini', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'sejarah-kopi-dari-etiopia'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'sejarah-kopi-dari-etiopia')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kopi punya sejarah yang legendaris.', true, 1),
  (1, 'Membaca kata menguap saja bisa membuatmu menguap.', false, 2),
  (1, 'Keduanya respons evolusioner untuk kondisi basah', false, 3),
  (1, 'GPS bekerja dengan mengukur waktu tempuh sinyal dari beberapa satelit.', false, 4),
  (2, 'Itu bukan kebetulan — menguap dikenal sangat menular.', false, 1),
  (2, 'Pernahkah kamu menatap ke atas pada hari yang cerah dan bertanya-tanya mengapa hamparan luas itu berwarna biru?', false, 2),
  (2, 'Dari sana kopi menyebar ke seluruh dunia Arab, lalu Eropa lewat pelabuhan Venesia.', true, 3),
  (2, 'Hampir semua hewan vertebrata menguap — bahkan kelelawar menguap bersama-sama dalam kelompoknya.', false, 4),
  (3, 'Ia justru memblokir sinyal lelah di otak.', false, 1),
  (3, 'Etiopia adalah tempat asal-muasal kopi Arabika', true, 2),
  (3, 'Kerutan di ujung jari dikendalikan oleh sistem saraf simpatik.', false, 3),
  (3, 'WHO memperkirakan penyakit yang ditularkan nyamuk membunuh lebih dari 700 ribu orang setiap tahun.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'sejarah-kopi-dari-etiopia')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Suhu Inti Bumi Hampir Sepanas Permukaan Matahari', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'suhu-inti-bumi'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'suhu-inti-bumi')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Kalau kamu membeli kopi biji, dua nama yang hampir selalu muncul adalah Arabika dan Robusta.', false, 1),
  (1, 'Merah selalu di bagian luar pelangi, ungu di dalam', false, 2),
  (1, 'Stroberi berasal dari bunga dengan banyak ovarium, dan titik-titik di permukaannya sebenarnya adalah buah-buah kecil ber', false, 3),
  (1, 'Semakin dalam kamu masuk ke Bumi, semakin panas suhunya.', true, 4),
  (2, 'Di inti dalam, perkiraan suhu mencapai 5.200 derajat Celsius.', true, 1),
  (2, 'Pernah lihat madu mengkristal dan mengira sudah rusak?', false, 2),
  (2, 'Fermentasi alami ini memberi rasa yang lebih halus dan berkurang asamnya.', false, 3),
  (2, 'Ketika kamu melihat cahaya matahari, sebenarnya kamu sedang melihat masa lalu.', false, 4),
  (3, 'Stroberi berasal dari bunga dengan banyak ovarium, dan titik-titik di permukaannya sebenarnya adalah buah-buah kecil ber', false, 1),
  (3, 'Keduanya sangat berbeda — dari rasa sampai kandungan kafeinnya.', false, 2),
  (3, 'Air mengatur suhu tubuh lewat keringat', false, 3),
  (3, 'Permukaan matahari sendiri bersuhu sekitar 5.500 derajat Celsius.', true, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'suhu-inti-bumi')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('GPS dan Relativitas: Kenapa Jam Satelit Harus Dikoreksi', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'gps-relativitas-einstein'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'gps-relativitas-einstein')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Setelah kembali ke Bumi, sebagian dari mereka hidup kembali.', false, 1),
  (1, 'Kamu perlu makan ratusan ribu pisang sekaligus untuk mengalami efek yang berbahaya bagi tubuh.', false, 2),
  (1, 'GPS bekerja dengan mengukur waktu tempuh sinyal dari beberapa satelit.', true, 3),
  (1, 'Jika Gunung Everest ditaruh di sana, puncaknya masih berada lebih dari satu kilometer di bawah permukaan laut.', false, 4),
  (2, 'Kuncinya sederhana: pelajari cara bertanya yang baik.', false, 1),
  (2, 'Tidak punya bandara maupun stasiun kereta sendiri', false, 2),
  (2, 'Tapi ada satu masalah: jam di satelit berjalan berbeda dengan jam di Bumi.', true, 3),
  (2, 'Sekitar 60 persen tubuh orang dewasa terdiri dari air — dan angka itu bukan sekadar statistik.', false, 4),
  (3, 'Pisang, tomat, dan timun justru termasuk berry.', false, 1),
  (3, 'Menurut relativitas umum, gravitasi membuat waktu berjalan lebih lambat.', true, 2),
  (3, 'Senyawa capsaicin dalam cabe menempel pada reseptor TRPV1 yang biasanya aktif saat terkena panas.', false, 3),
  (3, 'Keduanya respons evolusioner untuk kondisi basah', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'gps-relativitas-einstein')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Emas di Dalam Laut: Ada Banyak, Tapi Tak Bisa Ditambang', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'emas-terlarut-di-laut'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'emas-terlarut-di-laut')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Pada 1989, Tim Berners-Lee mengajukan sistem hypertext yang kelak menjadi World Wide Web.', false, 1),
  (1, 'Kamu mungkin mengira jari mengerut karena menyerap air.', false, 2),
  (1, 'Sampai di sini, kabar menarik: laut memang mengandung emas.', true, 3),
  (1, 'Jamur berperan penting mengurai material', false, 4),
  (2, 'Yang bertahan adalah manusia yang mampu memakai AI sebagai alat bantu.', false, 1),
  (2, 'Kabar kurang menarik: konsentrasinya sangat, sangat encer.', true, 2),
  (2, 'Kamu perlu makan ratusan ribu pisang sekaligus untuk mengalami efek yang berbahaya bagi tubuh.', false, 3),
  (2, 'Sinyal kelelahan tertunda, bukan hilang', false, 4),
  (3, 'Setiap titik kuning kecil di permukaan stroberi adalah buah sejati yang berisi satu biji.', false, 1),
  (3, 'Tekanan di dasar palung lebih dari 1.000 kali tekanan atmosfer di permukaan', false, 2),
  (3, 'Menurut NOAA, air laut rata-rata hanya mengandung emas sekitar satu gram per 100 juta ton air.', true, 3),
  (3, 'Jadi saat kupu-kupu hinggap di bahumu, bisa jadi ia sedang mencicipi kamu.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'emas-terlarut-di-laut')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Nyamuk: Hewan Paling Mematikan di Dunia', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'nyamuk-hewan-paling-mematikan'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'nyamuk-hewan-paling-mematikan')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Jika menyebut hewan paling mematikan, sebagian orang berpikir tentang hiu atau ular.', true, 1),
  (1, 'Inti dalam padat, sebagian besar besi dan nikel', false, 2),
  (1, 'Yaman menjadi gerbang penyebaran kopi ke dunia', false, 3),
  (1, 'Kuncinya sederhana: pelajari cara bertanya yang baik.', false, 4),
  (2, 'Piramida Agung Giza adalah satu-satunya keajaiban dunia kuno yang masih berdiri.', false, 1),
  (2, 'Cahaya biru sudah tersebar habis di perjalanan, menyisakan warna dengan panjang gelombang lebih panjang untuk kita lihat', false, 2),
  (2, 'Pernahkah kamu menatap ke atas pada hari yang cerah dan bertanya-tanya mengapa hamparan luas itu berwarna biru?', false, 3),
  (2, 'Padahal jawabannya jauh lebih kecil: nyamuk.', true, 4),
  (3, 'Kadar air yang rendah menyulitkan mikroba', false, 1),
  (3, 'Popularitasnya melonjak setelah film "The Bucket List" (2007) menyebutnya.', false, 2),
  (3, 'WHO memperkirakan penyakit yang ditularkan nyamuk membunuh lebih dari 700 ribu orang setiap tahun.', true, 3),
  (3, 'Suhu air di kedalaman nyaris mendekati titik beku', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'nyamuk-hewan-paling-mematikan')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Kenapa Pelangi Selalu Melengkung?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-pelangi-melengkung'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-pelangi-melengkung')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Itulah sebabnya madu bisa bertahan begitu lama.', false, 1),
  (1, 'Pelangi selalu tampak melengkung, bukan karena kebetulan.', true, 2),
  (1, 'Dari menulis ringkasan sampai mengoreksi kode, AI sudah menjadi rekan kerja sehari-hari.', false, 3),
  (1, 'Robusta: kafein sekitar 2,2%, rasa pahit & pekat', false, 4),
  (2, 'Efek kafein mulai terasa sekitar 15 menit dan bertahan 4–6 jam di dalam tubuh.', false, 1),
  (2, 'Para ilmuwan bahkan memakai istilah banana equivalent dose untuk menjelaskan tingkat radiasi kecil kepada publik.', false, 2),
  (2, 'Jadi lain kali makan stroberi, ingat: kamu sedang menikmati kumpulan buah-buah mini yang tersusun rapi.', false, 3),
  (2, 'Bentuk itu adalah hasil pasti dari bagaimana cahaya dibiaskan di dalam tetesan air.', true, 4),
  (3, 'Cahaya matahari yang masuk ke tetesan hujan dipantulkan di dalam dan keluar lagi.', true, 1),
  (3, 'Para ilmuwan bahkan memakai istilah banana equivalent dose untuk menjelaskan tingkat radiasi kecil kepada publik.', false, 2),
  (3, 'Semakin dalam kamu masuk ke Bumi, semakin panas suhunya.', false, 3),
  (3, 'Itulah sebabnya madu bisa bertahan begitu lama.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-pelangi-melengkung')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Madu: Makanan yang (Hampir) Tidak Pernah Basi', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'madu-tidak-pernah-basi'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'madu-tidak-pernah-basi')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Jari yang mengerut terbukti membantu mencengkeram benda basah lebih mantap.', false, 1),
  (1, 'Tidak punya bandara maupun stasiun kereta sendiri', false, 2),
  (1, 'Madu murni dikenal sebagai salah satu makanan yang hampir tidak pernah basi.', true, 3),
  (1, 'Gagarin mengawali hari itu dengan kata-kata: "Poyekhali!" — "Ayo berangkat!"', false, 4),
  (2, 'Burung tidak merasakan pedas sama sekali — ini trik cabe agar bijinya disebar burung, bukan dikunyah mamalia.', false, 1),
  (2, 'Beberapa toples madu yang ditemukan di makam Mesir kuno bahkan masih aman dikonsumsi.', true, 2),
  (2, 'Berry botani adalah buah berdaging yang berasal dari satu bunga dan bijinya tertanam di dalam daging buah.', false, 3),
  (2, 'Bisa hidup kembali setelah puluhan tahun dalam kondisi kering', false, 4),
  (3, 'Kabar kurang menarik: konsentrasinya sangat, sangat encer.', false, 1),
  (3, 'Sebagian besar pekerjaan masa depan belum tercipta — kombinasi manusia + AI adalah keterampilan baru yang paling dicari.', false, 2),
  (3, 'Madu bertahan lama berkat kombinasi kadar air yang sangat rendah, sifat asam, dan produksi hidrogen peroksida yang dihas', true, 3),
  (3, 'Di Samudra Pasifik, sekitar 200 kilometer timur Filipina, terbentang titik terdalam di Bumi: Palung Mariana.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'madu-tidak-pernah-basi')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('5 Fakta Kopi yang Mungkin Belum Kamu Tahu', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = '5-fakta-kopi-belum-tahu'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = '5-fakta-kopi-belum-tahu')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Pelangi selalu tampak melengkung, bukan karena kebetulan.', false, 1),
  (1, 'Setiap tetes air bertindak seperti prisma kecil', false, 2),
  (1, 'Kopi punya lebih banyak cerita daripada sekadar kafein.', true, 3),
  (1, 'Kemampuan menulis prompt yang jelas akan menjadi salah satu skill paling berharga.', false, 4),
  (2, 'Ini lima fakta yang mungkin belum kamu dengar.', true, 1),
  (2, 'Tomat dan timun juga termasuk berry', false, 2),
  (2, 'Setelah kembali ke Bumi, sebagian dari mereka hidup kembali.', false, 3),
  (2, 'Kopi adalah buah kedua paling banyak diperdagangkan setelah minyak', false, 4),
  (3, 'Kopi sebenarnya adalah biji dari buah ceri kopi', true, 1),
  (3, 'Jadi lain kali makan stroberi, ingat: kamu sedang menikmati kumpulan buah-buah mini yang tersusun rapi.', false, 2),
  (3, 'Memori jangka pendek dipindahkan ke memori jangka panjang', false, 3),
  (3, 'Etiopia adalah tempat asal-muasal kopi Arabika', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = '5-fakta-kopi-belum-tahu')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Mengapa Jari Mengerut Saat Berendam Lama?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'jari-mengerut-saat-berendam'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'jari-mengerut-saat-berendam')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Fermentasi alami ini memberi rasa yang lebih halus dan berkurang asamnya.', false, 1),
  (1, 'Kamu mungkin mengira jari mengerut karena menyerap air.', true, 2),
  (1, 'Ini lima fakta yang mungkin belum kamu dengar.', false, 3),
  (1, 'Kadar air rendah membuat bakteri sulit berkembang', false, 4),
  (2, 'Bayi di dalam kandungan dilaporkan ikut menguap', false, 1),
  (2, 'Pisang, tomat, dan timun justru termasuk berry.', false, 2),
  (2, 'Radiasi alami dari lingkungan jauh lebih besar dari pisang', false, 3),
  (2, 'Ternyata itu bukan alasan utamanya.', true, 4),
  (3, 'Secara evolusi, jamur lebih dekat kekerabatannya dengan hewan — termasuk manusia — dibandingkan dengan tumbuhan.', false, 1),
  (3, 'Kamu mungkin menguap saat membaca judul artikel ini.', false, 2),
  (3, 'Piramida Agung Giza adalah satu-satunya keajaiban dunia kuno yang masih berdiri.', false, 3),
  (3, 'Kerutan di ujung jari dikendalikan oleh sistem saraf simpatik.', true, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'jari-mengerut-saat-berendam')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Yuri Gagarin: Manusia Pertama yang Terbang ke Luar Angkasa', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'yuri-gagarin-manusia-pertama'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'yuri-gagarin-manusia-pertama')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Naik pesawat memberi radiasi lebih tinggi daripada makan pisang', false, 1),
  (1, 'Ulat berubah menjadi kupu-kupu lewat metamorfosis total', false, 2),
  (1, 'Pada 12 April 1961, kosmonot berusia 27 tahun bernama Yuri Gagarin menjadi manusia pertama yang mengorbit Bumi.', true, 3),
  (1, 'Ia justru bekerja keras: membersihkan racun, mengkonsolidasikan memori, dan memperbaiki jaringan.', false, 4),
  (2, 'Stroberi termasuk aggregate fruit', false, 1),
  (2, 'Madu bertahan lama berkat kombinasi kadar air yang sangat rendah, sifat asam, dan produksi hidrogen peroksida yang dihas', false, 2),
  (2, 'Misi Vostok 1 hanya berlangsung 108 menit.', true, 3),
  (2, 'Menguap diperkirakan membantu mendinginkan otak yang mulai panas.', false, 4),
  (3, 'Lebih banyak manusia yang pernah ke luar angkasa daripada yang pernah menyentuh dasar Palung Mariana.', false, 1),
  (3, 'Gagarin menyelesaikan satu orbit penuh mengelilingi Bumi sebelum mendarat dengan selamat.', true, 2),
  (3, 'Menguap yang menular dianggap berkaitan dengan kemampuan membaca perasaan orang lain.', false, 3),
  (3, 'Ilmuwan masih meneliti mengapa alam semesta kita didominasi materi, sementara antimateri hampir tidak terlihat.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'yuri-gagarin-manusia-pertama')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Palung Mariana: Titik Terdalam di Bumi', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'palung-mariana-titik-terdalam'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'palung-mariana-titik-terdalam')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Lebih banyak manusia yang pernah ke luar angkasa daripada yang pernah menyentuh dasar Palung Mariana.', false, 1),
  (1, 'Diduga terkait penguapan, konveksi, dan gas terlarut', false, 2),
  (1, 'Di Samudra Pasifik, sekitar 200 kilometer timur Filipina, terbentang titik terdalam di Bumi: Palung Mariana.', true, 3),
  (1, 'Yang terlihat di permukaan hanyalah buahnya, sebagian besar tubuh jamur ada di dalam tanah', false, 4),
  (2, 'Padahal jawabannya jauh lebih kecil: nyamuk.', false, 1),
  (2, 'Jadi di pagi hari, secangkir kopi tidak memberi tenaga, melainkan menunda panggilan tidur tubuhmu.', false, 2),
  (2, 'Titik terdalamnya, Challenger Deep, mencapai kedalaman sekitar 10.935 meter.', true, 3),
  (2, 'Jamur tidak berfotosintesis seperti tumbuhan.', false, 4),
  (3, 'Itu bukan kebetulan — menguap dikenal sangat menular.', false, 1),
  (3, 'Semua emas di lautan jika ditambang habis-habisan, harganya tak akan menutup biaya teknologinya.', false, 2),
  (3, 'Bayi dan orang dengan beberapa kondisi tertentu jarang terpengaruh', false, 3),
  (3, 'Jika Gunung Everest ditaruh di sana, puncaknya masih berada lebih dari satu kilometer di bawah permukaan laut.', true, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'palung-mariana-titik-terdalam')
on conflict (question_id, position) do nothing;

insert into public.quizzes (title, description, article_id)
  values ('Mengapa Menguap Itu Menular?', 'Tanya jawab seputar artikel ini.',
    (select id from public.articles where slug = 'kenapa-kita-menguap'))
on conflict (title) do nothing;

insert into public.quiz_questions (quiz_id, question, position)
select q.id, x.question, x.position
from public.quizzes q
cross join (values
  (1, 'Manakah pernyataan yang benar?'),
  (2, 'Berdasarkan artikel ini, pernyataan manakah yang benar?'),
  (3, 'Pernyataan manakah yang sesuai dengan isi artikel?')
) as x(position, question)
where q.article_id = (select id from public.articles where slug = 'kenapa-kita-menguap')
on conflict (quiz_id, position) do nothing;

insert into public.quiz_options (question_id, label, is_correct, position)
select qq.id, x.label, x.is_correct, x.position
from public.quiz_questions qq
join public.quizzes q on q.id = qq.quiz_id
cross join (values
  (1, 'Berita pendaratan di Bulan diterima langsung oleh ratusan juta orang lewat siaran televisi langsung.', false, 1),
  (1, 'Pelangi selalu tampak melengkung, bukan karena kebetulan.', false, 2),
  (1, 'Ketika kamu melihat cahaya matahari, sebenarnya kamu sedang melihat masa lalu.', false, 3),
  (1, 'Kamu mungkin menguap saat membaca judul artikel ini.', true, 4),
  (2, 'Itu bukan kebetulan — menguap dikenal sangat menular.', true, 1),
  (2, 'Kamu mungkin menguap saat membaca judul artikel ini.', false, 2),
  (2, 'Sepanjang hari otak menumpuk adenosin, molekul yang membuatmu mengantuk.', false, 3),
  (2, 'Kurang tidur berarti sampah itu menumpuk.', false, 4),
  (3, 'Para ilmuwan belum sepenuhnya sepakat mengapa kita menguap.', true, 1),
  (3, 'Negara lain yang tak kalah kecil: Monako (2 km²) dan Nauru (21 km²).', false, 2),
  (3, 'Hampir semua hewan vertebrata menguap — bahkan kelelawar menguap bersama-sama dalam kelompoknya.', false, 3),
  (3, 'Jamur tidak berfotosintesis seperti tumbuhan.', false, 4)
) as x(qposition, label, is_correct, position)
where qq.position = x.qposition and q.article_id = (select id from public.articles where slug = 'kenapa-kita-menguap')
on conflict (question_id, position) do nothing;
