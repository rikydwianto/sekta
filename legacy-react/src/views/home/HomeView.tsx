import React from 'react';
import { Bell, ChevronRight, Zap, Clock, Bookmark } from 'lucide-react';
import { mockArticles, mockCategories } from '../../data/mockData';
import type { NavigateFn, Theme } from '../../types';

interface HomeViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
}

export default function HomeView({ onNavigate, theme }: HomeViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className={`flex justify-between items-center px-6 pt-10 pb-4 sticky top-0 backdrop-blur-xl z-30 transition-colors ${
        isDark ? 'bg-[#0b0d10]/90 text-slate-100' : 'bg-white/90 text-slate-900'
      }`}>
        <h1 className="text-xl font-black tracking-tight">Sekejap Fakta</h1>
        <div className="flex items-center space-x-3">
          <button onClick={() => onNavigate('notifications')} className={`p-2 rounded-full border relative ${isDark ? 'bg-[#141720] border-slate-800 text-slate-300' : 'bg-slate-50 border-slate-200 text-slate-700'}`}>
            <Bell className="w-4 h-4"/>
            <span className="absolute top-1 right-1 w-2 h-2 bg-rose-600 rounded-full"></span>
          </button>
          <div 
            onClick={() => onNavigate('profile', 'profile')}
            className="w-10 h-10 bg-slate-800 border border-slate-700 rounded-full flex items-center justify-center cursor-pointer overflow-hidden shadow-inner"
          >
            <div className="w-full h-full bg-gradient-to-tr from-blue-600 to-indigo-600 flex items-center justify-center text-white text-xs font-black">
              RD
            </div>
          </div>
        </div>
      </div>

      {/* Hero Banner */}
      <div className="px-6 mb-6">
        <div onClick={() => onNavigate('article-detail')} className="group relative rounded-[2rem] overflow-hidden h-[340px] cursor-pointer shadow-xl border border-slate-800/80 bg-gradient-to-br from-blue-900/60 via-indigo-950 to-slate-900 p-6 flex flex-col justify-between">
          <div className="absolute inset-0 opacity-40 bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-blue-400 via-transparent to-transparent"></div>
          
          <div className="relative z-10">
            <span className="px-3 py-1 bg-blue-600 text-white text-[10px] font-black rounded-lg uppercase tracking-widest">SAINS</span>
          </div>

          <div className="relative z-10">
            <h2 className="text-[28px] font-black text-white leading-[1.1] mb-2 tracking-tight">Kenapa Langit Berwarna Biru?</h2>
            <p className="text-slate-300 text-xs line-clamp-2 mb-5 font-medium">Alasan sederhana di balik fenomena yang kita lihat setiap...</p>
            <button className="bg-white/90 hover:bg-white text-slate-900 text-xs font-bold py-3 px-5 rounded-xl flex items-center shadow-lg active:scale-95 transition-all">
              Baca Sekarang <ChevronRight className="w-4 h-4 ml-1" />
            </button>
          </div>
        </div>
      </div>

      {/* Daily Fact */}
      <div className="px-6 mb-6">
        <div onClick={() => onNavigate('article-detail')} className={`rounded-[2rem] p-6 border relative overflow-hidden group cursor-pointer transition-all ${
          isDark ? 'bg-[#141720] border-slate-800 hover:border-emerald-500/40' : 'bg-emerald-50/50 border-emerald-100 hover:border-emerald-300'
        }`}>
          <div className="flex items-center mb-2">
            <Zap className="w-4 h-4 text-emerald-500 mr-2" />
            <h3 className="text-xs font-black text-emerald-500 uppercase tracking-widest">Sekejap Fakta</h3>
          </div>
          <p className={`text-base font-bold leading-snug mb-3 ${isDark ? 'text-slate-100' : 'text-slate-800'}`}>"Tahukah kamu? Gurita memiliki tiga jantung."</p>
          <button className="text-xs font-bold text-emerald-500 flex items-center hover:underline">
            Baca selengkapnya <ChevronRight className="w-4 h-4 ml-0.5" />
          </button>
        </div>
      </div>

      {/* Categories */}
      <div className="pl-6 mb-6 overflow-x-auto hide-scrollbar">
        <div className="flex space-x-2.5 pr-6">
          {mockCategories.map((cat, i) => (
            <button key={i} onClick={() => onNavigate('explore')} className={`px-5 py-2.5 rounded-2xl text-xs font-bold whitespace-nowrap transition-all ${
              i === 0 
                ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/30' 
                : isDark 
                  ? 'bg-[#141720] border border-slate-800 text-slate-300 hover:bg-slate-800' 
                  : 'bg-slate-100 border border-slate-200 text-slate-700 hover:bg-slate-200'
            }`}>
              {cat}
            </button>
          ))}
        </div>
      </div>

      {/* Popular Articles */}
      <div className="px-6 mb-6">
        <h3 className="text-lg font-black mb-4 tracking-tight">Artikel Populer</h3>
        <div className="space-y-3">
          {mockArticles.slice(1, 3).map((article) => (
            <div key={article.id} onClick={() => onNavigate('article-detail')} className={`p-3 rounded-[1.5rem] flex items-center space-x-4 cursor-pointer group border transition-all ${
              isDark ? 'bg-[#141720] border-slate-800 hover:border-slate-700' : 'bg-slate-50 border-slate-200 hover:border-slate-300'
            }`}>
              <div className={`w-[76px] h-[76px] rounded-2xl flex-shrink-0 ${article.image} shadow-inner`}></div>
              <div className="flex-1 py-1 pr-1">
                <span className="text-[9px] font-black text-blue-500 uppercase tracking-widest block mb-1">{article.category}</span>
                <h4 className={`text-sm font-bold leading-snug mb-1 line-clamp-2 ${isDark ? 'text-slate-100' : 'text-slate-800'}`}>{article.title}</h4>
                <p className={`text-[11px] flex items-center ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>
                  <Clock className="w-3 h-3 mr-1" />
                  {article.readTime}
                </p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Weekly Quiz Banner */}
      <div className="px-6 mb-6">
        <div className="bg-gradient-to-br from-blue-700 via-indigo-700 to-indigo-900 rounded-[2rem] p-6 text-white relative overflow-hidden shadow-xl group cursor-pointer" onClick={() => onNavigate('quiz-home', 'quiz-home')}>
          <div className="flex items-center mb-2">
            <span className="text-[10px] font-black bg-white/20 px-2.5 py-0.5 rounded uppercase tracking-widest">KUIS MINGGUAN</span>
          </div>
          <h3 className="text-xl font-black mb-1 leading-tight tracking-tight">Uji Pengetahuanmu:<br/>Fakta Unik Hewan</h3>
          <p className="text-blue-100 text-xs mb-5 font-medium">Seberapa banyak yang kamu tahu tentang dunia satwa?</p>
          <button className="bg-rose-600 hover:bg-rose-500 text-white font-bold py-3 px-5 rounded-xl text-xs shadow-lg active:scale-95 transition-all">
            Mulai Kuis
          </button>
        </div>
      </div>

      {/* Latest Articles */}
      <div className="px-6 mb-6">
        <h3 className="text-lg font-black mb-4 tracking-tight">Artikel Terbaru</h3>
        <div className={`rounded-[2rem] border overflow-hidden ${
          isDark ? 'bg-[#141720] border-slate-800 divide-y divide-slate-800/80' : 'bg-white border-slate-200 divide-y divide-slate-100 shadow-sm'
        }`}>
          {mockArticles.slice(3).map((article) => (
            <div key={article.id} onClick={() => onNavigate('article-detail')} className={`p-4 flex items-center justify-between cursor-pointer transition-colors ${
              isDark ? 'hover:bg-slate-800/40' : 'hover:bg-slate-50'
            }`}>
              <div className="pr-4">
                <h4 className={`text-sm font-bold mb-1 leading-snug ${isDark ? 'text-slate-200' : 'text-slate-800'}`}>{article.title}</h4>
                <p className={`text-[11px] font-semibold uppercase ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>{article.category} • {article.readTime}</p>
              </div>
              <div className={`w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0 ${isDark ? 'bg-slate-800 text-slate-400' : 'bg-slate-100 text-slate-600'}`}>
                <Bookmark className="w-4 h-4" />
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="px-6">
        <button onClick={() => onNavigate('explore')} className={`w-full border font-bold py-4 rounded-2xl text-sm transition-all ${
          isDark ? 'bg-[#141720] hover:bg-slate-800 border-slate-800 text-slate-200' : 'bg-slate-100 hover:bg-slate-200 border-slate-200 text-slate-800'
        }`}>
          Lihat Semua Artikel
        </button>
      </div>
    </div>
  );
}
