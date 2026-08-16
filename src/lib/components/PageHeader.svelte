<script lang="ts">
  import { Bell, Settings, ChevronLeft, Sun, Moon, Search } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import type { Snippet } from 'svelte';
  import { app, toggleTheme } from '$lib/stores/app.svelte';
  import { goBack } from '$lib/stores/navigation.svelte';

  interface Props {
    title: string;
    type?: 'dashboard' | 'page';
    backHref?: string;
    titleHref?: string;
    showSearch?: boolean;
    showNotifications?: boolean;
    showSettings?: boolean;
    children?: Snippet;
  }

  let { title, type = 'dashboard', backHref, titleHref, showSearch = true, showNotifications = false, showSettings = false, children }: Props = $props();

  let isDark = $derived(app.theme === 'dark');
  let hasUnreadNotifications = $derived(app.notifications?.some(n => n.unread) ?? false);

  // Explicit backHref wins; otherwise true history-based back
  function handleBack() {
    if (backHref) goto(backHref);
    else goBack();
  }
</script>

<div
  class="flex items-center px-6 {type === 'dashboard' ? 'pt-12 pb-5' : 'pt-4 pb-4'} sticky top-0 z-30 border-b transition-colors {isDark
    ? 'bg-slate-950 border-slate-800'
    : 'bg-white border-slate-200'}"
>
  <!-- Left: back button (page) -->
  {#if type === 'page'}
    <button
      onclick={handleBack}
      class="p-2 -ml-2 mr-1 rounded transition-colors {isDark ? 'text-slate-300 hover:bg-slate-800' : 'text-slate-700 hover:bg-slate-100'}"
      aria-label="Back"
    >
      <ChevronLeft class="w-6 h-6 stroke-[2.5]" />
    </button>
  {/if}

  <!-- Left: Title -->
  {#if type === 'dashboard'}
    <a
      href="/"
      class="text-2xl font-black tracking-tight min-w-0 truncate text-blue-600"
    >
      {title}
    </a>
  {:else if titleHref}
    <a href={titleHref} class="text-2xl font-black tracking-tight min-w-0 truncate">{title}</a>
  {:else}
    <h1 class="text-2xl font-black tracking-tight min-w-0 truncate">{title}</h1>
  {/if}

  <!-- Spacer -->
  <div class="flex-1"></div>

  <!-- Right: Action buttons -->
  <div class="flex items-center gap-2">
    <button
      onclick={toggleTheme}
      class="p-2.5 rounded border transition-all active:scale-95 {isDark ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800' : 'bg-slate-50 border-slate-200 text-slate-700 hover:bg-slate-200'}"
      aria-label="Toggle dark mode"
    >
      {#if isDark}
        <Sun class="w-5 h-5" />
      {:else}
        <Moon class="w-5 h-5" />
      {/if}
    </button>

    <button
      onclick={() => goto('/search')}
      class="p-2.5 rounded border transition-all active:scale-95 {isDark ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800' : 'bg-slate-50 border-slate-200 text-slate-700 hover:bg-slate-200'}"
      aria-label="Search"
    >
      <Search class="w-5 h-5" />
    </button>

    {#if showNotifications}
      <button
        onclick={() => goto('/notifications')}
        class="relative p-2.5 rounded border transition-all active:scale-95 {isDark ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800' : 'bg-slate-50 border-slate-200 text-slate-700 hover:bg-slate-200'}"
        aria-label="Notifications"
      >
        <Bell class="w-5 h-5" />
        {#if hasUnreadNotifications}
          <span class="absolute top-1.5 right-1.5 w-2.5 h-2.5 bg-red-500 rounded-full ring-2 {isDark ? 'ring-slate-950' : 'ring-white'} animate-pulse"></span>
        {/if}
      </button>
    {/if}

    {#if showSettings}
      <button
        onclick={() => goto('/settings')}
        class="p-2.5 rounded border transition-all active:scale-95 {isDark ? 'bg-slate-900 border-slate-700 text-slate-300 hover:bg-slate-800' : 'bg-slate-50 border-slate-200 text-slate-700 hover:bg-slate-200'}"
        aria-label="Settings"
      >
        <Settings class="w-5 h-5" />
      </button>
    {/if}

    {#if children}
      {@render children()}
    {/if}
  </div>
</div>
