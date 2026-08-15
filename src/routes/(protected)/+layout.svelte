<script lang="ts">
  import { goto } from '$app/navigation';
  import { app } from '$lib/stores/app.svelte';

  let { children } = $props();

  $effect(() => {
    if (app.authInitialized && !app.isLoggedIn) {
      const current = window.location.pathname + window.location.search;
      sessionStorage.setItem('sekta-redirect', current);
      goto(`/login?redirect=${encodeURIComponent(current)}`);
    }
  });
</script>

{#if app.authInitialized && app.isLoggedIn}
  {@render children()}
{:else}
  <div class="min-h-screen flex items-center justify-center">
    <div class="w-8 h-8 border-2 border-blue-600 border-t-transparent rounded-full animate-spin"></div>
  </div>
{/if}
