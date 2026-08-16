import { getArticles, getCategories, getFeaturedArticle, getQuizList, getSekejapFacts, getTrendingArticles } from '$lib/api';

export const load = async () => {
  const [articles, categories, facts, quizzes, trending, featured] = await Promise.all([
    getArticles(10).catch(() => []),
    getCategories().catch(() => []),
    getSekejapFacts().catch(() => []),
    getQuizList().catch(() => []),
    getTrendingArticles(5).catch(() => []),
    getFeaturedArticle().catch(() => undefined)
  ]);
  return { articles, categories, facts, quizzes, trending, featured };
};
