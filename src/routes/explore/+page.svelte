<script lang="ts">
  import { ChevronRight, ChevronDown, Atom, Landmark, Cpu, Globe, PawPrint, UserRound, Sparkles, Compass, Coffee, SlidersHorizontal, Clock, TrendingUp, Star } from '@lucide/svelte';
  import { app } from '$lib/stores/app.svelte';
  import SkeletonLoader from '$lib/components/SkeletonLoader.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';
  import { goto } from '$app/navigation';
  import { getArticlesPage } from '$lib/api';
  import { untrack } from 'svelte';

  const PAGE_SIZE = 10;

  let { data } = $props();

  const initialCats = untrack(() => data.categories);
  const initialArticles = untrack(() => data.articles);
  const initialTotal = untrack(() => data.total);

  let isDark = $derived(app.theme === 'dark');
  let categories = $derived(initialCats);
  let articles = $state(initialArticles);
  let total = $state(initialTotal ?? initialArticles.length);
  let active = $state('all');
  let loading = $state(false);

  let selectedReadTime = $state<string>('');
  let selectedSort = $state<'newest' | 'trending' | 'most-read'>('newest');
  let showFilters = $state(false);

  const READ_TIME_OPTIONS = [
    { label: 'Semua', value: '' },
    { label: '< 3 mnt', value: 'short' },
    { label: '3–5 mnt', value: 'medium' },
    { label: '> 5 mnt', value: 'long' }
  ];

  const SORT_OPTIONS: { label: string; value: 'newest' | 'trending' | 'most-read'; icon: typeof TrendingUp }[] = [
    { label: 'Terbaru', value: 'newest', icon: Clock },
    { label: 'Trending', value: 'trending', icon: TrendingUp },
    { label: 'Terpopuler', value: 'most-read', icon: Star }
  ];

  let displayArticles = $derived.by(() => {
    let base = articles;
    if (selectedReadTime) {
      base = base.filter((a) => {
        const mins = parseInt(a.readTime);
        if (selectedReadTime === 'short') return mins < 3;
        if (selectedReadTime === 'medium') return mins >= 3 && mins <= 5;
        if (selectedReadTime === 'long') return mins > 5;
        return true;
      });
    }
    if (selectedSort === 'trending') {
      return [...base].sort((a, b) => (b.viewCount + (b.reactionCount ?? 0)) - (a.viewCount + (a.reactionCount ?? 0)));
    } else if (selectedSort === 'most-read') {
      return [...base].sort((a, b) => b.viewCount - a.viewCount);
    }
    return base;
  });

  let hasActiveFilters = $derived(selectedReadTime !== '' || selectedSort !== 'newest');
  let activeFilterCount = $derived((selectedReadTime ? 1 : 0) + (selectedSort !== 'newest' ? 1 : 0));

  const CAT_ICONS: Record<string, { icon: typeof Compass; cls: string }> = {
    sains: { icon: Atom, cls: 'text-sky-500 bg-sky-500/10' },
    sejarah: { icon: Landmark, cls: 'text-amber-500 bg-amber-500/10' },
    teknologi: { icon: Cpu, cls: 'text-violet-500 bg-violet-500/10' },
    dunia: { icon: Globe, cls: 'text-emerald-500 bg-emerald-500/10' },
    hewan: { icon: PawPrint, cls: 'text-orange-500 bg-orange-500/10' },
    manusia: { icon: UserRound, cls: 'text-rose-500 bg-rose-500/10' },
    'fakta-unik': { icon: Sparkles, cls: 'text-fuchsia-500 bg-fuchsia-500/10' },
    kopi: { icon: Coffee, cls: 'text-amber-700 bg-amber-700/10' }
  };

  let hasMore = $derived(articles.length < total);

  async function loadPage(cat: string | null, reset: boolean) {
    loading = true;
    try {
      const res = await getArticlesPage(cat, reset ? 0 : articles.length, PAGE_SIZE);
      articles = reset ? res.articles : [...articles, ...res.articles];
      total = res.total ?? articles.length;
    } catch {
      /* biarkan daftar yang ada */
    }
    loading = false;
  }

  function selectCat(slug: string) {
    active = slug;
    loadPage(slug === 'all' ? null : slug, true);
  }

  function loadMore() {
    loadPage(active === 'all' ? null : active, false);
  }
</script>

<div class="min-h-full pb-12 transition-colors duration-300 page-enter {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <PageHeader title="Jelajahi Konten" type="page" showNotifications={true}></PageHeader>

  <div class="px-6 pt-4">
    <div class="flex gap-2 overflow-x-auto hide-scrollbar pb-2 mb-4">
      <button
        onclick={() => selectCat('all')}
        class="px-3.5 py-2 rounded text-sm font-bold whitespace-nowrap transition-colors flex items-center gap-1.5 {active === 'all'
          ? 'bg-blue-600 text-white'
          : isDark
            ? 'bg-slate-800 border border-slate-700 text-slate-300 hover:bg-slate-700'
            : 'bg-slate-100 border border-slate-300 text-slate-700 hover:bg-slate-200'}"
      >
        <Compass class="w-4 h-4" />
        Semua
      </button>
      {#if categories.length > 0}
        {#each categories as c}
          {@const ci = CAT_ICONS[c.slug] ?? CAT_ICONS['fakta-unik']}
          {@const Icon = ci.icon}
          <button
            onclick={() => selectCat(c.slug)}
            class="px-3.5 py-2 rounded text-sm font-bold whitespace-nowrap transition-colors flex items-center gap-1.5 {active === c.slug
              ? 'bg-blue-600 text-white'
              : isDark
                ? 'bg-slate-800 border border-slate-700 text-slate-300 hover:bg-slate-700'
                : 'bg-slate-100 border border-slate-300 text-slate-700 hover:bg-slate-200'}"
          >
            <span class={active === c.slug ? 'text-white' : ci.cls}>
              <Icon class="w-4 h-4" />
            </span>
            {c.name}
          </button>
        {/each}
      {:else}
        {#each Array(5) as _}
          <div class="{isDark ? 'bg-slate-800' : 'bg-slate-200'} rounded h-9 w-20 animate-pulse"></div>
        {/each}
      {/if}
    </div>

    <!-- Filter & Sort Bar -->
    <div class="flex items-center gap-2 mb-4">
      <button
        onclick={() => showFilters = !showFilters}
        class="flex items-center gap-1.5 px-3 py-1.5 rounded border text-xs font-bold transition-colors relative
          {showFilters || hasActiveFilters
            ? 'bg-blue-600 border-blue-600 text-white'
            : isDark
              ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800'
              : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-100'}"
      >
        <SlidersHorizontal class="w-3.5 h-3.5" />
        Filter
        {#if activeFilterCount > 0}
          <span class="ml-0.5 bg-white text-blue-600 rounded-full w-4 h-4 flex items-center justify-center text-[10px] font-black">
            {activeFilterCount}
          </span>
        {/if}
      </button>

      <div class="flex gap-2 overflow-x-auto hide-scrollbar flex-1">
        {#each SORT_OPTIONS as opt}
          <button
            onclick={() => selectedSort = opt.value}
            class="flex items-center gap-1 px-3 py-1.5 rounded border text-xs font-bold whitespace-nowrap transition-colors
              {selectedSort === opt.value
                ? 'bg-slate-900 border-slate-900 text-white ' + (isDark ? 'bg-slate-100 border-slate-100 text-slate-900' : '')
                : isDark
                  ? 'bg-slate-900 border-slate-700 text-slate-400 hover:bg-slate-800 hover:text-slate-200'
                  : 'bg-white border-slate-200 text-slate-500 hover:bg-slate-100 hover:text-slate-700'}"
          >
            <opt.icon class="w-3 h-3" />
            {opt.label}
          </button>
        {/each}
      </div>
    </div>

    <!-- Read time filter panel -->
    {#if showFilters}
      <div class="mb-4">
        <p class="text-xs font-black uppercase tracking-wider mb-2 {isDark ? 'text-slate-500' : 'text-slate-400'}">Waktu Baca</p>
        <div class="flex flex-wrap gap-2">
          {#each READ_TIME_OPTIONS as opt}
            <button
              onclick={() => selectedReadTime = opt.value}
              class="px-3 py-1.5 rounded border text-xs font-bold transition-colors
                {selectedReadTime === opt.value
                  ? 'bg-blue-600 border-blue-600 text-white'
                  : isDark
                    ? 'bg-slate-800 border-slate-700 text-slate-300 hover:bg-slate-700'
                    : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-100'}"
            >
              {opt.label}
            </button>
          {/each}
        </div>
      </div>
    {/if}

    {#if articles.length > 0 || loading}
      {#if articles.length > 0}
        <p class="text-xs font-semibold uppercase tracking-wider mb-3 {isDark ? 'text-slate-500' : 'text-slate-500'}">
          {displayArticles.length} artikel{total != null && total > displayArticles.length ? ` dari ${total}` : ''}
        </p>
        <div class="space-y-3">
          {#each displayArticles as art}
            <a
              href={`/article/${art.slug}`}
              class="p-3 rounded border flex items-center gap-3 cursor-pointer transition-colors card-hover {isDark ? 'bg-slate-900 border-slate-800 hover:bg-slate-800' : 'bg-slate-50 border-slate-200 hover:bg-white'}"
            >
              <CoverImage image={art.image} class="w-20 h-20 rounded flex-shrink-0" />
              <div class="flex-1 min-w-0">
                <span class="text-xs font-black text-blue-600 uppercase">{art.category}</span>
                <h4 class="text-sm font-bold line-clamp-2 mb-1 {isDark ? 'text-slate-100' : 'text-slate-800'}">{art.title}</h4>
                <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-500'} line-clamp-1">{art.excerpt || art.readTime}</p>
              </div>
              <ChevronRight class="w-5 h-5 {isDark ? 'text-slate-600' : 'text-slate-300'} flex-shrink-0 ml-2" />
            </a>
          {/each}
        </div>

        {#if hasMore}
          <div class="pt-4 pb-6">
            <button
              onclick={loadMore}
              disabled={loading}
              class="w-full border rounded py-3 font-bold text-sm flex items-center justify-center gap-2 transition-colors disabled:opacity-50 {isDark
                ? 'bg-slate-900 border-slate-800 text-slate-200 hover:bg-slate-800'
                : 'bg-slate-50 border-slate-300 text-slate-800 hover:bg-slate-100'}"
            >
              {#if loading}
                <span class="w-4 h-4 border-2 border-current border-t-transparent rounded-full animate-spin"></span>
                Memuat...
              {:else}
                <ChevronDown class="w-4 h-4" />
                Muat Lebih Banyak
              {/if}
            </button>
          </div>
        {:else if loading}
          <div class="py-6 flex justify-center">
            <span class="w-6 h-6 border-2 border-current border-t-transparent rounded-full animate-spin"></span>
          </div>
        {/if}
      {:else}
        <div class="text-center py-16">
          <p class="text-sm font-semibold {isDark ? 'text-slate-400' : 'text-slate-600'}">Belum ada artikel di kategori ini.</p>
          <button
            onclick={() => selectCat('all')}
            class="mt-4 px-5 py-2.5 rounded bg-blue-600 text-white text-sm font-bold hover:bg-blue-700 transition-colors"
          >
            Lihat Semua Artikel
          </button>
        </div>
      {/if}
    {:else}
      <div class="space-y-3 pb-6">
        {#each Array(6) as _}
          <SkeletonLoader type="card" />
        {/each}
      </div>
    {/if}
  </div>
</div>
