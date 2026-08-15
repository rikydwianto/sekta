<script lang="ts">
  import { Play } from '@lucide/svelte';
  import type { VideoItem } from '$lib/types';
  import { app } from '$lib/stores/app.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import { getVideos } from '$lib/api';
  import { timeAgo } from '$lib/format';

  let isDark = $derived(app.theme === 'dark');

  let videos = $state<VideoItem[]>([]);
  let loading = $state(true);

  $effect(() => {
    loading = true;
    getVideos().then((list) => {
      videos = list;
      loading = false;
    });
  });
</script>

<div class="min-h-full pb-12 transition-colors duration-300 {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">
  <PageHeader title="Video" type="dashboard" showNotifications={true} />

  <div class="px-6 py-5 space-y-5">
    {#if loading}
      <div class="space-y-4">
        {#each Array(2) as _}
          <div class="h-64 rounded-2xl {isDark ? 'bg-slate-900' : 'bg-slate-100'} animate-pulse"></div>
        {/each}
      </div>
    {:else if videos.length === 0}
      <div class="flex flex-col items-center justify-center py-14 text-center">
        <div class="w-14 h-14 rounded-2xl mb-3 flex items-center justify-center {isDark ? 'bg-slate-900' : 'bg-slate-100'}">
          <Play class="w-6 h-6 {isDark ? 'text-slate-600' : 'text-slate-400'}" />
        </div>
        <p class="text-sm font-bold mb-1 {isDark ? 'text-slate-400' : 'text-slate-600'}">Belum ada video</p>
        <p class="text-xs {isDark ? 'text-slate-600' : 'text-slate-400'}">Unggah video pertamamu lewat halaman profil.</p>
      </div>
    {:else}
      <div class="space-y-5">
        {#each videos as v}
          <div class="rounded-2xl border overflow-hidden {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
            <video controls preload="metadata" playsinline class="w-full aspect-video bg-black">
              <source src={v.url} />
            </video>
            <div class="p-4">
              <h3 class="text-sm font-black leading-snug mb-1">{v.title}</h3>
              <p class="text-[10px] font-semibold mb-2 {isDark ? 'text-slate-500' : 'text-slate-400'}">
                {v.authorName} • {timeAgo(v.createdAt)}
              </p>
              {#if v.description}
                <p class="text-xs leading-relaxed {isDark ? 'text-slate-400' : 'text-slate-600'}">{v.description}</p>
              {/if}
            </div>
          </div>
        {/each}
      </div>
    {/if}
  </div>
</div>
