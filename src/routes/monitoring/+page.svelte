<script lang="ts">
  import { Eye, Users, Activity, TrendingUp, RefreshCw } from '@lucide/svelte';
  import { app } from '$lib/stores/app.svelte';
  import PageHeader from '$lib/components/PageHeader.svelte';
  import type { MonitoringData } from './+page.ts';

  let { data } = $props();

  let isDark = $derived(app.theme === 'dark');
  let refreshing = $state(false);
  let refreshed = $state<MonitoringData | null>(null);
  let current = $derived(refreshed ?? data);
  let lastUpdated = $state<Date | null>(null);

  const RANGES = [
    { id: '24h', label: '24 Jam' },
    { id: '7d', label: '7 Hari' },
    { id: '30d', label: '30 Hari' },
    { id: 'all', label: 'Semua' }
  ];
  let range = $state('7d');

  const rangeLabel = $derived(RANGES.find((r) => r.id === range)?.label ?? range);

  const maxViews = $derived(
    (current.stats?.daily ?? []).reduce((m, d) => Math.max(m, d.views), 1)
  );

  const totalTopPages = $derived((current.stats?.topPages ?? []).reduce((m, p) => m + p.total, 0) || 1);
  const totalTopEvents = $derived((current.stats?.topEvents ?? []).reduce((m, p) => m + p.total, 0) || 1);

  async function refresh(r: string = range) {
    refreshing = true;
    try {
      const res = await fetch(`/api/monitoring?range=${r}`);
      refreshed = (await res.json()) as MonitoringData;
      lastUpdated = new Date();
    } finally {
      refreshing = false;
    }
  }

  function selectRange(id: string) {
    if (id === range && refreshed) return;
    range = id;
    refresh(id);
  }

  function bucketLabel(b: string): string {
    const isHourly = current.stats?.bucket === 'hour';
    const d = new Date(b.includes('T') ? b : b.replace(' ', 'T'));
    if (isHourly && !isNaN(d.getTime())) {
      return `${String(d.getHours()).padStart(2, '0')}:00`;
    }
    return b.slice(0, 10);
  }

  function timeLabel(d: Date): string {
    return d.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
  }

  $effect(() => {
    if (lastUpdated === null && current.stats) lastUpdated = new Date();
  });

  function hostOf(url: string): string {
    try {
      return new URL(url).host;
    } catch {
      return url;
    }
  }

  function pathOf(url: string): string {
    try {
      const p = new URL(url).pathname;
      return p.length > 1 ? p : '/';
    } catch {
      return url;
    }
  }

  function fmt(n: number): string {
    return new Intl.NumberFormat('id-ID').format(n);
  }
</script>

<svelte:head>
  <title>Monitoring — SEKTA</title>
</svelte:head>

<div class="min-h-full pb-20 transition-colors duration-300 page-enter {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-slate-50'}">
  <PageHeader title="Monitoring" type="page">
    {#snippet children()}
      <button
        onclick={() => refresh()}
        disabled={refreshing}
        aria-label="Muat ulang data"
        class="p-2.5 rounded border transition-all active:scale-95 disabled:opacity-50 {isDark ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800' : 'bg-slate-50 border-slate-200 text-slate-700 hover:bg-slate-200'}"
      >
        <RefreshCw class="w-5 h-5 {refreshing ? 'animate-spin' : ''}" />
      </button>
    {/snippet}
  </PageHeader>

  <div class="px-6 pt-4 space-y-5">
    {#if current.error && !current.configured}
      <div class="border rounded-3xl p-6 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <h2 class="font-black mb-2">PostHog belum dikonfigurasi</h2>
        <p class="text-sm mb-3 {isDark ? 'text-slate-400' : 'text-slate-600'}">
          Tambahkan di <code class="px-1.5 py-0.5 rounded bg-slate-200/60 text-xs">.env</code>:
        </p>
        <pre class="text-xs p-3 rounded-2xl overflow-x-auto {isDark ? 'bg-slate-950 text-emerald-400' : 'bg-slate-100 text-emerald-700'}">POSTHOG_PROJECT_ID=
POSTHOG_API_KEY=phx_...</pre>
        <p class="text-xs mt-3 {isDark ? 'text-slate-500' : 'text-slate-400'}">
          Personal API Key dari posthog.com → Project Settings → Personal API Keys. Project ID di Project Settings → General.
        </p>
      </div>
    {:else if current.error}
      <div class="border rounded-3xl p-6 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <h2 class="font-black mb-2">Gagal memuat data</h2>
        <p class="text-xs {isDark ? 'text-slate-400' : 'text-slate-600'}">{current.error}</p>
      </div>
    {:else if current.stats}
      <!-- Pemilih rentang waktu -->
      <div class="flex rounded-2xl p-1 border {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        {#each RANGES as r}
          <button
            onclick={() => selectRange(r.id)}
            disabled={refreshing}
            class="flex-1 py-2 rounded-xl text-xs font-black transition-all disabled:opacity-60 {range === r.id
              ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20'
              : isDark
                ? 'text-slate-400 hover:text-slate-200'
                : 'text-slate-500 hover:text-slate-800'}"
          >
            {r.label}
          </button>
        {/each}
      </div>

      {#if lastUpdated}
        <p class="text-[10px] text-center font-semibold {isDark ? 'text-slate-600' : 'text-slate-400'}">
          {refreshing ? 'Memuat ulang…' : `Terakhir diperbarui ${timeLabel(lastUpdated)} WIB`}
        </p>
      {/if}

      <!-- Kartu ringkasan -->
      <div class="grid grid-cols-2 gap-3">
        <div class="border rounded-3xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <div class="flex items-center gap-2 mb-1">
            <Eye class="w-4 h-4 text-blue-500" />
            <span class="text-[10px] font-black uppercase tracking-widest {isDark ? 'text-slate-500' : 'text-slate-400'}">Pageview</span>
          </div>
          <p class="text-2xl font-black">{fmt(current.stats.pageviews)}</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-slate-600' : 'text-slate-400'}">{rangeLabel}</p>
        </div>
        <div class="border rounded-3xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <div class="flex items-center gap-2 mb-1">
            <TrendingUp class="w-4 h-4 text-emerald-500" />
            <span class="text-[10px] font-black uppercase tracking-widest {isDark ? 'text-slate-500' : 'text-slate-400'}">Total Semua</span>
          </div>
          <p class="text-2xl font-black">{fmt(current.stats.pageviewsTotal)}</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-slate-600' : 'text-slate-400'}">Sepanjang waktu</p>
        </div>
        <div class="border rounded-3xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <div class="flex items-center gap-2 mb-1">
            <Users class="w-4 h-4 text-purple-500" />
            <span class="text-[10px] font-black uppercase tracking-widest {isDark ? 'text-slate-500' : 'text-slate-400'}">User Unik</span>
          </div>
          <p class="text-2xl font-black">{fmt(current.stats.users)}</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-slate-600' : 'text-slate-400'}">{rangeLabel}</p>
        </div>
        <div class="border rounded-3xl p-4 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <div class="flex items-center gap-2 mb-1">
            <Activity class="w-4 h-4 text-amber-500" />
            <span class="text-[10px] font-black uppercase tracking-widest {isDark ? 'text-slate-500' : 'text-slate-400'}">Aktif 24 Jam</span>
          </div>
          <p class="text-2xl font-black">{fmt(current.stats.users24h)}</p>
          <p class="text-[10px] font-semibold {isDark ? 'text-slate-600' : 'text-slate-400'}">Terakhir 24 jam</p>
        </div>
      </div>

      <!-- Tren -->
      <div class="border rounded-3xl p-5 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <h3 class="text-xs font-black uppercase tracking-widest mb-4 {isDark ? 'text-slate-500' : 'text-slate-400'}">Tren Pageview · {rangeLabel}</h3>
        {#if (current.stats.daily ?? []).length === 0}
          <p class="text-sm text-center py-6 {isDark ? 'text-slate-500' : 'text-slate-400'}">Belum ada data.</p>
        {:else}
          <div class="flex items-end gap-[3px] h-28">
            {#each current.stats.daily as d (d.day)}
              <div
                class="flex-1 rounded-t-md transition-all {isDark ? 'bg-blue-600/70' : 'bg-blue-500/80'}"
                style="height: {Math.max(4, (d.views / maxViews) * 100)}%"
                title="{bucketLabel(d.day)}: {d.views}"
              ></div>
            {/each}
          </div>
          <div class="flex justify-between mt-1.5 text-[10px] font-semibold {isDark ? 'text-slate-500' : 'text-slate-400'}">
            <span>{bucketLabel(current.stats.daily[0]?.day ?? '')}</span>
            <span>{bucketLabel(current.stats.daily[current.stats.daily.length - 1]?.day ?? '')}</span>
          </div>
        {/if}
      </div>

      <!-- Top artikel -->
      {#if (current.stats.topArticles ?? []).length > 0}
        <div class="border rounded-3xl p-5 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <h3 class="text-xs font-black uppercase tracking-widest mb-3 {isDark ? 'text-slate-500' : 'text-slate-400'}">Artikel Terpopuler</h3>
          <ul class="space-y-1.5">
            {#each current.stats.topArticles as a}
              <li>
                <a href="/article/{a.slug}" class="flex items-center gap-3 p-2.5 rounded-xl hover:bg-blue-600/10 transition-colors">
                  <span class="w-7 text-right text-sm font-black {isDark ? 'text-slate-600' : 'text-slate-300'}">{a.total}</span>
                  <span class="flex-1 min-w-0 text-sm font-bold line-clamp-2">{a.title}</span>
                </a>
              </li>
            {/each}
          </ul>
        </div>
      {/if}

      <!-- Top halaman -->
      {#if (current.stats.topPages ?? []).length > 0}
        <div class="border rounded-3xl p-5 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <h3 class="text-xs font-black uppercase tracking-widest mb-3 {isDark ? 'text-slate-500' : 'text-slate-400'}">Halaman Terbanyak</h3>
          <ul class="space-y-2">
            {#each current.stats.topPages as p}
              <li>
                <div class="flex items-center justify-between text-sm mb-1">
                  <span class="font-bold truncate pr-2">{pathOf(p.url)}</span>
                  <span class="text-[10px] font-black flex-shrink-0 {isDark ? 'text-slate-500' : 'text-slate-400'}">{fmt(p.total)}</span>
                </div>
                <div class="h-1.5 rounded-full {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
                  <div class="h-full rounded-full bg-blue-600/80" style="width: {(p.total / totalTopPages) * 100}%"></div>
                </div>
                <span class="text-[10px] {isDark ? 'text-slate-600' : 'text-slate-400'}">{hostOf(p.url)}</span>
              </li>
            {/each}
          </ul>
        </div>
      {/if}

      <!-- Top event -->
      {#if (current.stats.topEvents ?? []).length > 0}
        <div class="border rounded-3xl p-5 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
          <h3 class="text-xs font-black uppercase tracking-widest mb-3 {isDark ? 'text-slate-500' : 'text-slate-400'}">Event Terbanyak (7 Hari)</h3>
          <ul class="space-y-2">
            {#each current.stats.topEvents as e}
              <li>
                <div class="flex items-center justify-between text-sm mb-1">
                  <span class="font-bold truncate pr-2 font-mono text-xs">{e.event}</span>
                  <span class="text-[10px] font-black flex-shrink-0 {isDark ? 'text-slate-500' : 'text-slate-400'}">{fmt(e.total)}</span>
                </div>
                <div class="h-1.5 rounded-full {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
                  <div class="h-full rounded-full bg-emerald-600/80" style="width: {(e.total / totalTopEvents) * 100}%"></div>
                </div>
              </li>
            {/each}
          </ul>
        </div>
      {/if}
    {:else}
      <div class="flex flex-col items-center justify-center py-20 text-center">
        <div class="w-10 h-10 border-2 border-blue-600 border-t-transparent rounded-full animate-spin mb-4"></div>
        <p class="text-sm font-bold {isDark ? 'text-slate-400' : 'text-slate-600'}">Memuat data...</p>
      </div>
    {/if}
  </div>
</div>
