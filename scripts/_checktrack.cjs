const { createClient } = require('@supabase/supabase-js');
const sb = createClient('https://ynhfcdbbhhsjnynynddd.supabase.co', 'sb_publishable_Yxsu1nmQr3rtD6G0ahbaXw_zvK67fak');
(async () => {
  const { error: e1 } = await sb.from('visits').insert({ ip: '203.0.113.9', ua: 'test', path: '/test' });
  console.log('anon insert visits:', e1 ? 'GAGAL ' + e1.code + ' ' + e1.message : 'OK');
  const { error: e2 } = await sb.from('geo_cache').upsert({ ip: '203.0.113.9', country: 'X', region: 'Y', city: 'Z' });
  console.log('anon upsert geo_cache:', e2 ? 'GAGAL ' + e2.code + ' ' + e2.message : 'OK');
  const { count: v } = await sb.from('visits').select('id', { count: 'exact', head: true });
  const { count: g } = await sb.from('geo_cache').select('ip', { count: 'exact', head: true });
  console.log('jumlah visits:', v, '| jumlah geo_cache:', g);
})();
