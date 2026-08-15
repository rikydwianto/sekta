import React from 'react';
import TopBar from '../../components/TopBar';
import type { GoBackFn, NavigateFn, Theme } from '../../types';

interface AccountSecurityViewProps {
  onNavigate: NavigateFn;
  goBack: GoBackFn;
  theme: Theme;
}

export default function AccountSecurityView({ onNavigate, goBack, theme }: AccountSecurityViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title="Account & Security" onBack={goBack} theme={theme} />
      <div className="px-6 py-4 space-y-6">
        <div className={`border p-4 rounded-2xl ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
          <div className="flex justify-between items-center mb-1">
            <span className={`text-xs font-bold ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Email Address</span>
            <span className="bg-emerald-950 text-emerald-400 text-[9px] font-black px-2 py-0.5 rounded">Verified</span>
          </div>
          <p className="text-sm font-bold mb-3">user@example.com</p>
          <button className="text-xs font-bold text-blue-600">Ubah Email</button>
        </div>
        <div className={`border p-4 rounded-2xl ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
          <span className={`text-xs font-bold block mb-1 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Password</span>
          <p className="text-lg font-black tracking-widest mb-3">• • • • • • • •</p>
          <button onClick={() => onNavigate('change-password')} className="text-xs font-bold text-blue-600">Ubah Password</button>
        </div>
      </div>
    </div>
  );
}
