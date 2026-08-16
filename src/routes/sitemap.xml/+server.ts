import { supabase } from '$lib/supabase';

export const GET = async ({ request }) => {
  const base = new URL(request.url).origin;

  const { data } = await supabase
    .from('articles')
    .select('slug, updated_at, published_at')
    .eq('status', 'PUBLISHED')
    .order('published_at', { ascending: false });

  const staticPages: { loc: string; lastmod: string; freq: string; pri: string }[] = [
    { loc: '/', lastmod: '', freq: 'weekly', pri: '1.0' },
    { loc: '/explore', lastmod: '', freq: 'weekly', pri: '0.7' },
    { loc: '/quiz', lastmod: '', freq: 'weekly', pri: '0.7' },
    { loc: '/video', lastmod: '', freq: 'weekly', pri: '0.6' },
    { loc: '/about', lastmod: '', freq: 'monthly', pri: '0.5' },
    { loc: '/privacy', lastmod: '', freq: 'monthly', pri: '0.3' },
    { loc: '/terms', lastmod: '', freq: 'monthly', pri: '0.3' },
    { loc: '/search', lastmod: '', freq: 'monthly', pri: '0.3' }
  ];

  const articles: { loc: string; lastmod: string; freq: string; pri: string }[] = (data ?? []).map((a) => ({
    loc: `/article/${a.slug}`,
    lastmod: (a.updated_at ?? a.published_at ?? '').slice(0, 10),
    freq: 'daily',
    pri: '0.8'
  }));

  const urls = [...staticPages, ...articles].map(
    (u) =>
      `  <url>\n    <loc>${base}${u.loc}</loc>${u.lastmod ? `\n    <lastmod>${u.lastmod}</lastmod>` : ''}\n    <changefreq>${u.freq}</changefreq>\n    <priority>${u.pri}</priority>\n  </url>`
  );

  const xml = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls.join('\n')}\n</urlset>`;

  return new Response(xml, { headers: { 'Content-Type': 'application/xml' } });
};
