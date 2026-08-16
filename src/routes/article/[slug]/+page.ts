import { getArticleBySlug, incrementArticleView, getRelatedArticles, getAdjacentArticles, getQuizByArticle } from '$lib/api';

function within<T>(ms: number, fallback: T, p: Promise<T>): Promise<T> {
  return Promise.race([p, new Promise<T>((r) => setTimeout(() => r(fallback), ms))]);
}

export const load = async ({ params }: { params: { slug: string } }) => {
  const slug = params.slug ?? '';
  const article = await getArticleBySlug(slug).catch(() => undefined);
  if (article) incrementArticleView(article.id).catch(() => {});
  const [related, adjacent, quiz] = await Promise.all([
    within(2500, [], getRelatedArticles(slug).catch(() => [])),
    within(2500, { prev: null, next: null }, getAdjacentArticles(slug).catch(() => ({ prev: null, next: null }))),
    article ? within(2500, null, getQuizByArticle(article.id).catch(() => null)) : Promise.resolve(null)
  ]);
  return { article: article ?? null, related, adjacent, quiz };
};
