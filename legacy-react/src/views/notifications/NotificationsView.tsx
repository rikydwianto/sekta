import React from 'react';
import TopBar from '../../components/TopBar';
import type { GoBackFn, NotificationItem, Theme } from '../../types';

interface NotificationsViewProps {
  goBack: GoBackFn;
  theme: Theme;
  notifications: NotificationItem[];
  setNotifications: React.Dispatch<React.SetStateAction<NotificationItem[]>>;
}

export default function NotificationsView({ goBack, theme, notifications, setNotifications }: NotificationsViewProps) {
  const isDark = theme === 'dark';
  const markAllRead = () => {
    setNotifications(notifications.map(n => ({ ...n, unread: false })));
  };

  return (
    <div className={`min-h-full pb-12 transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title="Notifikasi" onBack={goBack} theme={theme} rightIcon={<button onClick={markAllRead} className="text-[10px] text-blue-600 font-bold whitespace-nowrap">Baca Semua</button>} />
      <div className="px-6 py-4 space-y-3">
        {notifications.map((notif) => (
          <div key={notif.id} className={`border p-4 rounded-2xl relative ${notif.unread ? (isDark ? 'bg-blue-950/20 border-blue-900/50' : 'bg-blue-50/60 border-blue-100') : (isDark ? 'bg-[#141720] border-slate-800' : 'bg-slate-50 border-slate-200')}`}>
            {notif.unread && <span className="absolute top-4 right-4 w-2 h-2 bg-blue-600 rounded-full"></span>}
            <h4 className="text-xs font-bold mb-1 pr-4">{notif.title}</h4>
            <p className={`text-[11px] mb-2 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>{notif.desc}</p>
            <span className="text-[10px] text-slate-500">{notif.time}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
