<script lang="ts">
  import { FileText, Video, PenLine, Trash2, Eye, AlertTriangle } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { app } from '$lib/stores/app.svelte';
  import { getMyArticles, getMyVideos, deleteArticle, deleteVideo } from '$lib/api';
  import type { Article, VideoItem } from '$lib/types';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';
  import SkeletonLoader from '$lib/components/SkeletonLoader.svelte';

  let isDark = $derived(app.theme === 'dark');

  let tab = $state<'artikel' | 'video'>('artikel');
  let articles = $state<Article[]>([]);
  let videos = $state<VideoItem[]>([]);
  let loading = $state(true);
  let confirmTarget = $state<{ kind: 'artikel' | 'video'; id: number; title: string } | null>(null);
  let busy = $state(false);
  let error = $state('');

  const STATUS_META: Record<string, { label: string; cls: string }> = {
    PUBLISHED: { label: 'Tayang', cls: 'text-emerald-500 bg-emerald-500/10' },
    SUBMITTED: { label: 'Menunggu', cls: 'text-amber-500 bg-amber-500/10' },
    REJECTED: { label: 'Ditolak', cls: 'text-red-500 bg-red-500/10' },
    DRAFT: { label: 'Draf', cls: 'text-slate-500 bg-slate-500/10' }
  };

  $effect(() => {
    Promise.all([getMyArticles(), getMyVideos()]).then(([a, v]) => {
      articles = a;
      videos = v;
      loading = false;
    });
  });

  function isEditable(art: Article): boolean {
    return art.status !== 'PUBLISHED';
  }

  async function confirmDelete() {
    if (!confirmTarget || busy) return;
    busy = true;
    error = '';
    const ok = confirmTarget.kind === 'artikel'
      ? await deleteArticle(confirmTarget.id)
      : await deleteVideo(confirmTarget.id);
    busy = false;
    if (ok) {
      if (confirmTarget.kind === 'artikel') articles = articles.filter((a) => a.id !== confirmTarget!.id);
      else videos = videos.filter((v) => v.id !== confirmTarget!.id);
      confirmTarget = null;
    } else {
      error = 'Gagal menghapus. Coba lagi.';
    }
  }
</script>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">
  <PageHeader title="Kelola Konten" type="page" />

  <!-- Tab Artikel / Video -->
  <div class="px-6 pt-4 pb-3">
    <div class="flex p-1 rounded-2xl border {isDark ? 'bg-slate-900 border-slate-800' : 'bg-slate-100 border-slate-200'}">
      <button
        onclick={() => (tab = 'artikel')}
        class="flex-1 py-2.5 text-xs font-bold rounded-xl transition-all flex items-center justify-center gap-1.5 {tab === 'artikel' ? 'bg-blue-600 text-white shadow-sm' : isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-800'}"
      >
        <FileText class="w-3.5 h-3.5" />
        Artikel ({articles.length})
      </button>
      <button
        onclick={() => (tab = 'video')}
        class="flex-1 py-2.5 text-xs font-bold rounded-xl transition-all flex items-center justify-center gap-1.5 {tab === 'video' ? 'bg-blue-600 text-white shadow-sm' : isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-800'}"
      >
        <Video class="w-3.5 h-3.5" />
        Video ({videos.length})
      </button>
    </div>
  </div>

  <div class="px-6 space-y-3">
    {#if error}
      <p class="text-xs font-bold text-red-500">{error}</p>
    {/if}

    {#if loading}
      {#each Array(3) as _}
        <div class="border rounded-2xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <div class="flex gap-3">
            <SkeletonLoader type="image" width="w-24" height="h-16" />
            <div class="flex-1 space-y-2">
              <SkeletonLoader type="heading" width="w-3/4" height="h-4" />
              <SkeletonLoader type="text" width="w-1/3" height="h-3" />
            </div>
          </div>
        </div>
      {/each}
    {:else if tab === 'artikel'}
      {#if articles.length === 0}
        <div class="flex flex-col items-center text-center py-12">
          <div class="w-14 h-14 rounded-2xl bg-blue-500/10 flex items-center justify-center mb-3">
            <PenLine class="w-6 h-6 text-blue-500" />
          </div>
          <p class="text-sm font-black mb-1">Belum ada artikel</p>
          <p class="text-xs mb-4 {isDark ? 'text-slate-400' : 'text-slate-500'}">Tulis artikel pertamamu dan kelola di sini.</p>
          <button
            onclick={() => goto('/tulis')}
            class="px-5 py-2.5 bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold rounded-xl transition-all active:scale-95"
          >
            Tulis Artikel
          </button>
        </div>
      {:else}
        {#each articles as art}
          <div class="border rounded-2xl overflow-hidden {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
            <div class="flex gap-3 p-3.5">
              <div class="w-24 h-16 rounded-xl overflow-hidden flex-shrink-0">
                <CoverImage image={art.image} class="w-full h-full object-cover" />
              </div>
              <div class="flex-1 min-w-0">
                <div class="flex items-center gap-2 mb-1">
                  <span class="text-[10px] font-black uppercase px-2 py-0.5 rounded-full {STATUS_META[art.status ?? '']?.cls ?? 'text-slate-500 bg-slate-500/10'}">
                    {STATUS_META[art.status ?? '']?.label ?? art.status}
                  </span>
                  <span class="text-[10px] font-bold {isDark ? 'text-slate-500' : 'text-slate-400'}">{art.date}</span>
                </div>
                <p class="text-sm font-black line-clamp-2 leading-tight">{art.title}</p>
                <p class="text-[11px] mt-1 line-clamp-1 {isDark ? 'text-slate-400' : 'text-slate-500'}">{art.excerpt || 'Tanpa ringkasan'}</p>
              </div>
            </div>
            <div class="flex border-t {isDark ? 'border-slate-800' : 'border-slate-100'}">
              {#if art.status === 'PUBLISHED'}
                <a
                  href={`/article/${art.slug}`}
                  class="flex-1 flex items-center justify-center gap-1.5 py-2.5 text-xs font-bold {isDark ? 'text-slate-300 hover:bg-slate-800' : 'text-slate-600 hover:bg-slate-50'}"
                >
                  <Eye class="w-3.5 h-3.5" />
                  Lihat
                </a>
              {:else}
                <button
                  onclick={() => goto(`/tulis?edit=${art.id}`)}
                  class="flex-1 flex items-center justify-center gap-1.5 py-2.5 text-xs font-bold {isDark ? 'text-blue-400 hover:bg-slate-800' : 'text-blue-600 hover:bg-slate-50'}"
                >
                  <PenLine class="w-3.5 h-3.5" />
                  Edit
                </button>
                <span class="w-px {isDark ? 'bg-slate-800' : 'bg-slate-100'}"></span>
                <button
                  onclick={() => (confirmTarget = { kind: 'artikel', id: art.id, title: art.title })}
                  class="flex-1 flex items-center justify-center gap-1.5 py-2.5 text-xs font-bold {isDark ? 'text-red-400 hover:bg-slate-800' : 'text-red-500 hover:bg-slate-50'}"
                >
                  <Trash2 class="w-3.5 h-3.5" />
                  Hapus
                </button>
              {/if}
            </div>
          </div>
        {/each}
        {#if articles.some((a) => a.status === 'PUBLISHED')}
          <p class="text-[10px] text-center {isDark ? 'text-slate-600' : 'text-slate-400'}">
            Artikel yang sudah tayang tidak bisa diedit atau dihapus.
          </p>
        {/if}
      {/if}
    {:else}
      {#if videos.length === 0}
        <div class="flex flex-col items-center text-center py-12">
          <div class="w-14 h-14 rounded-2xl bg-rose-500/10 flex items-center justify-center mb-3">
            <Video class="w-6 h-6 text-rose-500" />
          </div>
          <p class="text-sm font-black mb-1">Belum ada video</p>
          <p class="text-xs mb-4 {isDark ? 'text-slate-400' : 'text-slate-500'}">Unggah video pertamamu dari halaman profil.</p>
          <button
            onclick={() => goto('/profile')}
            class="px-5 py-2.5 bg-rose-600 hover:bg-rose-500 text-white text-xs font-bold rounded-xl transition-all active:scale-95"
          >
            Unggah Video
          </button>
        </div>
      {:else}
        {#each videos as vid}
          <div class="border rounded-2xl overflow-hidden {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
            <div class="flex items-center gap-3 p-3.5">
              <div class="w-10 h-10 rounded-xl bg-rose-500/10 flex items-center justify-center flex-shrink-0">
                <Video class="w-5 h-5 text-rose-500" />
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-black truncate">{vid.title}</p>
                <p class="text-[11px] {isDark ? 'text-slate-400' : 'text-slate-500'}">{vid.createdAt || 'Baru saja'}</p>
              </div>
            </div>
            <div class="flex border-t {isDark ? 'border-slate-800' : 'border-slate-100'}">
              <button
                onclick={() => (confirmTarget = { kind: 'video', id: vid.id, title: vid.title })}
                class="flex-1 flex items-center justify-center gap-1.5 py-2.5 text-xs font-bold {isDark ? 'text-red-400 hover:bg-slate-800' : 'text-red-500 hover:bg-slate-50'}"
              >
                <Trash2 class="w-3.5 h-3.5" />
                Hapus
              </button>
            </div>
          </div>
        {/each}
      {/if}
    {/if}
  </div>

  <!-- Konfirmasi Hapus -->
  {#if confirmTarget}
    <div class="fixed inset-0 z-50 flex items-center justify-center p-6 bg-black/50">
      <div class="w-full max-w-sm rounded-3xl p-5 {isDark ? 'bg-slate-900 border border-slate-800' : 'bg-white border border-slate-200'}">
        <div class="flex items-center gap-3 mb-3">
          <div class="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center flex-shrink-0">
            <AlertTriangle class="w-5 h-5 text-red-500" />
          </div>
          <div>
            <h3 class="text-sm font-black">Hapus {confirmTarget.kind === 'artikel' ? 'artikel' : 'video'}?</h3>
            <p class="text-xs text-red-500 font-semibold">Tindakan ini tidak bisa dibatalkan.</p>
          </div>
        </div>
        <p class="text-xs mb-4 {isDark ? 'text-slate-400' : 'text-slate-600'}">
          "{confirmTarget.title}" akan dihapus permanen.
        </p>
        <div class="flex gap-2">
          <button
            onclick={confirmDelete}
            disabled={busy}
            class="flex-1 py-2.5 rounded-xl bg-red-600 hover:bg-red-500 text-white text-xs font-bold transition-all active:scale-95 disabled:opacity-50"
          >
            {#if busy}
              <span class="inline-block w-3.5 h-3.5 border-2 border-white border-t-transparent rounded-full animate-spin align-middle mr-1"></span>
            {:else}
              <Trash2 class="w-3.5 h-3.5 inline-block mr-1 align-middle" />
            {/if}
            Hapus
          </button>
          <button
            onclick={() => (confirmTarget = null)}
            disabled={busy}
            class="flex-1 py-2.5 rounded-xl border text-xs font-bold transition-all active:scale-95 disabled:opacity-50 {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-800' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}"
          >
            Batal
          </button>
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
  .hide-scrollbar::-webkit-scrollbar { display: none; }
</style>
