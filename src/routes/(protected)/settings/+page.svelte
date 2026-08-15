<script lang="ts">
  import {
    Sun,
    Moon,
    Bell,
    BellOff,
    ChevronRight,
    User,
    Shield,
    Info,
    FileText,
    Lock,
    LogOut,
    Newspaper,
    Brain,
    Star
  } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import LogoutModal from '$lib/components/LogoutModal.svelte';
  import { app, toggleTheme } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');
  let showLogout = $state(false);

  // ── Notification preference state ────────────────────────
  let notifArticle = $state(true);
  let notifQuiz = $state(true);
  let notifAchievement = $state(false);
  let notifWeeklyDigest = $state(true);

  function toggleNotif(key: 'article' | 'quiz' | 'achievement' | 'weekly') {
    if (key === 'article') notifArticle = !notifArticle;
    else if (key === 'quiz') notifQuiz = !notifQuiz;
    else if (key === 'achievement') notifAchievement = !notifAchievement;
    else if (key === 'weekly') notifWeeklyDigest = !notifWeeklyDigest;
  }
</script>

<div
  class="min-h-full pb-20 transition-colors duration-300 {isDark
    ? 'text-slate-100 bg-slate-950'
    : 'text-slate-900 bg-slate-50'}"
>
  <PageHeader title="Pengaturan" type="page" backHref="/profile" />

  <div class="px-5 py-5 space-y-7">

    <!-- ── TAMPILAN ──────────────────────────────────────── -->
    <section>
      <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-3 px-1">
        TAMPILAN
      </span>
      <div
        class="border rounded-2xl p-4 flex justify-between items-center gap-4 {isDark
          ? 'bg-slate-900 border-slate-800'
          : 'bg-white border-slate-200'}"
      >
        <div class="flex items-center gap-3">
          {#if isDark}
            <div class="w-9 h-9 rounded-xl bg-blue-600/20 flex items-center justify-center flex-shrink-0">
              <Moon class="w-5 h-5 text-blue-400" />
            </div>
          {:else}
            <div class="w-9 h-9 rounded-xl bg-amber-100 flex items-center justify-center flex-shrink-0">
              <Sun class="w-5 h-5 text-amber-500" />
            </div>
          {/if}
          <div>
            <h4 class="text-sm font-bold">Mode Tampilan</h4>
            <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-500'}">
              {isDark ? 'Mode Gelap aktif' : 'Mode Terang aktif'}
            </p>
          </div>
        </div>

        <!-- Toggle switch -->
        <button
          onclick={toggleTheme}
          aria-label="Toggle tema"
          aria-pressed={isDark}
          class="relative w-[52px] h-7 rounded-full flex-shrink-0 transition-colors duration-300 focus-visible:outline focus-visible:outline-2 focus-visible:outline-blue-600 {isDark
            ? 'bg-blue-600'
            : 'bg-slate-300'}"
        >
          <span
            class="absolute top-1 w-5 h-5 bg-white rounded-full shadow transition-transform duration-300 {isDark
              ? 'translate-x-[26px]'
              : 'translate-x-1'}"
          ></span>
        </button>
      </div>
    </section>

    <!-- ── NOTIFIKASI ────────────────────────────────────── -->
    <section>
      <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-3 px-1">
        NOTIFIKASI
      </span>
      <div
        class="border rounded-2xl overflow-hidden divide-y {isDark
          ? 'bg-slate-900 border-slate-800 divide-slate-800'
          : 'bg-white border-slate-200 divide-slate-100'}"
      >
        <!-- Artikel baru -->
        <div class="p-4 flex justify-between items-center gap-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
              <Newspaper class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
            </div>
            <div>
              <h4 class="text-sm font-bold">Artikel Baru</h4>
              <p class="text-[11px] {isDark ? 'text-slate-400' : 'text-slate-500'}">Artikel terbaru diterbitkan</p>
            </div>
          </div>
          <button
            onclick={() => toggleNotif('article')}
            aria-label="Toggle notifikasi artikel"
            aria-pressed={notifArticle}
            class="relative w-[52px] h-7 rounded-full flex-shrink-0 transition-colors duration-300 {notifArticle
              ? 'bg-blue-600'
              : isDark
                ? 'bg-slate-700'
                : 'bg-slate-300'}"
          >
            <span
              class="absolute top-1 w-5 h-5 bg-white rounded-full shadow transition-transform duration-300 {notifArticle
                ? 'translate-x-[26px]'
                : 'translate-x-1'}"
            ></span>
          </button>
        </div>

        <!-- Kuis baru -->
        <div class="p-4 flex justify-between items-center gap-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
              <Brain class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
            </div>
            <div>
              <h4 class="text-sm font-bold">Kuis Baru</h4>
              <p class="text-[11px] {isDark ? 'text-slate-400' : 'text-slate-500'}">Tantangan kuis tersedia</p>
            </div>
          </div>
          <button
            onclick={() => toggleNotif('quiz')}
            aria-label="Toggle notifikasi kuis"
            aria-pressed={notifQuiz}
            class="relative w-[52px] h-7 rounded-full flex-shrink-0 transition-colors duration-300 {notifQuiz
              ? 'bg-blue-600'
              : isDark
                ? 'bg-slate-700'
                : 'bg-slate-300'}"
          >
            <span
              class="absolute top-1 w-5 h-5 bg-white rounded-full shadow transition-transform duration-300 {notifQuiz
                ? 'translate-x-[26px]'
                : 'translate-x-1'}"
            ></span>
          </button>
        </div>

        <!-- Pencapaian -->
        <div class="p-4 flex justify-between items-center gap-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
              <Star class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
            </div>
            <div>
              <h4 class="text-sm font-bold">Pencapaian</h4>
              <p class="text-[11px] {isDark ? 'text-slate-400' : 'text-slate-500'}">Badge dan pencapaian baru</p>
            </div>
          </div>
          <button
            onclick={() => toggleNotif('achievement')}
            aria-label="Toggle notifikasi pencapaian"
            aria-pressed={notifAchievement}
            class="relative w-[52px] h-7 rounded-full flex-shrink-0 transition-colors duration-300 {notifAchievement
              ? 'bg-blue-600'
              : isDark
                ? 'bg-slate-700'
                : 'bg-slate-300'}"
          >
            <span
              class="absolute top-1 w-5 h-5 bg-white rounded-full shadow transition-transform duration-300 {notifAchievement
                ? 'translate-x-[26px]'
                : 'translate-x-1'}"
            ></span>
          </button>
        </div>

        <!-- Rangkuman mingguan -->
        <div class="p-4 flex justify-between items-center gap-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
              {#if notifWeeklyDigest}
                <Bell class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
              {:else}
                <BellOff class="w-4 h-4 {isDark ? 'text-slate-500' : 'text-slate-400'}" />
              {/if}
            </div>
            <div>
              <h4 class="text-sm font-bold">Rangkuman Mingguan</h4>
              <p class="text-[11px] {isDark ? 'text-slate-400' : 'text-slate-500'}">Kirim setiap Senin pagi</p>
            </div>
          </div>
          <button
            onclick={() => toggleNotif('weekly')}
            aria-label="Toggle rangkuman mingguan"
            aria-pressed={notifWeeklyDigest}
            class="relative w-[52px] h-7 rounded-full flex-shrink-0 transition-colors duration-300 {notifWeeklyDigest
              ? 'bg-blue-600'
              : isDark
                ? 'bg-slate-700'
                : 'bg-slate-300'}"
          >
            <span
              class="absolute top-1 w-5 h-5 bg-white rounded-full shadow transition-transform duration-300 {notifWeeklyDigest
                ? 'translate-x-[26px]'
                : 'translate-x-1'}"
            ></span>
          </button>
        </div>
      </div>
    </section>

    <!-- ── AKUN ──────────────────────────────────────────── -->
    <section>
      <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-3 px-1">
        AKUN
      </span>
      <div
        class="border rounded-2xl overflow-hidden divide-y {isDark
          ? 'bg-slate-900 border-slate-800 divide-slate-800'
          : 'bg-white border-slate-200 divide-slate-100'}"
      >
        <a
          href="/profile/edit"
          class="w-full p-4 flex items-center gap-3 text-sm font-bold transition-colors {isDark
            ? 'hover:bg-slate-800'
            : 'hover:bg-slate-50'}"
        >
          <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
            <User class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
          </div>
          <span class="flex-1">Edit Profil</span>
          <ChevronRight class="w-4 h-4 text-slate-400 flex-shrink-0" />
        </a>

        <a
          href="/settings/account-security"
          class="w-full p-4 flex items-center gap-3 text-sm font-bold transition-colors {isDark
            ? 'hover:bg-slate-800'
            : 'hover:bg-slate-50'}"
        >
          <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
            <Shield class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
          </div>
          <span class="flex-1">Akun & Keamanan</span>
          <ChevronRight class="w-4 h-4 text-slate-400 flex-shrink-0" />
        </a>

        <a
          href="/settings/change-password"
          class="w-full p-4 flex items-center gap-3 text-sm font-bold transition-colors {isDark
            ? 'hover:bg-slate-800'
            : 'hover:bg-slate-50'}"
        >
          <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
            <Lock class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
          </div>
          <span class="flex-1">Ubah Password</span>
          <ChevronRight class="w-4 h-4 text-slate-400 flex-shrink-0" />
        </a>
      </div>
    </section>

    <!-- ── TENTANG APLIKASI ──────────────────────────────── -->
    <section>
      <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-3 px-1">
        TENTANG APLIKASI
      </span>
      <div
        class="border rounded-2xl overflow-hidden divide-y {isDark
          ? 'bg-slate-900 border-slate-800 divide-slate-800'
          : 'bg-white border-slate-200 divide-slate-100'}"
      >
        <a
          href="/about"
          class="w-full p-4 flex items-center gap-3 text-sm font-bold transition-colors {isDark
            ? 'hover:bg-slate-800'
            : 'hover:bg-slate-50'}"
        >
          <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
            <Info class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
          </div>
          <span class="flex-1">Tentang Sekejap Fakta</span>
          <ChevronRight class="w-4 h-4 text-slate-400 flex-shrink-0" />
        </a>

        <a
          href="/privacy"
          class="w-full p-4 flex items-center gap-3 text-sm font-bold transition-colors {isDark
            ? 'hover:bg-slate-800'
            : 'hover:bg-slate-50'}"
        >
          <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
            <Shield class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
          </div>
          <span class="flex-1">Kebijakan Privasi</span>
          <ChevronRight class="w-4 h-4 text-slate-400 flex-shrink-0" />
        </a>

        <a
          href="/terms"
          class="w-full p-4 flex items-center gap-3 text-sm font-bold transition-colors {isDark
            ? 'hover:bg-slate-800'
            : 'hover:bg-slate-50'}"
        >
          <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
            <FileText class="w-4 h-4 {isDark ? 'text-slate-400' : 'text-slate-600'}" />
          </div>
          <span class="flex-1">Syarat & Ketentuan</span>
          <ChevronRight class="w-4 h-4 text-slate-400 flex-shrink-0" />
        </a>

        <!-- App version info -->
        <div class="p-4 flex items-center gap-3">
          <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
            <Info class="w-4 h-4 {isDark ? 'text-slate-600' : 'text-slate-400'}" />
          </div>
          <div class="flex-1">
            <span class="text-sm font-bold">Versi Aplikasi</span>
          </div>
          <span class="text-xs font-semibold {isDark ? 'text-slate-500' : 'text-slate-400'}">1.0.0</span>
        </div>

        <!-- Language -->
        <div class="p-4 flex items-center gap-3">
          <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-100'} flex items-center justify-center flex-shrink-0">
            <span class="text-xs font-black {isDark ? 'text-slate-400' : 'text-slate-600'}">ID</span>
          </div>
          <div class="flex-1">
            <span class="text-sm font-bold">Bahasa</span>
          </div>
          <span class="text-xs font-semibold {isDark ? 'text-slate-500' : 'text-slate-400'}">Indonesia</span>
        </div>
      </div>
    </section>

    <!-- ── KELUAR ─────────────────────────────────────────── -->
    <button
      onclick={() => (showLogout = true)}
      class="w-full p-4 rounded-2xl border flex items-center justify-center gap-2 font-bold text-sm transition-all active:scale-[0.98] {isDark
        ? 'bg-rose-950/20 border-rose-900/40 text-rose-400 hover:bg-rose-950/30'
        : 'bg-rose-50 border-rose-200 text-rose-600 hover:bg-rose-100'}"
    >
      <LogOut class="w-4 h-4" />
      Keluar dari Akun
    </button>

  </div>

  <LogoutModal open={showLogout} onClose={() => (showLogout = false)} />
</div>
