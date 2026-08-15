import React from 'react';
import type { NavigateFn, Theme } from '../../types';

interface ForgotPasswordViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
}

export default function ForgotPasswordView({ onNavigate, theme }: ForgotPasswordViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`p-8 flex flex-col h-full transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className="mb-6 mt-8">
        <h1 className="text-2xl font-black tracking-tight mb-2">Lupa password?</h1>
        <p className={`text-xs font-medium leading-relaxed ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>
          Masukkan email yang kamu gunakan untuk akun public. Kami akan mengirimkan instruksi untuk mengatur ulang kata sandi.
        </p>
      </div>
      
      <div className="mb-6">
        <label className={`block text-xs font-bold mb-2 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Email</label>
        <input type="email" placeholder="nama@email.com" className={`w-full border rounded-2xl px-4 py-3.5 ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} />
      </div>

      <button onClick={() => onNavigate('login')} className="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-2xl py-3.5 mb-4 shadow-lg shadow-blue-600/30">
        Kirim link reset
      </button>

      <button onClick={() => onNavigate('login')} className={`w-full text-center text-xs font-bold ${isDark ? 'text-slate-400 hover:text-slate-200' : 'text-slate-600 hover:text-slate-900'}`}>
        Kembali ke Login
      </button>
    </div>
  );
}
