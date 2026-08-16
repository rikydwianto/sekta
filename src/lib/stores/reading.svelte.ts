import type { Article } from '$lib/types';

const KEY = 'sekta-history';

type HistoryEntry = { slug: string; title: string; image: string; at: number };

function load(): HistoryEntry[] {
  if (typeof localStorage === 'undefined') return [];
  try {
    const raw = localStorage.getItem(KEY);
    return raw ? (JSON.parse(raw) as HistoryEntry[]) : [];
  } catch {
    return [];
  }
}

function save(entries: HistoryEntry[]) {
  if (typeof localStorage === 'undefined') return;
  localStorage.setItem(KEY, JSON.stringify(entries.slice(0, 20)));
}

export const readingHistory = $state<HistoryEntry[]>(load());

export function recordRead(article: Article) {
  const entry: HistoryEntry = { slug: article.slug, title: article.title, image: article.image, at: Date.now() };
  readingHistory.splice(
    readingHistory.findIndex((h) => h.slug === article.slug),
    1
  );
  readingHistory.unshift(entry);
  save(readingHistory);
}
