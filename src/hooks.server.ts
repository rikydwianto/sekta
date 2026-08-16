import { supabase } from '$lib/supabase';
import type { Handle } from '@sveltejs/kit';

// De-dupe dalam satu proses server untuk menghindari API GeoIP dipanggil
// berulang untuk IP yang sama (mis. dua halaman dibuka bersamaan).
// ponytail: hanya per-proses; pada deployment multi-instance boleh dobel sekali.
const resolving = new Set<string>();

// Skip bot/perayap agar statistik tidak tercemar.
const BOT_RE = /bot|crawler|spider|curl|wget|headless|bingpreview|googlebot/i;

async function resolveGeo(ip: string) {
  if (resolving.has(ip)) return;
  resolving.add(ip);
  try {
    const { data } = await supabase.from('geo_cache').select('ip').eq('ip', ip).maybeSingle();
    if (!data) {
      // ip-api.com gratis: HTTP-only, 45 permintaan/menit. De-dupe via geo_cache
      // membuat hanya IP baru yang di-resolve.
      const res = await fetch(`http://ip-api.com/json/${ip}?fields=status,country,regionName,city&lang=id`);
      const j = await res.json().catch(() => null);
      if (j?.status === 'success') {
        await supabase
          .from('geo_cache')
          .upsert({ ip, country: String(j.country), region: String(j.regionName ?? ''), city: String(j.city ?? '') });
      }
    }
  } catch {
    // tracking tidak boleh menggagalkan halaman
  } finally {
    resolving.delete(ip);
  }
}

export const handle: Handle = async ({ event, resolve }) => {
  const response = await resolve(event);

  // Hanya muatan halaman penuh (sec-fetch-dest: document). Navigasi SPA
  // (__data.json) dan aset (script/css) dilewati; pembaca SPA sudah dihitung
  // oleh view counter yang sudah ada.
  const dest = event.request.headers.get('sec-fetch-dest');
  const ua = event.request.headers.get('user-agent') ?? '';
  if (event.request.method === 'GET' && dest === 'document' && !BOT_RE.test(ua)) {
    try {
      const ip = event.getClientAddress();
      const path = event.url.pathname;
      (async () => {
        const { error } = await supabase.from('visits').insert({ ip, ua, path });
        if (!error) await resolveGeo(ip);
      })().catch(() => {});
    } catch {
      // adaptor non-node / dev tanpa client address: lewati
    }
  }

  return response;
};
