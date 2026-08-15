import React from 'react';
import { ChevronLeft } from 'lucide-react';
import type { GoBackFn, Theme } from '../types';

interface TopBarProps {
  title: string;
  onBack: GoBackFn;
  rightIcon?: React.ReactNode;
  theme: Theme;
}

export default function TopBar({ title, onBack, rightIcon, theme }: TopBarProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`flex items-center justify-between px-6 py-4 sticky top-0 z-40 transition-colors duration-300 backdrop-blur-xl border-b ${
      isDark ? 'bg-[#0b0d10]/90 border-slate-800/60 text-slate-100' : 'bg-white/90 border-slate-100 text-slate-900'
    }`}>
      <button onClick={onBack} className={`p-2 -ml-2 rounded-full transition-colors ${isDark ? 'text-slate-200 hover:bg-slate-800/60' : 'text-slate-700 hover:bg-slate-100'}`}>
        <ChevronLeft className="w-6 h-6 stroke-[2.5]" />
      </button>
      <h1 className="text-base font-bold tracking-tight">{title}</h1>
      <div className="w-10 flex justify-end">
        {rightIcon}
      </div>
    </div>
  );
}
