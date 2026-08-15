<script lang="ts">
  const FALLBACK = '/assets/images/logo.png';

  let {
    name = '',
    src = '',
    size = 'md',
    class: className = ''
  }: {
    name: string;
    src?: string;
    size?: 'sm' | 'md' | 'lg' | 'xl';
    class?: string;
  } = $props();

  const sizeClasses = {
    sm: 'w-8 h-8 text-xs rounded-xl',
    md: 'w-12 h-12 text-sm rounded-2xl',
    lg: 'w-16 h-16 text-base rounded-2xl',
    xl: 'w-20 h-20 text-xl rounded-3xl'
  };

  // Track image loading state
  let imageLoaded = $state(false);
  let imageError = $state(false);

  // Image load handler with caching
  function handleImageLoad() {
    imageLoaded = true;
    imageError = false;
  }

  function handleImageError() {
    imageError = true;
    imageLoaded = false;
  }

  $effect(() => {
    imageLoaded = false;
    imageError = false;
  });
</script>

{#if src && !imageError}
  <div class="overflow-hidden bg-slate-200 flex-shrink-0 {sizeClasses[size]} {className}">
    <img
      src={src}
      alt={name}
      loading="lazy"
      class="w-full h-full object-cover {imageLoaded ? 'opacity-100' : 'opacity-0'} transition-opacity duration-300"
      onload={handleImageLoad}
      onerror={handleImageError}
    />
    {#if !imageLoaded}
      <div class="absolute inset-0 bg-slate-300 animate-pulse"></div>
    {/if}
  </div>
{:else if src && imageError}
  <div class="overflow-hidden bg-slate-200 flex-shrink-0 {sizeClasses[size]} {className}">
    <img
      src={FALLBACK}
      alt={name}
      loading="lazy"
      class="w-full h-full object-cover"
    />
  </div>
{:else}
  <div
    class="overflow-hidden flex-shrink-0 bg-slate-200 {sizeClasses[size]} {className}"
  >
    <img src={FALLBACK} alt={name} loading="lazy" class="w-full h-full object-cover" />
  </div>
{/if}
