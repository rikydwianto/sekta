<script lang="ts">
  import { app } from '$lib/stores/app.svelte';

  interface Props {
    type?: 'card' | 'text' | 'heading' | 'button' | 'avatar' | 'image' | 'line';
    width?: string;
    height?: string;
    count?: number;
    class?: string;
  }

  let { type = 'text', width = 'w-full', height = 'h-4', count = 1, class: className = '' }: Props = $props();

  let isDark = $derived(app.theme === 'dark');

  const baseClass = $derived(`${isDark ? 'bg-slate-800' : 'bg-slate-200'} rounded animate-pulse`);
</script>

{#if type === 'card'}
  <!-- Card skeleton -->
  <div class={`border rounded p-4 ${isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'} ${className}`}>
    <div class={`${baseClass} h-40 mb-4`}></div>
    <div class={`${baseClass} h-4 mb-3 w-24`}></div>
    <div class={`${baseClass} h-5 mb-4 w-3/4`}></div>
    <div class={`${baseClass} h-3 w-full`}></div>
  </div>
{:else if type === 'heading'}
  <!-- Heading skeleton -->
  <div class={`${baseClass} ${width} ${height} ${className}`}></div>
{:else if type === 'text'}
  <!-- Text/line skeleton -->
  {#each Array(count) as _, i}
    <div class={`${baseClass} ${width} ${height} mb-2 ${i === count - 1 ? 'mb-0' : ''} ${className}`}></div>
  {/each}
{:else if type === 'button'}
  <!-- Button skeleton -->
  <div class={`${baseClass} w-full h-11 rounded ${className}`}></div>
{:else if type === 'avatar'}
  <!-- Avatar skeleton -->
  <div class={`${baseClass} w-16 h-16 rounded-2xl ${className}`}></div>
{:else if type === 'image'}
  <!-- Image skeleton -->
  <div class={`${baseClass} ${width} ${height} rounded ${className}`}></div>
{/if}

<style>
  @keyframes shimmer {
    0% {
      opacity: 0.5;
    }
    50% {
      opacity: 0.75;
    }
    100% {
      opacity: 0.5;
    }
  }

  :global(.animate-pulse) {
    animation: shimmer 2.8s ease-in-out infinite;
  }
</style>
