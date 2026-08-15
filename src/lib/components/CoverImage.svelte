<script lang="ts">
  const FALLBACK = '/assets/images/logo.png';

  let {
    image,
    class: classStr = ''
  }: { image: string; class?: string } = $props();

  let imageError = $state(false);
</script>

<div class="{classStr} overflow-hidden bg-slate-200">
  {#if imageError}
    <img src={FALLBACK} alt="" loading="lazy" class="w-full h-full object-cover" />
  {:else}
    <img src={image || FALLBACK} alt="" loading="lazy" class="w-full h-full object-cover" onerror={() => (imageError = true)} />
  {/if}
</div>
