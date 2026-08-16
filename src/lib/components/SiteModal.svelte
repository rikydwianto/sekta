<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import { X, Sparkles } from '@lucide/svelte';
  import { app } from '$lib/stores/app.svelte';
  import { getSiteModal } from '$lib/api';
  import type { SiteModal as SiteModalData } from '$lib/types';

  let modal = $state<SiteModalData | null>(null);
  let isDark = $derived(app.theme === 'dark');

  const seenKey = (id: number) => `sekta-modal-seen-${id}`;

  onMount(async () => {
    try {
      const m = await getSiteModal();
      if (!m) return;
      const seen =
        m.frequency === 'once'
          ? localStorage.getItem(seenKey(m.id))
          : m.frequency === 'session'
            ? sessionStorage.getItem(seenKey(m.id))
            : null;
      if (seen) return;
      modal = m;
      if (m.frequency !== 'always') {
        const store = m.frequency === 'once' ? localStorage : sessionStorage;
        store.setItem(seenKey(m.id), '1');
      }
    } catch {
      // modal tidak boleh menggagalkan halaman
    }
  });

  function close() {
    modal = null;
  }

  function onButton() {
    const url = modal?.buttonUrl;
    close();
    if (url) goto(url);
  }
</script>

{#if modal}
  <div
    onclick={() => {
      if (modal?.dismissible) close();
    }}
    class="bg-slate-400/70 fixed inset-0 z-[60] flex items-center justify-center p-4"
    role="presentation"
  >
    <div
      onclick={(e) => e.stopPropagation()}
      onkeydown={(e) => {
        if (e.key === 'Escape' && modal?.dismissible) close();
      }}
      role="dialog"
      aria-modal="true"
      tabindex="-1"
      class="relative w-full max-w-[360px] sm:max-w-md fact-pop-in rounded-xl shadow-[0_10px_25px_rgba(0,0,0,0.12)] max-h-[calc(100vh-2rem)] overflow-y-auto {isDark
        ? 'bg-slate-900 text-slate-100'
        : 'bg-white text-slate-900'}"
    >
      {#if modal.imageUrl}
        <div class="relative">
          <img src={modal.imageUrl} alt={modal.title} class="w-full h-auto rounded-t-xl" loading="lazy" />

          <div
            class="absolute bottom-0 left-1/2 -translate-x-1/2 translate-y-1/2 w-16 h-16 rounded-full flex items-center justify-center shadow-sm {isDark
              ? 'bg-slate-900'
              : 'bg-white'}"
          >
            <Sparkles class="w-8 h-8 text-rose-600" />
          </div>
        </div>
      {/if}

      {#if modal.dismissible}
        <button
          onclick={close}
          aria-label="Tutup"
          class="absolute top-3 right-3 p-2 rounded-full shadow-sm hover:opacity-80 {isDark
            ? 'bg-slate-800/90 text-slate-300'
            : 'bg-white/90 text-slate-500'}"
        >
          <X class="w-4 h-4" />
        </button>
      {/if}

      <div class="px-6 pb-6 pt-12 text-center">
        {#if modal.title}
          <h2 class="text-xl font-black mb-3">{modal.title}</h2>
        {/if}
        {#if modal.body}
          <p class="text-sm leading-relaxed mb-6 whitespace-pre-line {isDark ? 'text-slate-400' : 'text-slate-500'}">{modal.body}</p>
        {/if}
        <div class="flex flex-col gap-3">
          {#if modal.buttonLabel}
            <button onclick={onButton} class="w-full bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 rounded-lg text-sm transition-colors">
              {modal.buttonLabel}
            </button>
          {/if}
          {#if modal.dismissible}
            <button onclick={close} class="w-full font-semibold py-3 rounded-lg text-sm hover:opacity-80 transition-colors {isDark ? 'text-slate-400' : 'text-slate-500'}">
              Nanti Saja
            </button>
          {:else if !modal.buttonLabel}
            <button onclick={close} class="w-full font-semibold py-3 rounded-lg text-sm hover:opacity-80 transition-colors {isDark ? 'text-slate-400' : 'text-slate-500'}">
              Tutup
            </button>
          {/if}
        </div>
      </div>
    </div>
  </div>
{/if}
