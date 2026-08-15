<script lang="ts">
  import { ChevronRight, ChevronLeft, Brain } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { page } from '$app/state';
  import { app, addQuizResult, setCurrentQuiz } from '$lib/stores/app.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import { getQuizQuestions, getQuizList } from '$lib/api';
  import type { QuizQuestion } from '$lib/types';

  let isDark = $derived(app.theme === 'dark');

  let quizId = $derived(Number(page.url.searchParams.get('id')) || 0);
  let questions = $state<QuizQuestion[]>([]);
  let quizTitle = $state('');
  let loading = $state(true);
  let notFound = $state(false);

  $effect(() => {
    if (!quizId) return;
    loading = true;
    notFound = false;
    Promise.all([getQuizQuestions(quizId), getQuizList()]).then(([qs, quizzes]) => {
      questions = qs;
      quizTitle = quizzes.find((q) => q.id === quizId)?.title ?? '';
      setCurrentQuiz(quizId, quizTitle);
      currentQuestionIndex = 0;
      selectedAnswers = {};
      quizStarted = false;
      loading = false;
      notFound = qs.length === 0;
    });
  });

  // Quiz state
  let currentQuestionIndex = $state(0);
  let selectedAnswers = $state<Record<number, number>>({});
  let quizStarted = $state(false);

  const currentQuestion = $derived(questions[currentQuestionIndex]);
  const isLastQuestion = $derived(currentQuestionIndex === questions.length - 1);
  const totalQuestions = $derived(questions.length);
  const progress = $derived(questions.length ? ((currentQuestionIndex + 1) / totalQuestions) * 100 : 0);

  function startQuiz() {
    quizStarted = true;
  }

  function selectAnswer(answerId: number) {
    if (!currentQuestion) return;
    selectedAnswers[currentQuestion.id] = answerId;
  }

  function nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    }
  }

  function previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
    }
  }

  function finishQuiz() {
    let correctCount = 0;
    for (const q of questions) {
      const selectedAnswerId = selectedAnswers[q.id];
      const selectedAnswer = q.options.find(a => a.id === selectedAnswerId);
      if (selectedAnswer?.isCorrect) {
        correctCount++;
      }
    }

    const score = Math.round((correctCount / questions.length) * 100);

    addQuizResult({
      score,
      correctAnswers: correctCount,
      totalQuestions: questions.length,
      date: new Date()
    });

    goto(`/quiz/result?score=${score}&correct=${correctCount}&total=${totalQuestions}&id=${quizId}`);
  }
</script>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">

  <!-- Page Header -->
  <PageHeader title="Kuis Interaktif" type="page" />

  <!-- Quiz Content -->
  <div class="px-6 pt-4">

    {#if loading}
      <div class="flex flex-col items-center justify-center py-20 text-center">
        <div class="w-10 h-10 border-2 border-purple-600 border-t-transparent rounded-full animate-spin mb-4"></div>
        <p class="text-sm font-bold {isDark ? 'text-slate-400' : 'text-slate-600'}">Memuat kuis...</p>
      </div>

    {:else if notFound || questions.length === 0}
      <div class="flex flex-col items-center justify-center py-20 text-center">
        <div class="w-20 h-20 rounded-3xl bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center mb-6">
          <span class="text-4xl">🧠</span>
        </div>
        <h2 class="text-2xl font-black mb-3">Kuis Tidak Ditemukan</h2>
        <p class="text-sm {isDark ? 'text-slate-400' : 'text-slate-600'} mb-6 max-w-xs leading-relaxed">
          Kuis untuk artikel ini belum tersedia.
        </p>
        <button
          onclick={() => goto('/quiz')}
          class="w-full py-3 px-4 rounded-2xl bg-purple-600 hover:bg-purple-700 text-white font-bold transition-all active:scale-95 shadow-lg shadow-purple-600/20"
        >
          Lihat Kuis Lainnya
        </button>
      </div>

    {:else if !quizStarted}
      <!-- Quiz Welcome Screen -->
      <div class="flex flex-col items-center justify-center py-20 text-center">
        <div class="w-20 h-20 rounded-3xl bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center mb-6">
          <span class="text-4xl">🧠</span>
        </div>
        {#if quizTitle}
          <h2 class="text-2xl font-black mb-2">{quizTitle}</h2>
        {/if}
        <p class="text-sm {isDark ? 'text-slate-400' : 'text-slate-600'} mb-6 max-w-xs leading-relaxed">
          Jawab {totalQuestions} pertanyaan seru dan lihat seberapa banyak yang kamu tahu.
        </p>

        <div class="w-full mb-8">
          <div class="grid grid-cols-3 gap-3 mb-6">
            <div class="border rounded-2xl p-4 text-center {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
              <div class="text-2xl font-black text-purple-600 mb-1">{totalQuestions}</div>
              <div class="text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-500'}">Pertanyaan</div>
            </div>
            <div class="border rounded-2xl p-4 text-center {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
              <div class="text-2xl font-black text-blue-600 mb-1">~2m</div>
              <div class="text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-500'}">Durasi</div>
            </div>
            <div class="border rounded-2xl p-4 text-center {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
              <div class="text-2xl font-black text-emerald-600 mb-1">∞</div>
              <div class="text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-500'}">Coba Lagi</div>
            </div>
          </div>
        </div>

        <button
          onclick={startQuiz}
          class="w-full py-3 px-4 rounded-2xl bg-purple-600 hover:bg-purple-700 text-white font-bold transition-all active:scale-95 shadow-lg shadow-purple-600/20"
        >
          Mulai Kuis Sekarang
        </button>

        <p class="text-xs {isDark ? 'text-slate-600' : 'text-slate-400'} mt-4">
          Tidak ada batas waktu, kerjakan dengan santai! ✌️
        </p>
      </div>

    {:else}
      <!-- Quiz In Progress -->
      <div>
        <!-- Progress bar -->
        <div class="mb-6">
          <div class="flex items-center justify-between mb-2">
            <span class="text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-500'}">Soal {currentQuestionIndex + 1}/{totalQuestions}</span>
            <span class="text-xs font-bold text-purple-600">{Math.round(progress)}%</span>
          </div>
          <div class="h-2 rounded-full overflow-hidden {isDark ? 'bg-slate-800' : 'bg-slate-200'}">
            <div class="h-full bg-purple-600 rounded-full transition-all duration-300" style="width: {progress}%"></div>
          </div>
        </div>

        <!-- Question Card -->
        <div class="border rounded-2xl p-6 mb-6 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <h2 class="text-lg font-black mb-6 leading-snug">
            {currentQuestion.question}
          </h2>

          <!-- Answer Options -->
          <div class="space-y-3">
            {#each currentQuestion.options as option}
              <button
                onclick={() => selectAnswer(option.id)}
                class="w-full p-4 rounded-2xl border text-left font-bold transition-all card-hover
                  {selectedAnswers[currentQuestion.id] === option.id
                    ? 'bg-purple-600 border-purple-600 text-white'
                    : isDark
                      ? 'bg-slate-800 border-slate-700 text-slate-100 hover:bg-slate-700'
                      : 'bg-slate-50 border-slate-200 text-slate-800 hover:bg-slate-100'}"
              >
                <div class="flex items-center gap-3">
                  <div class="w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0
                    {selectedAnswers[currentQuestion.id] === option.id
                      ? 'bg-white border-white'
                      : isDark
                        ? 'border-slate-600'
                        : 'border-slate-300'}"
                  >
                    {#if selectedAnswers[currentQuestion.id] === option.id}
                      <div class="w-2 h-2 bg-purple-600 rounded-full"></div>
                    {/if}
                  </div>
                  <span>{option.label}</span>
                </div>
              </button>
            {/each}
          </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="flex gap-3">
          <button
            onclick={previousQuestion}
            disabled={currentQuestionIndex === 0}
            class="flex items-center justify-center gap-2 py-3 px-4 rounded-2xl border font-bold text-sm transition-all active:scale-95
              {currentQuestionIndex === 0
                ? isDark
                  ? 'bg-slate-900 border-slate-700 text-slate-500'
                  : 'bg-slate-100 border-slate-200 text-slate-400'
                : isDark
                  ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800'
                  : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'}"
          >
            <ChevronLeft class="w-4 h-4" />
            Sebelumnya
          </button>

          {#if isLastQuestion}
            <button
              onclick={finishQuiz}
              disabled={!selectedAnswers[currentQuestion.id]}
              class="flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-2xl border font-bold text-sm transition-all active:scale-95
                {!selectedAnswers[currentQuestion.id]
                  ? isDark
                    ? 'bg-slate-900 border-slate-700 text-slate-500'
                    : 'bg-slate-100 border-slate-200 text-slate-400'
                  : 'bg-emerald-600 border-emerald-600 text-white hover:bg-emerald-700'}"
            >
              Selesai
            </button>
          {:else}
            <button
              onclick={nextQuestion}
              disabled={!selectedAnswers[currentQuestion.id]}
              class="flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-2xl border font-bold text-sm transition-all active:scale-95
                {!selectedAnswers[currentQuestion.id]
                  ? isDark
                    ? 'bg-slate-900 border-slate-700 text-slate-500'
                    : 'bg-slate-100 border-slate-200 text-slate-400'
                  : 'bg-purple-600 border-purple-600 text-white hover:bg-purple-700'}"
            >
              Lanjut
              <ChevronRight class="w-4 h-4" />
            </button>
          {/if}
        </div>
      </div>
    {/if}

  </div>

</div>