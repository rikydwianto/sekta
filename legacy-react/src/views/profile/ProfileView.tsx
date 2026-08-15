import React, { useState } from 'react';
import { Bell, Settings } from 'lucide-react';
import type { Article, NavigateFn, Theme, UserProfile } from '../../types';

interface ProfileViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
  user: UserProfile;
  savedArticles: Article[];
}

export default function ProfileView({ onNavigate, theme, user, savedArticles }: ProfileViewProps) {
  const [tab, setTab] = useState('tersimpan');
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full pb-16 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className="px-6 pt-10 pb-4 flex justify-between items-center">
        <h1 className="text-2xl font-black">Profil</h1>
        <div className="flex space-x-2">
          <button onClick={() => onNavigate('notifications')} className={`p-2.5 rounded-full border ${isDark ? 'bg-[#141720] border-slate-800 text-slate-300' : 'bg-slate-50 border-slate-200 text-slate-700'}`}><Bell className="w-4 h-4"/></button>
          <button onClick={() => onNavigate('settings')} className={`p-2.5 rounded-full border ${isDark ? 'bg-[#141720] border-slate-800 text-slate-300' : 'bg-slate-50 border-slate-200 text-slate-700'}`}><Settings className="w-4 h-4"/></button>
        </div>
      </div>

      <div className="px-6 mb-6">
        <div className={`rounded-[2rem] p-6 border flex items-center space-x-4 mb-4 shadow-sm ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-blue-600 to-indigo-600 flex items-center justify-center text-xl font-black text-white">RD</div>
          <div>
            <h2 className="text-base font-black">{user.name}</h2>
            <p className={`text-xs mb-2 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>{user.username}</p>
            <button onClick={() => onNavigate('edit-profile')} className={`text-[11px] font-bold px-3 py-1 rounded-lg ${isDark ? 'bg-slate-800 text-slate-200' : 'bg-slate-200 text-slate-800'}`}>Edit Profil</button>
          </div>
        </div>

        <div className={`flex p-1 rounded-2xl border mb-4 ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-100 border-slate-200'}`}>
          <button onClick={() => setTab('tersimpan')} className={`flex-1 py-2.5 text-xs font-bold rounded-xl transition-all ${tab === 'tersimpan' ? 'bg-blue-600 text-white' : isDark ? 'text-slate-400' : 'text-slate-600'}`}>Tersimpan ({savedArticles.length})</button>
          <button onClick={() => setTab('kuis')} className={`flex-1 py-2.5 text-xs font-bold rounded-xl transition-all ${tab === 'kuis' ? 'bg-blue-600 text-white' : isDark ? 'text-slate-400' : 'text-slate-600'}`}>Kuis ({user.stats.quizzes})</button>
        </div>
      </div>

      <div className="px-6 space-y-3">
        {tab === 'tersimpan' ? (
          savedArticles.length > 0 ? (
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
            <div className={`text-center py-8 text-xs ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Belum ada artikel tersimpan.</div>
          )
        ) : (
          <div className={`border p-4 rounded-2xl text-center text-xs ${isDark ? 'bg-[#141720] border-slate-800 text-slate-400' : 'bg-slate-50 border-slate-200 text-slate-600'}`}>
            Riwayat kuis: 8 kuis telah diselesaikan dengan rata-rata skor 85%.
          </div>
        )}
      </div>
    </div>
  );
}
