<script lang="ts">
  import TopBar from '$lib/components/TopBar.svelte';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');
</script>

<div class="min-h-full pb-12 transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <TopBar title="Account & Security" backHref="/settings" />
  <div class="px-6 py-4 space-y-6">
    <div class="border p-4 rounded-2xl {isDark ? 'bg-[#141720] border-slate-800' : 'bg-white border-slate-200'}">
      <div class="flex justify-between items-center mb-1">
        <span class="text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-600'}">Email Address</span>
        <span class="bg-emerald-950 text-emerald-400 text-[9px] font-black px-2 py-0.5 rounded">Verified</span>
      </div>
      <p class="text-sm font-bold mb-3">user@example.com</p>
      <button class="text-xs font-bold text-blue-600">Ubah Email</button>
    </div>
    <div class="border p-4 rounded-2xl {isDark ? 'bg-[#141720] border-slate-800' : 'bg-white border-slate-200'}">
      <span class="text-xs font-bold block mb-1 {isDark ? 'text-slate-400' : 'text-slate-600'}">Password</span>
      <p class="text-lg font-black tracking-widest mb-3">• • • • • • • •</p>
      <a href="/settings/change-password" class="text-xs font-bold text-blue-600">Ubah Password</a>
    </div>
  </div>
</div>
