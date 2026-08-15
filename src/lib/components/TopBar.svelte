<script lang="ts">
  import { ChevronLeft } from '@lucide/svelte';
  import type { Snippet } from 'svelte';
  import { app } from '$lib/stores/app.svelte';

  let { title, backHref = '/', right }: { title: string; backHref?: string; right?: Snippet } = $props();

  let isDark = $derived(app.theme === 'dark');
</script>

<div
  class="flex items-center justify-between px-6 py-4 sticky top-0 z-40 border-b transition-colors {isDark
    ? 'bg-slate-950 border-slate-800'
    : 'bg-white border-slate-200'}"
>
  <a
    href={backHref}
    class="p-2 -ml-2 rounded-xl transition-colors {isDark ? 'hover:bg-slate-800 text-slate-100' : 'hover:bg-slate-100 text-slate-900'}"
  >
    <ChevronLeft class="w-6 h-6 stroke-[2.5]" />
  </a>
  <h1 class="text-lg font-bold">{title}</h1>
  <div class="w-10 flex justify-end">
    {#if right}
      {@render right()}
    {/if}
  </div>
</div>
