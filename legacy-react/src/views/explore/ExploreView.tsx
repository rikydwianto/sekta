import React from 'react';
import { Search, ChevronRight } from 'lucide-react';
import { mockArticles } from '../../data/mockData';
import type { NavigateFn, Theme } from '../../types';

interface ExploreViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
  setSearchQuery: React.Dispatch<React.SetStateAction<string>>;
}

export default function ExploreView({ onNavigate, theme, setSearchQuery }: ExploreViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className={`px-6 pt-10 pb-4 sticky top-0 backdrop-blur-xl z-20 ${isDark ? 'bg-[#0b0d10]/90' : 'bg-white/90'}`}>
        <div className="flex justify-between items-center mb-2">
          <h1 className="text-2xl font-black tracking-tight">Eksplorasi</h1>
          <button onClick={() => onNavigate('search')} className={`p-2.5 rounded-full border ${isDark ? 'bg-[#141720] border-slate-800 text-slate-300' : 'bg-slate-100 border-slate-200 text-slate-700'}`}>
            <Search className="w-4 h-4" />
          </button>
        </div>
        <p className={`text-xs mb-4 font-medium ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Temukan sesuatu yang baru hari ini.</p>
        
        <div className="flex space-x-2 overflow-x-auto hide-scrollbar pb-2">
          {['Semua', 'Sains', 'Sejarah', 'Teknologi', 'Dunia', 'Manusia', 'Alam'].map((c, i) => (
            <button key={i} onClick={() => setSearchQuery(c)} className={`px-4 py-2 rounded-xl text-xs font-bold whitespace-nowrap ${
              i === 0 ? 'bg-blue-600 text-white' : isDark ? 'bg-[#141720] border border-slate-800 text-slate-300' : 'bg-slate-100 border border-slate-200 text-slate-700'
            }`}>
              {c}
            </button>
          ))}
        </div>
      </div>

      <div className="px-6 mt-4">
        <h3 className={`text-sm font-black uppercase tracking-wider mb-3 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Sorotan Utama</h3>
        <div onClick={() => onNavigate('article-detail')} className={`rounded-[2rem] p-5 border cursor-pointer mb-6 ${
          isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200 shadow-sm'
        }`}>
          <div className="h-44 rounded-2xl bg-gradient-to-br from-blue-600 to-indigo-800 mb-4"></div>
          <span className="text-[10px] font-black text-blue-500 uppercase tracking-widest block mb-1">SAINS</span>
          <h2 className="text-lg font-black mb-2">Kenapa Langit Berwarna Biru?</h2>
          <p className={`text-xs line-clamp-2 mb-3 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Pernahkah kamu menatap ke atas dan bertanya-tanya mengapa hamparan luas itu berwarna biru?...</p>
          <div className={`flex justify-between text-[11px] font-semibold ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>
            <span>Dr. Awan Cerah</span>
            <span>5 mnt baca</span>
          </div>
        </div>

        <h3 className={`text-sm font-black uppercase tracking-wider mb-3 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Semua Artikel</h3>
        <div className="space-y-3">
          {mockArticles.map((art) => (
            <div key={art.id} onClick={() => onNavigate('article-detail')} className={`p-4 rounded-2xl border cursor-pointer flex justify-between items-center ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
              <div>
                <span className="text-[9px] font-black text-blue-500 uppercase block mb-1">{art.category}</span>
                <h4 className="text-xs font-bold">{art.title}</h4>
              </div>
              <ChevronRight className="w-4 h-4 text-slate-400 flex-shrink-0 ml-2" />
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
