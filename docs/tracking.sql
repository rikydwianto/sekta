-- ============================================================
-- SEKTA — TRACKING PENGUNJUNG (kota & negara)
-- ============================================================
-- Cara pakai:
--   1. Buka Supabase Dashboard → SQL Editor → New query
--   2. Salin seluruh isi file ini → Run
--
-- Idempoten (aman diulang).
--
-- visits    : 1 baris per buka halaman HTML (dokumen saja, SPA nav tidak dihitung
--             ulang). Pengisi: src/hooks.server.ts (getClientAddress, native).
-- geo_cache : cache IP -> negara/kota, diisi server via ip-api.com (gratis, tanpa key).
--
-- Catatan privasi: menyimpan IP mentah di tabel visits. Untuk kepatuhan UU PDP,
-- cukup jalankan berkala: update visits set ip = null where ts < now() - interval '30 days';

create table if not exists public.visits (
  id bigint generated always as identity primary key,
  ts timestamptz not null default now(),
  ip text,
  ua text,
  path text not null
);

create index if not exists visits_ts_idx  on public.visits (ts desc);
create index if not exists visits_path_idx on public.visits (path);
create index if not exists visits_ip_idx   on public.visits (ip);

create table if not exists public.geo_cache (
  ip text primary key,
  country text,
  region text,
  city text,
  resolved_at timestamptz not null default now()
);

alter table public.visits    enable row level security;
alter table public.geo_cache enable row level security;

-- Idempoten walau dijalankan ulang.
drop policy if exists "visits insert" on public.visits;
create policy "visits insert" on public.visits
  for insert to anon, authenticated with check (true);

drop policy if exists "geo select" on public.geo_cache;
create policy "geo select" on public.geo_cache
  for select to anon, authenticated using (true);
drop policy if exists "geo insert" on public.geo_cache;
create policy "geo insert" on public.geo_cache
  for insert to anon, authenticated with check (true);
drop policy if exists "geo update" on public.geo_cache;
create policy "geo update" on public.geo_cache
  for update to anon, authenticated using (true) with check (true);

-- Hak akses eksplisit (tidak bergantung pada default privileges Supabase).
grant insert on public.visits to anon, authenticated;
grant select, insert, update on public.geo_cache to anon, authenticated;
grant usage on sequence public.visits_id_seq to anon, authenticated;

-- Contoh laporan (jalankan di SQL Editor):
--   -- Pembaca per negara (7 hari terakhir)
--   select g.country, count(*) as kunjungan
--   from public.visits v
--   left join public.geo_cache g on g.ip = v.ip
--   where v.ts > now() - interval '7 days'
--   group by 1 order by 2 desc;
--
--   -- Pembaca per kota
--   select g.city, count(*) as kunjungan
--   from public.visits v
--   left join public.geo_cache g on g.ip = v.ip
--   where v.ts > now() - interval '7 days' and g.city is not null
--   group by 1 order by 2 desc;
--
--   -- Pengunjung unik per hari
--   select ts::date as tanggal, count(distinct ip) as pengunjung
--   from public.visits group by 1 order by 1 desc;
