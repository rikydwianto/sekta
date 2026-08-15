import { getQuizList } from '$lib/api';

export const load = async () => {
  const quizzes = await getQuizList().catch(() => []);
  return { quizzes };
};
