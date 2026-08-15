<script lang="ts">
  import { Search, Clock, ChevronRight, SlidersHorizontal, X, TrendingUp, Star } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { page } from '$app/stores';
  import type { Article } from '$lib/types';
  import { getArticles, getCategories, searchArticles } from '$lib/api';
  import { app } from '$lib/stores/app.svelte';
  import SkeletonLoader from '$lib/components/SkeletonLoader.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';

  let isDark = $derived(app.theme === 'dark');

  // ─── Search state ──────────────────────────────────────────────
  let urlQuery = $derived($page.url.searchParams.get('q') ?? '');
  let query = $state('');
  let isLoading = $state(false);
  let searchResults = $state<Article[]>([]);
  let allArticles = $state<Article[]>([]);
  let categories = $state<{ id: number; name: string; slug: string; description: string }[]>([]);

  // ─── Filter & sort state ────────────────────────────────────────
  let selectedCategory = $state<string>('');
  let selectedReadTime = $state<string>('');
  let selectedSort = $state<'newest' | 'trending' | 'most-read'>('newest');
  let showFilters = $state(false);

  // ─── Debounce timer ─────────────────────────────────────────────
  let debounceTimer: ReturnType<typeof setTimeout> | null = null;

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

  const TRENDING_TOPICS = ['Black Hole', 'Gurita', 'Luar Angkasa', 'Sejarah', 'AI', 'Sains', 'Teknologi'];

  // ─── Load articles and categories on mount ──────────────────────
  $effect(() => {
    getArticles().then(a => { allArticles = a; }).catch(() => {});
    getCategories().then(c => { categories = c; }).catch(() => {});
  });

  // ─── Sync URL query ─────────────────────────────────────────────
  $effect(() => {
    if (urlQuery && urlQuery !== query) {
      query = urlQuery;
    }
  });

  // ─── Real-time search with debounce ─────────────────────────────
  $effect(() => {
    const q = query;
    if (debounceTimer) clearTimeout(debounceTimer);

    if (q.trim() === '') {
      searchResults = [];
      isLoading = false;
      return;
    }

    isLoading = true;
    debounceTimer = setTimeout(async () => {
      try {
        const results = await searchArticles(q.trim());
        searchResults = results;
      } catch {
        searchResults = [];
      } finally {
        isLoading = false;
      }
    }, 300);
  });

  // ─── Computed: filtered + sorted results ────────────────────────
  let displayResults = $derived.by(() => {
    let base = query.trim() === '' ? allArticles : searchResults;

    // Filter by category
    if (selectedCategory) {
      base = base.filter(
        (a) => a.category.toLowerCase() === selectedCategory.toLowerCase()
      );
    }

    // Filter by read time
    if (selectedReadTime) {
      base = base.filter((a) => {
        const mins = parseInt(a.readTime);
        if (selectedReadTime === 'short') return mins < 3;
        if (selectedReadTime === 'medium') return mins >= 3 && mins <= 5;
        if (selectedReadTime === 'long') return mins > 5;
        return true;
      });
    }

    // Sort
    if (selectedSort === 'newest') {
      // already ordered by published_at desc from API
      return base;
    } else if (selectedSort === 'trending') {
      // sort featured first, then rest
      return [...base].sort((a, b) => Number(b.featured) - Number(a.featured));
    } else if (selectedSort === 'most-read') {
      // sort by read time (more time = more content = more read)
      return [...base].sort((a, b) => parseInt(b.readTime) - parseInt(a.readTime));
    }
    return base;
  });

  let hasActiveFilters = $derived(selectedCategory !== '' || selectedReadTime !== '' || selectedSort !== 'newest');
  let activeFilterCount = $derived(
    (selectedCategory ? 1 : 0) + (selectedReadTime ? 1 : 0) + (selectedSort !== 'newest' ? 1 : 0)
  );

  function clearFilters() {
    selectedCategory = '';
    selectedReadTime = '';
    selectedSort = 'newest';
  }

  function handleQueryInput(e: Event) {
    const val = (e.target as HTMLInputElement).value;
    query = val;
  }

  function clearQuery() {
    query = '';
    searchResults = [];
  }

  function selectTrending(tag: string) {
    query = tag;
  }

  function handleKeydown(e: KeyboardEvent) {
    if (e.key === 'Enter') {
      const q = query.trim();
      if (q) goto(`/search?q=${encodeURIComponent(q)}`, { replaceState: true });
    }
  }
</script>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-white'}">

  <!-- Page Header -->
  <PageHeader title="Cari Artikel" type="page" />

  <!-- Search Input Bar -->
  <div class="px-6 pt-4 pb-3 border-b {isDark ? 'border-slate-800' : 'border-slate-200'}">
    <div class="relative flex items-center">
      <Search class="absolute left-3 w-4 h-4 {isDark ? 'text-slate-500' : 'text-slate-400'} pointer-events-none" />
      <input
        type="search"
        value={query}
        oninput={handleQueryInput}
        onkeydown={handleKeydown}
        placeholder="Cari fakta menarik..."
        class="w-full pl-10 pr-10 py-3 rounded border text-sm font-medium focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors
          {isDark
            ? 'bg-slate-900 border-slate-700 text-slate-100 placeholder:text-slate-500 focus:border-blue-500'
            : 'bg-slate-50 border-slate-200 text-slate-900 placeholder:text-slate-400 focus:border-blue-500 focus:bg-white'}"
      />
      {#if query}
        <button
          onclick={clearQuery}
          aria-label="Hapus pencarian"
          class="absolute right-3 p-0.5 rounded transition-colors {isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-400 hover:text-slate-600'}"
        >
          <X class="w-4 h-4" />
        </button>
      {/if}
    </div>
  </div>

  <!-- Filter & Sort Bar -->
  <div class="px-6 py-3 flex items-center gap-2 border-b {isDark ? 'border-slate-800' : 'border-slate-200'}">
    <!-- Filter toggle button -->
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

    <!-- Sort chips -->
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

  <!-- Expanded filter panel -->
  {#if showFilters}
    <div class="px-6 py-4 border-b {isDark ? 'bg-slate-900 border-slate-800' : 'bg-slate-50 border-slate-200'}">
      <!-- Category filter -->
      <div class="mb-4">
        <p class="text-xs font-black uppercase tracking-wider mb-2 {isDark ? 'text-slate-500' : 'text-slate-400'}">Kategori</p>
        <div class="flex flex-wrap gap-2">
          <button
            onclick={() => selectedCategory = ''}
            class="px-3 py-1.5 rounded border text-xs font-bold transition-colors
              {selectedCategory === ''
                ? 'bg-blue-600 border-blue-600 text-white'
                : isDark
                  ? 'bg-slate-800 border-slate-700 text-slate-300 hover:bg-slate-700'
                  : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-100'}"
          >
            Semua
          </button>
          {#each categories as cat}
            <button
              onclick={() => selectedCategory = selectedCategory === cat.name ? '' : cat.name}
              class="px-3 py-1.5 rounded border text-xs font-bold transition-colors
                {selectedCategory === cat.name
                  ? 'bg-blue-600 border-blue-600 text-white'
                  : isDark
                    ? 'bg-slate-800 border-slate-700 text-slate-300 hover:bg-slate-700'
                    : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-100'}"
            >
              {cat.name}
            </button>
          {/each}
        </div>
      </div>

      <!-- Read time filter -->
      <div>
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

      <!-- Clear filters -->
      {#if hasActiveFilters}
        <button
          onclick={clearFilters}
          class="mt-3 text-xs font-bold text-red-500 hover:text-red-400 flex items-center gap-1 transition-colors"
        >
          <X class="w-3.5 h-3.5" />
          Hapus semua filter
        </button>
      {/if}
    </div>
  {/if}

  <!-- Main Content Area -->
  <div class="px-6 pt-4">

    <!-- Empty query: show trending topics -->
    {#if query.trim() === '' && !hasActiveFilters}
      <div class="mb-6">
        <h3 class="text-xs font-black uppercase tracking-wider mb-3 {isDark ? 'text-slate-500' : 'text-slate-400'}">🔥 Trending Topik</h3>
        <div class="flex flex-wrap gap-2 mb-8">
          {#each TRENDING_TOPICS as tag}
            <button
              onclick={() => selectTrending(tag)}
              class="px-4 py-2 rounded border text-sm font-bold transition-colors
                {isDark
                  ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800 hover:border-slate-600'
                  : 'bg-slate-50 border-slate-200 text-slate-700 hover:bg-slate-100'}"
            >
              {tag}
            </button>
          {/each}
        </div>

        <!-- All articles heading when no query -->
        <h3 class="text-xs font-black uppercase tracking-wider mb-4 {isDark ? 'text-slate-500' : 'text-slate-400'}">📖 Semua Artikel</h3>
      </div>

      <!-- Show all articles when no search query -->
      {#if allArticles.length > 0}
        <div class="space-y-3 pb-6">
          {#each displayResults as article}
            <a
              href={`/article/${article.slug}`}
              class="p-4 rounded border block transition-colors card-hover
                {isDark
                  ? 'bg-slate-900 border-slate-800 hover:bg-slate-800'
                  : 'bg-white border-slate-200 hover:bg-slate-50'}"
            >
              <div class="flex items-start justify-between gap-3">
                <div class="flex-1 min-w-0">
                  <span class="text-[11px] font-black text-blue-600 uppercase tracking-wide">{article.category}</span>
                  <h4 class="text-sm font-bold mt-1 mb-2 line-clamp-2 {isDark ? 'text-slate-100' : 'text-slate-800'}">
                    {article.title}
                  </h4>
                  <p class="text-xs line-clamp-2 mb-2 {isDark ? 'text-slate-400' : 'text-slate-500'}">
                    {article.excerpt}
                  </p>
                  <span class="flex items-center gap-1 text-xs {isDark ? 'text-slate-500' : 'text-slate-400'}">
                    <Clock class="w-3 h-3" />
                    {article.readTime}
                  </span>
                </div>
                <CoverImage image={article.image} class="w-20 h-20 rounded-xl flex-shrink-0" />
                <ChevronRight class="w-5 h-5 flex-shrink-0 mt-1 {isDark ? 'text-slate-600' : 'text-slate-300'}" />
              </div>
            </a>
          {/each}
        </div>
      {:else}
        <!-- Loading skeleton for all articles -->
        <div class="space-y-3 pb-6">
          {#each Array(5) as _}
            <SkeletonLoader type="card" />
          {/each}
        </div>
      {/if}

    <!-- Has query or filters: show results -->
    {:else}

      <!-- Result count / status line -->
      <div class="flex items-center justify-between mb-4">
        {#if isLoading}
          <p class="text-xs {isDark ? 'text-slate-500' : 'text-slate-400'}">Mencari...</p>
        {:else if query.trim() !== ''}
          <p class="text-xs font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">
            {displayResults.length} hasil untuk
            <span class="font-black {isDark ? 'text-slate-200' : 'text-slate-800'}">"{query}"</span>
          </p>
        {:else}
          <p class="text-xs font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">
            {displayResults.length} artikel
          </p>
        {/if}

        {#if hasActiveFilters}
          <button
            onclick={clearFilters}
            class="text-xs font-bold text-blue-500 hover:text-blue-400 transition-colors"
          >
            Reset filter
          </button>
        {/if}
      </div>

      <!-- Loading skeletons -->
      {#if isLoading}
        <div class="space-y-3 pb-6">
          {#each Array(4) as _}
            <div class="p-4 rounded border {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
              <div class="{isDark ? 'bg-slate-800' : 'bg-slate-200'} rounded animate-pulse h-3 w-16 mb-2"></div>
              <div class="{isDark ? 'bg-slate-800' : 'bg-slate-200'} rounded animate-pulse h-4 w-3/4 mb-2"></div>
              <div class="{isDark ? 'bg-slate-800' : 'bg-slate-200'} rounded animate-pulse h-3 w-full mb-1"></div>
              <div class="{isDark ? 'bg-slate-800' : 'bg-slate-200'} rounded animate-pulse h-3 w-2/3"></div>
            </div>
          {/each}
        </div>

      <!-- Search results -->
      {:else if displayResults.length > 0}
        <div class="space-y-3 pb-6">
          {#each displayResults as article}
            <a
              href={`/article/${article.slug}`}
              class="p-4 rounded border block transition-colors card-hover
                {isDark
                  ? 'bg-slate-900 border-slate-800 hover:bg-slate-800'
                  : 'bg-white border-slate-200 hover:bg-slate-50'}"
            >
              <div class="flex items-start justify-between gap-3">
                <div class="flex-1 min-w-0">
                  <span class="text-[11px] font-black text-blue-600 uppercase tracking-wide">{article.category}</span>
                  <h4 class="text-sm font-bold mt-1 mb-2 line-clamp-2 {isDark ? 'text-slate-100' : 'text-slate-800'}">
                    {article.title}
                  </h4>
                  <p class="text-xs line-clamp-2 mb-2 {isDark ? 'text-slate-400' : 'text-slate-500'}">
                    {article.excerpt}
                  </p>
                  <span class="flex items-center gap-1 text-xs {isDark ? 'text-slate-500' : 'text-slate-400'}">
                    <Clock class="w-3 h-3" />
                    {article.readTime}
                  </span>
                </div>
                <CoverImage image={article.image} class="w-20 h-20 rounded-xl flex-shrink-0" />
                <ChevronRight class="w-5 h-5 flex-shrink-0 mt-1 {isDark ? 'text-slate-600' : 'text-slate-300'}" />
              </div>
            </a>
          {/each}
        </div>

      <!-- Empty state -->
      {:else}
        <div class="flex flex-col items-center justify-center py-20 text-center">
          <div class="w-16 h-16 rounded-full flex items-center justify-center mb-4
            {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
            <Search class="w-8 h-8 {isDark ? 'text-slate-600' : 'text-slate-300'}" />
          </div>
          <h3 class="text-base font-black mb-2 {isDark ? 'text-slate-300' : 'text-slate-700'}">
            {#if hasActiveFilters && query.trim() === ''}
              Tidak ada artikel yang cocok
            {:else}
              Tidak ditemukan
            {/if}
          </h3>
          <p class="text-sm mb-6 max-w-xs {isDark ? 'text-slate-500' : 'text-slate-400'}">
            {#if hasActiveFilters && query.trim() === ''}
              Coba ubah atau hapus filter yang aktif.
            {:else}
              Tidak ada artikel yang cocok dengan <span class="font-bold">"{query}"</span>.
              Coba kata kunci lain.
            {/if}
          </p>
          <div class="flex gap-2 flex-wrap justify-center">
            {#if hasActiveFilters}
              <button
                onclick={clearFilters}
                class="px-4 py-2 rounded border text-sm font-bold transition-colors
                  {isDark
                    ? 'bg-slate-800 border-slate-700 text-slate-300 hover:bg-slate-700'
                    : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-100'}"
              >
                Hapus Filter
              </button>
            {/if}
            <button
              onclick={clearQuery}
              class="px-4 py-2 rounded text-sm font-bold bg-blue-600 text-white hover:bg-blue-700 transition-colors"
            >
              Lihat Semua
            </button>
          </div>

          <!-- Trending suggestions -->
          <div class="mt-8 w-full">
            <p class="text-xs font-black uppercase tracking-wider mb-3 {isDark ? 'text-slate-600' : 'text-slate-400'}">
              Coba topik ini
            </p>
            <div class="flex flex-wrap gap-2 justify-center">
              {#each TRENDING_TOPICS.slice(0, 5) as tag}
                <button
                  onclick={() => selectTrending(tag)}
                  class="px-3 py-1.5 rounded border text-xs font-bold transition-colors
                    {isDark
                      ? 'bg-slate-900 border-slate-700 text-slate-400 hover:bg-slate-800'
                      : 'bg-slate-50 border-slate-200 text-slate-600 hover:bg-slate-100'}"
                >
                  {tag}
                </button>
              {/each}
            </div>
          </div>
        </div>
      {/if}
    {/if}

  </div>
</div>
