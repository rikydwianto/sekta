-- ============================================================
-- SEKTA — SEED 10 ARTIKEL WOW (Hewan · Tumbuhan · Teknologi)
-- ============================================================
-- Cara pakai:
--   1. Buka Supabase Dashboard → SQL Editor → New query
--   2. Salin seluruh isi file ini → Run
--
-- Aman diulang (idempotent): artikel unik via slug (on conflict do nothing),
-- fakta via kolom unik, sumber via (article_id, title).
-- Tidak menyentuh tabel lain dan tidak mengubah data produksi yang ada.
--
-- Kategori yang dipakai:
--   'hewan'  → 4 artikel hewan
--   'sains'  → 3 artikel tumbuhan (biologi; tidak ada kategori tumbuhan khusus)
--   'teknologi' → 3 artikel teknologi
-- ============================================================

insert into public.articles (author_name, category_id, title, slug, excerpt, cover_image, content, read_time_minutes, status, published_at) values
(
  'Sekta',
  (select id from public.categories where slug = 'hewan'),
  'Axolotl: Salamander Ajaib yang Tidak Pernah Tumbuh Dewasa',
  'axolotl-salamander-ajaib',
  'Makhluk yang bisa menumbuhkan kembali bagian otak, jantung, dan sumsum tulang belakangnya tanpa bekas luka.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Axolotl_ganz.jpg/1280px-Axolotl_ganz.jpg',
  '[
    {"type":"paragraph","data":{"text":"Bayangkan hewan yang bisa menumbuhkan kembali tangan, kaki, bahkan bagian otaknya sendiri — tanpa meninggalkan bekas luka sedikit pun. Itulah axolotl, salamander asal Meksiko yang sering dijuluki sebagai monster air."}},
    {"type":"heading","data":{"text":"Superpower: Regenerasi Nyaris Sempurna"}},
    {"type":"paragraph","data":{"text":"Axolotl bisa memperbaiki jaringan tubuh yang rusak tanpa jaringan parut. Jantung, sumsum tulang belakang, ekor, dan bahkan sebagian otaknya dapat tumbuh kembali seperti semula. Para ilmuwan mempelajarinya dengan harapan suatu hari manusia bisa melakukan hal yang sama."}},
    {"type":"fact","data":{"text":"Axolotl memegang rekor regenerasi terbaik di dunia hewan vertebrata — sebagian besar hewan lain hanya bisa menumbuhkan bagian tubuh sederhana."}},
    {"type":"list","data":{"items":["Tidak pernah tumbuh dewasa secara penuh (neoteni) — tetap tinggal di air seumur hidup","Insang luarnya yang berumbai menyerupai cabang pohon merah muda","Hampir punah di alam liar; habitat aslinya hanya tersisa di Danau Xochimilco, Kota Meksiko"]}},
    {"type":"quote","data":{"text":"Menjadi anak-anak selamanya bukan kutukan — bagi axolotl, itulah kunci keajaibannya."}},
    {"type":"paragraph","data":{"text":"Ironisnya, makhluk serba bisa ini nyaris punah di habitat aslinya karena pencemaran danau. Untungnya, jutaan axolotl hidup di akuarium dan laboratorium di seluruh dunia."}}
  ]'::jsonb,
  4,
  'PUBLISHED',
  '2026-08-01T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'hewan'),
  'Tardigrade: Beruang Air yang Selamat dari Ruang Angkasa',
  'tardigrade-beruang-air',
  'Makhluk mikroskopis yang bisa bertahan di ruang hampa, radiasi, dan hidup puluhan tahun tanpa makan.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/SEM_image_of_Milnesium_tardigradum_in_active_state_-_journal.pone.0045682.g001-2_%28white_background%29.png/1280px-SEM_image_of_Milnesium_tardigradum_in_active_state_-_journal.pone.0045682.g001-2_%28white_background%29.png',
  '[
    {"type":"paragraph","data":{"text":"Pernah mendengar makhluk yang dikirim ke luar angkasa dan kembali dengan selamat? Tardigrade, alias beruang air, adalah hewan mikroskopis berukuran kurang dari satu milimeter yang dianggap makhluk paling tangguh di Bumi."}},
    {"type":"heading","data":{"text":"Mode Bertahan Hidup Super"}},
    {"type":"paragraph","data":{"text":"Saat lingkungan memburuk, tardigrade mengeluarkan hampir semua air dari tubuhnya dan berubah menjadi gumpalan kering bernama tun. Dalam kondisi ini metabolismenya nyaris berhenti total — ia bisa bertahan bertahun-tahun, bahkan puluhan tahun, tanpa makan dan minum."}},
    {"type":"fact","data":{"text":"Tardigrade pernah menempel di permukaan luar stasiun ruang angkasa selama 10 hari dan tetap hidup di ruang hampa yang mematikan."}},
    {"type":"list","data":{"items":["Tahan panas hingga sekitar 150 derajat Celsius dan dingin hingga -272 derajat Celsius","Tahan radiasi yang mematikan bagi manusia","Tahan tekanan setara kedalaman samudra paling dalam"]}},
    {"type":"quote","data":{"text":"Jika kiamat menimpa Bumi, kemungkinan besar yang bertahan adalah beruang air yang tingginya sepersepuluh milimeter."}},
    {"type":"paragraph","data":{"text":"Delapan kaki mungil, wajah mirip beruang, dan kemampuan bertahan luar biasa menjadikan tardigrade bintang favorit ilmuwan dan penggemar sains di seluruh dunia."}}
  ]'::jsonb,
  4,
  'PUBLISHED',
  '2026-08-02T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'hewan'),
  'Udang Mantis: Pukulan Secepat Peluru dan Mata Paling Canggih',
  'udang-mantis-pukulan-secepat-peluru',
  'Makhluk laut berwarna pelangi yang bisa memecahkan kaca akuarium dan melihat 12 jenis warna.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Odontodactylus_scyllarus_R%C3%A9union.jpg/1280px-Odontodactylus_scyllarus_R%C3%A9union.jpg',
  '[
    {"type":"paragraph","data":{"text":"Udang mantis mungkin kecil, tapi jangan pernah meremehkannya. Pukulan cakarnya bergerak secepat peluru kaliber kecil dan bisa memecahkan kaca akuarium."}},
    {"type":"heading","data":{"text":"Tinju Secepat Peluru"}},
    {"type":"paragraph","data":{"text":"Cakar udang mantis menyerang dengan kecepatan hingga 80 km/jam dalam waktu kurang dari seperseribu detik. Akibatnya, muncul gelembung kavitasi yang meledak dengan suhu sepanas permukaan matahari — cukup untuk melumpuhkan kepiting bercangkang keras."}},
    {"type":"fact","data":{"text":"Manusia punya 3 jenis sel penglihatan warna. Udang mantis punya 12 hingga 16 — dan bisa melihat sinar ultraviolet serta cahaya terpolarisasi."}},
    {"type":"list","data":{"items":["Pukulan dipercepat seperti gerakan busur panah","Dapat melihat 12-16 spektrum warna (manusia hanya 3)","Warna tubuhnya bak lukisan pelangi di dasar laut"]}},
    {"type":"quote","data":{"text":"Di dalam laut, ada petinju kecil yang pukulannya lebih cepat dari mata manusia bisa melihat."}},
    {"type":"paragraph","data":{"text":"Di penangkaran, udang mantis dijuluki \"pengunci jari\" karena nekat menyentuhnya bisa berujung pada luka. Keindahannya berbanding lurus dengan kekuatannya."}}
  ]'::jsonb,
  4,
  'PUBLISHED',
  '2026-08-03T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'hewan'),
  'Cheetah: 0–100 km/jam dalam 3 Detik',
  'cheetah-hewan-tercepat',
  'Hewan darat tercepat yang akselerasinya menyaingi supercar terbaik dunia.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Male_cheetah_facing_left_in_South_Africa.jpg/1280px-Male_cheetah_facing_left_in_South_Africa.jpg',
  '[
    {"type":"paragraph","data":{"text":"Cheetah adalah pelari tercepat di darat. Dalam tiga detik, ia bisa melesat dari diam menjadi 100 km/jam — lebih cepat dari banyak mobil sport produksi massal."}},
    {"type":"heading","data":{"text":"Mesin Kecepatan yang Dirancang Alam"}},
    {"type":"paragraph","data":{"text":"Tulang belakang cheetah bekerja seperti pegas yang memanjang dan memendek, sementara cakarnya yang tidak bisa ditarik penuh berfungsi seperti paku karet untuk mencengkeram tanah saat berlari kencang."}},
    {"type":"fact","data":{"text":"Cheetah hanya bisa mempertahankan kecepatan maksimal sekitar 30 detik. Setelah itu tubuhnya kepanasan dan ia harus berhenti."}},
    {"type":"list","data":{"items":["Kecepatan puncak sekitar 100 km/jam","Ekor panjang berperan seperti kemudi saat berbelok cepat","Garis hitam di wajah menyerap silau matahari agar penglihatan tetap tajam"]}},
    {"type":"quote","data":{"text":"Yang membuat cheetah menakjubkan bukan sekadar cepat — tapi seberapa cepat ia mempercepat."}},
    {"type":"paragraph","data":{"text":"Namun juara sprint ini bukan petarung ulung: cheetah sering kehilangan mangsanya karena singa, hyena, dan macan tutul yang lebih kuat mengintai hasil buruannya."}}
  ]'::jsonb,
  4,
  'PUBLISHED',
  '2026-08-04T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Rafflesia Arnoldii: Bunga Terbesar Dunia yang Berbau Bangkai',
  'rafflesia-bunga-terbesar',
  'Bunga raksasa tanpa akar, batang, dan daun yang baunya menyerupai daging membusuk.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Rafflesia_arnoldii%2C_Sumatra.jpg/1280px-Rafflesia_arnoldii%2C_Sumatra.jpg',
  '[
    {"type":"paragraph","data":{"text":"Di hutan Sumatera dan Kalimantan tumbuh bunga dengan diameter hingga satu meter dan berat lebih dari 10 kilogram. Namanya Rafflesia arnoldii — bunga tunggal terbesar di dunia."}},
    {"type":"heading","data":{"text":"Parasit Tanpa Identitas Tumbuhan"}},
    {"type":"paragraph","data":{"text":"Anehnya, Rafflesia tidak memiliki akar, batang, maupun daun. Ia hidup sebagai parasit di dalam akar tanaman merambat Tetrastigma, dan hanya muncul saat bunganya siap mekar."}},
    {"type":"fact","data":{"text":"Baunya menyerupai bangkai untuk menarik lalat penyerbuk — itulah kenapa disebut bunga bangkai raksasa."}},
    {"type":"list","data":{"items":["Diameter bunga hingga sekitar 1 meter","Berat bisa mencapai 11 kilogram","Mekar hanya bertahan 5-7 hari sebelum layu","Kuncupnya butuh waktu berbulan-bulan untuk matang"]}},
    {"type":"quote","data":{"text":"Kecantikan terbesar hutan tropis punya rahasia paling busuk."}},
    {"type":"paragraph","data":{"text":"Semakin besar dan busuk baunya, semakin banyak lalat tertarik — dan semakin besar peluang bunga raksasa ini berkembang biak."}}
  ]'::jsonb,
  4,
  'PUBLISHED',
  '2026-08-05T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Venus Flytrap: Tumbuhan yang Bisa Menghitung',
  'venus-flytrap-tanaman-karnivora',
  'Perangkap berkecepatan 0,1 detik yang tahu membedakan mangsa asli dari gangguan biasa.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Venus_Flytrap_showing_trigger_hairs.jpg/1280px-Venus_Flytrap_showing_trigger_hairs.jpg',
  '[
    {"type":"paragraph","data":{"text":"Tumbuhan yang memakan serangga terdengar seperti fiksi ilmiah — sampai kamu melihat Venus flytrap menutup perangkapnya dalam sepersepuluh detik."}},
    {"type":"heading","data":{"text":"Karnivora dengan Kemampuan Menghitung"}},
    {"type":"paragraph","data":{"text":"Di dalam daun perangkap ada bulu-bulu pemicu. Satu sentuhan membuat perangkap siaga. Dua sentuhan dalam 20 detik membuat perangkap menutup. Dan untuk mulai mencerna mangsa, dibutuhkan lima sentuhan — bukti bahwa tumbuhan ini benar-benar menghitung."}},
    {"type":"fact","data":{"text":"Dua sentuhan dalam 20 detik membuat perangkap menutup; lima sentuhan memicu proses pencernaan."}},
    {"type":"list","data":{"items":["Hidup di rawa miskin nutrisi, jadi serangga adalah 'pupuk' utamanya","Setiap perangkap hanya bisa menutup beberapa kali sebelum mati","Jentik getar dari serangga dibedakan dari tetesan air hujan"]}},
    {"type":"quote","data":{"text":"Alam membuktikan bahwa otak bukan satu-satunya cara untuk 'berpikir'."}},
    {"type":"paragraph","data":{"text":"Venus flytrap hanya tumbuh liar di lahan basah Carolina Utara dan Selatan, Amerika Serikat — dan kini menjadi favorit para pehobi tanaman karnivora di seluruh dunia."}}
  ]'::jsonb,
  4,
  'PUBLISHED',
  '2026-08-06T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'sains'),
  'Bunga Bangkai: Setinggi Gedung, Hangat, dan Berbau Mengerikan',
  'bunga-bangkai-titan-arum',
  'Titan arum mekar hanya beberapa hari dalam bertahun-tahun dan memanaskan dirinya sendiri.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Amorphophallus_titanum_%28corpse_flower%29_-_2.jpg/1280px-Amorphophallus_titanum_%28corpse_flower%29_-_2.jpg',
  '[
    {"type":"paragraph","data":{"text":"Titan arum, atau bunga bangkai raksasa, adalah perbungaan tertinggi di dunia — bisa mencapai 3 meter. Dan untuk menarik penyerbuk, ia bersedia mengeluarkan bau paling busuk di kerajaan tumbuhan."}},
    {"type":"heading","data":{"text":"Panas Rahasia di Balik Bau"}},
    {"type":"paragraph","data":{"text":"Saat mekar, bunga ini memanaskan dirinya hingga sekitar 36 derajat Celsius. Panas itu membantu menyebarkan bau daging membusuk lebih jauh, memancing kumbang dan lalat bangkai untuk datang menyerbuki."}},
    {"type":"fact","data":{"text":"Titan arum bisa menunggu bertahun-tahun untuk mekar, dan masa mekarnya hanya berlangsung sekitar 24-48 jam."}},
    {"type":"list","data":{"items":["Endemik hutan Sumatera","Tinggi bisa mencapai 3 meter","Umbi terberatnya bisa melebihi 100 kilogram","Jarang mekar — kebun raya di seluruh dunia menyiarkannya langsung"]}},
    {"type":"quote","data":{"text":"Semakin busuk baunya, semakin sempurna trik evolusinya."}},
    {"type":"paragraph","data":{"text":"Begitu langka dan dramatisnya, mekarnya bunga bangkai selalu menjadi peristiwa yang ditunggu-tunggu dan disiarkan langsung ke seluruh dunia."}}
  ]'::jsonb,
  4,
  'PUBLISHED',
  '2026-08-07T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'teknologi'),
  'Komputer Kuantum: Menghitung di Banyak Tempat Sekaligus',
  'komputer-kuantum',
  'Mesin yang beroperasi mendekati -273 derajat dan bisa jadi serba-serbi angka secara bersamaan.',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/IBM_Quantum_Computer_Demo_at_ITUWTSA_2024%2C_Delhi_2.jpg/1280px-IBM_Quantum_Computer_Demo_at_ITUWTSA_2024%2C_Delhi_2.jpg',
  '[
    {"type":"paragraph","data":{"text":"Komputer biasa memproses bit 0 atau 1. Komputer kuantum menggunakan qubit yang bisa menjadi 0 dan 1 secara bersamaan — dan itulah yang membuatnya begitu menakjubkan."}},
    {"type":"heading","data":{"text":"Lebih Dingin dari Luar Angkasa"}},
    {"type":"paragraph","data":{"text":"Qubit bekerja lewat fenomena mekanika kuantum: superposisi (berada di banyak keadaan sekaligus) dan keterikatan (dua partikel saling terhubung seketika). Untuk menjaga qubit tetap stabil, chip kuantum didinginkan mendekati nol mutlak, jauh lebih dingin daripada ruang angkasa."}},
    {"type":"fact","data":{"text":"Google mengklaim chip kuantumnya menyelesaikan perhitungan dalam hitungan detik yang membutuhkan superkomputer terbaik di dunia 10.000 tahun."}},
    {"type":"list","data":{"items":["Beroperasi pada suhu mendekati -273 derajat Celsius","Bisa memecahkan enkripsi modern yang kini dianggap aman","Sangat menjanjikan untuk simulasi obat, material, dan cuaca"]}},
    {"type":"quote","data":{"text":"Kita sedang membangun komputer yang memakai hukum alam yang paling aneh untuk memecahkan soal paling sulit."}},
    {"type":"paragraph","data":{"text":"Komputer kuantum tidak akan menggantikan laptopmu. Ia adalah kalkulator khusus untuk masalah yang mustahil diselesaikan mesin konvensional."}}
  ]'::jsonb,
  5,
  'PUBLISHED',
  '2026-08-08T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'teknologi'),
  'Teleskop James Webb: Mesin Waktu yang Melihat 13,5 Miliar Tahun',
  'teleskop-james-webb',
  'Mata manusia di luar angkasa yang menatap cahaya dari masa paling awal alam semesta.',
  'https://upload.wikimedia.org/wikipedia/commons/2/2a/JWST_spacecraft_model_3.png',
  '[
    {"type":"paragraph","data":{"text":"Cahaya membutuhkan waktu untuk melaju. Semakin jauh objek, semakin lama cahayanya sampai ke kita. Teleskop James Webb mampu menangkap cahaya yang telah menempuh perjalanan 13,5 miliar tahun — artinya ia benar-benar melihat masa lalu."}},
    {"type":"heading","data":{"text":"Karya Teknologi Terbesar di Luar Angkasa"}},
    {"type":"paragraph","data":{"text":"Cermin utama Webb berdiameter 6,5 meter dan dilapisi emas agar menangkap cahaya inframerah. Perisai matahari sebesar lapangan tenis melindunginya, dan ia mengorbit 1,5 juta kilometer dari Bumi di titik Lagrange kedua."}},
    {"type":"fact","data":{"text":"Dengan bantuan gravitasi dan suhu -233 derajat Celsius, Webb bisa mendeteksi panas sekecil lilin lebah dari jarak Bulan."}},
    {"type":"list","data":{"items":["Diluncurkan pada Desember 2021","Membutuhkan waktu sekitar 30 hari untuk membuka cerminnya","Bisa mengintip atmosfer planet di luar tata surya","Menjadi proyek sains termahal: sekitar 10 miliar dolar"]}},
    {"type":"quote","data":{"text":"Melihat Webb sama dengan membuka jendela menuju masa ketika galaksi pertama baru lahir."}},
    {"type":"paragraph","data":{"text":"Setiap gambar yang dikirim Webb bukan sekadar foto — melainkan kilas balik paling jauh yang pernah dilihat umat manusia."}}
  ]'::jsonb,
  5,
  'PUBLISHED',
  '2026-08-09T09:00:00Z'
),
(
  'Sekta',
  (select id from public.categories where slug = 'teknologi'),
  'Graphene: Bahan Satu Atom yang Lebih Kuat dari Baja',
  'graphene-bahan-terkuat',
  'Diciptakan dari pensil dan selotip, kini disebut material ajaib masa depan.',
  'https://upload.wikimedia.org/wikipedia/commons/9/9e/Graphen.jpg',
  '[
    {"type":"paragraph","data":{"text":"Graphene adalah lembaran karbon setebal satu atom — bahan paling tipis yang pernah diketahui manusia. Tapi jangan salah: ia sekitar 200 kali lebih kuat dari baja."}},
    {"type":"heading","data":{"text":"Dari Selotip ke Nobel"}},
    {"type":"paragraph","data":{"text":"Pada 2004, dua ilmuwan di Manchester mengisolasi graphene dengan mengelupas grafit pensil memakai selotip biasa. Enam tahun kemudian mereka memenangkan Nobel Fisika atas penemuan yang dianggap mustahil ini."}},
    {"type":"fact","data":{"text":"Graphene 200 kali lebih kuat dari baja, tetapi tetap lentur, transparan, dan penghantar listrik yang lebih baik daripada tembaga."}},
    {"type":"list","data":{"items":["Tebalnya hanya satu atom — sekitar 1 juta kali lebih tipis dari rambut","Berpotensi untuk layar lipat, baterai super, dan pemurni air","Kuat namun bisa ditarik seperti karet"]}},
    {"type":"quote","data":{"text":"Dari ujung pensil, manusia menemukan material yang bisa mengubah seluruh industri."}},
    {"type":"paragraph","data":{"text":"Ratusan laboratorium kini berlomba memproduksi graphene secara massal — membayangkan dunia dengan layar fleksibel, baterai yang mengisi dalam hitungan menit, dan material sekuat baja tapi seringan bulu."}}
  ]'::jsonb,
  5,
  'PUBLISHED',
  '2026-08-10T09:00:00Z'
)
on conflict (slug) do nothing;

-- ---------- ARTIKEL UNGGULAN (opsional, tampil di hero beranda) ----------
update public.articles set featured = true
where slug in ('cheetah-hewan-tercepat', 'rafflesia-bunga-terbesar');

-- ---------- SEKEJAP FAKTA ----------
insert into public.sekejap_facts (fact, article_id) values
  ('Axolotl bisa menumbuhkan kembali bagian otaknya tanpa bekas luka.', (select id from public.articles where slug = 'axolotl-salamander-ajaib')),
  ('Tardigrade bisa hidup puluhan tahun tanpa makan dan minum.', (select id from public.articles where slug = 'tardigrade-beruang-air')),
  ('Pukulan udang mantis secepat peluru dan bisa memecahkan kaca.', (select id from public.articles where slug = 'udang-mantis-pukulan-secepat-peluru')),
  ('Cheetah berakselerasi 0-100 km/jam dalam 3 detik.', (select id from public.articles where slug = 'cheetah-hewan-tercepat')),
  ('Rafflesia arnoldii adalah bunga tunggal terbesar di dunia.', (select id from public.articles where slug = 'rafflesia-bunga-terbesar')),
  ('Venus flytrap menghitung sentuhan untuk mencerna mangsanya.', (select id from public.articles where slug = 'venus-flytrap-tanaman-karnivora')),
  ('Titan arum memanaskan bunganya hingga 36 derajat Celsius.', (select id from public.articles where slug = 'bunga-bangkai-titan-arum')),
  ('Komputer kuantum beroperasi mendekati -273 derajat Celsius.', (select id from public.articles where slug = 'komputer-kuantum')),
  ('Teleskop James Webb melihat cahaya dari 13,5 miliar tahun lalu.', (select id from public.articles where slug = 'teleskop-james-webb')),
  ('Graphene 200 kali lebih kuat dari baja setebal satu atom.', (select id from public.articles where slug = 'graphene-bahan-terkuat'))
on conflict (fact) do nothing;

-- ---------- SUMBER ----------
insert into public.sources (article_id, title, url, publisher) values
  ((select id from public.articles where slug = 'axolotl-salamander-ajaib'), 'Axolotl', 'https://en.wikipedia.org/wiki/Axolotl', 'Wikipedia'),
  ((select id from public.articles where slug = 'tardigrade-beruang-air'), 'Tardigrade', 'https://en.wikipedia.org/wiki/Tardigrade', 'Wikipedia'),
  ((select id from public.articles where slug = 'udang-mantis-pukulan-secepat-peluru'), 'Peacock mantis shrimp', 'https://en.wikipedia.org/wiki/Peacock_mantis_shrimp', 'Wikipedia'),
  ((select id from public.articles where slug = 'cheetah-hewan-tercepat'), 'Cheetah', 'https://en.wikipedia.org/wiki/Cheetah', 'Wikipedia'),
  ((select id from public.articles where slug = 'rafflesia-bunga-terbesar'), 'Rafflesia arnoldii', 'https://en.wikipedia.org/wiki/Rafflesia_arnoldii', 'Wikipedia'),
  ((select id from public.articles where slug = 'venus-flytrap-tanaman-karnivora'), 'Venus flytrap', 'https://en.wikipedia.org/wiki/Venus_flytrap', 'Wikipedia'),
  ((select id from public.articles where slug = 'bunga-bangkai-titan-arum'), 'Titan arum', 'https://en.wikipedia.org/wiki/Amorphophallus_titanum', 'Wikipedia'),
  ((select id from public.articles where slug = 'komputer-kuantum'), 'Quantum computing', 'https://en.wikipedia.org/wiki/Quantum_computing', 'Wikipedia'),
  ((select id from public.articles where slug = 'teleskop-james-webb'), 'James Webb Space Telescope', 'https://en.wikipedia.org/wiki/James_Webb_Space_Telescope', 'Wikipedia'),
  ((select id from public.articles where slug = 'graphene-bahan-terkuat'), 'Graphene', 'https://en.wikipedia.org/wiki/Graphene', 'Wikipedia')
on conflict (article_id, title) do nothing;
