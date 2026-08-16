<script lang="ts">
  import { Check, X, RefreshCw } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import type { Article } from '$lib/types';
  import { app } from '$lib/stores/app.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import { getModeratableArticles, adminSetArticleStatus } from '$lib/api';

  let isDark = $derived(app.theme === 'dark');

  $effect(() => {
    if (app.authInitialized && app.user.role !== 'ADMIN') goto('/profile');
  });

  let articles = $state<Article[]>([]);
  let loading = $state(true);

  $effect(() => {
    if (!app.authInitialized || app.user.role !== 'ADMIN') return;
    loading = true;
    getModeratableArticles().then((list) => {
      articles = list;
      loading = false;
    });
  });

  const STATUS_LABEL: Record<string, string> = {
    SUBMITTED: 'Menunggu',
    IN_REVIEW: 'Diulas',
    REJECTED: 'Ditolak',
    DRAFT: 'Draf'
  };
  const STATUS_STYLE: Record<string, string> = {
    SUBMITTED: 'bg-amber-500/15 text-amber-500',
    IN_REVIEW: 'bg-purple-500/15 text-purple-500',
    REJECTED: 'bg-red-500/15 text-red-500',
    DRAFT: 'bg-slate-500/15 text-slate-500'
  };

  async function setStatus(article: Article, status: 'PUBLISHED' | 'REJECTED') {
    const ok = await adminSetArticleStatus(article.id, status);
    if (ok) articles = articles.filter((a) => a.id !== article.id);
  }
</script>

<div class="min-h-full pb-20 transition-colors duration-300 {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-white'}">
  <PageHeader title="Kelola Artikel" type="page" backHref="/profile" />

  <div class="px-6 py-5 space-y-3">
    <p class="text-xs font-black uppercase tracking-widest {isDark ? 'text-slate-500' : 'text-slate-500'}">
      Antrean Artikel ({articles.length})
    </p>

    {#if loading}
      <div class="space-y-3">
        {#each Array(3) as _}
          <div class="h-32 rounded-2xl {isDark ? 'bg-slate-900' : 'bg-slate-100'} animate-pulse"></div>
        {/each}
      </div>
    {:else if articles.length === 0}
      <div class="flex flex-col items-center justify-center py-14 text-center">
        <div class="w-14 h-14 rounded-2xl mb-3 flex items-center justify-center {isDark ? 'bg-slate-900' : 'bg-slate-100'}">
          <RefreshCw class="w-6 h-6 {isDark ? 'text-slate-600' : 'text-slate-400'}" />
        </div>
        <p class="text-sm font-bold mb-1 {isDark ? 'text-slate-400' : 'text-slate-600'}">Tidak ada artikel menunggu</p>
        <p class="text-xs {isDark ? 'text-slate-600' : 'text-slate-400'}">Artikel kiriman user akan muncul di sini.</p>
      </div>
    {:else}
      {#each articles as article}
        <div class="rounded-2xl border overflow-hidden {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          {#if article.image}
            <img src={article.image} alt="" class="w-full h-28 object-cover" />
          {/if}
          <div class="p-4">
            <div class="flex items-center gap-2 mb-2">
              <span class="text-[10px] font-black text-blue-500 uppercase tracking-wide">{article.category}</span>
              <span class="px-2 py-0.5 rounded-full text-[10px] font-black uppercase {STATUS_STYLE[article.status ?? ''] ?? STATUS_STYLE.DRAFT}">
                {STATUS_LABEL[article.status ?? ''] ?? article.status}
              </span>
            </div>
            <h3 class="text-sm font-black leading-snug mb-1">{article.title}</h3>
            <p class="text-xs line-clamp-2 mb-2 {isDark ? 'text-slate-400' : 'text-slate-600'}">{article.excerpt}</p>
            <p class="text-[10px] font-semibold mb-3 {isDark ? 'text-slate-500' : 'text-slate-400'}">
              oleh {article.author}{article.date ? ` • ${article.date}` : ''}
            </p>
            <div class="flex gap-2">
              <button
                onclick={() => setStatus(article, 'PUBLISHED')}
                class="flex-1 flex items-center justify-center gap-1.5 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-500 text-white text-xs font-black transition-all active:scale-95"
              >
                <Check class="w-4 h-4" /> Terbitkan
              </button>
              <button
                onclick={() => setStatus(article, 'REJECTED')}
                class="flex-1 flex items-center justify-center gap-1.5 py-2.5 rounded-xl border text-xs font-black transition-all active:scale-95 {isDark ? 'border-red-900 text-red-400 hover:bg-red-950/30' : 'border-red-200 text-red-500 hover:bg-red-50'}"
              >
                <X class="w-4 h-4" /> Tolak
              </button>
            </div>
          </div>
        </div>
      {/each}
    {/if}
  </div>
</div>
