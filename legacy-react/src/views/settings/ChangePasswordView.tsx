import React from 'react';
import TopBar from '../../components/TopBar';
import type { GoBackFn, Theme } from '../../types';

interface ChangePasswordViewProps {
  goBack: GoBackFn;
  theme: Theme;
}

export default function ChangePasswordView({ goBack, theme }: ChangePasswordViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full flex flex-col transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title="Ubah Password" onBack={goBack} theme={theme} />
      <div className="px-6 py-4 space-y-4 flex-1">
        <input type="password" placeholder="Password saat ini" className={`w-full border rounded-xl p-3 text-xs ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} />
        <input type="password" placeholder="Password baru" className={`w-full border rounded-xl p-3 text-xs ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} />
      </div>
      <div className="p-6"><button onClick={goBack} className="w-full bg-blue-600 text-white font-bold py-3.5 rounded-2xl text-xs">Simpan</button></div>
    </div>
  );
}
