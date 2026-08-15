import React from 'react';
import type { NavigateFn, Theme } from '../../types';

interface QuizResultViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
}

export default function QuizResultView({ onNavigate, theme }: QuizResultViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full flex flex-col items-center justify-center p-6 text-center transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className={`w-32 h-32 rounded-full border-4 border-blue-600 flex items-center justify-center mb-6 shadow-xl ${isDark ? 'bg-[#141720]' : 'bg-slate-50'}`}>
        <span className="text-3xl font-black">4/5</span>
      </div>
      <h2 className="text-2xl font-black mb-2">Hebat!</h2>
      <p className={`text-xs mb-8 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Kamu sudah memahami dasar materi ini dengan sangat baik.</p>
      <button onClick={() => onNavigate('home', 'home')} className="w-full bg-blue-600 text-white font-bold py-4 rounded-2xl shadow-lg">Kembali ke Beranda</button>
    </div>
  );
}
