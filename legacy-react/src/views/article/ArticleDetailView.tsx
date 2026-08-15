import React from 'react';
import { ChevronLeft, Bookmark, Settings } from 'lucide-react';
import { mockArticles } from '../../data/mockData';
import type { Article, GoBackFn, NavigateFn, Theme } from '../../types';

interface ArticleDetailViewProps {
  goBack: GoBackFn;
  onNavigate: NavigateFn;
  theme: Theme;
  savedArticles: Article[];
  setSavedArticles: React.Dispatch<React.SetStateAction<Article[]>>;
}

export default function ArticleDetailView({ goBack, onNavigate, theme, savedArticles, setSavedArticles }: ArticleDetailViewProps) {
  const isDark = theme === 'dark';
  const isSaved = savedArticles.some(a => a.id === 1);

  const toggleSave = () => {
    if (isSaved) {
      setSavedArticles(savedArticles.filter(a => a.id !== 1));
    } else {
      setSavedArticles([...savedArticles, mockArticles[0]]);
    }
  };

  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className={`sticky top-0 backdrop-blur-xl z-40 px-4 py-3 flex items-center justify-between border-b ${
        isDark ? 'bg-[#0b0d10]/90 border-slate-800 text-slate-100' : 'bg-white/90 border-slate-200 text-slate-900'
      }`}>
        <button onClick={goBack} className={`p-2 -ml-2 rounded-full ${isDark ? 'hover:bg-slate-800 text-slate-200' : 'hover:bg-slate-100 text-slate-700'}`}>
          <ChevronLeft className="w-6 h-6 stroke-[2.5]" />
        </button>
        <div className="flex space-x-1">
          <button onClick={toggleSave} className={`p-2 rounded-full ${isSaved ? 'text-blue-600' : isDark ? 'hover:bg-slate-800 text-slate-300' : 'hover:bg-slate-100 text-slate-600'}`}>
            <Bookmark className="w-5 h-5" fill={isSaved ? "currentColor" : "none"}/>
          </button>
          <button onClick={() => onNavigate('settings')} className={`p-2 rounded-full ${isDark ? 'hover:bg-slate-800 text-slate-300' : 'hover:bg-slate-100 text-slate-600'}`}><Settings className="w-5 h-5"/></button>
        </div>
      </div>

      <div className="h-60 w-full bg-gradient-to-br from-blue-700 to-indigo-900 relative"></div>

      <div className="px-6 -mt-8 relative z-10">
        <div className={`rounded-[2rem] p-6 border mb-6 shadow-xl ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-white border-slate-200'}`}>
          <span className="inline-block px-3 py-1 bg-blue-600/20 text-blue-500 text-[10px] font-black rounded uppercase tracking-widest mb-3">SAINS</span>
          <h1 className="text-2xl font-black leading-tight mb-3">Kenapa Langit Berwarna Biru?</h1>
          <p className={`text-xs mb-4 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Fenomena sederhana yang ternyata punya penjelasan menarik.</p>
          <div className={`flex items-center pt-4 border-t text-xs justify-between ${isDark ? 'border-slate-800 text-slate-400' : 'border-slate-100 text-slate-500'}`}>
            <span>Sekta</span>
            <span>5 menit baca • 12 Okt 2023</span>
          </div>
        </div>

        <div className={`space-y-4 text-sm leading-relaxed font-medium mb-8 ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>
          <p>Pernahkah kamu menatap ke atas pada hari yang cerah dan bertanya-tanya mengapa hamparan luas itu berwarna biru? Jawabannya terletak pada interaksi menarik antara cahaya matahari dan atmosfer Bumi kita.</p>
          <p>Cahaya matahari, yang tampak putih bagi kita, sebenarnya terdiri dari semua warna pelangi. Ketika cahaya ini mencapai atmosfer Bumi, ia bertabrakan dengan molekul gas dan partikel lain di udara.</p>
          <div className={`border p-5 rounded-2xl my-6 ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-emerald-50 border-emerald-100'}`}>
            <h4 className="text-xs font-black text-emerald-500 uppercase tracking-widest mb-2">TAHUKAH KAMU?</h4>
            <p className={`text-xs ${isDark ? 'text-slate-300' : 'text-emerald-900'}`}>Cahaya biru lebih mudah tersebar oleh molekul udara karena memiliki panjang gelombang yang lebih pendek.</p>
          </div>
        </div>

        {/* Interactive Quiz Trigger in Article */}
        <div className="bg-gradient-to-br from-blue-700 to-indigo-800 rounded-[2rem] p-6 text-white mb-8">
          <h3 className="text-base font-black mb-1">Kuis Interaktif</h3>
          <p className="text-xs text-blue-100 mb-4">Seberapa dalam kamu memahami artikel ini? Tantang dirimu sekarang.</p>
          <button onClick={() => onNavigate('quiz-question')} className="bg-white text-blue-950 font-bold text-xs px-4 py-2.5 rounded-xl shadow">Mulai Kuis</button>
        </div>
      </div>
    </div>
  );
}
