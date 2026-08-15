<script lang="ts">
  import {
    Type, Heading2, Heading3, Play, Quote, Sparkles,
    Bold, Italic, Underline, Strikethrough, List, ListOrdered,
    Trash2, Upload, Send, FileText, CheckCircle2
  } from '@lucide/svelte';
  import { goto } from '$app/navigation';
  import { page } from '$app/state';
  import type { Category, ArticleBlock } from '$lib/types';
  import { app } from '$lib/stores/app.svelte';
  import TopBar from '$lib/components/TopBar.svelte';
  import { getCategories, submitArticle, updateArticle, getArticleById, uploadArticleImage, uploadVideoFile } from '$lib/api';
  import { sanitizeHtml } from '$lib/format';

  let isDark = $derived(app.theme === 'dark');

  type TextType = 'paragraph' | 'heading' | 'quote' | 'fact';
  type EditBlock = { type: TextType; html: string } | { type: 'video'; url: string; caption: string };

  const TEXT_META: Record<TextType, { label: string; accent: string; placeholder: string; editorClass: string }> = {
    paragraph: {
      label: 'Paragraf',
      accent: 'text-blue-500',
      placeholder: 'Tulis paragraf… tebal, miring, atau list tersedia di toolbar',
      editorClass: 'text-sm leading-relaxed'
    },
    heading: {
      label: 'Judul',
      accent: 'text-indigo-500',
      placeholder: 'Teks judul bagian…',
      editorClass: 'text-lg font-black tracking-tight'
    },
    quote: {
      label: 'Kutipan',
      accent: 'text-amber-500',
      placeholder: 'Tulis kutipan…',
      editorClass: 'text-sm italic'
    },
    fact: {
      label: 'Fakta',
      accent: 'text-emerald-500',
      placeholder: 'Satu fakta singkat…',
      editorClass: 'text-sm font-semibold'
    }
  };

  let categories = $state<Category[]>([]);
  let title = $state('');
  let excerpt = $state('');
  let categoryId = $state<number>(0);
  let coverImage = $state('');
  let coverUploading = $state(false);
  let blocks = $state<EditBlock[]>([]);
  let sources = $state<{ title: string; url: string; publisher: string }[]>([]);
  let submitting = $state(false);
  let error = $state('');
  let submitted = $state(false);
  let refs: (HTMLElement | undefined)[] = [];

  const editId = $derived(Number(page.url.searchParams.get('edit') || 0));

  function blocksToEdit(raw: ArticleBlock[]): EditBlock[] {
    return raw.map((b) => {
      if (b.type === 'video') return { type: 'video', url: b.data.url, caption: b.data.caption ?? '' };
      if (b.type === 'list') {
        return { type: 'paragraph', html: `<ul><li>${b.data.items.join('</li><li>')}</li></ul>` };
      }
      if (b.type === 'paragraph' || b.type === 'heading' || b.type === 'quote' || b.type === 'fact') {
        return { type: b.type, html: b.data.text };
      }
      return { type: 'paragraph', html: '' };
    });
  }

  $effect(() => {
    getCategories().then((c) => {
      categories = c;
      if (c.length > 0 && !categoryId) categoryId = c[0].id;
      if (editId) {
        getArticleById(editId).then((art) => {
          if (!art) {
            error = 'Artikel tidak ditemukan atau bukan milikmu.';
            return;
          }
          title = art.title;
          excerpt = art.excerpt;
          coverImage = art.image;
          blocks = blocksToEdit(art.content);
          sources = art.sources?.map((s) => ({ title: s.title, url: s.url, publisher: s.publisher })) ?? [];
          const cat = c.find((x) => x.slug === art.categorySlug);
          if (cat) categoryId = cat.id;
        });
      }
    });
  });

  let words = $derived.by(() => {
    let n = 0;
    for (const b of blocks) {
      if (b.type !== 'video') n += (b.html ?? '').replace(/<[^>]+>/g, ' ').split(/\s+/).filter(Boolean).length;
      if (b.type === 'video' && b.caption) n += b.caption.split(/\s+/).filter(Boolean).length;
    }
    return n;
  });
  let readTimeMinutes = $derived(Math.max(1, Math.round(words / 200)));

  function addBlock(type: EditBlock['type']) {
    blocks = [
      ...blocks,
      type === 'video' ? { type: 'video', url: '', caption: '' } : { type, html: '' }
    ] as EditBlock[];
    requestAnimationFrame(() => refs[blocks.length - 1]?.focus());
  }

  function removeBlock(i: number) {
    blocks = blocks.filter((_, idx) => idx !== i);
  }

  function addSource() {
    sources = [...sources, { title: '', url: '', publisher: '' }];
  }

  function removeSource(i: number) {
    sources = sources.filter((_, idx) => idx !== i);
  }

  // WYSIWYG via fitur native browser (document.execCommand).
  // ponytail: execCommand deprecated tapi didukung semua browser; ganti ke Selection.surroundContents / lib (Tiptap) bila browser melepasnya.
  function runCmd(block: EditBlock, cmd: string, value?: string) {
    if (block.type === 'video') return;
    document.execCommand(cmd, false, value);
    const el = document.activeElement as HTMLElement | null;
    if (el?.isContentEditable) block.html = el.innerHTML;
  }

  async function uploadCover(file: File) {
    coverUploading = true;
    try {
      coverImage = await uploadArticleImage(file);
    } catch {
      error = 'Gagal mengunggah sampul. Coba lagi.';
    }
    coverUploading = false;
  }

  async function uploadVideo(idx: number, file: File) {
    try {
      const url = await uploadVideoFile(file);
      blocks = blocks.map((b, i) => (i === idx ? { ...b, url } : b));
    } catch {
      error = 'Gagal mengunggah video. Coba lagi.';
    }
  }

  async function handleSubmit() {
    if (submitting) return;
    if (!title.trim()) { error = 'Judul wajib diisi.'; return; }
    if (!categoryId) { error = 'Pilih kategori.'; return; }
    if (blocks.length === 0) { error = 'Tambahkan minimal satu blok konten.'; return; }

    const content: ArticleBlock[] = blocks.map((b) => {
      if (b.type === 'video') return { type: 'video', data: { url: b.url ?? '', caption: b.caption ?? '' } };
      return { type: b.type, data: { text: sanitizeHtml(b.html ?? '') } };
    });

    for (const c of content) {
      const txt = (c as { data?: { text?: string } }).data?.text ?? '';
      if (c.type === 'video') {
        const url = (c as { data: { url: string } }).data.url;
        if (!url.trim()) { error = 'Blok video harus diisi URL atau file video.'; return; }
      } else if (!txt.replace(/<[^>]+>/g, ' ').trim()) {
        error = 'Blok teks tidak boleh kosong.';
        return;
      }
    }

    error = '';
    submitting = true;
    const input = {
      title: title.trim(),
      categoryId,
      excerpt: excerpt.trim(),
      coverImage,
      content,
      readTimeMinutes,
      sources: sources.filter((s) => s.title.trim())
    };
    const ok = editId ? await updateArticle(editId, input) : await submitArticle(input);
    submitting = false;
    if (ok) {
      submitted = true;
    } else {
      error = editId ? 'Gagal menyimpan perubahan. Periksa koneksi dan coba lagi.' : 'Gagal mengirim artikel. Periksa koneksi dan coba lagi.';
    }
  }
</script>

<div class="min-h-full pb-20 transition-colors duration-300 {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-white'}">
  <TopBar title={editId ? 'Edit Artikel' : 'Tulis Artikel'} backHref="/kelola" />

  {#if submitted}
    <div class="px-6 py-16 flex flex-col items-center text-center">
      <div class="w-16 h-16 rounded-2xl bg-emerald-500/15 flex items-center justify-center mb-4">
        {#if editId}
          <CheckCircle2 class="w-7 h-7 text-emerald-500" />
        {:else}
          <Send class="w-7 h-7 text-emerald-500" />
        {/if}
      </div>
      <h2 class="text-lg font-black mb-2">{editId ? 'Perubahan tersimpan!' : 'Artikel terkirim!'}</h2>
      <p class="text-sm mb-6 {isDark ? 'text-slate-400' : 'text-slate-500'}">
        {editId ? 'Perubahan akan tampil setelah disetujui admin.' : 'Artikel kamu masuk antrean dan akan tampil setelah disetujui admin.'}
      </p>
      <div class="flex gap-2">
        <button
          onclick={() => goto('/kelola')}
          class="px-5 py-2.5 bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold rounded-xl transition-all active:scale-95"
        >
          Kelola Konten
        </button>
        <button
          onclick={() => goto('/profile')}
          class="px-5 py-2.5 border text-xs font-bold rounded-xl transition-all active:scale-95 {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-900' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}"
        >
          Ke Profil
        </button>
      </div>
    </div>
  {:else}
    <div class="px-6 py-5 space-y-5">

      <!-- Judul + kategori -->
      <div class="rounded-2xl border overflow-hidden rise-in {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
        <input
          bind:value={title}
          placeholder="Judul artikel yang bikin penasaran…"
          class="w-full px-5 pt-5 pb-4 text-lg font-black bg-transparent outline-none {isDark ? 'text-slate-100 placeholder:text-slate-600' : 'text-slate-900 placeholder:text-slate-400'}"
        />
        <div class="flex items-center gap-2 px-5 pb-5">
          <select
            bind:value={categoryId}
            class="flex-1 min-w-0 px-3 py-2.5 rounded-xl border text-xs font-bold outline-none {isDark ? 'bg-slate-950 border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}"
          >
            {#each categories as c}
              <option value={c.id}>{c.name}</option>
            {/each}
          </select>
          <span class="shrink-0 text-[10px] font-black uppercase px-3 py-2.5 rounded-xl {isDark ? 'bg-slate-800 text-slate-400' : 'bg-slate-100 text-slate-500'}">
            ±{readTimeMinutes} mnt
          </span>
        </div>
      </div>

      <!-- Ringkasan -->
      <textarea
        bind:value={excerpt}
        rows="2"
        placeholder="Ringkasan singkat (tampil di halaman beranda)"
        class="w-full px-4 py-3 rounded-2xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 resize-none {isDark ? 'bg-slate-900 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
      ></textarea>

      <!-- Sampul -->
      <div class="space-y-2">
        <p class="text-xs font-black uppercase tracking-widest {isDark ? 'text-slate-500' : 'text-slate-500'}">Sampul Artikel</p>
        {#if coverImage}
          <div class="relative rounded-2xl overflow-hidden border {isDark ? 'border-slate-800' : 'border-slate-200'}">
            <img src={coverImage} alt="Sampul" class="w-full h-36 object-cover" />
            <button
              onclick={() => (coverImage = '')}
              class="absolute top-2 right-2 p-1.5 rounded-lg bg-black/60 text-white"
              aria-label="Hapus sampul"
            >
              <Trash2 class="w-4 h-4" />
            </button>
          </div>
        {:else}
          <label
            class="flex flex-col items-center justify-center gap-1.5 py-6 rounded-2xl border-dashed border cursor-pointer transition-colors {isDark ? 'border-slate-700 text-slate-400 hover:bg-slate-900' : 'border-slate-300 text-slate-500 hover:bg-slate-50'}"
          >
            {#if coverUploading}
              <div class="w-5 h-5 border-2 border-blue-600 border-t-transparent rounded-full animate-spin"></div>
              <span class="text-xs font-bold">Mengunggah...</span>
            {:else}
              <Upload class="w-5 h-5" />
              <span class="text-xs font-bold">Unggah gambar sampul</span>
            {/if}
            <input type="file" accept="image/*" class="hidden" onchange={(e) => e.currentTarget.files?.[0] && uploadCover(e.currentTarget.files[0])} />
          </label>
          <input
            bind:value={coverImage}
            placeholder="…atau tempel URL gambar"
            class="w-full px-4 py-3 rounded-2xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 {isDark ? 'bg-slate-900 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
          />
        {/if}
      </div>

      <!-- Konten -->
      <div class="space-y-3">
        <p class="text-xs font-black uppercase tracking-widest {isDark ? 'text-slate-500' : 'text-slate-500'}">Konten</p>

        {#if blocks.length === 0}
          <button
            onclick={() => addBlock('paragraph')}
            class="w-full flex flex-col items-center justify-center gap-2 py-10 rounded-2xl border-dashed border transition-colors {isDark ? 'border-slate-700 text-slate-500 hover:bg-slate-900' : 'border-slate-300 text-slate-400 hover:bg-slate-50'}"
          >
            <span class="w-12 h-12 rounded-2xl bg-blue-600 flex items-center justify-center text-white">
              <FileText class="w-6 h-6" />
            </span>
            <span class="text-sm font-black">Mulai tulis kontenmu</span>
            <span class="text-xs">Tekan tombol blok di bawah untuk menambahkan</span>
          </button>
        {/if}

        <div class="grid grid-cols-5 gap-2">
          <button onclick={() => addBlock('paragraph')} class="flex flex-col items-center gap-1 py-2.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-900' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}">
            <Type class="w-4 h-4 text-blue-500" />
            <span class="text-[9px] font-black">Paragraf</span>
          </button>
          <button onclick={() => addBlock('heading')} class="flex flex-col items-center gap-1 py-2.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-900' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}">
            <Heading2 class="w-4 h-4 text-indigo-500" />
            <span class="text-[9px] font-black">Judul</span>
          </button>
          <button onclick={() => addBlock('quote')} class="flex flex-col items-center gap-1 py-2.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-900' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}">
            <Quote class="w-4 h-4 text-amber-500" />
            <span class="text-[9px] font-black">Kutipan</span>
          </button>
          <button onclick={() => addBlock('fact')} class="flex flex-col items-center gap-1 py-2.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-900' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}">
            <Sparkles class="w-4 h-4 text-emerald-500" />
            <span class="text-[9px] font-black">Fakta</span>
          </button>
          <button onclick={() => addBlock('video')} class="flex flex-col items-center gap-1 py-2.5 rounded-2xl border transition-all active:scale-95 {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-900' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}">
            <Play class="w-4 h-4 text-rose-500" />
            <span class="text-[9px] font-black">Video</span>
          </button>
        </div>

        {#if blocks.length > 0}
          <div class="space-y-3">
            {#each blocks as block, i (i)}
              {#if block.type === 'video'}
                <div class="p-3 rounded-2xl border {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
                  <div class="flex items-center justify-between mb-2">
                    <span class="text-[10px] font-black uppercase tracking-widest text-rose-500">Video</span>
                    <button onclick={() => removeBlock(i)} class="p-1 rounded-lg {isDark ? 'text-slate-500 hover:bg-slate-800' : 'text-slate-400 hover:bg-slate-100'}" aria-label="Hapus blok">
                      <Trash2 class="w-4 h-4" />
                    </button>
                  </div>
                  <div class="space-y-2">
                    <div class="flex gap-2">
                      <input
                        bind:value={block.url}
                        placeholder="URL YouTube, TikTok, atau file video (mp4)"
                        class="flex-1 min-w-0 px-3 py-2.5 rounded-xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 {isDark ? 'bg-slate-950 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
                      />
                      <label class="flex items-center gap-1 px-3 rounded-xl border text-xs font-bold cursor-pointer {isDark ? 'border-slate-700 text-slate-300 hover:bg-slate-800' : 'border-slate-200 text-slate-700 hover:bg-slate-50'}">
                        <Upload class="w-3.5 h-3.5" />
                        Unggah
                        <input type="file" accept="video/*" class="hidden" onchange={(e) => e.currentTarget.files?.[0] && uploadVideo(i, e.currentTarget.files[0])} />
                      </label>
                    </div>
                    <input
                      bind:value={block.caption}
                      placeholder="Keterangan video (opsional)"
                      class="w-full px-3 py-2.5 rounded-xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 {isDark ? 'bg-slate-950 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
                    />
                  </div>
                </div>
              {:else}
                {@const meta = TEXT_META[block.type]}
                <div class="rounded-2xl border overflow-hidden {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
                  <div class="flex items-center justify-between gap-2 px-3 py-2 border-b {isDark ? 'border-slate-800' : 'border-slate-100'}">
                    <span class="text-[10px] font-black uppercase tracking-widest shrink-0 {meta.accent}">{meta.label}</span>
                    <div class="flex items-center gap-0.5 overflow-x-auto hide-scrollbar">
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'formatBlock', 'p')} class="toolbar-mini" aria-label="Paragraf">
                        <Type class="w-3.5 h-3.5" />
                      </button>
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'formatBlock', 'h2')} class="toolbar-mini" aria-label="Judul H2">
                        <Heading2 class="w-3.5 h-3.5" />
                      </button>
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'formatBlock', 'h3')} class="toolbar-mini" aria-label="Judul H3">
                        <Heading3 class="w-3.5 h-3.5" />
                      </button>
                      <span class="w-px h-4 mx-0.5 {isDark ? 'bg-slate-700' : 'bg-slate-200'}"></span>
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'bold')} class="toolbar-mini font-black" aria-label="Tebal">
                        <Bold class="w-3.5 h-3.5" />
                      </button>
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'italic')} class="toolbar-mini italic" aria-label="Miring">
                        <Italic class="w-3.5 h-3.5" />
                      </button>
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'underline')} class="toolbar-mini underline" aria-label="Garis bawah">
                        <Underline class="w-3.5 h-3.5" />
                      </button>
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'strikeThrough')} class="toolbar-mini line-through" aria-label="Coret">
                        <Strikethrough class="w-3.5 h-3.5" />
                      </button>
                      <span class="w-px h-4 mx-0.5 {isDark ? 'bg-slate-700' : 'bg-slate-200'}"></span>
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'insertUnorderedList')} class="toolbar-mini" aria-label="List">
                        <List class="w-3.5 h-3.5" />
                      </button>
                      <button onmousedown={(e) => e.preventDefault()} onclick={() => runCmd(block, 'insertOrderedList')} class="toolbar-mini" aria-label="List nomor">
                        <ListOrdered class="w-3.5 h-3.5" />
                      </button>
                      <button onclick={() => removeBlock(i)} class="p-1.5 rounded-lg {isDark ? 'text-rose-400 hover:bg-slate-800' : 'text-rose-500 hover:bg-slate-100'}" aria-label="Hapus blok">
                        <Trash2 class="w-3.5 h-3.5" />
                      </button>
                    </div>
                  </div>
                  <div
                    contenteditable="true"
                    role="textbox"
                    data-placeholder={meta.placeholder}
                    class="editor-empty prose-html outline-none px-4 py-3 {meta.editorClass} {block.type === 'fact' ? (isDark ? 'text-emerald-400' : 'text-emerald-600') : isDark ? 'text-slate-200' : 'text-slate-800'}"
                    oninput={(e) => (block.html = e.currentTarget.innerHTML)}
                    bind:this={refs[i]}
                  >
                    {@html block.html ?? ''}
                  </div>
                </div>
              {/if}
            {/each}
          </div>
        {/if}
      </div>

      <!-- Sumber -->
      <div class="space-y-2">
        <div class="flex items-center justify-between">
          <p class="text-xs font-black uppercase tracking-widest {isDark ? 'text-slate-500' : 'text-slate-500'}">Sumber (opsional)</p>
          <button
            onclick={addSource}
            class="px-2.5 py-1.5 rounded-lg text-[10px] font-black uppercase bg-blue-600 hover:bg-blue-500 text-white transition-all active:scale-95"
          >
            + Tambah
          </button>
        </div>

        {#if sources.length === 0}
          <p class="text-xs rounded-2xl border-dashed border px-4 py-3 {isDark ? 'border-slate-700 text-slate-500' : 'border-slate-300 text-slate-400'}">
            Tempel sumber referensi untuk memperkuat artikelmu (mis. Wikipedia, jurnal, situs berita).
          </p>
        {/if}

        {#each sources as src, i (i)}
          <div class="rounded-2xl border p-3 space-y-2 {isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200'}">
            <div class="flex items-center justify-between">
              <span class="text-[10px] font-black uppercase tracking-widest text-blue-500">Sumber {i + 1}</span>
              <button onclick={() => removeSource(i)} class="p-1 rounded-lg {isDark ? 'text-rose-400 hover:bg-slate-800' : 'text-rose-500 hover:bg-slate-100'}" aria-label="Hapus sumber">
                <Trash2 class="w-3.5 h-3.5" />
              </button>
            </div>
            <input
              bind:value={src.title}
              placeholder="Judul sumber (wajib)"
              class="w-full px-3 py-2.5 rounded-xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 {isDark ? 'bg-slate-950 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
            />
            <div class="grid grid-cols-2 gap-2">
              <input
                bind:value={src.url}
                placeholder="URL (https://…)"
                class="w-full px-3 py-2.5 rounded-xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 {isDark ? 'bg-slate-950 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
              />
              <input
                bind:value={src.publisher}
                placeholder="Penerbit"
                class="w-full px-3 py-2.5 rounded-xl border text-sm outline-none focus:ring-2 focus:ring-blue-500 {isDark ? 'bg-slate-950 border-slate-800 text-slate-100 placeholder:text-slate-500' : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
              />
            </div>
          </div>
        {/each}
      </div>

      {#if error}
        <p class="text-xs font-bold text-red-500">{error}</p>
      {/if}

      <button
        onclick={handleSubmit}
        disabled={submitting}
        class="w-full py-3.5 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-sm transition-all active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed shadow-md shadow-blue-600/20 flex items-center justify-center gap-2"
      >
        {#if submitting}
          <div class="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
          {editId ? 'Menyimpan...' : 'Mengirim...'}
        {:else}
          <Send class="w-4 h-4" />
          {editId ? 'Simpan Perubahan' : 'Kirim untuk Persetujuan'}
        {/if}
      </button>
      <p class="text-[10px] text-center {isDark ? 'text-slate-600' : 'text-slate-400'}">
        {words} kata • ±{readTimeMinutes} mnt baca • {editId ? 'Perubahan butuh persetujuan admin' : 'Artikel tampil setelah disetujui admin'}
      </p>
    </div>
  {/if}
</div>

<style>
  .toolbar-mini {
    padding: 0.25rem;
    border-radius: 0.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  :global(.toolbar-mini):hover {
    opacity: 0.7;
  }
</style>
