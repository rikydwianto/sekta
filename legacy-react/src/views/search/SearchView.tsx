import React from 'react';
import { ChevronLeft } from 'lucide-react';
import type { GoBackFn, NavigateFn, Theme } from '../../types';

interface SearchViewProps {
  goBack: GoBackFn;
  onNavigate: NavigateFn;
  theme: Theme;
  searchQuery: string;
  setSearchQuery: React.Dispatch<React.SetStateAction<string>>;
}

export default function SearchView({ goBack, onNavigate, theme, searchQuery, setSearchQuery }: SearchViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className={`px-6 pt-6 pb-4 border-b flex items-center space-x-3 ${isDark ? 'border-slate-800' : 'border-slate-200'}`}>
        <button onClick={goBack} className={`p-2 rounded-full ${isDark ? 'bg-[#141720]' : 'bg-slate-100'}`}><ChevronLeft className="w-5 h-5"/></button>
        <input 
          autoFocus 
          value={searchQuery} 
          onChange={(e) => setSearchQuery(e.target.value)} 
          placeholder="Cari fakta..." 
          className={`w-full border rounded-xl px-4 py-2.5 text-xs focus:outline-none ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} 
          onKeyDown={(e) => e.key === 'Enter' && onNavigate('search-results')}
        />
      </div>
      <div className="px-6 py-6">
        <h4 className="text-xs font-black text-slate-400 uppercase tracking-wider mb-3">Trending Topics</h4>
        <div className="flex flex-wrap gap-2">
          {['Black Hole', 'Gurita', 'Luar Angkasa', 'Sejarah', 'AI'].map((tag, i) => (
            <button key={i} onClick={() => { setSearchQuery(tag); onNavigate('search-results'); }} className={`px-4 py-2 rounded-xl text-xs font-bold ${isDark ? 'bg-[#141720] text-slate-300 border border-slate-800' : 'bg-slate-100 text-slate-700'}`}>
              {tag}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}
