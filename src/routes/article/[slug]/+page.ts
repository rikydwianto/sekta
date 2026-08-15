import { getArticleBySlug, incrementArticleView, getRelatedArticles, getAdjacentArticles } from '$lib/api';

export const load = async ({ params }: { params: { slug: string } }) => {
  const slug = params.slug ?? '';
  const article = await getArticleBySlug(slug).catch(() => undefined);
  if (article) incrementArticleView(article.id).catch(() => {});
  const [related, adjacent] = await Promise.all([
    getRelatedArticles(slug).catch(() => []),
    getAdjacentArticles(slug).catch(() => ({ prev: null, next: null }))
  ]);
  return { article: article ?? null, related, adjacent };
};
