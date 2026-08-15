<script lang="ts">
  import TopBar from '$lib/components/TopBar.svelte';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');
</script>

<div class="min-h-full pb-12 transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <TopBar title="Syarat &amp; Ketentuan" backHref="/" />
  <div class="px-6 py-6 max-w-2xl mx-auto space-y-6">
    <p class="text-sm leading-relaxed font-medium {isDark ? 'text-slate-300' : 'text-slate-600'}">
      Terakhir diperbarui: 15 Agustus 2026
    </p>

    <section class="space-y-2">
      <h2 class="text-base font-black">1. Penerimaan Ketentuan</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Dengan menggunakan aplikasi Sekta, Anda menyatakan setuju untuk terikat oleh Syarat &amp; Ketentuan ini. Jika
        Anda tidak setuju, mohon tidak menggunakan layanan kami.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">2. Penggunaan Layanan</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Anda setuju untuk menggunakan Sekta hanya untuk tujuan yang sah dan sesuai dengan aturan komunitas. Anda tidak
        diperbolehkan menyalahgunakan layanan, mencoba mengakses data pengguna lain, atau menyebarkan konten yang
        menyesatkan atau melanggar hukum.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">3. Akun Pengguna</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Anda bertanggung jawab menjaga kerahasiaan kredensial akun Anda dan seluruh aktivitas yang terjadi di bawah
        akun tersebut. Anda wajib memberi informasi yang benar saat mendaftar.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">4. Konten Pengguna</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Konten yang Anda unggah (seperti komentar) menjadi tanggung jawab Anda. Anda memberi kami lisensi terbatas
        untuk menampilkan konten tersebut di platform. Kami berhak menghapus konten yang melanggar aturan.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">5. Kekayaan Intelektual</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Seluruh konten, logo, dan desain aplikasi adalah milik Sekta. Anda tidak diperbolehkan menyalin, mendistribusikan,
        atau menggunakan kembali konten kami tanpa izin tertulis.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">6. Batasan Tanggung Jawab</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Layanan kami disediakan "sebagaimana adanya". Kami tidak bertanggung jawab atas kerugian yang timbul dari
        penggunaan atau ketidaktersediaan layanan, sejauh diperbolehkan oleh hukum yang berlaku.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">7. Penghentian Layanan</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Kami dapat menghentikan atau menangguhkan akses Anda bila melanggar ketentuan ini. Anda juga dapat berhenti
        menggunakan layanan kapan saja dengan menutup akun Anda.
      </p>
    </section>

    <section class="space-y-2">
      <h2 class="text-base font-black">8. Perubahan Ketentuan</h2>
      <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
        Kami dapat memperbarui Syarat &amp; Ketentuan ini sewaktu-waktu. Perubahan akan diumumkan pada halaman ini.
      </p>
    </section>
  </div>
</div>
