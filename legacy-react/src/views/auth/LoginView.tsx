import React from 'react';
import type { NavigateFn, Theme } from '../../types';

interface LoginViewProps {
  onNavigate: NavigateFn;
  theme: Theme;
}

export default function LoginView({ onNavigate, theme }: LoginViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`p-8 flex flex-col h-full relative overflow-hidden transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <div className="mb-8 mt-6 relative z-10">
        <h1 className="text-[30px] font-black tracking-tight mb-1">Sekejap Fakta</h1>
        <p className={`text-sm font-medium ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Selamat datang kembali.<br />Lanjutkan eksplorasi Anda.</p>
      </div>

      <div className="space-y-4 mb-6 relative z-10">
        <div>
          <label className={`block text-xs font-bold mb-2 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Email</label>
          <input type="email" placeholder="nama@email.com" className={`w-full border rounded-2xl px-5 py-4 focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20 font-medium ${
            isDark ? 'bg-[#141720] border-slate-800 text-slate-100 placeholder:text-slate-600' : 'bg-slate-50 border-slate-200 text-slate-900 placeholder:text-slate-400'
          }`} />
        </div>
        <div>
          <div className="flex justify-between items-center mb-2">
            <label className={`block text-xs font-bold ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Password</label>
            <button onClick={() => onNavigate('forgot-password')} className="text-xs font-bold text-blue-600 hover:text-blue-500">Lupa password?</button>
          </div>
          <input type="password" defaultValue="••••••••" className={`w-full border rounded-2xl px-5 py-4 focus:outline-none focus:border-blue-600 tracking-[0.2em] ${
            isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'
          }`} />
        </div>
      </div>

      <button onClick={() => onNavigate('home', 'home')} className="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-2xl py-4 mb-6 transition-all shadow-lg shadow-blue-600/30 active:scale-95 flex items-center justify-center">
        Masuk
      </button>

      <div className="flex items-center mb-6 text-slate-500">
        <div className={`flex-grow border-t ${isDark ? 'border-slate-800' : 'border-slate-200'}`}></div>
        <span className="px-4 text-xs font-semibold">atau</span>
        <div className={`flex-grow border-t ${isDark ? 'border-slate-800' : 'border-slate-200'}`}></div>
      </div>

      <button onClick={() => onNavigate('home', 'home')} className={`flex items-center justify-center w-full border rounded-2xl py-4 px-4 font-bold mb-6 transition-all active:scale-95 ${
        isDark ? 'bg-[#141720] border-slate-800 hover:bg-slate-800 text-slate-200' : 'bg-slate-50 border-slate-200 hover:bg-slate-100 text-slate-800'
      }`}>
        <svg className="w-5 h-5 mr-3" viewBox="0 0 24 24">
          <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
          <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
          <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
          <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
        </svg>
        Lanjut dengan Google
      </button>

      <p className={`text-center mt-auto text-sm font-medium pb-2 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>
        Belum punya akun? <button onClick={() => onNavigate('signup')} className="text-blue-600 font-bold hover:underline">Daftar</button>
      </p>
    </div>
  );
}
