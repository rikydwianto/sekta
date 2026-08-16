export type MonitoringStats = {
  range: string;
  bucket: 'hour' | 'day';
  pageviews: number;
  pageviewsTotal: number;
  users: number;
  users24h: number;
  daily: { day: string; views: number }[];
  topEvents: { event: string; total: number }[];
  topPages: { url: string; total: number }[];
  topArticles: { title: string; slug: string; total: number }[];
};

export type MonitoringData = {
  configured: boolean;
  error: string | null;
  stats: MonitoringStats | null;
};

export const load = async ({ fetch }): Promise<MonitoringData> => {
  try {
    const res = await fetch('/api/monitoring');
    return (await res.json()) as MonitoringData;
  } catch (e) {
    return { configured: false, error: e instanceof Error ? e.message : 'Gagal memuat data monitoring', stats: null };
  }
};
