<script lang="ts">
  import { Home, Compass, HelpCircle, User, Play } from '@lucide/svelte';
  import { page } from '$app/state';
  import { app } from '$lib/stores/app.svelte';

  let isDark = $derived(app.theme === 'dark');
  let currentPath = $derived(page.url.pathname);

  const tabs = [
    { id: '/', icon: Home, label: 'Home' },
    { id: '/explore', icon: Compass, label: 'Explore' },
    { id: '/quiz', icon: HelpCircle, label: 'Quiz' },
    { id: '/video', icon: Play, label: 'Video' },
    { id: '/profile', icon: User, label: 'Profil' }
  ];
</script>

<div
  class="border rounded flex justify-between items-center p-2 mx-auto max-w-xs pointer-events-auto {isDark
    ? 'bg-slate-900 border-slate-700'
    : 'bg-white border-slate-200'}"
>
  {#each tabs as tab}
    {@const isActive = currentPath === tab.id}
    <a
      href={tab.id}
      class="relative flex items-center justify-center h-12 px-4 rounded transition-all duration-200 active:scale-95 group {isActive ? 'w-auto' : 'w-12'}"
    >
      {#if isActive}
        <div class="absolute inset-0 bg-blue-600 rounded transition-all duration-200"></div>
      {/if}

      <div class="relative z-10 flex items-center justify-center">
        <tab.icon
          class="transition-all duration-200 {isActive
            ? 'w-5 h-5 text-white'
            : isDark
              ? 'w-5 h-5 text-slate-400 group-hover:text-slate-200'
              : 'w-5 h-5 text-slate-600 group-hover:text-slate-800'}"
        />
        {#if isActive}
          <span class="ml-2 text-xs font-bold text-white whitespace-nowrap">
            {tab.label}
          </span>
        {/if}
      </div>
    </a>
  {/each}
</div>
