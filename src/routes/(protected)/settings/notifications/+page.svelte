<script lang="ts">
  import TopBar from '$lib/components/TopBar.svelte';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');
</script>

<div class="min-h-full transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <TopBar title="Pengaturan Notifikasi" backHref="/settings" />
  <div class="px-6 py-4 space-y-4">
    <div class="flex justify-between items-center border p-4 rounded-2xl {isDark ? 'bg-[#141720] border-slate-800' : 'bg-white border-slate-200'}">
      <div>
        <h4 class="text-xs font-bold">Status Artikel</h4>
        <p class="text-[11px] {isDark ? 'text-slate-400' : 'text-slate-500'}">Pemberitahuan saat artikel baru diterbitkan.</p>
      </div>
      <div class="w-10 h-6 bg-blue-600 rounded-full relative cursor-pointer">
        <div class="absolute right-1 top-1 w-4 h-4 bg-white rounded-full"></div>
      </div>
    </div>
  </div>
</div>
