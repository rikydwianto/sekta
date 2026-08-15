import React from 'react';
import TopBar from '../../components/TopBar';
import type { GoBackFn, Theme } from '../../types';

interface StaticInfoViewProps {
  title: string;
  goBack: GoBackFn;
  theme: Theme;
  content: string;
}

export default function StaticInfoView({ title, goBack, theme, content }: StaticInfoViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title={title} onBack={goBack} theme={theme} />
      <div className="px-6 py-6">
        <p className={`text-xs leading-relaxed font-medium ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>{content}</p>
      </div>
    </div>
  );
}
