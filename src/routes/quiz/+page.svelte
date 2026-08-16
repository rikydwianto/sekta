<script lang="ts">
  import { Brain, ChevronRight } from '@lucide/svelte';
  import { app } from '$lib/stores/app.svelte';
  import SkeletonLoader from '$lib/components/SkeletonLoader.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';

  let { data } = $props();

  let isDark = $derived(app.theme === 'dark');
  let quizzes = $derived(data.quizzes);
  let selectedCat = $state('');

  let categories = $derived([
    ...new Map(
      quizzes
        .filter((q) => q.categorySlug)
        .map((q) => [q.categorySlug!, q.category!])
    )
  ]);

  let filtered = $derived(selectedCat ? quizzes.filter((q) => q.categorySlug === selectedCat) : quizzes);
</script>

<div class="min-h-full pb-12 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-white'}">
  <PageHeader title="Kuis Interaktif" type="page" showNotifications={true} />

  <!-- Category Filter -->
  {#if categories.length > 1}
    <div class="px-6 pt-5">
      <div class="flex gap-2 overflow-x-auto hide-scrollbar pb-1">
        <button
          onclick={() => (selectedCat = '')}
          class="px-3.5 py-2 rounded text-xs font-bold whitespace-nowrap transition-colors {selectedCat === ''
            ? 'bg-purple-600 text-white'
            : isDark
              ? 'bg-slate-800 border border-slate-700 text-slate-300 hover:bg-slate-700'
              : 'bg-slate-100 border border-slate-300 text-slate-700 hover:bg-slate-200'}"
        >
          Semua
        </button>
        {#each categories as [slug, name]}
          <button
            onclick={() => (selectedCat = slug)}
            class="px-3.5 py-2 rounded text-xs font-bold whitespace-nowrap transition-colors {selectedCat === slug
              ? 'bg-purple-600 text-white'
              : isDark
                ? 'bg-slate-800 border border-slate-700 text-slate-300 hover:bg-slate-700'
                : 'bg-slate-100 border border-slate-300 text-slate-700 hover:bg-slate-200'}"
          >
            {name}
          </button>
        {/each}
      </div>
    </div>
  {/if}

  <!-- Quiz Grid -->
  <div class="px-6 pt-6 space-y-3">
    {#each filtered as quiz, i}
      <a
        href={`/quiz/question?id=${quiz.id}`}
        class="block border rounded p-4 transition-all card-hover {isDark ? 'bg-slate-900 border-slate-800 hover:bg-slate-800' : 'bg-white border-slate-200 hover:bg-slate-50'}"
      >
        <!-- Cover + Badge -->
        <div class="flex items-center gap-3 mb-3">
          {#if quiz.coverImage}
            <CoverImage image={quiz.coverImage} class="w-16 h-16 rounded-xl flex-shrink-0" />
          {:else}
            <div class="w-16 h-16 rounded-xl bg-purple-600 flex items-center justify-center flex-shrink-0">
              <Brain class="w-6 h-6 text-white" />
            </div>
          {/if}
          <span class="text-xs font-black text-purple-600 uppercase">Kuis {i + 1}</span>
        </div>

        <!-- Title -->
        <h2 class="text-lg font-black mb-2 {isDark ? 'text-slate-100' : 'text-slate-800'}">{quiz.title}</h2>

        <!-- Description -->
        <p class="text-sm mb-4 line-clamp-2 {isDark ? 'text-slate-400' : 'text-slate-600'}">{quiz.description}</p>

        <!-- Footer with CTA -->
        <div class="flex items-center justify-between pt-3 border-t {isDark ? 'border-slate-700' : 'border-slate-100'}">
          <span class="text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-500'}">Mulai sekarang</span>
          <ChevronRight class="w-4 h-4 {isDark ? 'text-slate-600' : 'text-slate-300'}" />
        </div>
      </a>
    {/each}
    
    <!-- Loading Skeletons -->
    {#if quizzes.length === 0}
      {#each Array(4) as _}
        <SkeletonLoader type="card" />
      {/each}
    {/if}
  </div>

  <!-- Empty State -->
  {#if quizzes.length > 0 && filtered.length === 0}
    <div class="flex flex-col items-center justify-center py-16 px-6">
      <p class="text-sm font-bold mb-2 text-center {isDark ? 'text-slate-300' : 'text-slate-600'}">Tidak ada kuis di kategori ini.</p>
      <button onclick={() => (selectedCat = '')} class="px-5 py-2.5 bg-purple-600 text-white text-xs font-bold rounded-xl">
        Lihat Semua
      </button>
    </div>
  {/if}

  {#if quizzes.length === 0}
    <div class="flex flex-col items-center justify-center py-16 px-6">
      <div class="w-20 h-20 rounded-2xl mb-4 flex items-center justify-center {isDark ? 'bg-slate-900' : 'bg-slate-100'}">
        <Brain class="w-10 h-10 {isDark ? 'text-slate-600' : 'text-slate-400'}" />
      </div>
      <p class="text-lg font-bold mb-2 text-center">Belum ada kuis tersedia</p>
      <p class="text-sm text-center {isDark ? 'text-slate-400' : 'text-slate-500'} mb-6">Kuis akan segera hadir. Nantikan update terbaru kami!</p>
    </div>
  {/if}
</div>
