<script lang="ts">
  import { page } from '$app/state';
  import { app } from '$lib/stores/app.svelte';
  import { ChevronLeft, RefreshCw } from '@lucide/svelte';
  import { goBack } from '$lib/stores/navigation.svelte';

  let isDark = $derived(app.theme === 'dark');
  let isNotFound = $derived(page.status === 404);
</script>

<div class="min-h-full px-6 py-24 flex flex-col items-center justify-center text-center transition-colors duration-300 {isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}">
  <p class="text-6xl font-black mb-4 text-blue-500">{page.status}</p>
  <h1 class="text-xl font-black mb-2">{isNotFound ? 'Halaman tidak ditemukan' : 'Terjadi kesalahan'}</h1>
  <p class="text-sm mb-8 {isDark ? 'text-slate-400' : 'text-slate-500'}">
    {isNotFound
      ? 'Halaman yang kamu cari mungkin sudah dipindahkan atau tidak tersedia.'
      : 'Ada masalah saat memuat halaman. Coba muat ulang.'}
  </p>
  <div class="flex gap-3">
    <button
      onclick={() => window.location.reload()}
      class="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-blue-600 hover:bg-blue-500 text-white text-sm font-bold transition-all active:scale-95"
    >
      <RefreshCw class="w-4 h-4" />
      Coba Lagi
    </button>
    <button
      onclick={goBack}
      class="flex items-center gap-2 px-5 py-2.5 rounded-xl border text-sm font-bold transition-colors {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-800' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}"
    >
      <ChevronLeft class="w-4 h-4" />
      Kembali
    </button>
  </div>
</div>
