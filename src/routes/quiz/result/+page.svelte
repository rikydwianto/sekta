<script lang="ts">
  import { RotateCcw, Home, Share2, BookOpen, ChevronRight } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { page } from '$app/stores';
  import { app } from '$lib/stores/app.svelte';
  import { getArticleByQuiz, getQuizStats } from '$lib/api';
  import type { Article } from '$lib/types';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';

  let isDark = $derived(app.theme === 'dark');

  // Get score from URL params - with fallback
  let score = $state(0);
  let correct = $state(0);
  let total = $state(5);
  let sourceArticle = $state<Article | null>(null);
  let quizStats = $state({ count: 0, avgPercent: 0, bestPercent: 0, streak: 0 });

  $effect(() => {
    try {
      const s = parseInt($page.url.searchParams.get('score') ?? '0');
      const c = parseInt($page.url.searchParams.get('correct') ?? '0');
      const t = parseInt($page.url.searchParams.get('total') ?? '5');
      const id = parseInt($page.url.searchParams.get('id') ?? '0');

      score = isNaN(s) ? 0 : s;
      correct = isNaN(c) ? 0 : c;
      total = isNaN(t) ? 5 : t;
      if (id) {
        getArticleByQuiz(id).then((a) => (sourceArticle = a));
      }
      getQuizStats().then((s) => (quizStats = s)).catch(() => {});
    } catch (e) {
      console.error('Error parsing URL params:', e);
    }
  });

  // Determine performance level
  let performanceLevel = $derived.by(() => {
    if (score >= 80) return 'Luar Biasa';
    if (score >= 60) return 'Bagus';
    if (score >= 40) return 'Cukup';
    return 'Perlu Latihan';
  });

  let performanceColor = $derived.by(() => {
    if (score >= 80) return 'emerald';
    if (score >= 60) return 'blue';
    if (score >= 40) return 'yellow';
    return 'red';
  });

  let performanceEmoji = $derived.by(() => {
    if (score >= 80) return '🎉';
    if (score >= 60) return '👍';
    if (score >= 40) return '💪';
    return '📚';
  });

  function restartQuiz() {
    goto('/quiz/question');
  }

  function goHome() {
    goto('/');
  }

  function shareScore() {
    const text = `Saya mendapat skor ${score}% di Kuis Sekejap Fakta! 🧠 Coba juga kamu di app!`;
    if (navigator.share) {
      navigator.share({ title: 'Kuis Sekejap Fakta', text });
    } else {
      // Fallback: copy to clipboard
      navigator.clipboard.writeText(text);
      alert('Skor disalin ke clipboard!');
    }
  }
</script>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">

  <!-- Page Header -->
  <PageHeader title="Hasil Kuis" type="page" />

  <!-- Results Content -->
  <div class="px-6 pt-4">

    <!-- Score Card -->
    <div class="border rounded-3xl p-8 mb-6 text-center
      {performanceColor === 'emerald'
        ? isDark ? 'bg-emerald-950 border-emerald-900' : 'bg-emerald-50 border-emerald-200'
        : performanceColor === 'blue'
          ? isDark ? 'bg-blue-950 border-blue-900' : 'bg-blue-50 border-blue-200'
          : performanceColor === 'yellow'
            ? isDark ? 'bg-yellow-950 border-yellow-900' : 'bg-yellow-50 border-yellow-200'
            : isDark ? 'bg-red-950 border-red-900' : 'bg-red-50 border-red-200'}"
    >
      <div class="text-6xl mb-4">{performanceEmoji}</div>
      <p class="text-sm font-semibold mb-2
        {performanceColor === 'emerald'
          ? isDark ? 'text-emerald-300' : 'text-emerald-700'
          : performanceColor === 'blue'
            ? isDark ? 'text-blue-300' : 'text-blue-700'
            : performanceColor === 'yellow'
              ? isDark ? 'text-yellow-300' : 'text-yellow-700'
              : isDark ? 'text-red-300' : 'text-red-700'}"
      >
        {performanceLevel}
      </p>
      <div class="text-5xl font-black mb-2
        {performanceColor === 'emerald'
          ? isDark ? 'text-emerald-400' : 'text-emerald-600'
          : performanceColor === 'blue'
            ? isDark ? 'text-blue-400' : 'text-blue-600'
            : performanceColor === 'yellow'
              ? isDark ? 'text-yellow-400' : 'text-yellow-600'
              : isDark ? 'text-red-400' : 'text-red-600'}"
      >
        {score}%
      </div>
      <p class="text-sm {performanceColor === 'emerald'
        ? isDark ? 'text-emerald-200' : 'text-emerald-600'
        : performanceColor === 'blue'
          ? isDark ? 'text-blue-200' : 'text-blue-600'
          : performanceColor === 'yellow'
            ? isDark ? 'text-yellow-200' : 'text-yellow-600'
            : isDark ? 'text-red-200' : 'text-red-600'}">
        {correct} dari {total} jawaban benar
      </p>
    </div>

    <!-- Statistics -->
    <div class="grid grid-cols-2 gap-3 mb-6">
      <div class="border rounded-2xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <div class="text-2xl font-black text-blue-600 mb-1">{correct}</div>
        <div class="text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-500'}">Jawaban Benar</div>
      </div>
      <div class="border rounded-2xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <div class="text-2xl font-black text-red-600 mb-1">{total - correct}</div>
        <div class="text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-500'}">Jawaban Salah</div>
      </div>
    </div>

    <!-- Performance Message -->
    <div class="border rounded-2xl p-4 mb-6 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
      {#if score >= 80}
        <p class="text-sm font-semibold mb-2 text-emerald-600">Sempurna! 🌟</p>
        <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-600'}">
          Kamu menunjukkan pemahaman yang luar biasa! Lanjutkan semangat ini dan terus belajar hal-hal baru.
        </p>
      {:else if score >= 60}
        <p class="text-sm font-semibold mb-2 text-blue-600">Bagus! 👏</p>
        <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-600'}">
          Hasil yang baik! Masih ada ruang untuk improvement. Coba kembali lagi dan lihat peningkatannya.
        </p>
      {:else if score >= 40}
        <p class="text-sm font-semibold mb-2 text-yellow-600">Cukup Baik 💪</p>
        <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-600'}">
          Cara bagus untuk memulai! Jangan menyerah, coba kembali dan pelajari topik-topik yang belum dikuasai.
        </p>
      {:else}
        <p class="text-sm font-semibold mb-2 text-red-600">Keep Learning 📚</p>
        <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-600'}">
          Setiap orang dimulai dari sini. Baca artikel kami dan coba lagi untuk meningkatkan skor.
        </p>
      {/if}
    </div>

    <!-- Progress Bar -->
    <div class="mb-6">
      <div class="flex justify-between text-xs font-bold mb-2">
        <span class="text-slate-500">Progress Kuis</span>
        <span class="text-slate-400">{score}%</span>
      </div>      <div class="h-3 rounded-full overflow-hidden {isDark ? 'bg-slate-800' : 'bg-slate-200'}">
        <div class="h-full rounded-full transition-all duration-500 {performanceColor === 'emerald'
          ? 'bg-emerald-600'
          : performanceColor === 'blue'
            ? 'bg-blue-600'
            : performanceColor === 'yellow'
              ? 'bg-yellow-600'
              : 'bg-red-600'}" style="width: {score}%"></div>
      </div>
    </div>

    <!-- Sumber Artikel -->
    {#if sourceArticle}
      <a
        href={`/article/${sourceArticle.slug}`}
        class="block border rounded-2xl p-4 mb-6 transition-all active:scale-[0.98] hover:opacity-90 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}"
      >
        <p class="text-[10px] font-black uppercase tracking-widest mb-3 {isDark ? 'text-slate-500' : 'text-slate-400'}">
          Kuis dari artikel
        </p>
        <div class="flex items-center gap-3">
          <div class="w-16 h-12 rounded-xl overflow-hidden flex-shrink-0">
            <CoverImage image={sourceArticle.image} class="w-full h-full object-cover" />
          </div>
          <div class="flex-1 min-w-0">
            <p class="text-sm font-black line-clamp-2 leading-tight">{sourceArticle.title}</p>
            <p class="text-[11px] mt-1 font-semibold flex items-center gap-1 text-blue-500">
              Baca artikelnya
              <ChevronRight class="w-3 h-3" />
            </p>
          </div>
        </div>
      </a>
    {/if}

    <!-- Action Buttons -->
    <div class="space-y-3">
      <button
        onclick={restartQuiz}
        class="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-2xl border font-bold text-sm transition-all active:scale-95
          bg-purple-600 border-purple-600 text-white hover:bg-purple-700"
      >
        <RotateCcw class="w-4 h-4" />
        Coba Lagi
      </button>

      <div class="grid grid-cols-2 gap-3">
        <button
          onclick={shareScore}
          class="flex items-center justify-center gap-2 py-3 px-4 rounded-2xl border font-bold text-sm transition-all active:scale-95
            {isDark
              ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800'
              : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'}"
        >
          <Share2 class="w-4 h-4" />
          Bagikan
        </button>

        <button
          onclick={goHome}
          class="flex items-center justify-center gap-2 py-3 px-4 rounded-2xl border font-bold text-sm transition-all active:scale-95
            {isDark
              ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800'
              : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'}"
        >
          <Home class="w-4 h-4" />
          Beranda
        </button>
      </div>
    </div>

    <!-- Recent Quiz Stats -->
    <div class="mt-8 pt-6 border-t {isDark ? 'border-slate-800' : 'border-slate-200'}">
      <p class="text-xs font-black uppercase tracking-wider mb-4 {isDark ? 'text-slate-500' : 'text-slate-400'}">
        📈 Statistik Kamu
      </p>
      <div class="space-y-2">
        <div class="flex items-center justify-between text-sm">
          <span class={isDark ? 'text-slate-400' : 'text-slate-600'}>Total Kuis Diselesaikan</span>
          <span class="font-bold">{quizStats.count}</span>
        </div>
        <div class="flex items-center justify-between text-sm">
          <span class={isDark ? 'text-slate-400' : 'text-slate-600'}>Rata-rata Skor</span>
          <span class="font-bold text-blue-600">
            {quizStats.avgPercent}%
          </span>
        </div>
        <div class="flex items-center justify-between text-sm">
          <span class={isDark ? 'text-slate-400' : 'text-slate-600'}>Tertinggi</span>
          <span class="font-bold text-emerald-600">
            {quizStats.bestPercent}%
          </span>
        </div>
      </div>
    </div>

  </div>

</div>