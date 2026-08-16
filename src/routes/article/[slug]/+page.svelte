<script lang="ts">
import { ChevronLeft, Bookmark, Settings, MessageCircle, Send, ChevronUp, ChevronDown, Volume2, Pause, Play, Square, Sun, Moon, Share2 } from '@lucide/svelte';
import { goto, onNavigate } from '$app/navigation';
import type { ArticleBlock, ArticleReaction, CommentItem, Article } from '$lib/types';
import { app, toggleSaveArticle, toggleTheme } from '$lib/stores/app.svelte';
  import { goBack } from '$lib/stores/navigation.svelte';
  import CoverImage from '$lib/components/CoverImage.svelte';
  import AvatarInitials from '$lib/components/AvatarInitials.svelte';
  import TikTokFollowCard from '$lib/components/TikTokFollowCard.svelte';
import { getArticleReactions, setArticleReaction, getComments, addComment } from '$lib/api';
import { timeAgo, videoEmbedUrl, tiktokVideoId, tiktokProfile, applyIdVoice } from '$lib/format';
import { recordRead } from '$lib/stores/reading.svelte';

  let { data } = $props();

  const REACTION_DEFS: { type: ArticleReaction; emoji: string; label: string }[] = [
    { type: 'LIKE', emoji: '❤️', label: 'Suka' },
    { type: 'WOW', emoji: '😮', label: 'Wow' },
    { type: 'FUNNY', emoji: '😂', label: 'Lucu' },
    { type: 'SAD', emoji: '😢', label: 'Sedih' }
  ];

  let isDark = $derived(app.theme === 'dark');
  let article = $derived(data.article);
  let currentId = $derived(article?.id ?? -1);
  let isSaved = $derived(app.savedArticles.some((a) => a.id === currentId));

  let reactions = $state<ArticleReaction[]>([]);
  let myReaction = $state<ArticleReaction | null>(null);
  let comments = $state<CommentItem[]>([]);
  let commentText = $state('');
  let posting = $state(false);
  let socialLoading = $state(true);
  let lightboxSrc = $state('');
  let speaking = $state<string | null>(null);
  let paused = $state(false);
  let rate = $state(1);
  let fontSize = $state(2);
  let progressBar = $state<HTMLElement | null>(null);

  const FONT_SIZES = ['text-sm', 'text-[15px]', 'text-base', 'text-lg'];
  const RATES = [0.75, 1, 1.25];

  function shareArticle(article: Article) {
    const url = window.location.href;
    const text = `${article.title}\n\n${article.excerpt ?? ''}`;
    if (navigator.share) {
      navigator.share({ title: article.title, text, url }).catch(() => {});
    } else {
      navigator.clipboard.writeText(`${text}\n${url}`).then(() => alert('Link artikel disalin ke clipboard'));
    }
  }

  $effect(() => {
    const handler = (e: MouseEvent) => {
      const t = e.target;
      if (!(t instanceof Element)) return;
      const img = t.closest('img');
      if (!img || img.closest('a')) return;
      lightboxSrc = img.src;
    };
    document.addEventListener('click', handler);
    return () => document.removeEventListener('click', handler);
  });

  $effect(() => {
    const el = progressBar;
    if (!el) return;
    const onScroll = () => {
      const h = document.documentElement.scrollHeight - document.documentElement.clientHeight;
      const p = h > 0 ? Math.min(100, (window.scrollY / h) * 100) : 0;
      el.style.width = `${p}%`;
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
    return () => window.removeEventListener('scroll', onScroll);
  });
  let counts = $derived.by(() => {
    const c: Record<ArticleReaction, number> = { LIKE: 0, WOW: 0, FUNNY: 0, SAD: 0 };
    for (const r of reactions) c[r] += 1;
    return c;
  });

  let hasTiktok = $derived(
    (article?.content ?? []).some(
      (b) => b.type === 'video' && tiktokVideoId((b as Extract<ArticleBlock, { type: 'video' }>).data.url)
    )
  );

  $effect(() => {
    if (!hasTiktok) return;
    const inject = () => {
      if (document.querySelector('script[src="https://www.tiktok.com/embed.js"]')) return;
      const s = document.createElement('script');
      s.src = 'https://www.tiktok.com/embed.js';
      document.head.appendChild(s);
    };
    const els = document.querySelectorAll('.tiktok-embed');
    if (els.length === 0) {
      inject();
      return;
    }
    let done = false;
    const io = new IntersectionObserver(
      (entries) => {
        if (entries.some((e) => e.isIntersecting) && !done) {
          done = true;
          inject();
          io.disconnect();
        }
      },
      { rootMargin: '600px' }
    );
    els.forEach((el) => io.observe(el));
    return () => io.disconnect();
  });

  $effect(() => {
    if (currentId <= 0) return;
    let alive = true;
    socialLoading = true;
    recordRead(article!);
    Promise.all([
      getArticleReactions(currentId).catch(() => null),
      getComments(currentId).catch(() => null)
    ]).then(([rc, cm]) => {
      if (!alive) return;
      if (rc) {
        reactions = rc.reactions;
        myReaction = rc.mine;
      }
      if (cm) comments = cm;
      socialLoading = false;
    });
    return () => {
      alive = false;
    };
  });

  async function react(type: ArticleReaction) {
    const res = await setArticleReaction(currentId, type);
    if (!res) return;
    if (res === 'removed') {
      reactions = reactions.filter((r) => r !== type);
      myReaction = null;
    } else {
      if (myReaction) reactions = reactions.filter((r) => r !== myReaction);
      reactions = [...reactions, type];
      myReaction = type;
    }
  }

  function blockText(b: ArticleBlock): string {
    const d = (b as { data?: { text?: string; items?: string[] } }).data;
    if (!d) return '';
    if (d.items) return d.items.join('. ');
    return (d.text ?? '').replace(/<[^>]*>/g, '');
  }

  const speakableBlocks = $derived(
    (article?.content ?? []).filter((b) => ['paragraph', 'heading', 'quote', 'fact', 'list'].includes(b.type))
  );

  // Teks "Baca Semua" digabung sekali (bukan di setiap klik tombol).
  const allQueue = $derived(
    [article?.title ?? '', ...speakableBlocks.map(blockText)].filter((t) => t.trim().length > 0)
  );

  // Penanda generasi antrean; menambahnya membatalkan antrean "Baca Semua" yang berjalan
  // (misal saat user memulai blok tertentu atau memulai ulang).
  let allGen = 0;

  function speak(id: string, text: string) {
    if (typeof speechSynthesis === 'undefined') return;
    if (speaking === id && paused) {
      speechSynthesis.resume();
      paused = false;
      return;
    }
    if (speaking === id) {
      speechSynthesis.pause();
      paused = true;
      return;
    }
    speechSynthesis.cancel();
    paused = false;
    allGen += 1;
    speaking = id;
    // cancel() lalu speak() di tick yang sama bisa membuat Chrome membuang utterance baru.
    window.setTimeout(() => {
      const u = new SpeechSynthesisUtterance(text);
      applyIdVoice(u);
      u.rate = rate;
      u.onend = () => {
        if (speaking === id) {
          speaking = null;
          paused = false;
        }
      };
      speechSynthesis.speak(u);
    }, 50);
  }

  // "Baca Semua" dipecah jadi 1 utterance per blok; utterance berikutnya diucapkan di onend.
  // Jadi pause/resume/stop bekerja per blok pendek (responsif), bukan satu utterance raksasa
  // yang memblokir main thread di perangkat mobile.
  function speakAll() {
    if (typeof speechSynthesis === 'undefined') return;
    if (speaking === 'all' && paused) {
      speechSynthesis.resume();
      paused = false;
      return;
    }
    if (speaking === 'all') {
      speechSynthesis.pause();
      paused = true;
      return;
    }
    if (allQueue.length === 0) return;
    speechSynthesis.cancel();
    paused = false;
    allGen += 1;
    speaking = 'all';
    const gen = allGen;
    window.setTimeout(() => speakNextAll(0, gen), 50);
  }

  function speakNextAll(i: number, gen: number) {
    if (gen !== allGen || speaking !== 'all') return;
    if (i >= allQueue.length) {
      speaking = null;
      paused = false;
      return;
    }
    const u = new SpeechSynthesisUtterance(allQueue[i]);
    applyIdVoice(u);
    u.rate = rate;
    u.onend = () => speakNextAll(i + 1, gen);
    u.onerror = () => speakNextAll(i + 1, gen);
    speechSynthesis.speak(u);
  }

  function stopSpeaking() {
    allGen += 1;
    speechSynthesis.cancel();
    speaking = null;
    paused = false;
  }

  onNavigate(() => stopSpeaking());

  async function submitComment() {
    const text = commentText.trim();
    if (!text || posting) return;
    if (!app.isLoggedIn) {
      goto('/login');
      return;
    }
    posting = true;
    const ok = await addComment(currentId, text, app.user.name || 'Pengguna');
    posting = false;
    if (ok) {
      comments = [
        { id: Date.now(), authorName: app.user.name || 'Pengguna', content: text, createdAt: new Date().toISOString(), mine: true },
        ...comments
      ];
      commentText = '';
    }
  }
</script>

<svelte:head>
  {#if article}
    <title>{article.title} — SEKTA</title>
    <meta name="description" content={article.excerpt} />
    <meta property="og:title" content={article.title} />
    <meta property="og:description" content={article.excerpt} />
    <meta property="og:image" content={article.image} />
    <meta property="og:type" content="article" />
  {/if}
</svelte:head>

<div class="min-h-full pb-12 transition-colors duration-300 {isDark ? 'text-slate-100' : 'text-slate-900'}">
  <div class="sticky top-0 z-40">
    <div class="h-1 {isDark ? 'bg-slate-800' : 'bg-slate-100'}">
      <div bind:this={progressBar} class="h-full bg-blue-600" style="width: 0%"></div>
    </div>
    <div
      class="backdrop-blur-xl px-5 py-3.5 flex items-center justify-between border-b {isDark
        ? 'bg-[#0b0d10]/90 border-slate-800 text-slate-100'
        : 'bg-white/90 border-slate-200 text-slate-900'}"
    >
    <button onclick={goBack} class="p-2 -ml-2 rounded-full {isDark ? 'hover:bg-slate-800 text-slate-200' : 'hover:bg-slate-100 text-slate-700'}">
      <ChevronLeft class="w-6 h-6 stroke-[2.5]" />
    </button>
    {#if article}
      <span class="flex-1 min-w-0 px-2 text-sm font-black truncate">{article.title}</span>
    {/if}
    <div class="flex space-x-1">
      <button
        onclick={toggleTheme}
        class="p-2.5 rounded-full {isDark ? 'hover:bg-slate-800 text-slate-300' : 'hover:bg-slate-100 text-slate-600'}"
        aria-label="Toggle dark mode"
      >
        {#if isDark}
          <Sun class="w-5 h-5" />
        {:else}
          <Moon class="w-5 h-5" />
        {/if}
      </button>
      <button
        onclick={() => article && shareArticle(article)}
        class="p-2.5 rounded-full {isDark ? 'hover:bg-slate-800 text-slate-300' : 'hover:bg-slate-100 text-slate-600'}"
        aria-label="Bagikan artikel"
      >
        <Share2 class="w-5 h-5" />
      </button>
      <button onclick={() => article && toggleSaveArticle(article)} class="p-2.5 rounded-full {isSaved ? 'text-blue-600' : isDark ? 'hover:bg-slate-800 text-slate-300' : 'hover:bg-slate-100 text-slate-600'}">
        <Bookmark class="w-5 h-5" fill={isSaved ? 'currentColor' : 'none'} />
      </button>
      <a href="/settings" class="p-2.5 rounded-full {isDark ? 'hover:bg-slate-800 text-slate-300' : 'hover:bg-slate-100 text-slate-600'}">
        <Settings class="w-5 h-5" />
      </a>
    </div>
  </div>
  </div>

  {#if !article}
    <div class="flex flex-col items-center justify-center py-24 px-6 text-center">
      <p class="text-lg font-black mb-2">Artikel tidak ditemukan</p>
      <p class="text-sm mb-6 {isDark ? 'text-slate-400' : 'text-slate-500'}">Artikel mungkin belum dipublikasikan atau sudah dihapus.</p>
      <button
        onclick={() => goto('/')}
        class="bg-blue-600 hover:bg-blue-500 text-white font-bold text-sm px-5 py-2.5 rounded-xl transition-all active:scale-95"
      >
        Kembali ke Beranda
      </button>
    </div>
  {:else}
  <button onclick={() => (lightboxSrc = article.image)} class="block w-full cursor-zoom-in">
    <CoverImage image={article.image} class="h-72 md:h-96 w-full relative" />
  </button>

  <div class="px-6 md:px-10 -mt-12 relative z-10">
    <div class="rounded-[2rem] p-7 md:p-8 border mb-8 shadow-xl {isDark ? 'bg-[#141720] border-slate-800' : 'bg-white border-slate-200'}">
      <span class="inline-block px-3 py-1 bg-blue-600/20 text-blue-500 text-[10px] font-black rounded uppercase tracking-widest mb-4">
        {article.category}
      </span>
      <h1 class="text-2xl md:text-3xl font-black leading-tight mb-4">{article.title}</h1>
      <p class="text-sm leading-relaxed mb-5 {isDark ? 'text-slate-400' : 'text-slate-600'}">{article.excerpt}</p>
      <div class="flex items-center pt-5 border-t text-xs justify-between gap-3 {isDark ? 'border-slate-800 text-slate-400' : 'border-slate-100 text-slate-500'}">
        <span class="truncate">{article.author}</span>
        <span class="flex-shrink-0">{article.readTime}{article.date ? ` • ${article.date}` : ''} • {article.viewCount} dibaca</span>
      </div>
      {#if speakableBlocks.length}
        <div class="mt-4 flex items-center gap-2">
          <button
            onclick={speakAll}
            class="flex-1 flex items-center justify-center gap-2 py-2.5 rounded-xl border text-xs font-bold transition-colors {speaking === 'all'
              ? isDark
                ? 'border-slate-700 text-slate-300 hover:bg-slate-800'
                : 'border-slate-200 text-slate-600 hover:bg-slate-50'
              : 'bg-blue-600 text-white border-blue-600'}"
          >
            {#if speaking === 'all' && paused}
              <Play class="w-4 h-4" />
              Lanjutkan Membaca
            {:else if speaking === 'all'}
              <Pause class="w-4 h-4" />
              Jeda Membaca
            {:else}
              <Volume2 class="w-4 h-4" />
              Baca Semua
            {/if}
          </button>
          {#if speaking !== null}
            <button
              onclick={stopSpeaking}
              aria-label="Berhenti membaca"
              class="p-2.5 rounded-xl border text-xs font-bold transition-colors {isDark
                ? 'border-slate-700 text-slate-300 hover:bg-slate-800'
                : 'border-slate-200 text-slate-600 hover:bg-slate-50'}"
            >
              <Square class="w-4 h-4" />
            </button>
          {/if}
        </div>
        <div class="mt-2 flex items-center gap-1.5">
          <button
            onclick={() => (rate = RATES[(RATES.indexOf(rate) + 1) % RATES.length])}
            class="px-2.5 py-1 rounded-lg border text-[10px] font-bold transition-colors {isDark
              ? 'border-slate-700 text-slate-400 hover:bg-slate-800'
              : 'border-slate-200 text-slate-500 hover:bg-slate-100'}"
          >
            ⏩ {rate}x
          </button>
          <span class="flex-1"></span>
          <button
            onclick={() => (fontSize = Math.max(0, fontSize - 1))}
            disabled={fontSize === 0}
            class="px-2.5 py-1 rounded-lg border text-[10px] font-bold transition-colors disabled:opacity-40 {isDark
              ? 'border-slate-700 text-slate-400 hover:bg-slate-800'
              : 'border-slate-200 text-slate-500 hover:bg-slate-100'}"
          >
            A−
          </button>
          <button
            onclick={() => (fontSize = Math.min(FONT_SIZES.length - 1, fontSize + 1))}
            disabled={fontSize === FONT_SIZES.length - 1}
            class="px-2.5 py-1 rounded-lg border text-xs font-bold transition-colors disabled:opacity-40 {isDark
              ? 'border-slate-700 text-slate-400 hover:bg-slate-800'
              : 'border-slate-200 text-slate-500 hover:bg-slate-100'}"
          >
            A+
          </button>
        </div>
      {/if}
    </div>

    <div class="space-y-5 leading-relaxed font-medium mb-10 prose-html {FONT_SIZES[fontSize]} {isDark ? 'text-slate-300' : 'text-slate-700'}">
      {#each article.content as block, i (block)}
        {#if block.type === 'paragraph'}
          {@const pid = `b${i}`}
          <div class="group flex items-start gap-2">
            <p class="flex-1">{@html (block as Extract<ArticleBlock, { type: 'paragraph' }>).data.text}</p>
            <button
              onclick={() => speak(pid, blockText(block))}
              aria-label="Dengarkan paragraf"
              class="mt-1.5 flex-shrink-0 p-1.5 rounded-lg transition-colors {speaking === pid
                ? 'text-blue-600 bg-blue-600/10'
                : isDark
                  ? 'text-slate-600 hover:text-slate-300 hover:bg-slate-800'
                  : 'text-slate-400 hover:text-slate-700 hover:bg-slate-100'}"
            >
              <Volume2 class="w-3.5 h-3.5" />
            </button>
          </div>
        {:else if block.type === 'heading'}
          {@const hid = `b${i}`}
          <div class="group flex items-center gap-2 pt-4">
            <h2 class="flex-1 text-lg font-black tracking-tight {isDark ? 'text-slate-100' : 'text-slate-900'}">
              {@html (block as Extract<ArticleBlock, { type: 'heading' }>).data.text}
            </h2>
            <button
              onclick={() => speak(hid, blockText(block))}
              aria-label="Dengarkan heading"
              class="flex-shrink-0 p-1.5 rounded-lg transition-colors {speaking === hid
                ? 'text-blue-600 bg-blue-600/10'
                : isDark
                  ? 'text-slate-600 hover:text-slate-300 hover:bg-slate-800'
                  : 'text-slate-400 hover:text-slate-700 hover:bg-slate-100'}"
            >
              <Volume2 class="w-3.5 h-3.5" />
            </button>
          </div>
        {:else if block.type === 'quote'}
          <blockquote class="border-l-4 border-blue-500 pl-4 italic my-6 {isDark ? 'text-slate-400' : 'text-slate-500'}">
            {@html (block as Extract<ArticleBlock, { type: 'quote' }>).data.text}
          </blockquote>
        {:else if block.type === 'list'}
          <ul class="list-disc pl-5 space-y-1 my-4">
            {#each (block as Extract<ArticleBlock, { type: 'list' }>).data.items as item}
              <li>{item}</li>
            {/each}
          </ul>
        {:else if block.type === 'fact'}
          {@const fid = `b${i}`}
          <div class="border p-5 rounded-2xl my-6 {isDark ? 'bg-[#141720] border-slate-800' : 'bg-emerald-50 border-emerald-100'}">
            <div class="flex items-center justify-between mb-2">
              <h4 class="text-xs font-black text-emerald-500 uppercase tracking-widest">TAHUKAH KAMU?</h4>
              <button
                onclick={() => speak(fid, blockText(block))}
                aria-label="Dengarkan fakta"
                class="flex-shrink-0 p-1.5 rounded-lg transition-colors {speaking === fid
                  ? 'text-emerald-600 bg-emerald-600/10'
                  : isDark
                    ? 'text-slate-600 hover:text-slate-300 hover:bg-slate-800'
                    : 'text-emerald-400 hover:text-emerald-700 hover:bg-emerald-100'}"
              >
                <Volume2 class="w-3.5 h-3.5" />
              </button>
            </div>
            <p class="text-xs {isDark ? 'text-slate-300' : 'text-emerald-900'}">
              {@html (block as Extract<ArticleBlock, { type: 'fact' }>).data.text}
            </p>
          </div>
        {:else if block.type === 'divider'}
          <div class="h-px my-6 {isDark ? 'bg-slate-800' : 'bg-slate-200'}"></div>
        {:else if block.type === 'video'}
          {@const vid = (block as Extract<ArticleBlock, { type: 'video' }>).data}
          {@const embed = videoEmbedUrl(vid.url)}
          {@const tid = tiktokVideoId(vid.url)}
          {@const tp = tiktokProfile(vid.url)}
          <div class="my-6">
            {#if embed}
              <iframe
                class="w-full aspect-video rounded-2xl border {isDark ? 'border-slate-800' : 'border-slate-200'}"
                src={embed}
                title="Video"
                loading="lazy"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                referrerpolicy="strict-origin-when-cross-origin"
                allowfullscreen
              ></iframe>
            {:else if tid}
              <blockquote class="tiktok-embed" cite={vid.url} data-video-id={tid} style="max-width:605px;min-width:325px;">
                <section></section>
              </blockquote>
            {:else if tp}
              <TikTokFollowCard handle={tp.replace(/^https:\/\/www\.tiktok\.com\/@/, '')} />
            {:else}
              <video controls preload="metadata" class="w-full aspect-video rounded-2xl bg-black">
                <source src={vid.url} />
              </video>
            {/if}
            {#if vid.caption}
              <p class="text-xs mt-2 text-center {isDark ? 'text-slate-500' : 'text-slate-400'}">{vid.caption}</p>
            {/if}
          </div>
        {:else if block.type === 'image'}
          {@const img = (block as Extract<ArticleBlock, { type: 'image' }>).data}
          <figure class="my-6">
            <img
              src={img.src}
              alt={img.caption ?? ''}
              loading="lazy"
              class="w-full rounded-2xl border {isDark ? 'border-slate-800' : 'border-slate-200'}"
            />
            {#if img.caption}
              <figcaption class="text-xs mt-2 text-center {isDark ? 'text-slate-500' : 'text-slate-400'}">{img.caption}</figcaption>
            {/if}
          </figure>
        {/if}
      {/each}
    </div>

    <!-- Prev/Next Artikel -->
    {#if data.adjacent.prev || data.adjacent.next}
      <div class="mb-10 grid grid-cols-2 gap-3">
        {#if data.adjacent.prev}
          <a
            href={`/article/${data.adjacent.prev.slug}`}
            class="p-3 rounded-2xl border transition-colors {isDark ? 'bg-slate-900 border-slate-800 hover:bg-slate-800' : 'bg-white border-slate-200 hover:bg-slate-50'}"
          >
            <span class="flex items-center gap-1 text-[10px] font-black uppercase tracking-widest mb-1 {isDark ? 'text-slate-500' : 'text-slate-400'}">
              <ChevronUp class="w-3 h-3" />
              Lebih Baru
            </span>
            <span class="text-xs font-bold line-clamp-2 {isDark ? 'text-slate-200' : 'text-slate-800'}">{data.adjacent.prev.title}</span>
          </a>
        {:else}
          <div></div>
        {/if}
        {#if data.adjacent.next}
          <a
            href={`/article/${data.adjacent.next.slug}`}
            class="p-3 rounded-2xl border text-right transition-colors {isDark ? 'bg-slate-900 border-slate-800 hover:bg-slate-800' : 'bg-white border-slate-200 hover:bg-slate-50'}"
          >
            <span class="flex items-center justify-end gap-1 text-[10px] font-black uppercase tracking-widest mb-1 {isDark ? 'text-slate-500' : 'text-slate-400'}">
              Lebih Lama
              <ChevronDown class="w-3 h-3" />
            </span>
            <span class="text-xs font-bold line-clamp-2 {isDark ? 'text-slate-200' : 'text-slate-800'}">{data.adjacent.next.title}</span>
          </a>
        {/if}
      </div>
    {/if}

    <!-- Sumber -->
    {#if article.sources?.length}
      <div class="mb-10">
        <h3 class="text-xs font-black uppercase tracking-widest mb-3 {isDark ? 'text-slate-500' : 'text-slate-500'}">Sumber</h3>
        <ul class="space-y-2">
          {#each article.sources as src}
            <li>
              <a
                href={src.url}
                target="_blank"
                rel="noopener noreferrer"
                class="flex items-center gap-2 p-3 rounded-2xl border text-sm transition-colors {isDark ? 'bg-slate-900 border-slate-800 hover:bg-slate-800' : 'bg-white border-slate-200 hover:bg-slate-50'}"
              >
                <span class="flex-1 min-w-0">
                  <span class="block font-bold text-blue-600 line-clamp-2">{src.title}</span>
                  <span class="text-xs font-semibold {isDark ? 'text-slate-400' : 'text-slate-500'}">{src.publisher}</span>
                </span>
                <span class="text-blue-500 font-bold flex-shrink-0">↗</span>
              </a>
            </li>
          {/each}
        </ul>
      </div>
    {/if}

    <!-- Reactions -->
    <div class="mb-10">
      <h3 class="text-xs font-black uppercase tracking-widest mb-3 {isDark ? 'text-slate-500' : 'text-slate-500'}">Beri Reaksi</h3>
      {#if socialLoading}
        <div class="flex gap-2">
          {#each Array(4) as _}
            <div class="h-11 w-24 rounded-2xl {isDark ? 'bg-slate-800' : 'bg-slate-200'} animate-pulse"></div>
          {/each}
        </div>
      {:else}
        <div class="flex gap-2 flex-wrap">
          {#each REACTION_DEFS as def}
            {@const active = def.type === myReaction}
            <button
              onclick={() => react(def.type)}
              class="px-4 py-2.5 rounded-2xl border flex items-center gap-2 transition-all hover:scale-105 {active
                ? 'bg-blue-600 border-blue-600 text-white'
                : isDark
                  ? 'bg-slate-900 border-slate-800 text-slate-300 hover:bg-slate-800'
                  : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'}"
            >
              <span class="text-lg leading-none">{def.emoji}</span>
              <span class="text-xs font-bold">{def.label}</span>
              <span class="text-xs font-black opacity-70">{counts[def.type]}</span>
            </button>
          {/each}
        </div>
      {/if}
    </div>

    <!-- Artikel Terkait -->
    {#if data.related.length > 0}
      <div class="mb-10">
        <h3 class="text-xs font-black uppercase tracking-widest mb-3 {isDark ? 'text-slate-500' : 'text-slate-500'}">Artikel Terkait</h3>
        <div class="space-y-2">
          {#each data.related as rel}
            <a
              href={`/article/${rel.slug}`}
              class="p-3 rounded-2xl border flex items-center gap-3 transition-colors {isDark ? 'bg-slate-900 border-slate-800 hover:bg-slate-800' : 'bg-white border-slate-200 hover:bg-slate-50'}"
            >
              <CoverImage image={rel.image} class="w-16 h-16 rounded-xl flex-shrink-0" />
              <div class="flex-1 min-w-0">
                <span class="text-[10px] font-black text-blue-600 uppercase">{rel.category}</span>
                <h4 class="text-sm font-bold line-clamp-2 {isDark ? 'text-slate-100' : 'text-slate-800'}">{rel.title}</h4>
              </div>
            </a>
          {/each}
        </div>
      </div>
    {/if}

    <!-- Interactive Quiz Trigger in Article -->
    {#if data.quiz}
      <a href={`/quiz/question?id=${data.quiz.id}`} class="bg-gradient-to-br from-blue-700 to-indigo-800 rounded-[2rem] p-6 mb-10 text-white block">
        <h3 class="text-base font-black mb-1">Kuis Interaktif</h3>
        <p class="text-xs text-blue-100 mb-4">Seberapa dalam kamu memahami artikel ini? Tantang dirimu sekarang.</p>
        <span class="inline-block bg-white text-blue-950 font-bold text-xs px-4 py-2.5 rounded-xl shadow">Mulai Kuis</span>
      </a>
    {/if}

    <!-- Comments -->
    <div class="mb-4">
      <h3 class="text-base font-black mb-4 flex items-center gap-2">
        <MessageCircle class="w-4 h-4" />
        Komentar
        <span class="text-sm font-bold {isDark ? 'text-slate-500' : 'text-slate-400'}">({comments.length})</span>
      </h3>

      {#if app.isLoggedIn}
        <div class="flex gap-2 mb-5">
          <input
            bind:value={commentText}
            maxlength="1000"
            placeholder="Tulis komentar..."
            onkeydown={(e) => e.key === 'Enter' && submitComment()}
            class="flex-1 min-w-0 px-4 py-2.5 rounded-2xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 {isDark
              ? 'bg-slate-900 border-slate-800 text-slate-100 placeholder:text-slate-500'
              : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
          />
          <button
            onclick={submitComment}
            disabled={posting || !commentText.trim()}
            class="px-4 rounded-2xl bg-blue-600 text-white font-bold disabled:opacity-40 disabled:cursor-not-allowed hover:bg-blue-700 transition-colors"
          >
            <Send class="w-4 h-4" />
          </button>
        </div>
      {:else}
        <button
          onclick={() => goto('/login')}
          class="w-full border-dashed border rounded-2xl py-3 text-sm font-bold mb-5 transition-colors {isDark
            ? 'border-slate-700 text-slate-400 hover:bg-slate-900'
            : 'border-slate-300 text-slate-500 hover:bg-slate-50'}"
        >
          Masuk untuk berkomentar
        </button>
      {/if}

      {#if socialLoading}
        <div class="space-y-3">
          {#each Array(2) as _}
            <div class="flex gap-3">
              <div class="w-8 h-8 rounded-xl {isDark ? 'bg-slate-800' : 'bg-slate-200'} animate-pulse"></div>
              <div class="flex-1 space-y-2">
                <div class="h-3 w-24 {isDark ? 'bg-slate-800' : 'bg-slate-200'} rounded animate-pulse"></div>
                <div class="h-3 w-2/3 {isDark ? 'bg-slate-800' : 'bg-slate-200'} rounded animate-pulse"></div>
              </div>
            </div>
          {/each}
        </div>
      {:else if comments.length === 0}
        <p class="text-sm text-center py-8 {isDark ? 'text-slate-500' : 'text-slate-400'}">
          Belum ada komentar. Jadilah yang pertama! 💬
        </p>
      {:else}
        <div class="space-y-5">
          {#each comments as c}
            <div class="flex gap-3">
              <AvatarInitials name={c.authorName} size="sm" class="mt-0.5" />
              <div class="flex-1 min-w-0">
                <div class="flex items-baseline gap-2 mb-0.5">
                  <span class="text-xs font-black {isDark ? 'text-slate-200' : 'text-slate-700'}">{c.authorName}</span>
                  {#if c.mine}
                    <span class="text-[10px] font-bold text-blue-500">Kamu</span>
                  {/if}
                  <span class="text-[10px] {isDark ? 'text-slate-500' : 'text-slate-400'}">{timeAgo(c.createdAt)}</span>
                </div>
                <p class="text-sm leading-relaxed {isDark ? 'text-slate-300' : 'text-slate-600'}">{c.content}</p>
              </div>
            </div>
          {/each}
        </div>
      {/if}
    </div>
  </div>
  {/if}
</div>

<style>
  :global(.prose-html img) {
    cursor: zoom-in;
    border-radius: 1rem;
    max-width: 100%;
    height: auto;
  }
</style>

{#if lightboxSrc}
  <div
    onclick={() => (lightboxSrc = '')}
    onkeydown={(e) => e.key === 'Escape' && (lightboxSrc = '')}
    class="fixed inset-0 z-50 bg-black/90 flex items-center justify-center p-4 cursor-zoom-out"
    role="button"
    aria-label="Tutup pratinjau gambar"
    tabindex="0"
  >
    <img src={lightboxSrc} alt="" class="max-w-full max-h-full rounded-xl shadow-2xl" />
  </div>
{/if}

{#if speaking !== null}
  <div class="fixed bottom-4 left-1/2 -translate-x-1/2 z-40 flex items-center gap-2 px-4 py-2.5 rounded-2xl shadow-2xl border backdrop-blur-xl {isDark ? 'bg-slate-900/95 border-slate-700' : 'bg-white/95 border-slate-200'}">
    <button
      onclick={speakAll}
      class="p-2 rounded-full transition-colors {isDark ? 'text-slate-300 hover:bg-slate-800' : 'text-slate-700 hover:bg-slate-100'}"
      aria-label={paused ? 'Lanjutkan membaca' : 'Jeda membaca'}
    >
      {#if paused}
        <Play class="w-5 h-5" />
      {:else}
        <Pause class="w-5 h-5" />
      {/if}
    </button>
    <span class="text-[10px] font-black px-2 py-1 rounded-lg {isDark ? 'bg-slate-800 text-slate-400' : 'bg-slate-100 text-slate-500'}">
      {rate}x
    </span>
    <button
      onclick={stopSpeaking}
      class="p-2 rounded-full transition-colors {isDark ? 'text-slate-300 hover:bg-slate-800' : 'text-slate-700 hover:bg-slate-100'}"
      aria-label="Berhenti membaca"
    >
      <Square class="w-5 h-5" />
    </button>
  </div>
{/if}
