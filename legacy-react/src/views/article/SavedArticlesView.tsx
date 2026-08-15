import React from 'react';
import TopBar from '../../components/TopBar';
import type { Article, GoBackFn, NavigateFn, Theme } from '../../types';

interface SavedArticlesViewProps {
  goBack: GoBackFn;
  onNavigate: NavigateFn;
  theme: Theme;
  savedArticles: Article[];
}

export default function SavedArticlesView({ goBack, onNavigate, theme, savedArticles }: SavedArticlesViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title="Artikel Tersimpan" onBack={goBack} theme={theme} />
      <div className="px-6 py-4 space-y-3">
        {savedArticles.length > 0 ? (
          savedArticles.map((art) => (
            <div key={art.id} onClick={() => onNavigate('article-detail')} className={`border p-4 rounded-2xl flex items-center space-x-3 cursor-pointer ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
              <div className={`w-14 h-14 rounded-xl ${art.image} flex-shrink-0`}></div>
              <div>
                <span className="text-[9px] font-black text-blue-500 uppercase">{art.category}</span>
                <h4 className={`text-xs font-bold leading-tight ${isDark ? 'text-slate-100' : 'text-slate-800'}`}>{art.title}</h4>
              </div>
            </div>
          ))
        ) : (
          <div className="text-center py-12">
            <p className={`text-xs mb-5 ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Belum ada artikel tersimpan.</p>
            <button onClick={() => onNavigate('explore', 'explore')} className="bg-blue-600 hover:bg-blue-500 text-white font-bold py-3 px-5 rounded-xl text-xs shadow-lg transition-all">
              Jelajahi Artikel
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
