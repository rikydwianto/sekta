<script lang="ts">
  import { Bell, Settings, Edit3, BookOpen, Brain, Flame, ChevronRight, Bookmark, Star, HelpCircle, Clock, PenLine, ShieldCheck, Upload, Play, LayoutDashboard } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { getProfile, uploadVideo } from '$lib/api';
  import { app, updateUser } from '$lib/stores/app.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';
  import AvatarInitials from '$lib/components/AvatarInitials.svelte';
  import SkeletonLoader from '$lib/components/SkeletonLoader.svelte';

  let isDark = $derived(app.theme === 'dark');

  let tab = $state<'tersimpan' | 'kuis'>('tersimpan');

  let showUpload = $state(false);
  let vTitle = $state('');
  let vDesc = $state('');
  let vFile = $state<File | null>(null);
  let uploading = $state(false);
  let uploadError = $state('');

  async function handleUpload() {
    if (uploading) return;
    if (!vFile) { uploadError = 'Pilih file video dulu.'; return; }
    if (!vTitle.trim()) { uploadError = 'Judul wajib diisi.'; return; }
    uploadError = '';
    uploading = true;
    const ok = await uploadVideo({ file: vFile, title: vTitle.trim(), description: vDesc.trim() });
    uploading = false;
    if (ok) {
      vFile = null;
      vTitle = '';
      vDesc = '';
      showUpload = false;
    } else {
      uploadError = 'Gagal mengunggah video. Periksa koneksi dan coba lagi.';
    }
  }

  $effect(() => {
    getProfile().then((p) => {
      if (p) updateUser(p);
    });
  });

  // Reactive stats
  let savedCount = $derived(app.savedArticles.length);
  let quizCount = $derived(app.user.stats.quizzes);
  let streak = 7; // Static placeholder — real value would come from API
</script>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">

  <!-- ── Sticky Header ──────────────────────────────────── -->
  <PageHeader title="Profil" type="dashboard" showNotifications={true} showSettings={true} />

  <!-- ── Profile Identity Card ──────────────────────────── -->
  <div class="px-6 pt-5 pb-3">
    {#if app.user.name}
      <div class="border rounded-[1.75rem] p-5 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <div class="flex items-start gap-4 mb-4">
          <AvatarInitials src={app.user.avatar} name={app.user.name} size="xl" />
          <div class="flex-1 min-w-0 pt-1">
            <h2 class="text-lg font-black leading-tight truncate">{app.user.name || 'Pengguna'}</h2>
            <p class="text-sm font-semibold mb-3 {isDark ? 'text-slate-400' : 'text-slate-500'}">{app.user.username || '@pengguna'}</p>
            {#if app.user.bio}
              <p class="text-xs leading-relaxed mb-3 {isDark ? 'text-slate-400' : 'text-slate-600'}">{app.user.bio}</p>
            {/if}
            <button
              onclick={() => goto('/profile/edit')}
              class="flex items-center gap-1.5 px-3.5 py-2 rounded-xl border text-xs font-bold transition-all active:scale-95 {isDark ? 'bg-slate-800 border-slate-700 text-slate-200 hover:bg-slate-700' : 'bg-slate-100 border-slate-200 text-slate-700 hover:bg-slate-200'}"
            >
              <Edit3 class="w-3 h-3" />
              Edit Profil
            </button>
          </div>
        </div>

        <!-- Stats row -->
        <div class="grid grid-cols-3 gap-2 pt-4 border-t {isDark ? 'border-slate-800' : 'border-slate-100'}">
          <div class="flex flex-col items-center gap-1 py-2 px-1 rounded-xl {isDark ? 'bg-slate-800/60' : 'bg-slate-50'}">
            <Bookmark class="w-4 h-4 {isDark ? 'text-blue-400' : 'text-blue-600'}" />
            <span class="text-lg font-black leading-none">{savedCount}</span>
            <span class="text-[10px] font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">Disimpan</span>
          </div>
          <div class="flex flex-col items-center gap-1 py-2 px-1 rounded-xl {isDark ? 'bg-slate-800/60' : 'bg-slate-50'}">
            <Brain class="w-4 h-4 {isDark ? 'text-purple-400' : 'text-purple-600'}" />
            <span class="text-lg font-black leading-none">{quizCount}</span>
            <span class="text-[10px] font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">Kuis</span>
          </div>
          <div class="flex flex-col items-center gap-1 py-2 px-1 rounded-xl {isDark ? 'bg-slate-800/60' : 'bg-slate-50'}">
            <Flame class="w-4 h-4 {isDark ? 'text-orange-400' : 'text-orange-500'}" />
            <span class="text-lg font-black leading-none">{streak}</span>
            <span class="text-[10px] font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">Hari 🔥</span>
          </div>
        </div>
      </div>
    {:else}
      <div class="border rounded-[1.75rem] p-5 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <div class="flex items-start gap-4 mb-4">
          <SkeletonLoader type="avatar" />
          <div class="flex-1">
            <SkeletonLoader type="heading" width="w-3/4" height="h-5" class="mb-3" />
            <SkeletonLoader type="text" width="w-1/2" height="h-4" />
          </div>
        </div>
        <div class="grid grid-cols-3 gap-2 pt-4 border-t {isDark ? 'border-slate-800' : 'border-slate-100'}">
          {#each Array(3) as _}
            <div class="py-2 px-1">
              <SkeletonLoader type="text" width="w-full" height="h-5" />
            </div>
          {/each}
        </div>
      </div>
    {/if}
  </div>

  <!-- ── Quick Action Cards ────────────────────────────── -->
  <div class="px-6 pb-4">
    <div class="grid grid-cols-2 gap-2">
      <button
        onclick={() => goto('/quiz')}
        class="flex items-center gap-3 p-3.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'bg-purple-950/30 border-purple-900/50 hover:bg-purple-950/50' : 'bg-purple-50 border-purple-100 hover:bg-purple-100'}"
      >
        <div class="w-8 h-8 rounded-xl bg-purple-600 flex items-center justify-center flex-shrink-0">
          <Brain class="w-4 h-4 text-white" />
        </div>
        <div class="text-left">
          <p class="text-xs font-black {isDark ? 'text-purple-200' : 'text-purple-900'}">Main Kuis</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-purple-300/70' : 'text-purple-600'}">Uji pengetahuanmu</p>
        </div>
      </button>

      <button
        onclick={() => goto('/explore')}
        class="flex items-center gap-3 p-3.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'bg-blue-950/30 border-blue-900/50 hover:bg-blue-950/50' : 'bg-blue-50 border-blue-100 hover:bg-blue-100'}"
      >
        <div class="w-8 h-8 rounded-xl bg-blue-600 flex items-center justify-center flex-shrink-0">
          <BookOpen class="w-4 h-4 text-white" />
        </div>
        <div class="text-left">
          <p class="text-xs font-black {isDark ? 'text-blue-200' : 'text-blue-900'}">Jelajahi</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-blue-300/70' : 'text-blue-600'}">Baca artikel baru</p>
        </div>
      </button>

      <button
        onclick={() => goto('/tulis')}
        class="flex items-center gap-3 p-3.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'bg-emerald-950/30 border-emerald-900/50 hover:bg-emerald-950/50' : 'bg-emerald-50 border-emerald-100 hover:bg-emerald-100'}"
      >
        <div class="w-8 h-8 rounded-xl bg-emerald-600 flex items-center justify-center flex-shrink-0">
          <PenLine class="w-4 h-4 text-white" />
        </div>
        <div class="text-left">
          <p class="text-xs font-black {isDark ? 'text-emerald-200' : 'text-emerald-900'}">Tulis Artikel</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-emerald-300/70' : 'text-emerald-600'}">Kirim, tunggu persetujuan</p>
        </div>
      </button>

      <button
        onclick={() => (showUpload = !showUpload)}
        class="flex items-center gap-3 p-3.5 rounded-2xl border transition-all active:scale-95 {showUpload ? 'ring-2 ring-rose-500' : ''} {isDark ? 'bg-rose-950/30 border-rose-900/50 hover:bg-rose-950/50' : 'bg-rose-50 border-rose-100 hover:bg-rose-100'}"
      >
        <div class="w-8 h-8 rounded-xl bg-rose-600 flex items-center justify-center flex-shrink-0">
          <Upload class="w-4 h-4 text-white" />
        </div>
        <div class="text-left">
          <p class="text-xs font-black {isDark ? 'text-rose-200' : 'text-rose-900'}">Unggah Video</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-rose-300/70' : 'text-rose-600'}">Bagikan video-mu</p>
        </div>
      </button>

      <button
        onclick={() => goto('/kelola')}
        class="flex items-center gap-3 p-3.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'bg-cyan-950/30 border-cyan-900/50 hover:bg-cyan-950/50' : 'bg-cyan-50 border-cyan-100 hover:bg-cyan-100'}"
      >
        <div class="w-8 h-8 rounded-xl bg-cyan-600 flex items-center justify-center flex-shrink-0">
          <LayoutDashboard class="w-4 h-4 text-white" />
        </div>
        <div class="text-left">
          <p class="text-xs font-black {isDark ? 'text-cyan-200' : 'text-cyan-900'}">Kelola Konten</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-cyan-300/70' : 'text-cyan-600'}">Artikel & video buatanmu</p>
        </div>
      </button>

      {#if app.user.role === 'ADMIN'}
        <button
          onclick={() => goto('/admin')}
          class="flex items-center gap-3 p-3.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'bg-slate-800/60 border-slate-700 hover:bg-slate-800' : 'bg-slate-100 border-slate-200 hover:bg-slate-200'}"
        >
          <div class="w-8 h-8 rounded-xl bg-slate-600 flex items-center justify-center flex-shrink-0">
            <ShieldCheck class="w-4 h-4 text-white" />
          </div>
          <div class="text-left">
            <p class="text-xs font-black {isDark ? 'text-slate-200' : 'text-slate-800'}">Kelola Artikel</p>
            <p class="text-[10px] font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">Setujui kiriman user</p>
          </div>
        </button>
      {/if}
    </div>

    {#if showUpload}
      <div class="mt-3 border rounded-2xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <p class="text-xs font-black uppercase tracking-widest mb-3 {isDark ? 'text-slate-500' : 'text-slate-500'}">Unggah Video</p>
        <div class="space-y-2">
          <input
            bind:value={vTitle}
            placeholder="Judul video"
            class="w-full px-4 py-3 rounded-2xl border text-sm font-bold outline-none focus:ring-2 focus:ring-blue-500 {isDark ? 'bg-slate-950 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
          />
          <input
            bind:value={vDesc}
            placeholder="Deskripsi (opsional)"
            class="w-full px-4 py-3 rounded-2xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 {isDark ? 'bg-slate-950 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
          />
          <label
            class="flex items-center justify-center gap-2 py-4 rounded-2xl border-dashed border cursor-pointer transition-colors {isDark ? 'border-slate-700 text-slate-400 hover:bg-slate-950' : 'border-slate-300 text-slate-500 hover:bg-slate-50'}"
          >
            {#if vFile}
              <Play class="w-5 h-5 text-blue-500" />
              <span class="text-xs font-bold text-blue-500 truncate">{vFile.name}</span>
            {:else}
              <Upload class="w-5 h-5" />
              <span class="text-xs font-bold">Pilih file video</span>
            {/if}
            <input type="file" accept="video/*" class="hidden" onchange={(e) => (vFile = e.currentTarget.files?.[0] ?? null)} />
          </label>
          {#if uploadError}
            <p class="text-xs font-bold text-red-500">{uploadError}</p>
          {/if}
          <button
            onclick={handleUpload}
            disabled={uploading}
            class="w-full py-3 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-sm transition-all active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
          >
            {#if uploading}
              <div class="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
              Mengunggah...
            {:else}
              <Upload class="w-4 h-4" />
              Unggah Video
            {/if}
          </button>
        </div>
      </div>
    {/if}
  </div>

  <!-- ── Tab Navigation ─────────────────────────────────── -->
  <div class="px-6 pb-4">
    <div class="flex p-1 rounded-2xl border {isDark ? 'bg-slate-900 border-slate-800' : 'bg-slate-100 border-slate-200'}">
      <button
        onclick={() => (tab = 'tersimpan')}
        class="flex-1 py-2.5 text-xs font-bold rounded-xl transition-all flex items-center justify-center gap-1.5 {tab === 'tersimpan' ? 'bg-blue-600 text-white shadow-sm' : isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-800'}"
      >
        <Bookmark class="w-3.5 h-3.5" />
        Tersimpan ({savedCount})
      </button>
      <button
        onclick={() => (tab = 'kuis')}
        class="flex-1 py-2.5 text-xs font-bold rounded-xl transition-all flex items-center justify-center gap-1.5 {tab === 'kuis' ? 'bg-blue-600 text-white shadow-sm' : isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-800'}"
      >
        <HelpCircle class="w-3.5 h-3.5" />
        Kuis ({quizCount})
      </button>
    </div>
  </div>

  <!-- ── Tab Content ────────────────────────────────────── -->
  <div class="px-6 space-y-3">
    {#if tab === 'tersimpan'}
      {#if app.savedArticles.length > 0}
        {#each app.savedArticles as art}
          <a
            href={`/article/${art.slug}`}
            class="border rounded-2xl flex items-center gap-3 p-3.5 transition-all card-hover {isDark ? 'bg-slate-900 border-slate-800 hover:bg-slate-800' : 'bg-white border-slate-200 hover:bg-slate-50'}"
          >
            <CoverImage image={art.image} class="w-14 h-14 rounded-xl flex-shrink-0" />
            <div class="flex-1 min-w-0">
              <span class="text-[10px] font-black text-blue-500 uppercase tracking-wide">{art.category}</span>
              <h4 class="text-sm font-bold leading-snug line-clamp-2 {isDark ? 'text-slate-100' : 'text-slate-800'}">{art.title}</h4>
              {#if art.readTime}
                <p class="text-[11px] font-medium mt-0.5 flex items-center gap-1 {isDark ? 'text-slate-500' : 'text-slate-400'}">
                  <Clock class="w-3 h-3" />
                  {art.readTime}
                </p>
              {/if}
            </div>
            <ChevronRight class="w-4 h-4 flex-shrink-0 {isDark ? 'text-slate-600' : 'text-slate-300'}" />
          </a>
        {/each}
      {:else}
        <!-- Saved empty state -->
        <div class="flex flex-col items-center justify-center py-12 text-center">
          <div class="w-16 h-16 rounded-2xl mb-4 flex items-center justify-center {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
            <Bookmark class="w-7 h-7 {isDark ? 'text-slate-600' : 'text-slate-400'}" />
          </div>
          <p class="text-sm font-bold mb-1 {isDark ? 'text-slate-400' : 'text-slate-600'}">Belum ada artikel tersimpan</p>
          <p class="text-xs mb-4 {isDark ? 'text-slate-600' : 'text-slate-400'}">Simpan artikel menarik untuk dibaca nanti.</p>
          <button
            onclick={() => goto('/explore')}
            class="px-5 py-2.5 bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold rounded-xl transition-all active:scale-95 shadow-md shadow-blue-600/20"
          >
            Jelajahi Artikel
          </button>
        </div>
      {/if}

    {:else}
      <!-- Quiz tab -->
      {#if quizCount > 0}
        <div class="border rounded-2xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <div class="flex items-center gap-3 mb-4">
            <div class="w-10 h-10 rounded-2xl bg-purple-600 flex items-center justify-center flex-shrink-0">
              <Star class="w-5 h-5 text-white" />
            </div>
            <div>
              <p class="text-sm font-black">Ringkasan Kuis</p>
              <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-500'}">{quizCount} kuis diselesaikan</p>
            </div>
          </div>

          <!-- Score stats grid -->
          <div class="grid grid-cols-2 gap-3 mb-4">
            <div class="border rounded-xl p-3 {isDark ? 'border-slate-700 bg-slate-800' : 'border-slate-100 bg-slate-50'}">
              <div class="text-lg font-black text-purple-500">{quizCount}</div>
              <div class="text-[11px] font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">Total Kuis</div>
            </div>
            <div class="border rounded-xl p-3 {isDark ? 'border-slate-700 bg-slate-800' : 'border-slate-100 bg-slate-50'}">
              <div class="text-lg font-black text-emerald-500">85%</div>
              <div class="text-[11px] font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">Rata-rata Skor</div>
            </div>
          </div>

          <!-- Score progress bar -->
          <div class="space-y-1.5">
            <div class="flex justify-between text-xs font-bold">
              <span class="{isDark ? 'text-slate-400' : 'text-slate-600'}">Skor Rata-rata</span>
              <span class="text-purple-500">85%</span>
            </div>
            <div class="h-2 rounded-full overflow-hidden {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
              <div class="h-full w-[85%] bg-purple-600 rounded-full"></div>
            </div>
          </div>
        </div>

        <button
          onclick={() => goto('/quiz')}
          class="w-full flex items-center justify-center gap-2 py-3.5 rounded-2xl border font-bold text-sm transition-all active:scale-95 {isDark ? 'bg-slate-900 border-slate-800 text-slate-200 hover:bg-slate-800' : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'}"
        >
          <Brain class="w-4 h-4" />
          Main Kuis Lagi
        </button>

      {:else}
        <!-- Quiz empty state -->
        <div class="flex flex-col items-center justify-center py-12 text-center">
          <div class="w-16 h-16 rounded-2xl mb-4 flex items-center justify-center {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
            <Brain class="w-7 h-7 {isDark ? 'text-slate-600' : 'text-slate-400'}" />
          </div>
          <p class="text-sm font-bold mb-1 {isDark ? 'text-slate-400' : 'text-slate-600'}">Belum ada riwayat kuis</p>
          <p class="text-xs mb-4 {isDark ? 'text-slate-600' : 'text-slate-400'}">Coba kuis pertamamu sekarang!</p>
          <button
            onclick={() => goto('/quiz')}
            class="px-5 py-2.5 bg-purple-600 hover:bg-purple-500 text-white text-xs font-bold rounded-xl transition-all active:scale-95 shadow-md shadow-purple-600/20"
          >
            Mulai Kuis
          </button>
        </div>
      {/if}
    {/if}
  </div>

</div>
