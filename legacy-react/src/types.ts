export type Theme = 'light' | 'dark';

export type ViewName =
  | 'home'
  | 'explore'
  | 'quiz-home'
  | 'quiz-question'
  | 'quiz-result'
  | 'profile'
  | 'login'
  | 'signup'
  | 'forgot-password'
  | 'edit-profile'
  | 'settings'
  | 'account-security'
  | 'notifications-settings'
  | 'change-password'
  | 'notifications'
  | 'article-detail'
  | 'search'
  | 'search-results'
  | 'saved-articles'
  | 'logout-modal'
  | 'privacy'
  | 'terms'
  | 'about';

export interface Article {
  id: number;
  title: string;
  category: string;
  readTime: string;
  excerpt: string;
  author: string;
  date: string;
  image: string;
}

export interface UserProfile {
  name: string;
  username: string;
  bio: string;
  stats: {
    articles: number;
    quizzes: number;
  };
}

export interface NotificationItem {
  id: number;
  title: string;
  desc: string;
  time: string;
  unread: boolean;
}

export type NavigateFn = (view: ViewName, tab?: string) => void;
export type GoBackFn = () => void;
