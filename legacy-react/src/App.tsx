import React, { useState } from 'react';
import { mockArticles, initialUser, initialNotifications } from './data/mockData';
import type { Article, NotificationItem, Theme, UserProfile, ViewName } from './types';

import BottomNav from './components/BottomNav';
import LoginView from './views/auth/LoginView';
import SignUpView from './views/auth/SignUpView';
import ForgotPasswordView from './views/auth/ForgotPasswordView';
import HomeView from './views/home/HomeView';
import ExploreView from './views/explore/ExploreView';
import ArticleDetailView from './views/article/ArticleDetailView';
import SavedArticlesView from './views/article/SavedArticlesView';
import QuizHomeView from './views/quiz/QuizHomeView';
import QuizQuestionView from './views/quiz/QuizQuestionView';
import QuizResultView from './views/quiz/QuizResultView';
import ProfileView from './views/profile/ProfileView';
import EditProfileView from './views/profile/EditProfileView';
import SettingsView from './views/settings/SettingsView';
import AccountSecurityView from './views/settings/AccountSecurityView';
import NotificationSettingsView from './views/settings/NotificationSettingsView';
import ChangePasswordView from './views/settings/ChangePasswordView';
import NotificationsView from './views/notifications/NotificationsView';
import SearchView from './views/search/SearchView';
import SearchResultsView from './views/search/SearchResultsView';
import LogoutModalView from './views/common/LogoutModalView';
import StaticInfoView from './views/common/StaticInfoView';

export default function App() {
  const [currentView, setCurrentView] = useState<ViewName>('home');
  const [activeTab, setActiveTab] = useState('home');
  const [previousView, setPreviousView] = useState<ViewName | null>(null);
  const [isAnimating, setIsAnimating] = useState(false);
  const [theme, setTheme] = useState<Theme>('light');
  const [user, setUser] = useState<UserProfile>(initialUser);
  const [searchQuery, setSearchQuery] = useState('');
  const [savedArticles, setSavedArticles] = useState<Article[]>([mockArticles[0], mockArticles[1]]);
  const [notifications, setNotifications] = useState<NotificationItem[]>(initialNotifications);

  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };

  const navigateTo = (view: ViewName, tab?: string) => {
    setIsAnimating(true);
    setTimeout(() => {
      setPreviousView(currentView);
      setCurrentView(view);
      if (tab) setActiveTab(tab);
      setIsAnimating(false);
    }, 150);
  };

  const goBack = () => {
    setIsAnimating(true);
    setTimeout(() => {
      if (previousView) {
        setCurrentView(previousView);
        setPreviousView(null);
      } else {
        setCurrentView('home');
        setActiveTab('home');
      }
      setIsAnimating(false);
    }, 150);
  };

  const renderView = () => {
    switch (currentView) {
      case 'signup': return <SignUpView onNavigate={navigateTo} theme={theme} />;
      case 'login': return <LoginView onNavigate={navigateTo} theme={theme} />;
      case 'forgot-password': return <ForgotPasswordView onNavigate={navigateTo} theme={theme} />;
      case 'home': return <HomeView onNavigate={navigateTo} theme={theme} />;
      case 'explore': return <ExploreView onNavigate={navigateTo} theme={theme} setSearchQuery={setSearchQuery} />;
      case 'quiz-home': return <QuizHomeView onNavigate={navigateTo} theme={theme} />;
      case 'quiz-question': return <QuizQuestionView onNavigate={navigateTo} theme={theme} />;
      case 'quiz-result': return <QuizResultView onNavigate={navigateTo} theme={theme} />;
      case 'profile': return <ProfileView onNavigate={navigateTo} theme={theme} user={user} savedArticles={savedArticles} />;
      case 'edit-profile': return <EditProfileView goBack={goBack} theme={theme} user={user} setUser={setUser} />;
      case 'settings': return <SettingsView onNavigate={navigateTo} goBack={goBack} theme={theme} toggleTheme={toggleTheme} />;
      case 'account-security': return <AccountSecurityView onNavigate={navigateTo} goBack={goBack} theme={theme} />;
      case 'notifications-settings': return <NotificationSettingsView goBack={goBack} theme={theme} />;
      case 'change-password': return <ChangePasswordView goBack={goBack} theme={theme} />;
      case 'notifications': return <NotificationsView goBack={goBack} theme={theme} notifications={notifications} setNotifications={setNotifications} />;
      case 'article-detail': return <ArticleDetailView goBack={goBack} onNavigate={navigateTo} theme={theme} savedArticles={savedArticles} setSavedArticles={setSavedArticles} />;
      case 'search': return <SearchView goBack={goBack} onNavigate={navigateTo} theme={theme} searchQuery={searchQuery} setSearchQuery={setSearchQuery} />;
      case 'search-results': return <SearchResultsView goBack={goBack} searchQuery={searchQuery} onNavigate={navigateTo} theme={theme} />;
      case 'saved-articles': return <SavedArticlesView goBack={goBack} onNavigate={navigateTo} theme={theme} savedArticles={savedArticles} />;
      case 'logout-modal': return <LogoutModalView onNavigate={navigateTo} goBack={goBack} theme={theme} />;
      case 'privacy': return <StaticInfoView title="Kebijakan Privasi" goBack={goBack} theme={theme} content="Kami menghargai privasi Anda. Data yang dikumpulkan digunakan solely untuk meningkatkan pengalaman membaca dan kuis Anda di platform public." />;
      case 'terms': return <StaticInfoView title="Syarat & Ketentuan" goBack={goBack} theme={theme} content="Dengan menggunakan aplikasi Sekta, Anda setuju untuk mematuhi aturan komunitas dan tidak menyebarkan informasi palsu." />;
      case 'about': return <StaticInfoView title="Tentang Sekta" goBack={goBack} theme={theme} content="Sekta adalah platform pengetahuan digital yang menyajikan fakta unik, sains, sejarah, dan teknologi dalam format interaktif yang ringkas." />;
      default: return <HomeView onNavigate={navigateTo} theme={theme} />;
    }
  };

  const isDark = theme === 'dark';

  return (
    <div className={`flex justify-center items-center min-h-screen font-sans transition-colors duration-300 selection:bg-blue-600 selection:text-white sm:p-8 ${isDark ? 'bg-[#0d0f12] text-slate-100' : 'bg-slate-100 text-slate-900'}`}>
      <div className={`w-full max-w-[400px] h-screen sm:h-[840px] flex flex-col relative overflow-hidden sm:rounded-[3.5rem] shadow-[0_25px_60px_-15px_rgba(0,0,0,0.3)] sm:border-[8px] border-slate-700/20 z-10 isolate transition-colors duration-300 ${isDark ? 'bg-[#0b0d10]' : 'bg-white'}`}>
        
        {/* Main scrollable view area */}
        <div className={`flex-1 overflow-y-auto pb-32 scroll-smooth transition-opacity duration-200 ${isAnimating ? 'opacity-0' : 'opacity-100'}`}>
          {renderView()}
        </div>

        {/* Floating Bottom Navigation bar */}
        {['home', 'explore', 'quiz-home', 'profile'].includes(currentView) && (
          <div className="absolute bottom-6 left-0 right-0 px-6 z-50 pointer-events-none">
            <BottomNav activeTab={activeTab} navigateTo={navigateTo} theme={theme} />
          </div>
        )}
      </div>
    </div>
  );
}
