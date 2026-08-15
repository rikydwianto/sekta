<script lang="ts">
  import { goto } from '$app/navigation';
  import { app, signOut } from '$lib/stores/app.svelte';

  let { open, onClose }: { open: boolean; onClose: () => void } = $props();

  let isDark = $derived(app.theme === 'dark');

  async function handleLogout() {
    await goto('/');
    await signOut();
  }
</script>

{#if open}
  <div class="bg-black/70 backdrop-blur-sm min-h-full flex flex-col justify-end absolute inset-0 z-50 p-4">
    <div
      class="border rounded-[2.5rem] p-6 pb-8 text-center shadow-2xl {isDark
        ? 'bg-[#141720] border-slate-800 text-slate-100'
        : 'bg-white border-slate-200 text-slate-900'}"
    >
      <h2 class="text-lg font-black mb-2">Keluar dari Sekta?</h2>
      <p class="text-xs mb-6 {isDark ? 'text-slate-400' : 'text-slate-500'}">
        Kamu bisa login kembali kapan saja.
      </p>
      <div class="space-y-3">
        <button onclick={handleLogout} class="w-full bg-rose-600 hover:bg-rose-500 text-white font-bold py-3.5 rounded-2xl text-xs shadow-lg">
          Ya, Keluar
        </button>
        <button onclick={onClose} class="w-full font-bold py-3.5 rounded-2xl text-xs {isDark ? 'bg-slate-800 text-slate-200' : 'bg-slate-100 text-slate-800'}">
          Batal
        </button>
      </div>
    </div>
  </div>
{/if}
