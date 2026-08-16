// Seed batch-2: 10 artikel sehari-hari + kuis (3 soal) + fakta + sumber.
// Insert via service role, lalu tulis docs/seed-10-artikel-sehari-hari-2.sql (idempoten).
import { createClient } from '@supabase/supabase-js';
import { writeFileSync } from 'node:fs';

const URL = 'https://ynhfcdbbhhsjnynynddd.supabase.co';
const SERVICE = process.env.SUPABASE_SERVICE_ROLE_KEY;
const sb = createClient(URL, SERVICE);

const ARTICLES = [
  {
    title: 'Kenapa Kita Cegukan? Refleks Kecil yang Mengganggu',
    slug: 'kenapa-kita-cegukan',
    excerpt: 'Cegukan datang tiba-tiba dan hilang sendiri — tapi apa yang sebenarnya terjadi di dalam tubuh?',
    category: 'manusia',
    imgKeyword: 'hiccup',
    blocks: [
      { t: 'paragraph', text: 'Cegukan datang tanpa undangan: tiba-tiba "hik", lalu hilang sendiri. Meski sering dialami, mekanismenya masih mengejutkan banyak orang.' },
      { t: 'heading', text: 'Refleks yang Tidak Disengaja' },
      { t: 'paragraph', text: 'Cegukan terjadi saat diafragma — otot utama pernapasan — berkontraksi tiba-tiba dan pita suara menutup cepat. Udara tersumbat sehingga muncul suara "hik" yang khas.' },
      { t: 'fact', text: 'Cegukan terpanjang dalam sejarah tercatat berlangsung 68 tahun. Pemiliknya, Charles Osborne, mulai cegukan tahun 1922 dan baru berhenti tahun 1990.' },
      { t: 'list', items: ['Makan terlalu cepat atau terlalu kenyang memicu cegukan', 'Makanan pedas dan minuman bersoda juga pemicu umum', 'Cegukan bayi di dalam kandungan sudah mulai terjadi di trimester akhir'] },
      { t: 'quote', text: 'Cegukan adalah pengingat bahwa tubuh punya refleks yang bekerja di luar kendali kita.' },
      { t: 'paragraph', text: 'Menahan napas sebentar, menelan, atau meminum air perlahan sering membantu menghentikannya. Kalau cegukan tak kunjung berhenti berhari-hari, saatnya konsultasi ke dokter.' }
    ],
    source: ['Hiccup', 'https://en.wikipedia.org/wiki/Hiccup'],
    fact: 'Cegukan terpanjang yang tercatat berlangsung 68 tahun tanpa henti.',
    quiz: [
      { q: 'Apa penyebab langsung munculnya cegukan?', opts: [['Kontraksi diafragma yang tiba-tiba', true], ['Kekurangan vitamin C', false], ['Terlalu banyak minum air', false], ['Aliran darah ke kepala meningkat', false]] },
      { q: 'Suara "hik" pada cegukan muncul karena...', opts: [['Pita suara menutup cepat saat udara tersumbat', true], ['Lidah bergetar karena dingin', false], ['Tulang rusuk bergeser', false], ['Gigi mengatup tanpa sengaja', false]] },
      { q: 'Manakah pernyataan yang benar tentang cegukan?', opts: [['Makan terlalu cepat bisa memicunya', true], ['Cegukan hanya terjadi saat tidur', false], ['Cegukan menandakan penyakit jantung', false], ['Cegukan tidak bisa dihentikan dengan cara apa pun', false]] }
    ]
  },
  {
    title: 'Mengapa Wajah Merah saat Malu?',
    slug: 'mengapa-wajah-merah-saat-malu',
    excerpt: 'Tersipu adalah bahasa tubuh paling jujur — dan fenomena yang ternyata sangat langka di dunia hewan.',
    category: 'manusia',
    imgKeyword: 'blushing',
    blocks: [
      { t: 'paragraph', text: 'Semua orang pernah merasakannya: wajah terasa panas dan memerah saat melakukan kesalahan di depan banyak orang. Ini bukan sekadar malu — ada mekanisme tubuh di baliknya.' },
      { t: 'heading', text: 'Adrenalin dan Pembuluh Darah' },
      { t: 'paragraph', text: 'Saat malu, otak memicu pelepasan adrenalin. Pembuluh darah di wajah melebar sehingga lebih banyak darah mengalir, dan kulit pun tampak memerah.' },
      { t: 'fact', text: 'Tersipu karena malu hampir unik untuk manusia — hampir tidak ada hewan lain yang menunjukkan respons sosial seperti ini.' },
      { t: 'list', items: ['Pelebaran pembuluh darah membuat wajah terasa panas', 'Tersipu bisa menular dalam kelompok', 'Wajah memerah juga bisa muncul karena marah atau olahraga'] },
      { t: 'quote', text: 'Wajah memerah adalah sinyal sosial yang sulit dipalsukan.' },
      { t: 'paragraph', text: 'Para peneliti menduga tersipu berevolusi sebagai sinyal jujur yang menunjukkan rasa menyesal dan memperbaiki hubungan sosial.' }
    ],
    source: ['Blushing', 'https://en.wikipedia.org/wiki/Blushing'],
    fact: 'Tersipu malu hampir tidak ditemukan pada hewan lain — ini keunikan manusia.',
    quiz: [
      { q: 'Wajah merah saat malu disebabkan oleh...', opts: [['Adrenalin melebarkan pembuluh darah wajah', true], ['Kekurangan oksigen di kulit', false], ['Suhu tubuh naik karena demam', false], ['Alergi terhadap lingkungan', false]] },
      { q: 'Apa fungsi evolusioner tersipu?', opts: [['Menjadi sinyal jujur untuk memperbaiki hubungan sosial', true], ['Menakuti pemangsa', false], ['Membuat lawan bicara menyerah', false], ['Menjaga suhu tubuh tetap hangat', false]] },
      { q: 'Manakah pernyataan yang benar?', opts: [['Tersipu hampir unik untuk manusia', true], ['Semua hewan ikut tersipu saat malu', false], ['Tersipu terjadi karena otot wajah mengecil', false], ['Wajah merah selalu tanda demam', false]] }
    ]
  },
  {
    title: 'Kenapa Susu Bisa Basi dan Berbau Asam?',
    slug: 'kenapa-susu-bisa-basi',
    excerpt: 'Susu yang ditinggalkan di suhu ruang berubah asam dalam hitungan jam — inilah biang keladinya.',
    category: 'sains',
    imgKeyword: 'glass of milk',
    blocks: [
      { t: 'paragraph', text: 'Semua susu pada akhirnya akan basi — hanya masalah waktu. Yang menentukan cepat-lambatnya adalah suhu dan bakteri di sekitarnya.' },
      { t: 'heading', text: 'Kerja Bakteri Asam Laktat' },
      { t: 'paragraph', text: 'Bakteri asam laktat mengubah laktosa (gula susu) menjadi asam laktat. Asam inilah yang membuat susu berbau asam, menggumpal, dan rasanya masam.' },
      { t: 'fact', text: 'Pasteurisasi tidak membuat susu awet selamanya — ia hanya membunuh sebagian besar bakteri sehingga susu bertahan lebih lama di lemari es.' },
      { t: 'list', items: ['Suhu hangat mempercepat perkembangbiakan bakteri', 'Susu basi menggumpal karena protein mengendap oleh asam', 'Susu UHT bertahan lebih lama karena dipanaskan lebih tinggi'] },
      { t: 'quote', text: 'Basi adalah kerja keras bakteri yang berubah menjadi masalah dapur.' },
      { t: 'paragraph', text: 'Selama belum berbau asam atau menggumpal, susu masih aman. Begitu asam, buang saja — tubuhmu tidak butuh bakteri ekstra.' }
    ],
    source: ['Sour milk', 'https://en.wikipedia.org/wiki/Sour_milk'],
    fact: 'Susu basi terjadi karena bakteri mengubah gula laktosa menjadi asam laktat.',
    quiz: [
      { q: 'Penyebab utama susu menjadi basi adalah...', opts: [['Bakteri mengubah laktosa menjadi asam laktat', true], ['Udara dingin merusak protein', false], ['Vitamin hilang terkena cahaya', false], ['Susu terlalu lama di lemari es', false]] },
      { q: 'Mengapa susu basi menggumpal?', opts: [['Protein mengendap karena pengaruh asam', true], ['Bakteri membekukan susu', false], ['Kandungan lemak memadat', false], ['Susu kehilangan airnya', false]] },
      { q: 'Apa fungsi pasteurisasi?', opts: [['Membunuh sebagian besar bakteri agar susu tahan lebih lama', true], ['Menambahkan rasa manis', false], ['Membuat susu selalu segar tanpa batas waktu', false], ['Menghilangkan semua kandungan lemak', false]] }
    ]
  },
  {
    title: 'Mengapa Gigi Bisa Berlubang?',
    slug: 'mengapa-gigi-bisa-berlubang',
    excerpt: 'Gigi punya lapisan terkeras di tubuh — tapi bakteri dan gula tetap bisa menang.',
    category: 'manusia',
    imgKeyword: 'tooth decay',
    blocks: [
      { t: 'paragraph', text: 'Enamel gigi adalah jaringan paling keras di tubuh manusia — lebih keras dari tulang. Namun gigi tetap bisa berlubang. Bagaimana bisa?' },
      { t: 'heading', text: 'Asam yang Ditimbulkan Bakteri' },
      { t: 'paragraph', text: 'Bakteri di mulut mengubah sisa gula menjadi asam. Asam itu perlahan melarutkan mineral enamel, lalu menembus dentin, dan akhirnya sampai ke pulpa yang berisi saraf — itulah saat gigi terasa ngilu.' },
      { t: 'fact', text: 'Karies gigi adalah salah satu penyakit paling umum di dunia, bahkan mengalahkan banyak penyakit lainnya dalam jumlah penderita.' },
      { t: 'list', items: ['Sikat gigi membantu menghilangkan plak sebelum menjadi asam', 'Air liur membantu menetralkan asam di mulut', 'Fluoride memperkuat enamel melawan asam'] },
      { t: 'quote', text: 'Gigi bukan musuh gula — musuh sebenarnya adalah asam hasil kerja bakteri.' },
      { t: 'paragraph', text: 'Menjaga mulut bersih, mengurangi gula, dan rutin ke dokter gigi adalah kunci mencegah lubang sejak dini.' }
    ],
    source: ['Tooth decay', 'https://en.wikipedia.org/wiki/Tooth_decay'],
    fact: 'Enamel gigi adalah jaringan paling keras yang dimiliki tubuh manusia.',
    quiz: [
      { q: 'Proses gigi berlubang dimulai dari...', opts: [['Bakteri mengubah gula menjadi asam yang melarutkan enamel', true], ['Gigi mengeras karena terlalu banyak kalsium', false], ['Sikat gigi terlalu keras mengikis gigi', false], ['Kekurangan vitamin D langsung melubangi gigi', false]] },
      { q: 'Bahan apa yang memperkuat enamel melawan asam?', opts: [['Fluoride', true], ['Kafein', false], ['Asam sitrat', false], ['Garam meja', false]] },
      { q: 'Manakah pernyataan yang benar?', opts: [['Air liur membantu menetralkan asam di mulut', true], ['Gigi berlubang tidak bisa dicegah', false], ['Enamel lebih lunak dari tulang', false], ['Bakteri tidak berperan dalam kerusakan gigi', false]] }
    ]
  },
  {
    title: 'Kenapa Badan Menggigil Saat Demam?',
    slug: 'kenapa-badan-menggigil-saat-demam',
    excerpt: 'Menggigil bukan karena kedinginan — itu cara tubuh menaikkan suhunya sendiri.',
    category: 'manusia',
    imgKeyword: 'fever',
    blocks: [
      { t: 'paragraph', text: 'Saat demam mulai, kamu justru menggigil padahal tubuhmu panas. Ini terlihat kontradiktif, tapi sebenarnya sangat masuk akal.' },
      { t: 'heading', text: 'Suhu yang Dinaikkan Suka-Suka Otak' },
      { t: 'paragraph', text: 'Hipotalamus di otak menaikkan "pengaturan suhu" tubuh saat melawan infeksi. Karena suhu tubuh masih di bawah angka itu, tubuh merasa "dingin" dan menggigil untuk menghasilkan panas.' },
      { t: 'fact', text: 'Menggigil bisa menghasilkan panas hingga tiga sampai lima kali lebih banyak daripada kondisi normal.' },
      { t: 'list', items: ['Menggigil adalah kerja otot yang menghasilkan panas', 'Obat penurun panas menggeser set point kembali normal', 'Suhu tubuh naik membantu melawan kuman'] },
      { t: 'quote', text: 'Menggigil saat demam bukan tanda kedinginan — ia adalah mekanisme pemanasan dari dalam.' },
      { t: 'paragraph', text: 'Berpakaian nyaman dan cukup minum membantu tubuh melewati demam. Kalau demam sangat tinggi atau berhari-hari, segera periksakan ke tenaga medis.' }
    ],
    source: ['Fever', 'https://en.wikipedia.org/wiki/Fever'],
    fact: 'Menggigil saat demam bisa menghasilkan panas hingga 3-5 kali lipat dari normal.',
    quiz: [
      { q: 'Kenapa tubuh menggigil saat demam?', opts: [['Hipotalamus menaikkan pengaturan suhu sehingga tubuh berusaha memanaskan diri', true], ['Tubuh kehilangan banyak air', false], ['Vitamin C berlebih membuat otot menegang', false], ['Darah mengental karena dingin', false]] },
      { q: 'Apa fungsi kenaikan suhu saat demam?', opts: [['Membantu tubuh melawan infeksi', true], ['Mempercepat pertumbuhan bakteri', false], ['Mengurangi kebutuhan tidur', false], ['Meningkatkan produksi keringat saja', false]] },
      { q: 'Bagaimana obat penurun panas bekerja?', opts: [['Menurunkan set point suhu di hipotalamus', true], ['Membekukan darah', false], ['Menyedot panas lewat kulit', false], ['Menonaktifkan otot penggigil', false]] }
    ]
  },
  {
    title: 'Mengapa Gelas Dingin Berembun?',
    slug: 'mengapa-gelas-dingin-berembun',
    excerpt: 'Tetesan air di gelas es bukan bocor — itu uap udara yang kembali menjadi cair.',
    category: 'sains',
    imgKeyword: 'condensation glass',
    blocks: [
      { t: 'paragraph', text: 'Es teh dingin di hari panas pasti "berkeringat". Padahal gelasnya tidak bocor — dan tetesan itu bahkan tidak selalu dari air minummu.' },
      { t: 'heading', text: 'Perjalanan Uap Menjadi Cair' },
      { t: 'paragraph', text: 'Udara di sekitarmu mengandung uap air. Saat menyentuh permukaan gelas yang dingin, uap kehilangan energi, mengembun, dan berubah menjadi tetesan air di luar gelas.' },
      { t: 'fact', text: 'Proses ini bernama kondensasi — fenomena yang sama saat embun pagi terbentuk di daun atau kaca buram di ruang mandi.' },
      { t: 'list', items: ['Makin dingin gelas, makin cepat embun terbentuk', 'Udara lembap memperbanyak tetesan', 'Makin cepat uap mengembun di tempat yang lebih dingin dari titik embun'] },
      { t: 'quote', text: 'Setiap tetes di gelas es adalah uap udara yang pulang menjadi cair.' },
      { t: 'paragraph', text: 'Letakkan gelas di atas tatakan, dan perhatikan: tetesan itu adalah cuaca mini yang sedang terjadi di meja makanmu.' }
    ],
    source: ['Condensation', 'https://en.wikipedia.org/wiki/Condensation'],
    fact: 'Embun di gelas dingin adalah uap air di udara yang mengembun kembali menjadi cair.',
    quiz: [
      { q: 'Tetesan air di luar gelas dingin berasal dari...', opts: [['Uap air di udara yang mengembun', true], ['Air minum yang merembes keluar', false], ['Retakan pada gelas', false], ['Es yang mencair di dalam gelas', false]] },
      { q: 'Apa nama proses ini?', opts: [['Kondensasi', true], ['Evaporasi', false], ['Sublimasi', false], ['Filtrasi', false]] },
      { q: 'Manakah yang membuat gelas lebih cepat berembun?', opts: [['Udara yang lembap dan gelas yang dingin', true], ['Udara sangat kering', false], ['Gelas yang panas', false], ['Kandungan gula dalam minuman', false]] }
    ]
  },
  {
    title: 'Kenapa Tulang Kita Berbunyi "Krek"?',
    slug: 'kenapa-tulang-berbunyi-krek',
    excerpt: 'Bunyi krek saat menggerakkan jari atau leher biasanya bukan tanda patah tulang.',
    category: 'fakta-unik',
    imgKeyword: 'hand bones',
    blocks: [
      { t: 'paragraph', text: 'Pernah mendengar bunyi "krek" saat bangun pagi atau menggerakkan leher? Tenang, sebagian besar bunyi itu normal dan tidak berbahaya.' },
      { t: 'heading', text: 'Gas yang Lepas di Sendi' },
      { t: 'paragraph', text: 'Antara tulang ada cairan sendi yang mengandung gas terlarut. Saat sendi diregangkan, tekanannya turun dan gas membentuk gelembung yang pecah — itulah sumber bunyi krek.' },
      { t: 'fact', text: 'Bunyi krek pada jari bukan tanda radang sendi. Penelitian besar gagal menemukan hubungannya dengan nyeri sendi.' },
      { t: 'list', items: ['Cairan sendi disebut cairan sinovial', 'Setelah berbunyi, butuh waktu beberapa menit untuk bunyi lagi', 'Krek berulang disertai nyeri atau bengkak perlu diperiksa'] },
      { t: 'quote', text: 'Krek di persendian sering kali hanya ucapan selamat pagi dari gas nitrogen.' },
      { t: 'paragraph', text: 'Yang perlu diwaspadai adalah krek yang datang bersama nyeri, bengkak, atau bunyi yang "terkunci" — itu tanda untuk bertanya ke dokter.' }
    ],
    source: ['Cracking joints', 'https://en.wikipedia.org/wiki/Cracking_joints'],
    fact: 'Bunyi krek di jari berasal dari gelembung gas nitrogen yang pecah di cairan sendi.',
    quiz: [
      { q: 'Bunyi "krek" pada sendi berasal dari...', opts: [['Gelembung gas nitrogen yang pecah di cairan sendi', true], ['Pergeseran tulang yang patah', false], ['Tendon yang putus', false], ['Aliran darah yang tersumbat', false]] },
      { q: 'Apa nama cairan pelumas di sendi?', opts: [['Cairan sinovial', true], ['Cairan serebrospinal', false], ['Plasma darah', false], ['Getah bening', false]] },
      { q: 'Manakah yang benar tentang krek sendi?', opts: [['Krek jari tidak terbukti menyebabkan radang sendi', true], ['Krek selalu tanda patah tulang', false], ['Krek hanya terjadi pada orang tua', false], ['Bunyi krek berarti sendi rusak permanen', false]] }
    ]
  },
  {
    title: 'Mengapa Makanan Manis Membuat Ketagihan?',
    slug: 'mengapa-makanan-manis-membuat-ketagihan',
    excerpt: 'Gula bukan sekadar rasa — ia berbicara langsung ke pusat kesenangan otak.',
    category: 'sains',
    imgKeyword: 'sugar cubes',
    blocks: [
      { t: 'paragraph', text: 'Satu potong kue saja tidak pernah cukup. Bukan karena kurang nafsu — ada jalur kimia di otak yang membuat kita menginginkan lebih.' },
      { t: 'heading', text: 'Dopamin dan Sinyal Bahagia' },
      { t: 'paragraph', text: 'Gula memicu pelepasan dopamin, neurotransmiter yang membuat kita merasa senang. Jalur ini sama dengan yang diaktifkan oleh hal-hal menyenangkan lain — itulah mengapa manis terasa "kecanduan".' },
      { t: 'fact', text: 'Penelitian pada hewan menunjukkan gula bisa memicu sinyal dopamin berulang, menyerupai pola yang terlihat pada kecanduan zat.' },
      { t: 'list', items: ['Gula alami dari buah disertai serat yang memperlambat penyerapan', 'Gula tambahan pada minuman cepat terserap dan cepat memicu lonjakan', 'Lonjakan gula diikuti penurunan yang membuat kita lapar lagi'] },
      { t: 'quote', text: 'Manis adalah bahasa yang dipahami otak sebelum lidah sempat menerjemahkannya.' },
      { t: 'paragraph', text: 'Bukan berarti gula harus dihindari total — cukup kenali polanya, dan pilih sumber manis yang datang bersama serat dan nutrisi.' }
    ],
    source: ['Sugar and the brain', 'https://en.wikipedia.org/wiki/Sugar_addiction'],
    fact: 'Gula memicu pelepasan dopamin di otak — jalur yang sama dengan hal-hal menyenangkan.',
    quiz: [
      { q: 'Mengapa makanan manis terasa "membuat ketagihan"?', opts: [['Gula memicu pelepasan dopamin di otak', true], ['Gula menumpuk di otot', false], ['Gula membuat pembuluh darah menyempit', false], ['Gula mematikan reseptor rasa lainnya', false]] },
      { q: 'Apa kelebihan gula alami dari buah?', opts: [['Datang bersama serat yang memperlambat penyerapan', true], ['Tidak mengandung kalori sama sekali', false], ['Langsung diserap seluruhnya oleh lambung', false], ['Membuat tubuh tidak perlu insulin', false]] },
      { q: 'Manakah yang benar tentang gula tambahan?', opts: [['Cepat terserap dan bisa memicu lonjakan gula darah', true], ['Selalu aman dalam jumlah berapa pun', false], ['Hanya ditemukan di minuman soda', false], ['Tidak berpengaruh pada rasa lapar', false]] }
    ]
  },
  {
    title: 'Kenapa Hidung Meler Saat Makan Pedas?',
    slug: 'kenapa-hidung-meler-saat-makan-pedas',
    excerpt: 'Hidung meler saat makan pedas bukan gangguan — itu sistem pertahanan tubuh yang sedang bekerja.',
    category: 'fakta-unik',
    imgKeyword: 'chili pepper',
    blocks: [
      { t: 'paragraph', text: 'Sepiring sambal bisa membuat mata berair dan hidung ikut meler. Ternyata keduanya adalah satu sistem pertahanan yang sama.' },
      { t: 'heading', text: 'Lendir yang Bertugas Menjaga' },
      { t: 'paragraph', text: 'Capsaicin dari cabe merangsang saraf yang memerintahkan produksi lendir berlebih. Tubuh mencoba "membilas" zat yang dianggap mengganggu — hasilnya hidungmu meler.' },
      { t: 'fact', text: 'Tubuh memproduksi sekitar 1,5 liter lendir setiap hari, sebagian besar tertelan tanpa kita sadari.' },
      { t: 'list', items: ['Lendir menangkap debu dan kuman sebelum masuk paru-paru', 'Susu membantu karena proteinnya mengikat capsaicin', 'Makin pedas, makin deras produksi lendirnya'] },
      { t: 'quote', text: 'Hidung meler saat makan pedas adalah cara tubuh berkata "ini terlalu ekstrem, kubersihkan dulu".' },
      { t: 'paragraph', text: 'Jadi bukan kebetulan hidung ikut "menangis" saat mulut terbakar — keduanya saling membantu menjaga tubuhmu.' }
    ],
    source: ['Capsaicin', 'https://en.wikipedia.org/wiki/Capsaicin'],
    fact: 'Tubuh manusia memproduksi sekitar 1,5 liter lendir setiap hari.',
    quiz: [
      { q: 'Kenapa makan pedas membuat hidung meler?', opts: [['Capsaicin merangsang produksi lendir untuk membilas', true], ['Pedas menyebabkan dehidrasi', false], ['Keringat mengalir ke hidung', false], ['Alergi terhadap cabe', false]] },
      { q: 'Mengapa susu lebih efektif meredakan pedas daripada air?', opts: [['Protein susu mengikat capsaicin', true], ['Susu lebih dingin dari air', false], ['Susu mengandung gula', false], ['Susu mengencerkan lambung', false]] },
      { q: 'Apa fungsi utama lendir di saluran napas?', opts: [['Menangkap debu dan kuman', true], ['Menghasilkan oksigen', false], ['Memanaskan makanan', false], ['Mengunyah makanan', false]] }
    ]
  },
  {
    title: 'Mengapa Mata Sering Berkedut?',
    slug: 'mengapa-mata-sering-berkedut',
    excerpt: 'Kelopak mata yang berkedut sendiri biasanya bukan pertanda apa-apa — tapi ada pemicunya.',
    category: 'manusia',
    imgKeyword: 'human eye',
    blocks: [
      { t: 'paragraph', text: 'Kelopak mata tiba-tiba berkedut selama beberapa detik lalu berhenti. Banyak orang mengaitkannya dengan mitos — padahal ada penjelasan medisnya.' },
      { t: 'heading', text: 'Myokimia, Bukan Mistis' },
      { t: 'paragraph', text: 'Kedutan kelopak mata disebut myokymia — kontraksi kecil otot di kelopak yang tidak terkendali. Penyebabnya biasanya kelelahan, stres, atau kafein berlebih.' },
      { t: 'fact', text: 'Myokymia hampir selalu tidak berbahaya dan hilang sendiri dalam hitungan hari tanpa pengobatan.' },
      { t: 'list', items: ['Kurang tidur adalah pemicu paling umum', 'Mengurangi kafein bisa menghentikan kedutan', 'Kedutan yang menyebar ke seluruh wajah perlu diperiksa'] },
      { t: 'quote', text: 'Berkedutnya kelopak mata adalah kode sederhana: istirahat, minum air, dan kurangi kopi.' },
      { t: 'paragraph', text: 'Kalau kedutan bertahan berminggu-minggu atau menyebar ke bagian wajah lain, konsultasikan ke dokter untuk memastikan semuanya normal.' }
    ],
    source: ['Fasciculation', 'https://en.wikipedia.org/wiki/Fasciculation'],
    fact: 'Kelopak mata yang berkedut disebut myokymia dan hampir selalu tidak berbahaya.',
    quiz: [
      { q: 'Nama medis untuk kedutan kelopak mata adalah...', opts: [['Myokymia', true], ['Miopia', false], ['Migrain', false], ['Katarak', false]] },
      { q: 'Apa pemicu paling umum mata berkedut?', opts: [['Kelelahan dan kurang tidur', true], ['Makan buah berlebihan', false], ['Terlalu banyak minum air', false], ['Angin malam', false]] },
      { q: 'Kapan kedutan mata perlu diperiksa dokter?', opts: [['Saat menyebar ke seluruh wajah atau bertahan berminggu-minggu', true], ['Saat terjadi sekali dalam sebulan', false], ['Saat berlangsung satu detik', false], ['Tidak perlu pernah', false]] }
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
  const blocks = article.blocks.map((b) =>
    b.t === 'list'
      ? { type: 'list', data: { items: b.items } }
      : { type: b.t, data: { text: b.text } }
  );
  return JSON.stringify(blocks);
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
-- SEKTA — SEED 10 ARTIKEL SEHARI-HARI BATCH 2 (+ kuis & fakta)
-- ============================================================
-- Jalankan di Supabase Dashboard → SQL Editor → Run.
-- Idempoten: artikel via slug, fakta via kolom unik, kuis via judul.
-- Kategori: manusia, sains, fakta-unik.

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

const now = () => new Date().toISOString();

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
    const publishedAt = now();
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
    console.log(`  + ${a.slug} (img: ${image ? 'ok' : 'null'})`);
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
    writeFileSync('docs/seed-10-artikel-sehari-hari-2.sql', genSQL(fs), 'utf8');
    console.log('SQL ditulis ke docs/seed-10-artikel-sehari-hari-2.sql');
  }
  console.log(`Selesai. ${inserted.length} artikel baru.`);
}

main().catch((e) => { console.error('FAIL:', e); process.exit(1); });
