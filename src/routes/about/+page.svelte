<script lang="ts">
  import TopBar from '$lib/components/TopBar.svelte';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');
</script>

<div class="min-h-full pb-12 transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <TopBar title="Tentang Sekejap Fakta" backHref="/" />
  <div class="px-6 py-6 max-w-2xl mx-auto space-y-8">

    <section class="text-center space-y-3 py-2">
      <h2 class="text-2xl font-black tracking-tight">Fakta itu Menyenangkan.</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Dunia penuh hal menakjubkan yang belum kita ketahui — dan mempelajarinya tidak harus membosankan.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">Apa itu Sekejap Fakta?</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Sekejap Fakta adalah platform pengetahuan digital yang mengubah rasa penasaran menjadi kebiasaan belajar.
        Setiap hari kami menghadirkan fakta unik dari sains, sejarah, teknologi, dan dunia — dikemas singkat, ringan,
        dan menyenangkan, sehingga siapa pun bisa belajar dalam sekejap mata, di sela-sela kesibukan sehari-hari.
      </p>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Tidak peduli umurmu 8 atau 80 tahun — di sini selalu ada hal baru yang bikin kamu bilang, <em>"Oh, baru
        tahu!"</em>
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">Kuis Interaktif, Belajar yang Terukur</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Membaca saja tidak cukup — memahami itu yang penting. Itulah kenapa setiap topik dilengkapi kuis interaktif
        yang seru. Anak-anak bisa menguji seberapa dalam mereka memahami materi, sambil tetap tertawa dan terhibur.
        Belajar jadi petualangan, bukan hafalan.
      </p>
    </section>

    <section class="space-y-3 rounded-2xl border p-5 {isDark ? 'bg-[#141720] border-slate-800' : 'bg-blue-50 border-blue-100'}">
      <h2 class="text-base font-black">Dibalik Layar: Riky Dwianto</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-700'}">
        Sekejap Fakta dibuat oleh <span class="font-black">Riky Dwianto</span>, seorang <span class="font-bold">fullstack developer</span>
        dengan pengalaman <span class="font-bold">lebih dari 5 tahun</span> membangun berbagai project besar yang
        nyata manfaatnya — dari platform bisnis hingga produk teknologi untuk masyarakat.
      </p>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-700'}">
        Di balik setiap baris kode, ada satu tujuan sederhana: <span class="font-bold">membuat teknologi yang
        bermanfaat untuk banyak orang.</span> Sekejap Fakta adalah wujud dari semangat itu — sebuah cara baru agar
        ilmu pengetahuan bisa dinikmati anak-anak hingga orang dewasa di mana pun mereka berada.
      </p>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-700'}">
        Jelajahi karya-karya lain Riky di
        <a
          href="https://rikydwianto.my.id"
          target="_blank"
          rel="noopener noreferrer"
          class="font-black text-blue-600 underline underline-offset-4 decoration-2"
        >
          rikydwianto.my.id
        </a>
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">Mari Belajar Bareng</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Satu fakta hari ini, satu ilmu untuk selamanya. Selamat datang di Sekejap Fakta — rumah bagi orang yang tidak
        pernah berhenti penasaran.
      </p>
    </section>

  </div>
</div>
