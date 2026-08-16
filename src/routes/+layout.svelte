<script lang="ts">
  import '../app.css';
  import { page } from '$app/stores';
  import { goto } from '$app/navigation';
  import BottomNav from '$lib/components/BottomNav.svelte';
  import DashboardFooter from '$lib/components/DashboardFooter.svelte';
  import SiteModal from '$lib/components/SiteModal.svelte';
  import { app, initAuth, initTheme } from '$lib/stores/app.svelte';

  let { children } = $props();

  const SITE = { title: 'SEKTA — Sekejap Fakta', description: 'Kumpulan fakta menarik dari sains, sejarah, teknologi, dan dunia, dikemas singkat untuk rasa ingin tahu harianmu.' };


  // Initialize once on mount
  $effect.pre(() => {
    if (!app.authInitialized) {
      initTheme();
      initAuth().catch(err => console.error('Auth init error:', err));
    }
  });

  $effect(() => {
    if (typeof navigator !== 'undefined' && 'serviceWorker' in navigator) {
      navigator.serviceWorker.register('/sw.js');
    }
  });

  $effect(() => {
    const err = $page.url.searchParams.get('error');
    if (err && typeof window !== 'undefined') {
      const desc = $page.url.searchParams.get('error_description');
      history.replaceState(null, '', $page.url.pathname);
      sessionStorage.setItem('sekta-auth-error', desc || err);
      goto('/login');
    }
  });

  let isDark = $derived(app.theme === 'dark');
  let currentPath = $derived($page.url.pathname);

  const navPaths = ['/', '/explore', '/quiz', '/video', '/profile'];
  let showNav = $derived(navPaths.includes(currentPath));
</script>

<svelte:head>
  <title>{SITE.title}</title>
  <meta name="description" content={SITE.description} />
  <meta property="og:site_name" content="SEKTA" />
</svelte:head>

<div
  class="min-h-screen font-sans transition-colors duration-300 {isDark
    ? 'bg-slate-950 text-slate-100'
    : 'bg-white text-slate-900'}"
>
  <div
    class="w-full max-w-[430px] md:max-w-2xl lg:max-w-3xl mx-auto min-h-screen relative isolate transition-colors duration-300"
  >
    <div class="pb-32">
      <div class="page-enter">
        {@render children()}
      </div>
      {#if showNav}
        <DashboardFooter />
      {/if}
    </div>

    {#if showNav}
      <div class="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 w-[calc(100%-3rem)] max-w-[340px] pointer-events-none">
        <BottomNav />
      </div>
    {/if}

    <SiteModal />
  </div>
</div>
