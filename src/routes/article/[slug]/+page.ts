import { getArticleBySlug, incrementArticleView, getRelatedArticles, getAdjacentArticles, getQuizByArticle } from '$lib/api';

export const load = async ({ params }: { params: { slug: string } }) => {
  const slug = params.slug ?? '';
  const article = await getArticleBySlug(slug).catch(() => undefined);
  if (article) incrementArticleView(article.id).catch(() => {});
  const [related, adjacent, quiz] = await Promise.all([
    getRelatedArticles(slug).catch(() => []),
    getAdjacentArticles(slug).catch(() => ({ prev: null, next: null })),
    article ? getQuizByArticle(article.id).catch(() => null) : Promise.resolve(null)
  ]);
  return { article: article ?? null, related, adjacent, quiz };
};
