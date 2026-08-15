<script lang="ts">
  import { ChevronRight, ChevronLeft } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { app, addQuizResult } from '$lib/stores/app.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';

  let isDark = $derived(app.theme === 'dark');

  // Quiz data - mock data for now
  const QUIZ_QUESTIONS = [
    {
      id: 1,
      question: 'Berapa banyak tulang yang dimiliki tubuh manusia dewasa?',
      answers: [
        { id: 1, text: '186 tulang', correct: false },
        { id: 2, text: '206 tulang', correct: true },
        { id: 3, text: '226 tulang', correct: false },
        { id: 4, text: '246 tulang', correct: false }
      ]
    },
    {
      id: 2,
      question: 'Planet manakah yang paling dekat dengan Matahari?',
      answers: [
        { id: 1, text: 'Venus', correct: false },
        { id: 2, text: 'Merkurius', correct: true },
        { id: 3, text: 'Bumi', correct: false },
        { id: 4, text: 'Mars', correct: false }
      ]
    },
    {
      id: 3,
      question: 'Siapa penemu listrik?',
      answers: [
        { id: 1, text: 'Nikola Tesla', correct: false },
        { id: 2, text: 'Thomas Edison', correct: false },
        { id: 3, text: 'Benjamin Franklin', correct: true },
        { id: 4, text: 'James Watt', correct: false }
      ]
    },
    {
      id: 4,
      question: 'Berapa persentase air yang mengisi tubuh manusia?',
      answers: [
        { id: 1, text: '40%', correct: false },
        { id: 2, text: '50%', correct: false },
        { id: 3, text: '60%', correct: true },
        { id: 4, text: '70%', correct: false }
      ]
    },
    {
      id: 5,
      question: 'Negara manakah yang memiliki piramida terbanyak?',
      answers: [
        { id: 1, text: 'Mesir', correct: false },
        { id: 2, text: 'Sudan', correct: true },
        { id: 3, text: 'Mexico', correct: false },
        { id: 4, text: 'Inggris', correct: false }
      ]
    }
  ];

  // Quiz state
  let currentQuestionIndex = $state(0);
  let selectedAnswers = $state<Record<number, number>>({});
  let quizStarted = $state(false);

  const currentQuestion = $derived(QUIZ_QUESTIONS[currentQuestionIndex]);
  const isLastQuestion = $derived(currentQuestionIndex === QUIZ_QUESTIONS.length - 1);
  const totalQuestions = $derived(QUIZ_QUESTIONS.length);
  const progress = $derived((currentQuestionIndex + 1) / totalQuestions * 100);

  function startQuiz() {
    quizStarted = true;
  }

  function selectAnswer(answerId: number) {
    selectedAnswers[currentQuestion.id] = answerId;
  }

  function nextQuestion() {
    if (currentQuestionIndex < QUIZ_QUESTIONS.length - 1) {
      currentQuestionIndex++;
    }
  }

  function previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
    }
  }

  function finishQuiz() {
    // Calculate score
    let correctCount = 0;
    for (const q of QUIZ_QUESTIONS) {
      const selectedAnswerId = selectedAnswers[q.id];
      const selectedAnswer = q.answers.find(a => a.id === selectedAnswerId);
      if (selectedAnswer?.correct) {
        correctCount++;
      }
    }

    const score = Math.round((correctCount / QUIZ_QUESTIONS.length) * 100);
    
    // Store quiz result in app store
    addQuizResult({
      score,
      correctAnswers: correctCount,
      totalQuestions: QUIZ_QUESTIONS.length,
      date: new Date()
    });

    // Redirect to result page
    goto(`/quiz/result?score=${score}&correct=${correctCount}&total=${totalQuestions}`);
  }
</script>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">

  <!-- Page Header -->
  <PageHeader title="Kuis Interaktif" type="page" />

  <!-- Quiz Content -->
  <div class="px-6 pt-4">

    {#if !quizStarted}
      <!-- Quiz Welcome Screen -->
      <div class="flex flex-col items-center justify-center py-20 text-center">
        <div class="w-20 h-20 rounded-3xl bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center mb-6">
          <span class="text-4xl">🧠</span>
        </div>
        <h2 class="text-2xl font-black mb-3">Uji Pengetahuanmu!</h2>
        <p class="text-sm {isDark ? 'text-slate-400' : 'text-slate-600'} mb-6 max-w-xs leading-relaxed">
          Jawab {totalQuestions} pertanyaan seru dan lihat seberapa banyak yang kamu tahu tentang berbagai topik.
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
            {#each currentQuestion.answers as answer}
              <button
                onclick={() => selectAnswer(answer.id)}
                class="w-full p-4 rounded-2xl border text-left font-bold transition-all card-hover
                  {selectedAnswers[currentQuestion.id] === answer.id
                    ? 'bg-purple-600 border-purple-600 text-white'
                    : isDark
                      ? 'bg-slate-800 border-slate-700 text-slate-100 hover:bg-slate-700'
                      : 'bg-slate-50 border-slate-200 text-slate-800 hover:bg-slate-100'}"
              >
                <div class="flex items-center gap-3">
                  <div class="w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0
                    {selectedAnswers[currentQuestion.id] === answer.id
                      ? 'bg-white border-white'
                      : isDark
                        ? 'border-slate-600'
                        : 'border-slate-300'}"
                  >
                    {#if selectedAnswers[currentQuestion.id] === answer.id}
                      <div class="w-2 h-2 bg-purple-600 rounded-full"></div>
                    {/if}
                  </div>
                  <span>{answer.text}</span>
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