<script lang="ts">
  import { app } from '$lib/stores/app.svelte';
  import TikTokFollowCard from './TikTokFollowCard.svelte';

  let isDark = $derived(app.theme === 'dark');
</script>

<footer class="px-6 py-6 space-y-5">
  <TikTokFollowCard handle="sekejap.fakta" />
  <div class="text-center space-y-2">
    <div class="flex items-center justify-center gap-4 text-xs font-bold">
      <a href="/about" class="{isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-900'}">Tentang</a>
      <a href="/privacy" class="{isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-900'}">Privasi</a>
      <a href="/terms" class="{isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-900'}">Syarat</a>
      <a href="/monitoring" class="{isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-900'}">Monitoring</a>
    </div>
    <p class="text-[10px] font-semibold {isDark ? 'text-slate-600' : 'text-slate-400'}">
      © {new Date().getFullYear()} SEKTA — Sekejap Fakta. Dibuat dengan 💙 untuk rasa penasaran.
    </p>
  </div>
</footer>
