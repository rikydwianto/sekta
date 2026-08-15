<script lang="ts">
  import { Bell, ExternalLink } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import type { NotificationItem } from '$lib/types';
  import { app, markNotificationRead } from '$lib/stores/app.svelte';
  import { getNotification } from '$lib/api';
  import { timeAgo } from '$lib/format';
  import PageHeader from '$lib/components/PageHeader.svelte';

  let { params } = $props();

  let isDark = $derived(app.theme === 'dark');
  let id = $derived(Number(params.id));
  let notif = $state<NotificationItem | null>(null);
  let loading = $state(true);

  $effect(() => {
    if (id <= 0) return;
    let alive = true;
    loading = true;
    getNotification(id)
      .then(async (n) => {
        if (!alive) return;
        notif = n;
        loading = false;
        if (n?.unread && (await markNotificationRead(id))) {
          notif = { ...n, unread: false };
        }
      })
      .catch(() => {
        if (alive) loading = false;
      });
    return () => {
      alive = false;
    };
  });
</script>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">

  <PageHeader title="Notifikasi" type="page" />

  <div class="px-6 pt-6">
    {#if loading}
      <div class="flex flex-col items-center justify-center py-16">
        <div class="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin"></div>
      </div>
    {:else if !notif}
      <div class="flex flex-col items-center justify-center py-16 text-center">
        <div class="w-16 h-16 rounded-full flex items-center justify-center mb-4 {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
          <Bell class="w-8 h-8 {isDark ? 'text-slate-600' : 'text-slate-300'}" />
        </div>
        <h3 class="text-base font-black mb-2 {isDark ? 'text-slate-300' : 'text-slate-700'}">Notifikasi tidak ditemukan</h3>
        <p class="text-sm {isDark ? 'text-slate-500' : 'text-slate-400'} mb-6 max-w-xs">
          Notifikasi ini sudah dihapus atau tidak lagi tersedia.
        </p>
        <button
          onclick={() => goto('/notifications')}
          class="px-4 py-2 rounded-xl bg-blue-600 text-white text-sm font-bold hover:bg-blue-700 transition-colors"
        >
          Kembali ke Notifikasi
        </button>
      </div>
    {:else}
      <div class="p-5 rounded-2xl border {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <div class="flex items-start gap-3 mb-4">
          <div class="w-11 h-11 rounded-xl flex items-center justify-center flex-shrink-0 {notif.unread
            ? 'bg-blue-600/10 text-blue-600'
            : isDark
              ? 'bg-slate-800 text-slate-400'
              : 'bg-slate-100 text-slate-400'}">
            <Bell class="w-5 h-5" />
          </div>
          <div class="flex-1 min-w-0">
            <h2 class="font-black text-base mb-1">{notif.title}</h2>
            <p class="text-xs {isDark ? 'text-slate-500' : 'text-slate-400'}">{timeAgo(notif.createdAt)}</p>
          </div>
        </div>

        <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-700'}">{notif.description}</p>

        <div class="flex items-center justify-between mt-6 pt-4 border-t {isDark ? 'border-slate-800' : 'border-slate-100'}">
          <span class="text-xs font-bold px-2.5 py-1 rounded-full {notif.unread
            ? 'bg-blue-600 text-white'
            : isDark
              ? 'bg-slate-800 text-slate-400'
              : 'bg-slate-100 text-slate-500'}">
            {notif.unread ? 'Belum dibaca' : 'Dibaca'}
          </span>
          {#if notif.link}
            <button
              onclick={() => goto(notif!.link)}
              class="px-4 py-2 rounded-xl bg-blue-600 text-white text-sm font-bold hover:bg-blue-700 transition-colors flex items-center gap-2"
            >
              Lihat Konten
              <ExternalLink class="w-4 h-4" />
            </button>
          {/if}
        </div>
      </div>
    {/if}
  </div>

</div>
