<script lang="ts">
  import PageHeader from '$lib/components/PageHeader.svelte';
  import type { Article } from '$lib/types';
  import { getSavedArticles } from '$lib/api';
  import { app } from '$lib/stores/app.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';

  let isDark = $derived(app.theme === 'dark');

  let saved = $state<Article[]>(app.savedArticles);

  $effect(() => {
    getSavedArticles().then((s) => {
      if (s.length > 0) saved = s;
    });
  });
</script>

<div class="min-h-full pb-12 transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <PageHeader title="Artikel Tersimpan" type="page" backHref="/profile" />
  <div class="px-6 py-4 space-y-3">
    {#if saved.length > 0}
      {#each saved as art}
        <a
          href={`/article/${art.slug}`}
          class="border p-4 rounded-2xl flex items-center space-x-3 cursor-pointer block {isDark ? 'bg-[#141720] border-slate-800' : 'bg-white border-slate-200'}"
        >
          <CoverImage image={art.image} class="w-14 h-14 rounded-xl flex-shrink-0" />
          <div>
            <span class="text-[9px] font-black text-blue-500 uppercase">{art.category}</span>
            <h4 class="text-xs font-bold leading-tight {isDark ? 'text-slate-100' : 'text-slate-800'}">{art.title}</h4>
          </div>
        </a>
      {/each}
    {:else}
      <div class="text-center py-12">
        <p class="text-xs mb-5 {isDark ? 'text-slate-500' : 'text-slate-400'}">Belum ada artikel tersimpan.</p>
        <a href="/explore" class="inline-block bg-blue-600 hover:bg-blue-500 text-white font-bold py-3 px-5 rounded-xl text-xs shadow-lg transition-all">
          Jelajahi Artikel
        </a>
      </div>
    {/if}
  </div>
</div>
