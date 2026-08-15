<script lang="ts">
  import TopBar from '$lib/components/TopBar.svelte';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');
</script>

<div class="min-h-full flex flex-col transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <TopBar title="Ubah Password" backHref="/settings/account-security" />
  <div class="px-6 py-4 space-y-4 flex-1">
    <input
      type="password"
      placeholder="Password saat ini"
      class="w-full border rounded-xl p-3 text-xs {isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-white border-slate-200 text-slate-900'}"
    />
    <input
      type="password"
      placeholder="Password baru"
      class="w-full border rounded-xl p-3 text-xs {isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-white border-slate-200 text-slate-900'}"
    />
  </div>
  <div class="p-6">
    <a href="/settings/account-security" class="w-full bg-blue-600 text-white font-bold py-3.5 rounded-2xl text-xs block text-center">
      Simpan
    </a>
  </div>
</div>
