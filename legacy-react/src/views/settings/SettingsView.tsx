import React from 'react';
import { Sun, Moon, ChevronRight } from 'lucide-react';
import TopBar from '../../components/TopBar';
import type { GoBackFn, NavigateFn, Theme } from '../../types';

interface SettingsViewProps {
  onNavigate: NavigateFn;
  goBack: GoBackFn;
  theme: Theme;
  toggleTheme: () => void;
}

export default function SettingsView({ onNavigate, goBack, theme, toggleTheme }: SettingsViewProps) {
  const isDark = theme === 'dark';
  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title="Pengaturan" onBack={goBack} theme={theme} />
      <div className="px-6 py-4 space-y-6">
        <div>
          <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-2">TAMPILAN</span>
          <div className={`border rounded-2xl overflow-hidden p-4 flex justify-between items-center ${isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
            <div className="flex items-center space-x-3">
              {isDark ? <Moon className="w-5 h-5 text-blue-400" /> : <Sun className="w-5 h-5 text-amber-500" />}
              <div>
                <h4 className="text-xs font-bold">Mode Tampilan</h4>
                <p className={`text-[11px] ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>{isDark ? 'Mode Gelap aktif' : 'Mode Terang aktif'}</p>
              </div>
            </div>
            <button onClick={toggleTheme} className={`px-4 py-2 rounded-xl text-xs font-bold text-white transition-all ${isDark ? 'bg-blue-600 hover:bg-blue-500' : 'bg-slate-900 hover:bg-slate-800'}`}>
              {isDark ? 'Ke Terang' : 'Ke Gelap'}
            </button>
          </div>
        </div>

        <div>
          <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-2">AKUN</span>
          <div className={`border rounded-2xl overflow-hidden divide-y ${isDark ? 'bg-[#141720] border-slate-800 divide-slate-800' : 'bg-slate-50 border-slate-200 divide-slate-200'}`}>
            <button onClick={() => onNavigate('edit-profile')} className="w-full p-4 text-left text-xs font-bold flex justify-between items-center hover:opacity-75"><span>Profil</span><ChevronRight className="w-4 h-4 text-slate-400"/></button>
            <button onClick={() => onNavigate('account-security')} className="w-full p-4 text-left text-xs font-bold flex justify-between items-center hover:opacity-75"><span>Akun & Keamanan</span><ChevronRight className="w-4 h-4 text-slate-400"/></button>
          </div>
        </div>

        <div>
          <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-2">PREFERENSI</span>
          <div className={`border rounded-2xl overflow-hidden divide-y ${isDark ? 'bg-[#141720] border-slate-800 divide-slate-800' : 'bg-slate-50 border-slate-200 divide-slate-200'}`}>
            <button onClick={() => onNavigate('notifications-settings')} className="w-full p-4 text-left text-xs font-bold flex justify-between items-center hover:opacity-75"><span>Notifikasi</span><ChevronRight className="w-4 h-4 text-slate-400"/></button>
            <div className="w-full p-4 text-xs font-bold flex justify-between items-center"><span>Bahasa</span><span className="text-slate-400 text-[11px]">Indonesia</span></div>
          </div>
        </div>

        <div>
          <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-2">INFORMASI</span>
          <div className={`border rounded-2xl overflow-hidden divide-y ${isDark ? 'bg-[#141720] border-slate-800 divide-slate-800' : 'bg-slate-50 border-slate-200 divide-slate-200'}`}>
            <button onClick={() => onNavigate('privacy')} className="w-full p-4 text-left text-xs font-bold flex justify-between items-center hover:opacity-75"><span>Privasi</span><ChevronRight className="w-4 h-4 text-slate-400"/></button>
            <button onClick={() => onNavigate('terms')} className="w-full p-4 text-left text-xs font-bold flex justify-between items-center hover:opacity-75"><span>Syarat & Ketentuan</span><ChevronRight className="w-4 h-4 text-slate-400"/></button>
            <button onClick={() => onNavigate('about')} className="w-full p-4 text-left text-xs font-bold flex justify-between items-center hover:opacity-75"><span>Tentang Sekta</span><ChevronRight className="w-4 h-4 text-slate-400"/></button>
          </div>
        </div>

        <button onClick={() => onNavigate('logout-modal')} className="w-full p-4 bg-rose-950/20 border border-rose-900/50 rounded-2xl text-rose-500 font-bold text-xs">Keluar</button>
      </div>
    </div>
  );
}
