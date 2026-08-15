<script lang="ts">
  import { AlertCircle, ArrowLeft, Zap } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { page } from '$app/state';
  import { supabase } from '$lib/supabase';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');

  let redirect = $derived(page.url.searchParams.get('redirect') ?? '/');

  let email = $state('');
  let password = $state('');
  let error = $state('');
  let loading = $state(false);
  let googleLoading = $state(false);

  $effect(() => {
    const stored = sessionStorage.getItem('sekta-auth-error');
    if (stored) {
      error = stored;
      sessionStorage.removeItem('sekta-auth-error');
    }
  });

  $effect(() => {
    if (!page.url.searchParams.has('redirect')) {
      sessionStorage.removeItem('sekta-redirect');
    }
    if (app.isLoggedIn) {
      goto(redirect);
    }
  });

  async function handleLogin() {
    error = '';
    loading = true;
    sessionStorage.setItem('sekta-redirect', redirect);
    const { error: authError } = await supabase.auth.signInWithPassword({ email, password });
    loading = false;
    if (authError) {
      sessionStorage.removeItem('sekta-redirect');
      error = authError.message;
      return;
    }
  }

  async function handleGoogle() {
    if (googleLoading) return;
    googleLoading = true;
    error = '';
    sessionStorage.setItem('sekta-redirect', redirect);
    const { error: authError } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: { redirectTo: window.location.origin }
    });
    googleLoading = false;
    if (authError) error = authError.message;
  }
</script>

<div class="min-h-full flex flex-col transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">

  <!-- Top bar: back to homepage -->
  <div class="flex items-center justify-between px-6 pt-10 pb-2">
    <a
      href="/"
      class="flex items-center gap-1.5 text-xs font-bold transition-colors {isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-500 hover:text-slate-800'}"
    >
      <ArrowLeft class="w-4 h-4" />
      Beranda
    </a>
    <a
      href="/"
      class="px-4 py-2 rounded-full border text-xs font-bold transition-all active:scale-95 {isDark
        ? 'border-slate-700 text-slate-300 hover:bg-slate-800'
        : 'border-slate-200 text-slate-600 hover:bg-slate-100'}"
    >
      Jelajahi dulu →
    </a>
  </div>

  <!-- Brand header -->
  <div class="px-6 pt-6 pb-8">
    <div class="flex items-center gap-2 mb-4">
      <div class="w-9 h-9 rounded-xl bg-blue-600 flex items-center justify-center flex-shrink-0">
        <Zap class="w-5 h-5 text-white" />
      </div>
      <span class="text-base font-black tracking-tight">Sekejap Fakta</span>
    </div>
    <h1 class="text-[28px] font-black tracking-tight leading-tight mb-2">
      Selamat datang<br />kembali! 👋
    </h1>
    <p class="text-sm font-medium {isDark ? 'text-slate-400' : 'text-slate-500'}">
      Lanjutkan eksplorasi fakta dan kuis seru.
    </p>
  </div>

  <!-- Form -->
  <div class="px-6 flex-1">
    <div class="space-y-4 mb-5">
      <div>
        <label for="login-email" class="block text-xs font-bold mb-1.5 {isDark ? 'text-slate-400' : 'text-slate-600'}">Email</label>
        <input
          id="login-email"
          type="email"
          bind:value={email}
          placeholder="nama@email.com"
          class="w-full border rounded-2xl px-4 py-3.5 font-medium focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20 transition-all {isDark
            ? 'bg-[#141720] border-slate-800 text-slate-100 placeholder:text-slate-600'
            : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
        />
      </div>
      <div>
        <div class="flex justify-between items-center mb-1.5">
          <label for="login-password" class="block text-xs font-bold {isDark ? 'text-slate-400' : 'text-slate-600'}">Password</label>
          <a href="/forgot-password" class="text-xs font-bold text-blue-600 hover:text-blue-500 transition-colors">
            Lupa password?
          </a>
        </div>
        <input
          id="login-password"
          type="password"
          bind:value={password}
          class="w-full border rounded-2xl px-4 py-3.5 font-medium focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20 transition-all {isDark
            ? 'bg-[#141720] border-slate-800 text-slate-100'
            : 'bg-white border-slate-200 text-slate-900'}"
        />
      </div>

      {#if error}
        <div class="border p-3 rounded-2xl flex items-center text-xs font-semibold {isDark ? 'bg-rose-950/30 border-rose-900/50 text-rose-200' : 'bg-rose-50 border-rose-200 text-rose-600'}">
          <AlertCircle class="w-4 h-4 mr-2 flex-shrink-0" /> {error}
        </div>
      {/if}
    </div>

    <!-- Login button -->
    <button
      onclick={handleLogin}
      disabled={loading}
      class="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-2xl py-3.5 mb-5 transition-all shadow-lg shadow-blue-600/30 active:scale-95 flex items-center justify-center disabled:opacity-60 disabled:cursor-not-allowed"
    >
      {loading ? 'Memproses...' : 'Masuk'}
    </button>

    <!-- Divider -->
    <div class="flex items-center mb-5">
      <div class="flex-1 h-px {isDark ? 'bg-slate-800' : 'bg-slate-200'}"></div>
      <span class="px-3 text-[11px] font-semibold uppercase tracking-wider {isDark ? 'text-slate-500' : 'text-slate-400'}">atau</span>
      <div class="flex-1 h-px {isDark ? 'bg-slate-800' : 'bg-slate-200'}"></div>
    </div>

    <!-- Google button -->
    <button
      onclick={handleGoogle}
      disabled={googleLoading}
      class="flex items-center justify-center w-full border rounded-2xl py-3.5 px-4 font-bold mb-6 transition-all active:scale-95 disabled:opacity-60 disabled:cursor-not-allowed {isDark
        ? 'bg-[#141720] border-slate-800 hover:bg-slate-800 text-slate-200'
        : 'bg-white border-slate-200 hover:bg-slate-50 text-slate-800'}"
    >
      <svg class="w-5 h-5 mr-3" viewBox="0 0 24 24">
        <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4" />
        <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853" />
        <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05" />
        <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335" />
      </svg>
      Lanjut dengan Google
    </button>

    <!-- Guest CTA -->
    <div class="border rounded-2xl p-4 mb-6 {isDark ? 'border-slate-800 bg-slate-900/50' : 'border-slate-100 bg-slate-50'}">
      <p class="text-xs font-semibold mb-2 {isDark ? 'text-slate-400' : 'text-slate-500'}">
        Belum mau daftar? Kamu tetap bisa menjelajahi konten tanpa akun.
      </p>
      <a
        href="/"
        class="inline-flex items-center gap-1.5 text-xs font-bold text-blue-600 hover:text-blue-500 transition-colors"
      >
        <Zap class="w-3.5 h-3.5" />
        Jelajahi sebagai tamu →
      </a>
    </div>
  </div>

  <!-- Footer -->
  <div class="px-6 pb-8 pt-2">
    <p class="text-center text-xs font-medium {isDark ? 'text-slate-400' : 'text-slate-500'}">
      Belum punya akun?{' '}
      <a href="/signup" class="text-blue-600 font-bold hover:text-blue-500 transition-colors">Daftar gratis</a>
    </p>
  </div>

</div>
