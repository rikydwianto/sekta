import { getArticles, getCategories, getQuizList, getSekejapFacts, getTrendingArticles } from '$lib/api';

export const load = async () => {
  const [articles, categories, facts, quizzes, trending] = await Promise.all([
    getArticles(10).catch(() => []),
    getCategories().catch(() => []),
    getSekejapFacts().catch(() => []),
    getQuizList().catch(() => []),
    getTrendingArticles(5).catch(() => [])
  ]);
  return { articles, categories, facts, quizzes, trending };
};
