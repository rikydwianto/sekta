<script lang="ts">
  import { Bell, Check, Trash2 } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { app, markAllNotificationsRead, markNotificationRead, deleteNotification, clearAllNotifications } from '$lib/stores/app.svelte';
  import { timeAgo } from '$lib/format';
  import PageHeader from '$lib/components/PageHeader.svelte';

  let isDark = $derived(app.theme === 'dark');
  let showClearAll = $state(false);

  // Notification filters
  let filter = $state<'all' | 'unread'>('all');

  // Get filtered notifications
  let displayNotifications = $derived.by(() => {
    if (filter === 'unread') {
      return app.notifications.filter(n => n.unread);
    }
    return app.notifications;
  });

  function clearAll() {
    clearAllNotifications();
    showClearAll = false;
  }
</script>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">

  <!-- Page Header -->
  <PageHeader title="Notifikasi" type="page" />

  <!-- Filter Tabs -->
  <div class="px-6 pt-4 pb-3 border-b {isDark ? 'border-slate-800' : 'border-slate-200'}">
    <div class="flex gap-2">
      <button
        onclick={() => filter = 'all'}
        class="px-4 py-2 rounded-xl border text-sm font-bold transition-colors
          {filter === 'all'
            ? 'bg-blue-600 border-blue-600 text-white'
            : isDark
              ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800'
              : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'}"
      >
        Semua ({app.notifications.length})
      </button>
      <button
        onclick={() => filter = 'unread'}
        class="px-4 py-2 rounded-xl border text-sm font-bold transition-colors relative
          {filter === 'unread'
            ? 'bg-blue-600 border-blue-600 text-white'
            : isDark
              ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800'
              : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'}"
      >
        Belum Dibaca ({app.notifications.filter(n => n.unread).length})
      </button>
    </div>
  </div>

  <!-- Notifications List -->
  <div class="px-6 pt-4">
    {#if displayNotifications.length > 0}
      <div class="flex items-center justify-between mb-4">
        <p class="text-xs font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">
          {displayNotifications.length} notifikasi
        </p>
        <div class="flex gap-2">
          {#if app.notifications.some(n => n.unread)}
            <button
              onclick={markAllNotificationsRead}
              class="text-xs font-bold text-blue-600 hover:text-blue-500 transition-colors"
            >
              Tandai semua dibaca
            </button>
          {/if}
          <button
            onclick={() => (showClearAll = true)}
            class="text-xs font-bold text-red-600 hover:text-red-500 transition-colors"
          >
            Hapus semua
          </button>
        </div>
      </div>

      <div class="space-y-3 pb-6">
        {#each displayNotifications as notif (notif.id)}
          <div
            onclick={() => goto(`/notifications/${notif.id}`)}
            onkeydown={(e) => {
              if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                goto(`/notifications/${notif.id}`);
              }
            }}
            role="button"
            tabindex="0"
            class="cursor-pointer p-4 rounded-2xl border transition-all {notif.unread
              ? isDark
                ? 'bg-slate-800 border-slate-700'
                : 'bg-blue-50 border-blue-200'
              : isDark
                ? 'bg-slate-900 border-slate-800'
                : 'bg-white border-slate-200'} hover:border-blue-400"
          >
            <div class="flex items-start gap-3">
              <!-- Icon -->
              <div class="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0 {notif.unread
                ? 'bg-blue-600/10 text-blue-600'
                : isDark
                  ? 'bg-slate-800 text-slate-400'
                  : 'bg-slate-100 text-slate-400'}">
                <Bell class="w-5 h-5" />
              </div>

              <!-- Content -->
              <div class="flex-1 min-w-0">
                <div class="flex items-start justify-between gap-2 mb-1">
                  <h4 class="font-bold text-sm {notif.unread ? (isDark ? 'text-slate-100' : 'text-slate-900') : isDark ? 'text-slate-300' : 'text-slate-700'}">
                    {notif.title}
                  </h4>
                  {#if notif.unread}
                    <div class="w-2 h-2 bg-blue-600 rounded-full flex-shrink-0 mt-1.5"></div>
                  {/if}
                </div>
                <p class="text-xs mb-2 {isDark ? 'text-slate-400' : 'text-slate-600'} line-clamp-2">
                  {notif.description}
                </p>
                <p class="text-xs {isDark ? 'text-slate-500' : 'text-slate-400'}">
                  {timeAgo(notif.createdAt)}
                </p>
              </div>

              <!-- Actions -->
              <div class="flex gap-1 flex-shrink-0 pt-1">
                {#if notif.unread}
                  <button
                    onclick={(e) => { e.stopPropagation(); markNotificationRead(notif.id); }}
                    class="p-2 rounded transition-colors {isDark ? 'hover:bg-slate-700' : 'hover:bg-slate-100'}"
                    aria-label="Mark as read"
                  >
                    <Check class="w-4 h-4 {isDark ? 'text-slate-500' : 'text-slate-400'}" />
                  </button>
                {/if}
                <button
                  onclick={(e) => { e.stopPropagation(); deleteNotification(notif.id); }}
                  class="p-2 rounded transition-colors {isDark ? 'hover:bg-slate-700' : 'hover:bg-slate-100'}"
                  aria-label="Delete notification"
                >
                  <Trash2 class="w-4 h-4 {isDark ? 'text-slate-500' : 'text-slate-400'}" />
                </button>
              </div>
            </div>
          </div>
        {/each}
      </div>

    {:else}
      <!-- Empty State -->
      <div class="flex flex-col items-center justify-center py-16 text-center">
        <div class="w-16 h-16 rounded-full flex items-center justify-center mb-4 {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
          <Bell class="w-8 h-8 {isDark ? 'text-slate-600' : 'text-slate-300'}" />
        </div>
        <h3 class="text-base font-black mb-2 {isDark ? 'text-slate-300' : 'text-slate-700'}">
          {filter === 'unread' ? 'Tidak ada notifikasi baru' : 'Tidak ada notifikasi'}
        </h3>
        <p class="text-sm {isDark ? 'text-slate-500' : 'text-slate-400'} mb-6 max-w-xs">
          {filter === 'unread'
            ? 'Semua notifikasi sudah dibaca. Tetap update dengan mengikuti topik favorit.'
            : 'Belum ada notifikasi. Notifikasi akan muncul saat ada pembaruan penting.'}
        </p>

        {#if filter === 'unread' && app.notifications.length > 0}
          <button
            onclick={() => filter = 'all'}
            class="px-4 py-2 rounded-xl border text-sm font-bold transition-colors
              bg-blue-600 border-blue-600 text-white hover:bg-blue-700"
          >
            Lihat Semua Notifikasi
          </button>
        {/if}
      </div>
    {/if}
  </div>

</div>

{#if showClearAll}
  <div class="bg-black/70 backdrop-blur-sm fixed inset-0 z-50 flex items-center justify-center p-4">
    <div
      class="w-full max-w-sm border rounded-[2.5rem] p-6 pb-8 text-center shadow-2xl {isDark
        ? 'bg-[#141720] border-slate-800 text-slate-100'
        : 'bg-white border-slate-200 text-slate-900'}"
    >
      <h2 class="text-lg font-black mb-2">Hapus semua notifikasi?</h2>
      <p class="text-xs mb-6 {isDark ? 'text-slate-400' : 'text-slate-500'}">
        Semua notifikasi akan dihapus permanen.
      </p>
      <div class="space-y-3">
        <button onclick={clearAll} class="w-full bg-rose-600 hover:bg-rose-500 text-white font-bold py-3.5 rounded-2xl text-xs shadow-lg">
          Ya, Hapus Semua
        </button>
        <button onclick={() => (showClearAll = false)} class="w-full font-bold py-3.5 rounded-2xl text-xs {isDark ? 'bg-slate-800 text-slate-200' : 'bg-slate-100 text-slate-800'}">
          Batal
        </button>
      </div>
    </div>
  </div>
{/if}
