import { supabase } from '$lib/supabase';
import type { Article, ArticleBlock, ArticleReaction, Category, CommentItem, NotificationItem, Quiz, QuizQuestion, SekejapFact, UserProfile, UserRole, VideoItem } from '$lib/types';

const CACHE_TTL_MS = 30_000;
const cache = new Map<string, { t: number; v: unknown }>();

async function cached<T>(key: string, fn: () => Promise<T>): Promise<T> {
  const hit = cache.get(key);
  if (hit && Date.now() - hit.t < CACHE_TTL_MS) return hit.v as T;
  const v = await fn();
  cache.set(key, { t: Date.now(), v });
  return v;
}

function toCategory(row: Record<string, unknown>): Category {
  return {
    id: Number(row.id),
    name: String(row.name),
    slug: String(row.slug),
    description: String(row.description ?? '')
  };
}

function toArticle(row: Record<string, unknown>): Article {
  const related = (row.categories as Record<string, unknown> | null) ?? null;
  return {
    id: Number(row.id),
    slug: String(row.slug),
    title: String(row.title),
    category: related ? String(related.name).toUpperCase() : 'FAKTA',
    categorySlug: related ? String(related.slug) : undefined,
    readTime: `${Number(row.read_time_minutes ?? 3)} mnt baca`,
    excerpt: String(row.excerpt ?? ''),
    author: String(row.author_name ?? 'Sekta'),
    date: formatDate(row.published_at as string | null | undefined),
    image: String(row.cover_image ?? ''),
    featured: Boolean((row as Record<string, unknown>).featured),
    viewCount: Number(row.view_count ?? 0),
    status: row.status != null ? String(row.status) : undefined,
    content: parseBlocks(row.content),
    sources: Array.isArray(row.sources)
      ? (row.sources as { title?: unknown; url?: unknown; publisher?: unknown }[]).map((s) => ({
          title: String(s.title ?? ''),
          url: String(s.url ?? ''),
          publisher: String(s.publisher ?? '')
        }))
      : undefined
  };
}

function parseBlocks(raw: unknown): ArticleBlock[] {
  if (!Array.isArray(raw)) return [];
  return raw.filter((b): b is ArticleBlock => {
    const t = (b as { type?: string })?.type;
    return typeof t === 'string';
  });
}

function formatDate(iso: string | null | undefined): string {
  if (!iso) return '';
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return '';
  return d.toLocaleDateString('id-ID', { day: 'numeric', month: 'short', year: 'numeric' });
}

export async function getCategories(): Promise<Category[]> {
  return cached('categories', async () => {
    const { data, error } = await supabase.from('categories').select('*').order('position', { ascending: true });
    if (error) throw error;
    return (data ?? []).map(toCategory);
  });
}

export async function getArticles(limit?: number): Promise<Article[]> {
  return cached(limit ? `articles:${limit}` : 'articles', async () => {
    let q = supabase
      .from('articles')
      .select('*, categories(name, slug)')
      .eq('status', 'PUBLISHED')
      .order('published_at', { ascending: false });
    if (limit) q = q.limit(limit);
    const { data, error } = await q;
    if (error) throw error;
    return (data ?? []).map(toArticle);
  });
}

export async function getArticlesPage(
  categorySlug: string | null,
  offset: number,
  limit: number
): Promise<{ articles: Article[]; total: number | null }> {
  let q = supabase
    .from('articles')
    .select('*, categories(name, slug)', { count: 'exact' })
    .eq('status', 'PUBLISHED')
    .order('published_at', { ascending: false })
    .range(offset, offset + limit - 1);
  if (categorySlug) q = q.eq('categories.slug', categorySlug);
  const { data, error, count } = await q;
  if (error) throw error;
  return { articles: (data ?? []).map(toArticle), total: count };
}

export async function getArticleBySlug(slug: string): Promise<Article | undefined> {
  return cached(`article:${slug}`, async () => {
    const { data, error } = await supabase
      .from('articles')
      .select('*, categories(name, slug), sources(title, url, publisher)')
      .eq('slug', slug)
      .eq('status', 'PUBLISHED')
      .maybeSingle();
    if (error) throw error;
    return data ? toArticle(data) : undefined;
  });
}

export async function incrementArticleView(articleId: number): Promise<void> {
  try {
    await supabase.rpc('increment_article_view', { aid: articleId });
  } catch {
    // abai: penghitung baca tidak boleh menggagalkan halaman
  }
}

export async function getRelatedArticles(slug: string): Promise<Article[]> {
  const current = await getArticleBySlug(slug);
  if (!current) return [];
  const all = await getArticles();
  return all.filter(a => a.slug !== slug && a.categorySlug === current.categorySlug).slice(0, 3);
}

// Prev/next berdasarkan urutan publikasi (list diurutkan published_at DESC).
// prev = artikel lebih baru, next = artikel lebih lama (alur baca berurutan).
export async function getAdjacentArticles(
  slug: string
): Promise<{ prev: Article | null; next: Article | null }> {
  const all = await getArticles();
  const i = all.findIndex((a) => a.slug === slug);
  if (i === -1) return { prev: null, next: null };
  return { prev: all[i - 1] ?? null, next: all[i + 1] ?? null };
}

// Trending = artikel paling banyak DILIHAT + DIREAKSI (view_count + jumlah reaksi).
// Diambil 20 teratas by view lalu diurutkan client oleh skor gabungan.
export async function getTrendingArticles(limit = 5): Promise<Article[]> {
  return cached(`trending:${limit}`, async () => {
    const { data, error } = await supabase
      .from('articles')
      .select('*, categories(name, slug), reactions:article_reactions(count)')
      .eq('status', 'PUBLISHED')
      .order('view_count', { ascending: false })
      .limit(20);
    if (error) throw error;
    return (data ?? [])
      .map((row) => {
        const a = toArticle(row);
        const rc = Array.isArray(row.reactions) ? Number((row.reactions[0] as { count?: number })?.count ?? 0) : 0;
        return { ...a, reactionCount: rc };
      })
      .sort((a, b) => b.viewCount + (b.reactionCount ?? 0) - (a.viewCount + (a.reactionCount ?? 0)))
      .slice(0, limit);
  });
}

export async function searchArticles(q: string): Promise<Article[]> {
  return cached(`search:${q}`, async () => {
    const { data, error } = await supabase
      .from('articles')
      .select('*, categories(name, slug)')
      .eq('status', 'PUBLISHED')
      .textSearch('search', q, { type: 'websearch' })
      .order('published_at', { ascending: false })
      .limit(20);
    if (error) throw error;
    return (data ?? []).map(toArticle);
  });
}

export async function getSekejapFacts(): Promise<SekejapFact[]> {
  return cached('facts', async () => {
    const { data, error } = await supabase.from('sekejap_facts').select('*').order('created_at', { ascending: false });
    if (error) throw error;
    return (data ?? []).map(f => ({
      id: Number(f.id),
      fact: String(f.fact),
      articleId: f.article_id != null ? Number(f.article_id) : null
    }));
  });
}

export async function getQuizList(): Promise<Quiz[]> {
  return cached('quizzes', async () => {
    const { data, error } = await supabase.from('quizzes').select('*, articles(cover_image)').order('id', { ascending: true });
    if (error) throw error;
    return (data ?? []).map(q => ({
      id: Number(q.id),
      title: String(q.title),
      description: String(q.description ?? ''),
      coverImage: q.articles && typeof q.articles === 'object' ? String((q.articles as Record<string, unknown>).cover_image ?? '') : ''
    }));
  });
}

export async function getQuizByArticle(articleId: number): Promise<Quiz | null> {
  return cached(`quiz:article:${articleId}`, async () => {
    const { data, error } = await supabase
      .from('quizzes')
      .select('id, title, description')
      .eq('article_id', articleId)
      .maybeSingle();
    if (error) throw error;
    if (!data) return null;
    return {
      id: Number(data.id),
      title: String(data.title),
      description: String(data.description ?? '')
    };
  });
}

export async function getQuizQuestions(quizId: number): Promise<QuizQuestion[]> {
  return cached(`questions:${quizId}`, async () => {
    const { data: q, error } = await supabase
      .from('quiz_questions')
      .select('*, quiz_options(*)')
      .eq('quiz_id', quizId)
      .order('position', { ascending: true });
    if (error) throw error;
    return (q ?? []).map(row => ({
      id: Number(row.id),
      question: String(row.question),
      options: ((row.quiz_options as Record<string, unknown>[]) ?? [])
        .map(o => ({
          id: Number(o.id),
          label: String(o.label),
          isCorrect: Boolean(o.is_correct)
        }))
        .sort((a, b) => a.id - b.id)
    }));
  });
}

export async function getSavedArticles(): Promise<Article[]> {
  try {
    const { data, error } = await supabase
      .from('saved_articles')
      .select('articles(*, categories(name, slug))');
    if (error) throw error;
    if (!data || data.length === 0) return [];
    const rows = data as unknown as { articles: Record<string, unknown> }[];
    return rows
      .map((row) => toArticle(row.articles))
      .filter((a) => a.id != null);
  } catch {
    return [];
  }
}

export async function setArticleSaved(articleId: number, save: boolean): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    if (save) {
      const { error } = await supabase
        .from('saved_articles')
        .insert({ user_id: auth.user.id, article_id: articleId });
      return !error;
    } else {
      const { error } = await supabase
        .from('saved_articles')
        .delete()
        .eq('user_id', auth.user.id)
        .eq('article_id', articleId);
      return !error;
    }
  } catch {
    return false;
  }
}

export async function getProfile(): Promise<UserProfile | null> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return null;
    const { data, error } = await supabase.from('profiles').select('*').eq('id', auth.user.id).maybeSingle();
    if (error) throw error;
    const { count: savedCount } = await supabase
      .from('saved_articles')
      .select('*', { count: 'exact', head: true })
      .eq('user_id', auth.user.id);
    const { count: quizCount } = await supabase
      .from('quiz_results')
      .select('*', { count: 'exact', head: true })
      .eq('user_id', auth.user.id);
    return {
      name: String(data?.name ?? ''),
      username: String(data?.username ?? ''),
      bio: String(data?.bio ?? ''),
      avatar: String(data?.avatar ?? ''),
      role: (String(data?.role ?? 'USER') as UserRole),
      stats: {
        articles: savedCount ?? 0,
        quizzes: quizCount ?? 0
      }
    };
  } catch {
    return null;
  }
}

export async function updateProfile(partial: Partial<UserProfile>): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const payload: Record<string, string | number> = {};
    if (partial.name !== undefined) payload.name = partial.name;
    if (partial.username !== undefined) payload.username = partial.username;
    if (partial.bio !== undefined) payload.bio = partial.bio;
    if (partial.avatar !== undefined) payload.avatar = partial.avatar;
    if (Object.keys(payload).length === 0) return true;
    const { error } = await supabase.from('profiles').update(payload).eq('id', auth.user.id);
    return !error;
  } catch {
    return false;
  }
}

function toNotification(row: Record<string, unknown>): NotificationItem {
  return {
    id: Number(row.id),
    title: String(row.title),
    description: String(row.description),
    createdAt: String(row.created_at ?? ''),
    link: String(row.link ?? ''),
    unread: Boolean(row.unread)
  };
}

export async function getNotifications(): Promise<NotificationItem[]> {
  const { data: auth } = await supabase.auth.getUser();
  if (!auth?.user) return [];
  const { data, error } = await supabase
    .from('notifications')
    .select('*')
    .eq('user_id', auth.user.id)
    .order('created_at', { ascending: false });
  if (error) throw error;
  return (data ?? []).map(toNotification);
}

export async function getNotification(id: number): Promise<NotificationItem | null> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return null;
    const { data, error } = await supabase
      .from('notifications')
      .select('*')
      .eq('id', id)
      .eq('user_id', auth.user.id)
      .maybeSingle();
    if (error || !data) return null;
    return toNotification(data as Record<string, unknown>);
  } catch {
    return null;
  }
}

export async function markAllNotificationsRead(): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase
      .from('notifications')
      .update({ unread: false })
      .eq('user_id', auth.user.id)
      .eq('unread', true);
    return !error;
  } catch {
    return false;
  }
}

export async function markNotificationRead(id: number): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase
      .from('notifications')
      .update({ unread: false })
      .eq('id', id)
      .eq('user_id', auth.user.id);
    return !error;
  } catch {
    return false;
  }
}

export async function deleteNotification(id: number): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase
      .from('notifications')
      .delete()
      .eq('id', id)
      .eq('user_id', auth.user.id);
    return !error;
  } catch {
    return false;
  }
}

export async function deleteAllNotifications(): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase.from('notifications').delete().eq('user_id', auth.user.id);
    return !error;
  } catch {
    return false;
  }
}

export async function addQuizResult(quizTitle: string, score: number, totalQuestions: number): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase.from('quiz_results').insert({
      user_id: auth.user.id,
      quiz_title: quizTitle,
      score,
      total_questions: totalQuestions
    });
    return !error;
  } catch {
    return false;
  }
}

export async function uploadAvatar(file: File): Promise<string> {
  const { data: auth } = await supabase.auth.getUser();
  if (!auth?.user) throw new Error('Belum login');

  const ext = file.name.split('.').pop()?.toLowerCase() || 'jpg';
  const path = `${auth.user.id}/${Date.now()}.${ext}`;
  const { error } = await supabase.storage.from('avatars').upload(path, file, { cacheControl: '3600', upsert: true });
  if (error) throw error;

  return supabase.storage.from('avatars').getPublicUrl(path).data.publicUrl;
}

export const USERNAME_PATTERN = /^[a-z0-9_]*$/;

const REACTION_VALUES: ArticleReaction[] = ['LIKE', 'WOW', 'FUNNY', 'SAD'];

function getSessionId(): string {
  if (typeof localStorage === 'undefined') return '';
  let id = localStorage.getItem('sekta-session');
  if (!id) {
    id = crypto.randomUUID();
    localStorage.setItem('sekta-session', id);
  }
  return id;
}

export async function getArticleReactions(
  articleId: number
): Promise<{ reactions: ArticleReaction[]; mine: ArticleReaction | null }> {
  const { data, error } = await supabase
    .from('article_reactions')
    .select('reaction')
    .eq('article_id', articleId);
  if (error) throw error;
  const reactions = ((data ?? []) as { reaction: string }[])
    .map((r) => r.reaction)
    .filter((r): r is ArticleReaction => (REACTION_VALUES as string[]).includes(r));
  const { data: mine } = await supabase.rpc('my_article_reaction', {
    p_article_id: articleId,
    p_session_id: getSessionId()
  });
  return {
    reactions,
    mine: mine && (REACTION_VALUES as string[]).includes(mine) ? (mine as ArticleReaction) : null
  };
}

export async function setArticleReaction(
  articleId: number,
  reaction: ArticleReaction
): Promise<'added' | 'updated' | 'removed' | null> {
  try {
    const { data, error } = await supabase.rpc('set_article_reaction', {
      p_article_id: articleId,
      p_reaction: reaction,
      p_session_id: getSessionId()
    });
    if (error) return null;
    return (data as 'added' | 'updated' | 'removed') ?? null;
  } catch {
    return null;
  }
}

export async function getComments(articleId: number): Promise<CommentItem[]> {
  const { data: auth } = await supabase.auth.getUser();
  const uid = auth?.user?.id ?? null;
  const { data, error } = await supabase
    .from('comments')
    .select('*')
    .eq('article_id', articleId)
    .order('created_at', { ascending: false })
    .limit(50);
  if (error) throw error;
  return (data ?? []).map((c) => ({
    id: Number(c.id),
    authorName: String(c.author_name || 'Pengguna'),
    content: String(c.content),
    createdAt: String(c.created_at ?? ''),
    mine: uid ? c.user_id === uid : false
  }));
}

export async function addComment(articleId: number, content: string, authorName: string): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase.from('comments').insert({
      article_id: articleId,
      user_id: auth.user.id,
      author_name: authorName,
      content
    });
    return !error;
  } catch {
    return false;
  }
}

// ============================================================
// ARTIKEL DARI USER (status SUBMITTED, menunggu persetujuan admin)
// ============================================================

function slugify(s: string): string {
  return s
    .toLowerCase()
    .replace(/[^a-z0-9\s-]/g, '')
    .trim()
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .slice(0, 80);
}

export async function submitArticle(input: {
  title: string;
  categoryId: number;
  excerpt: string;
  coverImage: string;
  content: ArticleBlock[];
  readTimeMinutes: number;
  sources?: { title: string; url: string; publisher: string }[];
}): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { data: prof } = await supabase.from('profiles').select('name').eq('id', auth.user.id).maybeSingle();
    const base = slugify(input.title) || 'artikel';
    const row = {
      author_id: auth.user.id,
      author_name: String(prof?.name ?? '') || 'Pengguna',
      category_id: input.categoryId,
      title: input.title,
      slug: base,
      excerpt: input.excerpt,
      cover_image: input.coverImage,
      content: input.content,
      read_time_minutes: input.readTimeMinutes,
      status: 'SUBMITTED'
    };
    let articleId: number | undefined;
    const ins = await supabase.from('articles').insert(row).select('id').single();
    if (ins.error) {
      if (String(ins.error.code) === '23505') {
        // slug bentrok → tambah suffix acak singkat
        const retry = await supabase
          .from('articles')
          .insert({ ...row, slug: `${base}-${Date.now().toString(36).slice(-6)}` })
          .select('id')
          .single();
        if (retry.error) return false;
        articleId = (retry.data as { id: number }).id;
      } else {
        return false;
      }
    } else {
      articleId = (ins.data as { id: number }).id;
    }

    // Simpan sumber (bila ada) — RLS memastikan hanya penulis artikel yang bisa
    if (articleId && input.sources?.length) {
      const rows = input.sources
        .filter((s) => s.title.trim())
        .map((s) => ({ article_id: articleId as number, title: s.title.trim(), url: s.url.trim(), publisher: s.publisher.trim() }));
      if (rows.length) {
        const { error: srcErr } = await supabase.from('sources').insert(rows);
        if (srcErr) return false;
      }
    }
    return true;
  } catch {
    return false;
  }
}

export async function getModeratableArticles(): Promise<Article[]> {
  try {
    const { data, error } = await supabase
      .from('articles')
      .select('*, categories(name, slug)')
      .neq('status', 'PUBLISHED')
      .order('created_at', { ascending: false })
      .limit(50);
    if (error) throw error;
    return (data ?? []).map(toArticle);
  } catch {
    return [];
  }
}

export async function adminSetArticleStatus(articleId: number, status: 'PUBLISHED' | 'REJECTED'): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { data: art } = await supabase
      .from('articles')
      .select('author_id, title, slug, status')
      .eq('id', articleId)
      .maybeSingle();
    if (!art || art.status === status) return false;
    const { error } = await supabase.from('articles').update({ status }).eq('id', articleId);
    if (error) return false;
    if (art.author_id) {
      await supabase.from('notifications').insert({
        user_id: art.author_id,
        title: status === 'PUBLISHED' ? 'Artikel kamu telah dipublikasikan' : 'Artikel kamu ditolak',
        description: String(art.title),
        link: status === 'PUBLISHED' ? `/article/${art.slug}` : ''
      });
    }
    return true;
  } catch {
    return false;
  }
}

// ============================================================
// KONTEN SAYA (halaman kelola di profil)
// ============================================================

export async function getMyArticles(): Promise<Article[]> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return [];
    const { data, error } = await supabase
      .from('articles')
      .select('*, categories(name, slug)')
      .eq('author_id', auth.user.id)
      .order('created_at', { ascending: false })
      .limit(100);
    if (error) throw error;
    return (data ?? []).map(toArticle);
  } catch {
    return [];
  }
}

export async function getMyVideos(): Promise<VideoItem[]> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return [];
    const { data, error } = await supabase
      .from('videos')
      .select('*')
      .eq('user_id', auth.user.id)
      .order('created_at', { ascending: false })
      .limit(100);
    if (error) throw error;
    return (data ?? []).map((v) => ({
      id: Number(v.id),
      title: String(v.title ?? ''),
      description: String(v.description ?? ''),
      url: String(v.url),
      authorName: String(v.author_name ?? 'Pengguna'),
      createdAt: String(v.created_at ?? '')
    }));
  } catch {
    return [];
  }
}

export async function getArticleById(id: number): Promise<Article | null> {
  try {
    const { data, error } = await supabase
      .from('articles')
      .select('*, categories(name, slug), sources(title, url, publisher)')
      .eq('id', id)
      .maybeSingle();
    if (error || !data) return null;
    return toArticle(data);
  } catch {
    return null;
  }
}

export async function updateArticle(
  id: number,
  input: {
    title: string;
    categoryId: number;
    excerpt: string;
    coverImage: string;
    content: ArticleBlock[];
    readTimeMinutes: number;
    sources: { title: string; url: string; publisher: string }[];
  }
): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase
      .from('articles')
      .update({
        category_id: input.categoryId,
        title: input.title,
        excerpt: input.excerpt,
        cover_image: input.coverImage,
        content: input.content,
        read_time_minutes: input.readTimeMinutes
      })
      .eq('id', id);
    if (error) return false;

    // Ganti sumber: hapus lama, isi ulang (RLS membatasi pada penulis artikel).
    const { error: delErr } = await supabase.from('sources').delete().eq('article_id', id);
    if (delErr) return false;
    const rows = input.sources
      .filter((s) => s.title.trim())
      .map((s) => ({ article_id: id, title: s.title.trim(), url: s.url.trim(), publisher: s.publisher.trim() }));
    if (rows.length) {
      const { error: srcErr } = await supabase.from('sources').insert(rows);
      if (srcErr) return false;
    }
    return true;
  } catch {
    return false;
  }
}

export async function deleteArticle(id: number): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase.from('articles').delete().eq('id', id);
    return !error;
  } catch {
    return false;
  }
}

export async function deleteVideo(id: number): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const { error } = await supabase.from('videos').delete().eq('id', id);
    return !error;
  } catch {
    return false;
  }
}

// ============================================================
// VIDEO (feed /video — langsung tampil)
// ============================================================

async function uploadToBucket(bucket: string, file: File): Promise<string> {
  const { data: auth } = await supabase.auth.getUser();
  if (!auth?.user) throw new Error('Belum login');
  const ext = file.name.split('.').pop()?.toLowerCase() || 'bin';
  const path = `${auth.user.id}/${Date.now()}.${ext}`;
  const { error } = await supabase.storage.from(bucket).upload(path, file, { cacheControl: '3600', upsert: true });
  if (error) throw error;
  return supabase.storage.from(bucket).getPublicUrl(path).data.publicUrl;
}

export async function uploadArticleImage(file: File): Promise<string> {
  return uploadToBucket('covers', file);
}

export async function uploadVideoFile(file: File): Promise<string> {
  return uploadToBucket('videos', file);
}

export async function getVideos(): Promise<VideoItem[]> {
  try {
    const { data, error } = await supabase.from('videos').select('*').order('created_at', { ascending: false }).limit(50);
    if (error) throw error;
    return (data ?? []).map(v => ({
      id: Number(v.id),
      title: String(v.title ?? ''),
      description: String(v.description ?? ''),
      url: String(v.url),
      authorName: String(v.author_name ?? 'Pengguna'),
      createdAt: String(v.created_at ?? '')
    }));
  } catch {
    return [];
  }
}

export async function uploadVideo(input: { file: File; title: string; description: string }): Promise<boolean> {
  try {
    const { data: auth } = await supabase.auth.getUser();
    if (!auth?.user) return false;
    const url = await uploadToBucket('videos', input.file);
    const { data: prof } = await supabase.from('profiles').select('name').eq('id', auth.user.id).maybeSingle();
    const { error } = await supabase.from('videos').insert({
      user_id: auth.user.id,
      author_name: String(prof?.name ?? '') || 'Pengguna',
      title: input.title,
      description: input.description,
      url
    });
    return !error;
  } catch {
    return false;
  }
}
