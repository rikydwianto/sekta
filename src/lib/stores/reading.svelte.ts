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
  const i = readingHistory.findIndex((h) => h.slug === article.slug);
  if (i > -1) readingHistory.splice(i, 1);
  readingHistory.unshift(entry);
  save(readingHistory);
}

function toDateKey(ts: number): string {
  const d = new Date(ts);
  return `${d.getFullYear()}-${d.getMonth()}-${d.getDate()}`;
}

export function getReadingStreak(): number {
  const days = new Set(readingHistory.map((h) => toDateKey(h.at)));
  if (days.size === 0) return 0;
  let streak = 0;
  const d = new Date();
  if (!days.has(toDateKey(d.getTime()))) {
    d.setDate(d.getDate() - 1);
    if (!days.has(toDateKey(d.getTime()))) return 0;
  }
  for (;;) {
    if (!days.has(toDateKey(d.getTime()))) break;
    streak += 1;
    d.setDate(d.getDate() - 1);
    if (streak > 3650) break;
  }
  return streak;
}
