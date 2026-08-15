import { searchArticles, getArticles, getCategories } from '$lib/api';

export const load = async ({ url }: { url: URL }) => {
  const q = url.searchParams.get('q') ?? '';
  const query = q.trim();

  const [results, allArticles, categories] = await Promise.all([
    query === '' ? Promise.resolve([]) : searchArticles(query).catch(() => []),
    getArticles().catch(() => []),
    getCategories().catch(() => [])
  ]);

  return { query, results, allArticles, categories };
};
