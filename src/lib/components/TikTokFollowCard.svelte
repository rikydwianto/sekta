<script lang="ts">
  import { app } from '$lib/stores/app.svelte';

  let { handle }: { handle: string } = $props();
  let isDark = $derived(app.theme === 'dark');
</script>

<a
  href={`https://www.tiktok.com/@${handle}`}
  target="_blank"
  rel="noopener noreferrer"
  class="flex items-center gap-3 p-4 rounded-2xl border transition-all active:scale-[0.99] {isDark ? 'bg-[#141720] border-slate-800 hover:bg-slate-800' : 'bg-white border-slate-200 hover:bg-slate-50'}"
>
  <span class="w-10 h-10 rounded-xl bg-black text-white flex items-center justify-center text-lg font-black flex-shrink-0">♬</span>
  <span class="flex-1 min-w-0">
    <span class="block text-sm font-black">Ikuti Sekta di TikTok</span>
    <span class="text-xs {isDark ? 'text-slate-400' : 'text-slate-500'}">@{handle} — fakta singkat setiap hari</span>
  </span>
  <span class="text-lg font-black text-blue-500 flex-shrink-0">↗</span>
</a>
