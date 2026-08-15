import React from 'react';
import type { NavigateFn, Theme } from '../../types';

interface QuizHomeViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
}

export default function QuizHomeView({ onNavigate, theme }: QuizHomeViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full pb-16 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className="px-6 pt-10 pb-4">
        <h1 className="text-2xl font-black mb-1">Kuis Interaktif</h1>
        <p className={`text-xs ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Uji pengetahuanmu tentang berbagai topik menarik.</p>
      </div>
      <div className="px-6 space-y-4">
        <div onClick={() => onNavigate('quiz-question')} className={`border rounded-[2rem] p-6 cursor-pointer transition-all ${
          isDark ? 'bg-[#141720] border-slate-800 hover:border-blue-600' : 'bg-slate-50 border-slate-200 hover:border-blue-500 shadow-sm'
        }`}>
          <span className="text-[10px] font-black text-blue-500 uppercase tracking-widest block mb-2">SAINS</span>
          <h2 className="text-xl font-black mb-2">Misteri Lubang Hitam: Uji Kosmik</h2>
          <p className={`text-xs mb-4 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Seberapa jauh kamu mengenal lubang hitam di antariksa?</p>
          <button className="bg-blue-600 text-white px-5 py-2.5 rounded-xl text-xs font-bold shadow-lg">Mulai Kuis</button>
        </div>
        <div onClick={() => onNavigate('quiz-question')} className={`border rounded-[2rem] p-6 cursor-pointer transition-all ${
          isDark ? 'bg-[#141720] border-slate-800 hover:border-blue-600' : 'bg-slate-50 border-slate-200 hover:border-blue-500 shadow-sm'
        }`}>
          <span className="text-[10px] font-black text-emerald-500 uppercase tracking-widest block mb-2">BIOLOGI</span>
          <h2 className="text-xl font-black mb-2">Fakta Unik Gurita & Hewan Laut</h2>
          <p className={`text-xs mb-4 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Kenali rahasia makhluk bawah laut.</p>
          <button className="bg-emerald-600 text-white px-5 py-2.5 rounded-xl text-xs font-bold shadow-lg">Mulai Kuis</button>
        </div>
      </div>
    </div>
  );
}
