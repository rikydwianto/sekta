<script lang="ts">
  import { ChevronRight, Shuffle, Sparkles, X, Volume2, Share2 } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { app } from '$lib/stores/app.svelte';
  import { readingHistory } from '$lib/stores/reading.svelte';
  import { applyIdVoice } from '$lib/format';
  import SkeletonLoader from '$lib/components/SkeletonLoader.svelte';
  import AvatarInitials from '$lib/components/AvatarInitials.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';

  let { data } = $props();

  let isDark = $derived(app.theme === 'dark');
  let articles = $derived(data.articles);
  let categories = $derived(data.categories);
  let facts = $derived(data.facts);
  let quizzes = $derived(data.quizzes);

  let hero = $derived(data.featured ?? articles[0]);
  let heroImageError = $state(false);
  let rest = $derived(articles.filter((a) => a !== hero));
  let trending = $derived(data.trending);
  let trendingTop = $derived(trending.filter((a) => a.id !== hero?.id).slice(0, 2));
  let trendingIds = $derived(new Set(trending.map((a) => a.id)));
  let latest = $derived(rest.filter((a) => !trendingIds.has(a.id)));
  let factIdx = $state(0);
  let fact = $derived(facts[(new Date().getDate() + factIdx) % (facts.length || 1)] ?? null);
  let nextFact = () => {
    factIdx += 1;
  };
  let factModal = $state(false);
  let factClosing = $state(false);
  let flashMode = $state(false);
  let flashIdx = $state(0);
  let speaking = $state(false);
  function speakFact() {
    if (!fact || typeof speechSynthesis === 'undefined') return;
    speechSynthesis.cancel();
    if (speaking) {
      speaking = false;
      return;
    }
    const text = fact.fact;
    speaking = true;
    window.setTimeout(() => {
      const u = new SpeechSynthesisUtterance(text);
      applyIdVoice(u);
      u.onend = () => (speaking = false);
      speechSynthesis.speak(u);
    }, 50);
  }
  let openFactModal = () => {
    factModal = true;
    factClosing = false;
  };
  let openFlash = () => {
    flashIdx = factIdx;
    flashMode = true;
  };
  let flashFact = $derived(facts[flashIdx % (facts.length || 1)] ?? null);
  let touchX = $state(0);
  let flashNext = () => {
    flashIdx = (flashIdx + 1) % (facts.length || 1);
  };
  let flashPrev = () => {
    flashIdx = (flashIdx - 1 + (facts.length || 1)) % (facts.length || 1);
  };
  function flashSpeak() {
    if (!flashFact || typeof speechSynthesis === 'undefined') return;
    speechSynthesis.cancel();
    if (speaking) {
      speaking = false;
      return;
    }
    const text = flashFact.fact;
    speaking = true;
    window.setTimeout(() => {
      const u = new SpeechSynthesisUtterance(text);
      applyIdVoice(u);
      u.onend = () => (speaking = false);
      speechSynthesis.speak(u);
    }, 50);
  }
  function shareFact() {
    if (!fact) return;
    const text = `💡 Sekejap Fakta: ${fact.fact}\n\nCek fakta menarik lain di SEKTA — Sekejap Fakta!`;
    if (navigator.share) {
      navigator.share({ title: 'Sekejap Fakta', text }).catch(() => {});
    } else {
      navigator.clipboard.writeText(text).then(() => alert('Fakta disalin ke clipboard'));
    }
  }
  let closeFactModal = () => {
    if (factClosing) return;
    factClosing = true;
    setTimeout(() => {
      factModal = false;
      factClosing = false;
    }, 200);
  };
  let weeklyQuiz = $derived(quizzes[0]);
  let recentReads = $derived(readingHistory.slice(0, 3));

  const categoryEmoji: Record<string, string> = {
    sains: '🔬',
    sejarah: '🏛️',
    teknologi: '🤖',
    dunia: '🌍',
    hewan: '🐾',
    manusia: '🧠',
    'fakta-unik': '✨',
    kopi: '☕'
  };
</script>

<div class="min-h-full pb-12 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-white'}">
  <PageHeader title="SEKTA." type="dashboard" showNotifications={true}>
    <a href="/profile" class="hover:opacity-80">
      <AvatarInitials name={app.user.name} size="sm" />
    </a>
  </PageHeader>

  <!-- Hero Banner -->
  {#if hero}
    <div class="px-6 my-6 rise-in">
      <a
        href={`/article/${hero.slug}`}
        class="hero-pan block relative overflow-hidden border rounded bg-gradient-to-br from-blue-700 via-indigo-800 to-purple-900 text-white p-6 h-80 flex flex-col justify-between hover:scale-[1.01] transition-transform"
      >
        <div class="absolute inset-0 z-0">
          {#if hero.image && !heroImageError}
            <img src={hero.image} alt="" class="w-full h-full object-cover" onerror={() => (heroImageError = true)} />
            <div class="absolute inset-0 bg-gradient-to-t from-black/85 via-black/45 to-black/25"></div>
          {:else}
            <div class="hero-art absolute inset-0 bg-gradient-to-br from-blue-700 via-indigo-800 to-purple-900">
              <span class="hero-bubble w-20 h-20 top-6 left-8" style="animation-duration: 7s"></span>
              <span class="hero-bubble w-12 h-12 top-1/3 right-10" style="animation-duration: 5s"></span>
              <span class="hero-bubble w-8 h-8 bottom-10 left-1/3" style="animation-duration: 6s"></span>
            </div>
          {/if}
        </div>
        <div class="relative z-10">
          <span class="inline-block px-3 py-1 bg-white/15 backdrop-blur text-xs font-bold rounded mb-3">
            {hero.category}
          </span>
        </div>
        <div class="relative z-10">
          <h2 class="text-2xl font-black mb-3 leading-tight">
            {hero.title}
          </h2>
          <p class="text-blue-100 text-sm line-clamp-2 mb-4">
            {hero.excerpt}
          </p>
          <span class="inline-block bg-white text-blue-900 text-sm font-bold py-2 px-4 rounded">
            Baca Sekarang
          </span>
        </div>
      </a>
    </div>
  {:else}
    <div class="px-6 my-6">
      <div class="hero-art h-80 rounded bg-gradient-to-br from-blue-700 via-indigo-800 to-purple-900">
        <span class="hero-bubble w-24 h-24 top-8 left-10" style="animation-duration: 8s"></span>
        <span class="hero-bubble w-14 h-14 top-1/4 right-12" style="animation-duration: 5s"></span>
        <span class="hero-bubble w-10 h-10 bottom-12 left-1/4" style="animation-duration: 6s"></span>
        <span class="hero-bubble w-6 h-6 bottom-6 right-1/4" style="animation-duration: 4s"></span>
      </div>
    </div>
  {/if}

  <!-- Lanjutkan Membaca -->
  {#if recentReads.length > 0}
    <div class="px-6 mb-6 rise-in" style="animation-delay: 60ms">
      <div class="flex items-center justify-between mb-3">
        <h3 class="text-base font-black">Lanjutkan Membaca 📖</h3>
        <span class="text-[10px] font-bold uppercase tracking-wider {isDark ? 'text-slate-500' : 'text-slate-400'}">Terakhir dibaca</span>
      </div>
      <div class="space-y-2">
        {#each recentReads as h}
          <a
            href={`/article/${h.slug}`}
            class="p-3 flex items-center gap-3 card-hover transition-colors border rounded {isDark
              ? 'bg-slate-900 border-slate-800 hover:bg-slate-800'
              : 'bg-white border-slate-200 hover:bg-slate-50'}"
          >
            <CoverImage image={h.image} class="w-14 h-14 rounded flex-shrink-0" />
            <div class="flex-1 min-w-0">
              <h4 class="text-sm font-bold {isDark ? 'text-slate-100' : 'text-slate-800'} line-clamp-2 mb-1">
                {h.title}
              </h4>
              <p class="text-xs {isDark ? 'text-slate-500' : 'text-slate-400'}">Lanjut baca di sini</p>
            </div>
            <ChevronRight class="w-5 h-5 {isDark ? 'text-slate-600' : 'text-slate-300'} flex-shrink-0 ml-2" />
          </a>
        {/each}
      </div>
    </div>
  {/if}

  <!-- Stats Strip -->
  <div class="px-6 mb-6 rise-in" style="animation-delay: 50ms">
    <div class="grid grid-cols-3 gap-2">
      <div class="border rounded p-3 text-center {isDark ? 'bg-slate-900 border-slate-800' : 'bg-slate-50 border-slate-200'}">
        <p class="text-xl font-black {isDark ? 'text-slate-100' : 'text-slate-900'}">{articles.length}</p>
        <p class="text-[10px] font-bold uppercase tracking-wider {isDark ? 'text-slate-500' : 'text-slate-500'}">Artikel</p>
      </div>
      <div class="border rounded p-3 text-center {isDark ? 'bg-slate-900 border-slate-800' : 'bg-slate-50 border-slate-200'}">
        <p class="text-xl font-black text-emerald-500">{facts.length}</p>
        <p class="text-[10px] font-bold uppercase tracking-wider {isDark ? 'text-slate-500' : 'text-slate-500'}">Fakta</p>
      </div>
      <div class="border rounded p-3 text-center {isDark ? 'bg-slate-900 border-slate-800' : 'bg-slate-50 border-slate-200'}">
        <p class="text-xl font-black text-purple-500">{quizzes.length}</p>
        <p class="text-[10px] font-bold uppercase tracking-wider {isDark ? 'text-slate-500' : 'text-slate-500'}">Kuis</p>
      </div>
    </div>
  </div>

  <!-- Daily Fact -->
  {#if fact}
    <div class="px-6 mb-6 rise-in" style="animation-delay: 100ms">
      <div
        class="block w-full text-left border rounded p-5 bg-emerald-900 text-white hover:bg-emerald-800 transition-colors"
      >
        <div class="flex items-center justify-between mb-3">
          <div class="flex items-center gap-2">
            <Sparkles class="w-5 h-5 text-emerald-300" />
            <h3 class="text-xs font-black text-emerald-300 uppercase">Sekejap Fakta</h3>
          </div>
          <div class="flex items-center gap-1">
            <button
              onclick={speakFact}
              class="p-2 rounded text-emerald-300 hover:bg-emerald-800 hover:text-emerald-200 transition-colors"
              aria-label="Dengarkan fakta"
            >
              <Volume2 class="w-4 h-4" />
            </button>
            <button
              onclick={shareFact}
              class="p-2 rounded text-emerald-300 hover:bg-emerald-800 hover:text-emerald-200 transition-colors"
              aria-label="Bagikan fakta"
            >
              <Share2 class="w-4 h-4" />
            </button>
            {#if facts.length > 1}
            <button
              onclick={nextFact}
              class="p-2 rounded text-emerald-300 hover:bg-emerald-800 hover:text-emerald-200 transition-colors"
              aria-label="Kasih aku fakta"
            >
              <Shuffle class="w-4 h-4" />
            </button>
          {/if}
          </div>
        </div>
        <button
          onclick={openFactModal}
          class="block w-full text-left bg-transparent p-0 border-0 cursor-pointer"
        >
          <p class="text-base font-bold leading-snug mb-3 line-clamp-2">
            {fact.fact}
          </p>
        </button>
        <a
          href={fact.articleId ? `/article/${(articles.find(a => a.id === fact.articleId) ?? hero)?.slug}` : '/explore'}
          class="text-sm font-bold text-emerald-300 hover:text-emerald-200 inline-flex items-center gap-1"
        >
          Lihat Selengkapnya
          <ChevronRight class="w-4 h-4" />
        </a>
        <button
          onclick={openFlash}
          class="text-sm font-bold text-emerald-300 hover:text-emerald-200 inline-flex items-center gap-1 ml-4"
        >
          🃏 Mode Belajar
        </button>
      </div>
    </div>
  {:else}
    <div class="px-6 mb-6">
      <SkeletonLoader type="card" />
    </div>
  {/if}

  <!-- Fact Popup -->
  {#if factModal}
    <div
      class="fixed inset-0 z-50 flex items-center justify-center p-4"
      role="dialog"
      aria-modal="true"
      aria-label="Sekejap Fakta"
    >
      <button
        type="button"
        aria-label="Tutup popup"
        class="absolute inset-0 bg-black/70 backdrop-blur-sm {factClosing ? 'fact-fade-out' : 'fact-fade-in'} cursor-default"
        onclick={closeFactModal}
      ></button>
      <div
        class="relative w-full max-w-lg bg-emerald-900 text-white rounded-3xl p-6 shadow-2xl {factClosing ? 'fact-pop-out' : 'fact-pop-in'}"
      >
        <div class="flex items-center justify-between mb-4">
          <div class="flex items-center gap-2">
            <Sparkles class="w-5 h-5 text-emerald-300" />
            <h3 class="text-xs font-black text-emerald-300 uppercase">Sekejap Fakta</h3>
          </div>
          <div class="flex items-center gap-1">
            <button
              onclick={speakFact}
              class="p-2 rounded text-emerald-300 hover:bg-emerald-800 transition-colors"
              aria-label="Dengarkan fakta"
            >
              <Volume2 class="w-4 h-4" />
            </button>
            <button
              onclick={shareFact}
              class="p-2 rounded text-emerald-300 hover:bg-emerald-800 transition-colors"
              aria-label="Bagikan fakta"
            >
              <Share2 class="w-4 h-4" />
            </button>
            <button
              onclick={closeFactModal}
              class="p-2 rounded text-emerald-300 hover:bg-emerald-800 transition-colors"
              aria-label="Tutup"
            >
              <X class="w-5 h-5" />
            </button>
          </div>
        </div>
        <p class="text-xl font-bold leading-snug mb-6">
          {fact.fact}
        </p>
        <div class="flex items-center justify-between">
          <a
            href={fact.articleSlug ? `/article/${fact.articleSlug}` : '/explore'}
            class="text-sm font-bold text-emerald-300 hover:text-emerald-200 inline-flex items-center gap-1"
            onclick={closeFactModal}
          >
            Pelajari lebih lanjut
            <ChevronRight class="w-4 h-4" />
          </a>
          {#if facts.length > 1}
            <button
              onclick={nextFact}
              class="p-2 rounded text-emerald-300 hover:bg-emerald-800 transition-colors"
              aria-label="Fakta berikutnya"
            >
              <Shuffle class="w-4 h-4" />
            </button>
          {/if}
        </div>
      </div>
    </div>
  {/if}

  <!-- Flashcards Mode -->
  {#if flashMode && flashFact}
    <div
      class="fixed inset-0 z-50 flex flex-col"
      role="dialog"
      aria-modal="true"
      aria-label="Mode Belajar"
    >
      <div class="absolute inset-0 bg-emerald-950"></div>
      <div
        class="absolute inset-0 bg-gradient-to-br from-emerald-950 via-emerald-900 to-teal-950"
        role="presentation"
        ontouchstart={(e) => (touchX = e.touches[0].clientX)}
        ontouchend={(e) => {
          const dx = e.changedTouches[0].clientX - touchX;
          if (dx > 40) flashPrev();
          else if (dx < -40) flashNext();
        }}
      ></div>
      <div class="relative z-10 flex items-center justify-between p-5">
        <span class="text-xs font-black text-emerald-300 uppercase tracking-widest">
          Mode Belajar • {flashIdx + 1}/{facts.length}
        </span>
        <button
          onclick={() => {
            flashMode = false;
            speechSynthesis.cancel();
            speaking = false;
          }}
          class="p-2.5 rounded-full bg-white/10 text-white"
          aria-label="Tutup mode belajar"
        >
          <X class="w-5 h-5" />
        </button>
      </div>
      <div class="relative z-10 flex-1 flex items-center justify-center px-10">
        <div class="w-full max-w-md rounded-3xl bg-white/10 border border-white/20 backdrop-blur p-8 text-center fact-pop-in">
          <div class="flex items-center justify-center gap-2 mb-4">
            <Sparkles class="w-5 h-5 text-emerald-300" />
            <h3 class="text-xs font-black text-emerald-300 uppercase">Sekejap Fakta</h3>
          </div>
          <p class="text-2xl font-black leading-snug text-white mb-8">{flashFact.fact}</p>
          <div class="flex items-center justify-center gap-4">
            <button
              onclick={flashPrev}
              class="p-3.5 rounded-full bg-white/10 text-white active:scale-95 transition-transform"
              aria-label="Fakta sebelumnya"
            >
              <ChevronRight class="w-6 h-6 rotate-180" />
            </button>
            <button
              onclick={flashSpeak}
              class="p-3.5 rounded-full bg-white/10 text-white active:scale-95 transition-transform"
              aria-label="Dengarkan fakta"
            >
              <Volume2 class="w-6 h-6" />
            </button>
            <button
              onclick={flashNext}
              class="p-3.5 rounded-full bg-white/10 text-white active:scale-95 transition-transform"
              aria-label="Fakta berikutnya"
            >
              <ChevronRight class="w-6 h-6" />
            </button>
          </div>
        </div>
      </div>
      <div class="relative z-10 p-6 text-center">
        <p class="text-[10px] font-semibold text-emerald-400/70 uppercase tracking-widest">Geser kiri / kanan untuk ganti fakta</p>
      </div>
    </div>
  {/if}

  <!-- Categories -->
  {#if categories.length > 0}
    <div class="px-6 mb-6 rise-in" style="animation-delay: 200ms">
      <h3 class="text-base font-black mb-3">Jelajahi Kategori</h3>
      <div class="grid grid-cols-2 gap-3">
        {#each categories as cat}
          <button
            onclick={() => goto(`/search?cat=${encodeURIComponent(cat.slug)}`)}
            class="p-3 rounded border flex items-center gap-3 text-left card-hover {isDark
              ? 'bg-slate-900 border-slate-800 hover:bg-slate-800'
              : 'bg-slate-50 border-slate-200 hover:bg-white'}"
          >
            <span class="text-2xl">{categoryEmoji[cat.slug] ?? '📚'}</span>
            <span class="text-sm font-bold {isDark ? 'text-slate-200' : 'text-slate-700'}">{cat.name}</span>
          </button>
        {/each}
      </div>
    </div>
  {:else}
    <div class="px-6 mb-6">
      <h3 class="text-base font-black mb-3">Jelajahi Kategori</h3>
      <div class="grid grid-cols-2 gap-3">
        {#each Array(4) as _}
          <div class="h-14 {isDark ? 'bg-slate-900' : 'bg-slate-200'} rounded animate-pulse"></div>
        {/each}
      </div>
    </div>
  {/if}

  <!-- Popular Articles -->
  <div class="px-6 mb-6 rise-in" style="animation-delay: 300ms">
    <h3 class="text-lg font-black mb-3">Artikel yang Sedang Trending 🔥</h3>
    {#if trendingTop.length > 0}
      <div class="space-y-3">
        {#each trendingTop as article}
          <a
            href={`/article/${article.slug}`}
            class="p-3 rounded border flex items-center gap-3 card-hover {isDark
              ? 'bg-slate-900 border-slate-800 hover:bg-slate-800'
              : 'bg-slate-50 border-slate-200 hover:bg-white'}"
          >
            <CoverImage image={article.image} class="w-16 h-16 rounded flex-shrink-0" />
            <div class="flex-1">
              <span class="text-xs font-black text-blue-600 uppercase">{article.category}</span>
              <h4 class="text-sm font-bold line-clamp-2 {isDark ? 'text-slate-100' : 'text-slate-800'} mb-1">
                {article.title}
              </h4>
              <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-500'}">
                {article.viewCount} dibaca • {article.reactionCount ?? 0} reaksi
              </p>
            </div>
          </a>
        {/each}
      </div>
    {:else}
      <div class="space-y-3">
        {#each Array(2) as _}
          <SkeletonLoader type="card" />
        {/each}
      </div>
    {/if}
  </div>

  <!-- Weekly Quiz Banner -->
  {#if weeklyQuiz}
    <div class="px-6 mb-6 rise-in" style="animation-delay: 400ms">
      <a
        href={`/quiz/question?id=${weeklyQuiz.id}`}
        class="block bg-purple-700 text-white p-6 rounded border border-purple-600 hover:bg-purple-600 transition-colors"
      >
        <span class="text-xs font-black bg-purple-800 px-3 py-1 rounded inline-block mb-2 uppercase">KUIS MINGGU INI</span>
        <h3 class="text-xl font-black mb-2">{weeklyQuiz.title}</h3>
        <p class="text-purple-100 text-sm mb-4">{weeklyQuiz.description}</p>
        <span class="inline-block bg-white text-purple-700 font-bold py-2 px-4 rounded text-sm">
          Coba Sekarang 💡
        </span>
      </a>
    </div>
  {:else}
    <div class="px-6 mb-6">
      <SkeletonLoader type="card" />
    </div>
  {/if}

  <!-- Latest Articles -->
  <div class="px-6 mb-6 rise-in" style="animation-delay: 500ms">
    <h3 class="text-lg font-black mb-3">Artikel Terbaru ✨</h3>
    {#if latest.length > 0}
      <div class="space-y-2 {isDark ? 'divide-slate-800' : 'divide-slate-200'}">
        {#each latest as article}
          <a
            href={`/article/${article.slug}`}
            class="p-3 flex items-center gap-3 card-hover transition-colors border rounded {isDark
              ? 'bg-slate-900 border-slate-800 hover:bg-slate-800'
              : 'bg-white border-slate-200 hover:bg-slate-50'}"
          >
            <CoverImage image={article.image} class="w-16 h-16 rounded flex-shrink-0" />
            <div class="flex-1 min-w-0">
              <h4 class="text-sm font-bold {isDark ? 'text-slate-100' : 'text-slate-800'} line-clamp-2 mb-1">
                {article.title}
              </h4>
              <p class="text-xs font-semibold uppercase {isDark ? 'text-slate-400' : 'text-slate-600'}">
                {article.category} • {article.readTime}
              </p>
            </div>
            <ChevronRight class="w-5 h-5 {isDark ? 'text-slate-600' : 'text-slate-300'} flex-shrink-0 ml-2" />
          </a>
        {/each}
      </div>
    {:else}
      <div class="space-y-2">
        {#each Array(3) as _}
          <div class="{isDark ? 'bg-slate-900' : 'bg-white'} border rounded p-4">
            <SkeletonLoader type="text" width="w-3/4" height="h-4" />
          </div>
        {/each}
      </div>
    {/if}
  </div>

  <div class="px-6 rise-in" style="animation-delay: 600ms">
    <button
      onclick={() => goto('/explore')}
      class="w-full border rounded py-3 font-bold text-sm transition-colors {isDark
        ? 'bg-slate-900 border-slate-800 text-slate-200 hover:bg-slate-800'
        : 'bg-slate-50 border-slate-300 text-slate-800 hover:bg-slate-100'}"
    >
      Jelajahi Semua Artikel 🚀
    </button>
  </div>

  <!-- Tujuan Aplikasi -->
  <div class="px-6 mt-6 mb-6 rise-in" style="animation-delay: 700ms">
    <div class="relative overflow-hidden rounded-3xl border p-6 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-slate-50 border-slate-100'}">
      <div class="hero-art absolute inset-0 opacity-40 pointer-events-none">
        <span class="hero-bubble w-16 h-16 top-4 right-8" style="animation-duration: 8s"></span>
        <span class="hero-bubble w-8 h-8 bottom-8 right-24" style="animation-duration: 5s"></span>
      </div>
      <div class="relative z-10">
        <div class="flex items-center gap-2 mb-3">
          <span class="w-2.5 h-2.5 rounded-full bg-blue-500"></span>
          <span class="text-[10px] font-black uppercase tracking-[0.2em] {isDark ? 'text-slate-400' : 'text-slate-500'}">Apa itu SEKTA?</span>
        </div>
        <h2 class="text-3xl font-black tracking-tight leading-none mb-2 bg-gradient-to-r from-blue-600 via-indigo-500 to-purple-600 bg-clip-text text-transparent">
          SEKTA — Sekejap Fakta
        </h2>
        <p class="text-sm font-medium leading-relaxed mb-4 {isDark ? 'text-slate-300' : 'text-slate-600'}">
          <span class="font-black">SEKTA (Sekejap Fakta)</span> adalah platform pengetahuan harian yang menyajikan fakta
          unik dari bidang sains, sejarah, teknologi, dan dunia lewat artikel singkat serta kuis interaktif.
        </p>
        <div class="rounded-2xl border p-4 mb-4 {isDark ? 'bg-slate-950/60 border-slate-800' : 'bg-white border-slate-200'}">
          <p class="text-[10px] font-black uppercase tracking-[0.2em] mb-1.5 {isDark ? 'text-slate-400' : 'text-slate-500'}">
            Mengapa Perlu Login Akun Google?
          </p>
          <p class="text-xs leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">
            Pengguna dapat masuk menggunakan akun Google untuk mengakses fitur personalisasi, seperti menyimpan riwayat
            kuis, menyimpan artikel favorit, memberi reaksi dan komentar pada konten, serta melihat statistik progres belajar harian.
          </p>
        </div>
        <div class="flex flex-wrap gap-2 mb-5">
          <span class="px-3 py-1.5 rounded-xl text-[10px] font-black border {isDark ? 'bg-slate-800 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-600'}">📰 Artikel Singkat</span>
          <span class="px-3 py-1.5 rounded-xl text-[10px] font-black border {isDark ? 'bg-slate-800 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-600'}">🧠 Kuis Interaktif</span>
          <span class="px-3 py-1.5 rounded-xl text-[10px] font-black border {isDark ? 'bg-slate-800 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-600'}">💬 Komentar</span>
          <span class="px-3 py-1.5 rounded-xl text-[10px] font-black border {isDark ? 'bg-slate-800 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-600'}">🔊 Bisa Dibacakan</span>
        </div>
        <div class="flex gap-2">
          <a href="/explore" class="flex items-center gap-1.5 px-4 py-2.5 rounded-xl bg-gradient-to-r from-blue-600 to-indigo-600 text-white text-xs font-black transition-all active:scale-95 shadow-md shadow-blue-600/20">
            Mulai Jelajahi
            <ChevronRight class="w-3.5 h-3.5" />
          </a>
          <a href="/quiz" class="flex items-center gap-1.5 px-4 py-2.5 rounded-xl border text-xs font-black transition-all active:scale-95 {isDark ? 'border-slate-700 text-slate-200 hover:bg-slate-800' : 'border-slate-200 text-slate-600 hover:bg-slate-50'}">
            Main Kuis
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
