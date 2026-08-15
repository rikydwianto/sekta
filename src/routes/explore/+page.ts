import { getArticlesPage, getCategories } from '$lib/api';

export const load = async () => {
  const [page, categories] = await Promise.all([
    getArticlesPage(null, 0, 10).catch(() => ({ articles: [], total: null })),
    getCategories().catch(() => [])
  ]);
  return { articles: page.articles, total: page.total, categories };
};
