<script lang="ts">
  import { ArrowLeft, Zap, CheckCircle2, AlertCircle } from '@lucide/svelte';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');

  let email = $state('');
  let error = $state('');
  let success = $state(false);
  let loading = $state(false);

  import { supabase } from '$lib/supabase';

  async function handleReset() {
    error = '';
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      error = 'Format email tidak valid.';
      return;
    }
    loading = true;
    const { error: authError } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/login`
    });
    loading = false;
    if (authError) {
      error = authError.message;
      return;
    }
    success = true;
  }
</script>

<div class="min-h-full flex flex-col transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">

  <!-- Top bar: back to login -->
  <div class="flex items-center justify-between px-6 pt-10 pb-2">
    <a
      href="/login"
      class="flex items-center gap-1.5 text-xs font-bold transition-colors {isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-500 hover:text-slate-800'}"
    >
      <ArrowLeft class="w-4 h-4" />
      Kembali ke Login
    </a>
    <a
      href="/"
      class="px-4 py-2 rounded-full border text-xs font-bold transition-all active:scale-95 {isDark
        ? 'border-slate-700 text-slate-300 hover:bg-slate-800'
        : 'border-slate-200 text-slate-600 hover:bg-slate-100'}"
    >
      Beranda →
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
      Lupa password? 🔑<br />Tenang, kami bantu!
    </h1>
    <p class="text-sm font-medium {isDark ? 'text-slate-400' : 'text-slate-500'}">
      Masukkan email akun kamu. Kami kirimkan link untuk atur ulang password.
    </p>
  </div>

  <!-- Form -->
  <div class="px-6 flex-1">

    {#if success}
      <!-- Success state -->
      <div class="border rounded-2xl p-5 mb-6 {isDark ? 'border-emerald-900/50 bg-emerald-950/30' : 'border-emerald-200 bg-emerald-50'}">
        <div class="flex items-start gap-3">
          <CheckCircle2 class="w-5 h-5 mt-0.5 flex-shrink-0 {isDark ? 'text-emerald-400' : 'text-emerald-600'}" />
          <div>
            <p class="text-sm font-bold mb-1 {isDark ? 'text-emerald-200' : 'text-emerald-800'}">
              Link reset terkirim!
            </p>
            <p class="text-xs font-medium {isDark ? 'text-emerald-300/80' : 'text-emerald-700'}">
              Cek inbox email kamu dan klik link yang kami kirimkan. Jangan lupa cek folder spam jika tidak masuk.
            </p>
          </div>
        </div>
      </div>
    {:else}
      <div class="space-y-4 mb-5">
        <div>
          <label for="forgot-email" class="block text-xs font-bold mb-1.5 {isDark ? 'text-slate-400' : 'text-slate-600'}">Email</label>
          <input
            id="forgot-email"
            type="email"
            bind:value={email}
            placeholder="nama@email.com"
            class="w-full border rounded-2xl px-4 py-3.5 font-medium focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20 transition-all {isDark
              ? 'bg-[#141720] border-slate-800 text-slate-100 placeholder:text-slate-600'
              : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
          />
        </div>

        {#if error}
          <div class="border p-3 rounded-2xl flex items-center text-xs font-semibold {isDark ? 'bg-rose-950/30 border-rose-900/50 text-rose-200' : 'bg-rose-50 border-rose-200 text-rose-600'}">
            <AlertCircle class="w-4 h-4 mr-2 flex-shrink-0" /> {error}
          </div>
        {/if}
      </div>

      <!-- Submit button -->
      <button
        onclick={handleReset}
        disabled={loading}
        class="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-2xl py-3.5 mb-5 transition-all shadow-lg shadow-blue-600/30 active:scale-95 flex items-center justify-center disabled:opacity-60 disabled:cursor-not-allowed"
      >
        {loading ? 'Mengirim...' : 'Kirim Link Reset'}
      </button>
    {/if}

    <!-- Guest CTA -->
    <div class="border rounded-2xl p-4 mb-6 {isDark ? 'border-slate-800 bg-slate-900/50' : 'border-slate-100 bg-slate-50'}">
      <p class="text-xs font-semibold mb-2 {isDark ? 'text-slate-400' : 'text-slate-500'}">
        Belum mau masuk? Kamu tetap bisa menjelajahi konten tanpa akun.
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
      Ingat passwordnya?{' '}
      <a href="/login" class="text-blue-600 font-bold hover:text-blue-500 transition-colors">Masuk</a>
      {' '}·{' '}
      <a href="/signup" class="text-blue-600 font-bold hover:text-blue-500 transition-colors">Daftar gratis</a>
    </p>
  </div>

</div>
