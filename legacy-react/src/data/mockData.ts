import type { Article, NotificationItem, UserProfile } from '../types';

export const mockArticles: Article[] = [
  {
    id: 1,
    title: 'Kenapa Langit Berwarna Biru?',
    category: 'SAINS',
    readTime: '5 mnt baca',
    excerpt: 'Pernahkah kamu menatap ke atas dan bertanya-tanya mengapa hamparan luas itu berwarna biru?...',
    author: 'Dr. Awan Cerah',
    date: '12 Okt 2023',
    image: 'bg-gradient-to-br from-blue-600 via-indigo-600 to-sky-400'
  },
  {
    id: 2,
    title: 'Misteri Pembangunan Piramida Mesir yang Belum Terpecahkan',
    category: 'SEJARAH',
    readTime: '5 mnt baca',
    excerpt: 'Keajaiban dunia kuno yang menyimpan ribuan rahasia arsitektur masa lalu.',
    author: 'Prof. Sejarah',
    date: '10 Nov 2023',
    image: 'bg-gradient-to-tr from-amber-600 via-orange-500 to-yellow-600'
  },
  {
    id: 3,
    title: 'Bagaimana AI Akan Mengubah Cara Kita Bekerja?',
    category: 'TEKNOLOGI',
    readTime: '4 mnt baca',
    excerpt: 'Kecerdasan buatan bukan lagi fiksi ilmiah, melainkan realitas harian.',
    author: 'Tech Guru',
    date: '01 Des 2023',
    image: 'bg-gradient-to-bl from-teal-600 to-emerald-800'
  },
  {
    id: 4,
    title: 'Negara Terkecil di Dunia yang Jarang Diketahui',
    category: 'DUNIA',
    readTime: '3 mnt baca',
    excerpt: 'Menjelajahi negara berdaulat dengan luas wilayah kurang dari beberapa kilometer persegi.',
    author: 'Globe Trotter',
    date: '15 Jan 2024',
    image: 'bg-gradient-to-r from-rose-600 to-pink-700'
  },
  {
    id: 5,
    title: 'Apa Itu Antimateri? Penjelasan Sederhana',
    category: 'SAINS',
    readTime: '6 mnt baca',
    excerpt: 'Zat misterius yang bernilai miliaran dolar per gram dan potensi energinya.',
    author: 'Dr. Fisika',
    date: '20 Feb 2024',
    image: 'bg-gradient-to-br from-slate-700 via-slate-800 to-zinc-900'
  },
  {
    id: 6,
    title: 'Sejarah Singkat Penemuan Internet',
    category: 'SEJARAH',
    readTime: '4 mnt baca',
    excerpt: 'Dari ARPANET militer hingga jaringan global yang menghubungkan miliaran umat manusia.',
    author: 'Arsiparis',
    date: '05 Mar 2024',
    image: 'bg-gradient-to-br from-cyan-600 to-blue-800'
  }
];

export const mockCategories: string[] = ['Sains', 'Sejarah', 'Teknologi', 'Dunia'];

export const initialUser: UserProfile = {
  name: 'Riky Dwianto',
  username: '@rikydwianto',
  bio: 'Penggemar fakta unik dan sejarah internet. Selalu mencari hal baru untuk dipelajari di sela-sela waktu luang.',
  stats: { articles: 34, quizzes: 8 }
};

export const initialNotifications: NotificationItem[] = [
  { id: 1, title: 'Artikel kamu telah dipublikasikan', desc: '5 Fakta Menarik Tentang Laut', time: '10 menit lalu', unread: true },
  { id: 2, title: 'Kuis baru tersedia', desc: 'Seberapa tahu kamu tentang Antariksa?', time: '1 jam lalu', unread: true },
  { id: 3, title: 'Pembaruan Sistem v2.1', desc: 'Fitur kuis baru dan perbaikan bug telah ditambahkan.', time: 'Kemarin, 14:30', unread: false },
  { id: 4, title: 'Pencapaian Baru: Penjelajah Fakta', desc: 'Kamu telah membaca 50 artikel minggu ini.', time: 'Kemarin, 09:15', unread: false }
];
