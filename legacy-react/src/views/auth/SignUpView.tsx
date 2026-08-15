import React from 'react';
import { AlertCircle } from 'lucide-react';
import type { NavigateFn, Theme } from '../../types';

interface SignUpViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
}

export default function SignUpView({ onNavigate, theme }: SignUpViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`p-8 flex flex-col h-full transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className="mb-6 mt-2">
        <h1 className="text-2xl font-black tracking-tight mb-1">Buat akun Sekta</h1>
        <p className={`text-xs font-medium ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Gabung dan temukan lebih banyak hal menarik setiap hari.</p>
      </div>

      <div className="space-y-3 flex-1">
        <div>
          <label className={`block text-xs font-bold mb-1 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Nama</label>
          <input type="text" defaultValue="Riky Dwianto" className={`w-full border rounded-2xl px-4 py-3 font-medium ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} />
        </div>
        <div>
          <label className={`block text-xs font-bold mb-1 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Username</label>
          <input type="text" defaultValue="@rikydwianto" className={`w-full border rounded-2xl px-4 py-3 font-medium ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} />
        </div>
        <div>
          <label className={`block text-xs font-bold mb-1 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Email</label>
          <input type="email" defaultValue="alex@invalid" className={`w-full border rounded-2xl px-4 py-3 font-medium ${isDark ? 'bg-red-950/30 border-red-800/60 text-red-200' : 'bg-red-50 border-red-200 text-red-700'}`} />
          <p className="text-red-500 text-[11px] mt-1 font-semibold flex items-center"><AlertCircle className="w-3.5 h-3.5 mr-1"/> Format email tidak valid.</p>
        </div>
        <div>
          <label className={`block text-xs font-bold mb-1 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Password</label>
          <input type="password" placeholder="Minimal 8 karakter" className={`w-full border rounded-2xl px-4 py-3 ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} />
        </div>
      </div>

      <div className="pt-4">
        <button onClick={() => onNavigate('home', 'home')} className="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-2xl py-4 transition-all shadow-lg shadow-blue-600/30">
          Daftar
        </button>
        <p className={`text-center mt-4 text-xs ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>
          Sudah punya akun? <button onClick={() => onNavigate('login')} className="text-blue-600 font-bold">Masuk</button>
        </p>
      </div>
    </div>
  );
}
