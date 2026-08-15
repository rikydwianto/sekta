import React from 'react';
import TopBar from '../../components/TopBar';
import { mockArticles } from '../../data/mockData';
import type { GoBackFn, NavigateFn, Theme } from '../../types';

interface SearchResultsViewProps {
  goBack: GoBackFn;
  searchQuery: string;
  onNavigate: NavigateFn;
  theme: Theme;
}

export default function SearchResultsView({ goBack, searchQuery, onNavigate, theme }: SearchResultsViewProps) {
  const isDark = theme === 'dark';
  const filtered = mockArticles.filter(a => a.title.toLowerCase().includes(searchQuery.toLowerCase()) || a.category.toLowerCase().includes(searchQuery.toLowerCase()));

  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title={`Hasil: "${searchQuery || 'Semua'}"`} onBack={goBack} theme={theme} />
      <div className="px-6 py-4 space-y-3">
        {filtered.length > 0 ? (
          filtered.map(art => (
            <div key={art.id} onClick={() => onNavigate('article-detail')} className={`border p-4 rounded-2xl cursor-pointer ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
              <span className="text-[9px] font-black text-blue-500 uppercase">{art.category}</span>
              <h4 className="text-xs font-bold mt-1">{art.title}</h4>
            </div>
          ))
        ) : (
          <div className="text-center py-12 text-xs text-slate-400">Tidak ada artikel yang ditemukan.</div>
        )}
      </div>
    </div>
  );
}
