import React, { useState } from 'react';
import { X } from 'lucide-react';
import type { NavigateFn, Theme } from '../../types';

interface QuizQuestionViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
}

export default function QuizQuestionView({ onNavigate, theme }: QuizQuestionViewProps) {
  const [selected, setSelected] = useState<number | null>(null);
  const [answered, setAnswered] = useState(false);
  const isDark = theme === 'dark';

  return (
    <div className={`min-h-full flex flex-col p-6 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className="flex items-center justify-between mb-6">
        <button onClick={() => onNavigate('quiz-home')} className={`p-2 rounded-full ${isDark ? 'bg-[#141720] text-slate-300' : 'bg-slate-100 text-slate-700'}`}><X className="w-5 h-5"/></button>
        <span className="text-xs font-black text-blue-500 uppercase">Soal 1 / 5</span>
        <div className="w-9"></div>
      </div>

      <h2 className="text-xl font-black mb-6 leading-snug">Kenapa langit terlihat biru?</h2>

      <div className="space-y-3 mb-6">
        {[
          'Karena pantulan air laut',
          'Karena proses penyebaran cahaya (Rayleigh Scattering)',
          'Karena warna asli ruang angkasa',
          'Karena pantulan cahaya bulan'
        ].map((ans, idx) => (
          <button 
            key={idx}
            onClick={() => { setSelected(idx); setAnswered(true); }}
            className={`w-full text-left p-4 rounded-2xl border text-xs font-bold transition-all ${
              answered && idx === 1 ? 'bg-emerald-950/40 border-emerald-500 text-emerald-200' :
              answered && selected === idx ? 'bg-rose-950/40 border-rose-500 text-rose-200' :
              isDark ? 'bg-[#141720] border-slate-800 text-slate-300 hover:border-slate-700' : 'bg-slate-50 border-slate-200 text-slate-700 hover:border-slate-300'
            }`}
          >
            {String.fromCharCode(65 + idx)}. {ans}
          </button>
        ))}
      </div>

      {answered && (
        <div className="mt-auto">
          <div className={`border p-4 rounded-2xl mb-4 ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-emerald-50 border-emerald-200'}`}>
            <h4 className="text-xs font-black text-emerald-500 mb-1">Benar!</h4>
            <p className={`text-xs ${isDark ? 'text-slate-300' : 'text-emerald-900'}`}>Cahaya biru memiliki panjang gelombang lebih pendek dan mudah tersebar.</p>
          </div>
          <button onClick={() => onNavigate('quiz-result')} className="w-full bg-blue-600 text-white font-bold py-3.5 rounded-2xl shadow-lg">Lanjut</button>
        </div>
      )}
    </div>
  );
}
