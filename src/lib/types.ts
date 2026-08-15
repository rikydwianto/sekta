export type Theme = 'light' | 'dark';

export interface Category {
  id: number;
  name: string;
  slug: string;
  description: string;
}

export type ArticleBlock =
  | { type: 'paragraph'; data: { text: string } }
  | { type: 'heading'; data: { text: string } }
  | { type: 'quote'; data: { text: string } }
  | { type: 'list'; data: { items: string[] } }
  | { type: 'fact'; data: { text: string } }
  | { type: 'divider'; data: Record<string, never> }
  | { type: 'quiz'; data: { quizId: string } }
  | { type: 'video'; data: { url: string; caption?: string } }
  | { type: 'image'; data: { src: string; caption?: string } };

export type UserRole = 'USER' | 'CONTRIBUTOR' | 'ADMIN';

export interface SourceItem {
  title: string;
  url: string;
  publisher: string;
}

export interface Article {
  id: number;
  slug: string;
  title: string;
  category: string;
  categorySlug?: string;
  readTime: string;
  excerpt: string;
  author: string;
  date: string;
  image: string;
  featured: boolean;
  viewCount: number;
  reactionCount?: number;
  status?: string;
  sources?: SourceItem[];
  content: ArticleBlock[];
}

export interface SekejapFact {
  id: number;
  fact: string;
  articleId: number | null;
}

export interface QuizOption {
  id: number;
  label: string;
  isCorrect: boolean;
}

export interface QuizQuestion {
  id: number;
  question: string;
  options: QuizOption[];
}

export interface Quiz {
  id: number;
  title: string;
  description: string;
  coverImage?: string;
}

export interface UserProfile {
  name: string;
  username: string;
  bio: string;
  avatar: string;
  role: UserRole;
  stats: {
    articles: number;
    quizzes: number;
  };
}

export interface NotificationItem {
  id: number;
  title: string;
  description: string;
  link: string;
  createdAt: string;
  unread: boolean;
}

export interface QuizHistoryEntry {
  quizId: number;
  quizTitle: string;
  score: number;
  total: number;
  percent: number;
  completedAt: string;
}

export type ArticleReaction = 'LIKE' | 'WOW' | 'FUNNY' | 'SAD';

export interface CommentItem {
  id: number;
  authorName: string;
  content: string;
  createdAt: string;
  mine: boolean;
}

export interface VideoItem {
  id: number;
  title: string;
  description: string;
  url: string;
  authorName: string;
  createdAt: string;
}
