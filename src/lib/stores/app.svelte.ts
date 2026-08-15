import type { Article, NotificationItem, QuizHistoryEntry, UserProfile } from '$lib/types';
import type { User } from '@supabase/supabase-js';
import {
  setArticleSaved, getProfile, getSavedArticles, getNotifications,
  markAllNotificationsRead as markAllNotificationsReadApi,
  markNotificationRead as markNotificationReadApi,
  deleteNotification as deleteNotificationApi,
  deleteAllNotifications as deleteAllNotificationsApi,
  addQuizResult as saveQuizResultToDb
} from '$lib/api';
import { supabase } from '$lib/supabase';
import { goto } from '$app/navigation';

const anonymousUser: UserProfile = { name: '', username: '', bio: '', avatar: '', role: 'USER', stats: { articles: 0, quizzes: 0 } };

export const app = $state({
  theme: 'light' as 'light' | 'dark',
  user: anonymousUser,
  isLoggedIn: false,
  authInitialized: false,
  savedArticles: [] as Article[],
  notifications: [] as NotificationItem[],
  searchQuery: '',
  // Quiz state
  currentQuizId: 0,
  currentQuizTitle: '',
  quizHistory: [] as QuizHistoryEntry[]
});

export function userInitials(name: string): string {
  const parts = name.trim().split(/\s+/).filter(Boolean);
  if (parts.length === 0) return 'S';
  return parts.slice(0, 2).map(p => p[0]!).join('').toUpperCase();
}

function profileFromSessionUser(user: User): UserProfile {
  const meta = (user.user_metadata ?? {}) as Record<string, unknown>;
  const rawName = String(meta.full_name ?? meta.name ?? '');
  const rawUsername = String(meta.username ?? meta.user_name ?? '');
  const fallback = String(user.email ?? 'pengguna').split('@')[0];
  return {
    name: rawName || fallback,
    username: rawUsername ? `@${rawUsername.replace(/^@/, '')}` : `@${fallback}`,
    bio: '',
    avatar: String(meta.avatar_url ?? meta.picture ?? ''),
    role: 'USER',
    stats: { articles: 0, quizzes: 0 }
  };
}

async function syncFromSession(user: User) {
  const profile = await getProfile();
  if (profile) {
    const meta = (user.user_metadata ?? {}) as Record<string, unknown>;
    const metaAvatar = String(meta.avatar_url ?? meta.picture ?? '');
    app.user = { ...profile, avatar: profile.avatar || metaAvatar };
  } else {
    app.user = profileFromSessionUser(user);
  }
  const saved = await getSavedArticles();
  app.savedArticles = saved;
  const notifs = await getNotifications();
  app.notifications = notifs;
}

async function consumeRedirect() {
  if (typeof window === 'undefined') return;
  const target = sessionStorage.getItem('sekta-redirect');
  if (target) {
    sessionStorage.removeItem('sekta-redirect');
    await goto(target);
  }
}

export async function initAuth() {
  const { data: { session } } = await supabase.auth.getSession();
  app.authInitialized = true;
  if (session?.user) {
    app.isLoggedIn = true;
    await syncFromSession(session.user);
    await consumeRedirect();
  }

  supabase.auth.onAuthStateChange(async (_event, session) => {
    app.authInitialized = true;
    if (session?.user) {
      app.isLoggedIn = true;
      await syncFromSession(session.user);
      await consumeRedirect();
    } else {
      app.isLoggedIn = false;
      app.user = anonymousUser;
      app.savedArticles = [];
      app.notifications = [];
    }
  });
}

export async function signOut() {
  await supabase.auth.signOut();
  app.isLoggedIn = false;
  app.user = anonymousUser;
  app.savedArticles = [];
  app.notifications = [];
}

export function initTheme() {
  if (typeof localStorage !== 'undefined') {
    const saved = localStorage.getItem('sekta-theme');
    if (saved === 'light' || saved === 'dark') app.theme = saved;
  }
}

export function toggleTheme() {
  app.theme = app.theme === 'light' ? 'dark' : 'light';
  if (typeof localStorage !== 'undefined') localStorage.setItem('sekta-theme', app.theme);
}

export function updateUser(partial: Partial<UserProfile>) {
  app.user = { ...app.user, ...partial };
}

export function toggleSaveArticle(article: Article) {
  const isSaved = app.savedArticles.some(a => a.id === article.id);
  if (isSaved) {
    app.savedArticles = app.savedArticles.filter(a => a.id !== article.id);
  } else {
    app.savedArticles = [...app.savedArticles, article];
  }
  setArticleSaved(article.id, !isSaved);
}

export async function markAllNotificationsRead(): Promise<boolean> {
  const ok = await markAllNotificationsReadApi();
  if (ok) app.notifications = app.notifications.map(n => ({ ...n, unread: false }));
  return ok;
}

export async function markNotificationRead(id: number): Promise<boolean> {
  const ok = await markNotificationReadApi(id);
  if (ok) {
    app.notifications = app.notifications.map(n => (n.id === id ? { ...n, unread: false } : n));
  }
  return ok;
}

export async function deleteNotification(id: number): Promise<boolean> {
  const ok = await deleteNotificationApi(id);
  if (ok) app.notifications = app.notifications.filter(n => n.id !== id);
  return ok;
}

export async function clearAllNotifications(): Promise<boolean> {
  const ok = await deleteAllNotificationsApi();
  if (ok) app.notifications = [];
  return ok;
}

export function setCurrentQuiz(id: number, title: string) {
  app.currentQuizId = id;
  app.currentQuizTitle = title;
}

export function addQuizHistory(entry: QuizHistoryEntry) {
  // Avoid duplicate entries for same quiz session (same timestamp)
  app.quizHistory = [entry, ...app.quizHistory].slice(0, 20);
}

export function addQuizResult(result: { score: number; correctAnswers: number; totalQuestions: number; date: Date }) {
  const entry: QuizHistoryEntry = {
    quizId: app.currentQuizId,
    quizTitle: app.currentQuizTitle || 'Kuis',
    score: result.score,
    total: result.totalQuestions,
    percent: result.totalQuestions > 0 ? Math.round((result.correctAnswers / result.totalQuestions) * 100) : 0,
    completedAt: result.date.toISOString()
  };
  addQuizHistory(entry);
  // Update user stats
  app.user.stats.quizzes = (app.user.stats.quizzes || 0) + 1;
  // Persist ke Supabase (hanya jika sudah login)
  saveQuizResultToDb(entry.quizTitle, result.score, result.totalQuestions, app.currentQuizId);
}

export function clearUser() {
  app.user = anonymousUser;
  app.isLoggedIn = false;
  app.savedArticles = [];
  app.notifications = [];
  app.quizHistory = [];
}
