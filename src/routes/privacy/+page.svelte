<script lang="ts">
  import TopBar from '$lib/components/TopBar.svelte';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');
</script>

<div class="min-h-full pb-12 transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <TopBar title="Kebijakan Privasi" backHref="/" />
  <div class="px-6 py-6 max-w-2xl mx-auto space-y-6">
    <p class="text-sm leading-relaxed font-medium {isDark ? 'text-slate-300' : 'text-slate-600'}">
      Terakhir diperbarui: 15 Agustus 2026
    </p>

    <section class="space-y-2">
      <h2 class="text-base font-black">1. Data yang Kami Kumpulkan</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Kami mengumpulkan data yang Anda berikan secara langsung saat mendaftar, seperti nama, alamat email, dan
        preferensi minat. Kami juga menyimpan aktivitas dasar seperti artikel yang Anda baca, reaksi yang Anda berikan,
        dan hasil kuis untuk meningkatkan pengalaman Anda.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">2. Penggunaan Data</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Data yang kami kumpulkan digunakan untuk: (a) menyediakan dan meningkatkan layanan Sekta, (b) merekomendasikan
        konten yang relevan, (c) menanggapi pertanyaan atau keluhan Anda, dan (d) menjaga keamanan dan integritas
        platform.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">3. Penyimpanan &amp; Keamanan</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Data Anda disimpan secara aman di server kami dan dilindungi dengan enkripsi saat transmisi. Kami menerapkan
        langkah-langkah keamanan yang wajar untuk mencegah akses, penggunaan, atau pengungkapan data secara tidak sah.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">4. Berbagi Data dengan Pihak Ketiga</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Kami tidak menjual data pribadi Anda. Data hanya dibagikan kepada penyedia layanan yang mendukung operasional
        aplikasi (misalnya penyimpanan cloud dan otentikasi), yang terikat kewajiban kerahasiaan.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">5. Hak Anda</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Anda berhak mengakses, memperbaiki, atau menghapus data pribadi Anda. Anda juga dapat menutup akun kapan saja
        melalui pengaturan aplikasi. Untuk permintaan terkait privasi, hubungi kami melalui email kontak yang tertera di
        aplikasi.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">6. Perubahan Kebijakan</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Kami dapat memperbarui kebijakan privasi ini sewaktu-waktu. Perubahan akan diumumkan pada halaman ini dengan
        tanggal pembaruan yang tercantum di bagian atas.
      </p>
    </section>
  </div>
</div>
