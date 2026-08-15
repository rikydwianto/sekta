import React from 'react';
import { Home, Compass, HelpCircle, User } from 'lucide-react';
import type { LucideIcon } from 'lucide-react';
import type { NavigateFn, Theme, ViewName } from '../types';

interface BottomNavProps {
  activeTab: string;
  navigateTo: NavigateFn;
  theme: Theme;
}

export default function BottomNav({ activeTab, navigateTo, theme }: BottomNavProps) {
  const isDark = theme === 'dark';
  const tabs: { id: ViewName; icon: LucideIcon; label: string }[] = [
    { id: 'home', icon: Home, label: 'Home' },
    { id: 'explore', icon: Compass, label: 'Explore' },
    { id: 'quiz-home', icon: HelpCircle, label: 'Quiz' },
    { id: 'profile', icon: User, label: 'Profil' }
  ];

  return (
    <div className={`backdrop-blur-2xl border shadow-2xl flex justify-between items-center p-2 rounded-[2.2rem] pointer-events-auto mx-auto max-w-[340px] transition-colors duration-300 ${
      isDark 
        ? 'bg-[#141720]/90 border-slate-800 shadow-black/80' 
        : 'bg-white/90 border-slate-200 shadow-slate-300/60'
    }`}>
      {tabs.map((tab) => {
        const isActive = activeTab === tab.id;
        return (
          <button
            key={tab.id}
            onClick={() => navigateTo(tab.id, tab.id)}
            className={`relative flex items-center justify-center h-12 px-4 rounded-[1.6rem] transition-all duration-300 ease-out active:scale-90 group ${
              isActive ? 'w-auto' : 'w-12'
            }`}
          >
            {isActive && (
              <div className="absolute inset-0 bg-blue-600 rounded-[1.6rem] shadow-lg shadow-blue-600/40 transition-all duration-300 ease-out"></div>
            )}
            
            <div className="relative z-10 flex items-center justify-center">
              <tab.icon 
                className={`transition-all duration-300 ${
                  isActive 
                    ? 'w-5 h-5 text-white stroke-[2.5]' 
                    : isDark ? 'w-5 h-5 text-slate-400 group-hover:text-slate-200 stroke-[2]' : 'w-5 h-5 text-slate-500 group-hover:text-slate-800 stroke-[2]'
                }`} 
              />
              {isActive && (
                <span className="ml-2 text-[13px] font-bold text-white tracking-wide whitespace-nowrap">
                  {tab.label}
                </span>
              )}
            </div>
          </button>
        );
      })}
    </div>
  );
}
