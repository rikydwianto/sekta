import { json } from '@sveltejs/kit';
import { env } from '$env/dynamic/private';
import { posthogQuery, scalar } from '$lib/server/posthog';

const RANGES = {
  '24h': { interval: 'interval 24 hour', bucket: 'hour' },
  '7d': { interval: 'interval 7 day', bucket: 'day' },
  '30d': { interval: 'interval 30 day', bucket: 'day' },
  all: { interval: null, bucket: 'day' }
} as const;

export const GET = async ({ url }) => {
  const configured = Boolean(env.POSTHOG_API_KEY && env.POSTHOG_PROJECT_ID);
  if (!configured) {
    return json({ configured: false, error: 'POSTHOG_API_KEY / POSTHOG_PROJECT_ID belum di-set di .env', stats: null });
  }

  const range = url.searchParams.get('range') ?? '7d';
  const cfg = RANGES[range as keyof typeof RANGES] ?? RANGES['7d'];
  const sinceExpr = cfg.interval ? ` and timestamp >= now() - ${cfg.interval}` : '';
  const whereAll = cfg.interval ? ` where timestamp >= now() - ${cfg.interval}` : '';
  const bucketExpr = cfg.bucket === 'hour' ? 'toStartOfHour(timestamp)' : 'toDate(timestamp)';

  try {
    const [pvTotal, pv, users, users24h, daily, topEvents, topPages, topArticles] = await Promise.all([
      posthogQuery("select count() from events where event = '$pageview'"),
      posthogQuery(`select count() from events where event = '$pageview'${sinceExpr}`),
      posthogQuery(`select uniqExact(distinct_id) from events${whereAll}`),
      posthogQuery('select uniqExact(distinct_id) from events where timestamp >= now() - interval 24 hour'),
      posthogQuery(
        `select ${bucketExpr} as day, count() as views from events where event = '$pageview'${sinceExpr} group by day order by day asc`
      ),
      posthogQuery(`select event, count() as total from events${whereAll} group by event order by total desc limit 10`),
      posthogQuery(
        `select properties.$current_url as url, count() as total from events where event = '$pageview'${sinceExpr} group by url order by total desc limit 10`
      ),
      posthogQuery(
        `select properties.title as title, properties.slug as slug, count() as total from events where event = 'article_viewed'${sinceExpr} group by title, slug order by total desc limit 10`
      )
    ]);

    const stats = {
      range,
      bucket: cfg.bucket,
      pageviews: scalar(pv.rows[0]),
      pageviewsTotal: scalar(pvTotal.rows[0]),
      users: scalar(users.rows[0]),
      users24h: scalar(users24h.rows[0]),
      daily: daily.rows.map((r) => ({ day: String(r[0] ?? ''), views: Number(r[1] ?? 0) })),
      topEvents: topEvents.rows.map((r) => ({ event: String(r[0] ?? ''), total: Number(r[1] ?? 0) })),
      topPages: topPages.rows.map((r) => ({ url: String(r[0] ?? ''), total: Number(r[1] ?? 0) })),
      topArticles: topArticles.rows.map((r) => ({
        title: String(r[0] ?? ''),
        slug: String(r[1] ?? ''),
        total: Number(r[2] ?? 0)
      }))
    };

    return json({ configured: true, error: null, stats });
  } catch (e) {
    return json({
      configured: true,
      error: e instanceof Error ? e.message : 'Gagal query PostHog',
      stats: null
    });
  }
};
