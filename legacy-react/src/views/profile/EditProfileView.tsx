import React, { useState } from 'react';
import TopBar from '../../components/TopBar';
import type { GoBackFn, Theme, UserProfile } from '../../types';

interface EditProfileViewProps {
  goBack: GoBackFn;
  theme: Theme;
  user: UserProfile;
  setUser: React.Dispatch<React.SetStateAction<UserProfile>>;
}

export default function EditProfileView({ goBack, theme, user, setUser }: EditProfileViewProps) {
  const [name, setName] = useState(user.name);
  const [username, setUsername] = useState(user.username);
  const [bio, setBio] = useState(user.bio);
  const isDark = theme === 'dark';

  const handleSave = () => {
    setUser({ ...user, name, username, bio });
    goBack();
  };

  return (
    <div className={`min-h-full flex flex-col transition-colors duration-300 ${isDark ? 'bg-[#0b0d10] text-slate-100' : 'bg-white text-slate-900'}`}>
      <TopBar title="Edit Profil" onBack={goBack} theme={theme} />
      <div className="px-6 py-4 flex-1 space-y-4">
        <div className="flex justify-center mb-4">
          <div className="w-20 h-20 rounded-2xl bg-gradient-to-tr from-blue-600 to-indigo-600 flex items-center justify-center text-2xl font-black text-white">RD</div>
        </div>
        <div>
          <label className={`block text-xs font-bold mb-1 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Nama Lengkap</label>
          <input type="text" value={name} onChange={(e) => setName(e.target.value)} className={`w-full border rounded-xl p-3 text-xs ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} />
        </div>
        <div>
          <label className={`block text-xs font-bold mb-1 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Username</label>
          <input type="text" value={username} onChange={(e) => setUsername(e.target.value)} className={`w-full border rounded-xl p-3 text-xs ${isDark ? 'bg-[#141720] border-slate-800 text-slate-100' : 'bg-slate-50 border-slate-200 text-slate-900'}`} />
        </div>
        <div>
          <label className={`block text-xs font-bold mb-1 ${isDark ? 'text-slate-400' : 'text-slate-600'}`}>Bio</label>
          <textarea rows="3" value={bio} onChange={(e) => setBio(e.target.value)} className={`w-full border rounded-xl p-3 text-xs ${isDark ? 'bg-[#141720] border-slate-800 text-slate-300' : 'bg-slate-50 border-slate-200 text-slate-700'}`}></textarea>
        </div>
      </div>
      <div className="p-6">
        <button onClick={handleSave} className="w-full bg-blue-600 text-white font-bold py-3.5 rounded-2xl text-xs shadow-lg">Simpan Perubahan</button>
      </div>
    </div>
  );
}
