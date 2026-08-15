import React from 'react';
import TopBar from '../../components/TopBar';
import type { GoBackFn, Theme } from '../../types';

interface NotificationSettingsViewProps {
  goBack: GoBackFn;
  theme: Theme;
}

export default function NotificationSettingsView({ goBack, theme }: NotificationSettingsViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title="Pengaturan Notifikasi" onBack={goBack} theme={theme} />
      <div className="px-6 py-4 space-y-4">
        <div className={`flex justify-between items-center border p-4 rounded-2xl ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
          <div>
            <h4 className="text-xs font-bold">Status Artikel</h4>
            <p className={`text-[11px] ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Pemberitahuan saat artikel baru diterbitkan.</p>
          </div>
          <div className="w-10 h-6 bg-blue-600 rounded-full relative cursor-pointer"><div className="absolute right-1 top-1 w-4 h-4 bg-white rounded-full"></div></div>
        </div>
      </div>
    </div>
  );
}
