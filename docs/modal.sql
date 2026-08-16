-- ============================================================
-- SEKTA — MODAL SITUS (muncul saat halaman dimuat)
-- ============================================================
-- Cara pakai:
--   1. Jalankan file ini sekali (idempoten).
--   2. Ubah barisnya via Dashboard → Table Editor: set active = true
--      dan isi title/body/image_url (button_label/button_url opsional,
--      kosong = tanpa tombol).
--
-- Banyak modal bisa dibuat, tapi hanya 1 yang aktif (trigger otomatis
-- menonaktifkan yang lain). Pakai untuk iklan, peringatan, apresiasi, dll.
--
-- frequency (berapa sering muncul):
--   always  → setiap halaman dimuat, semua tab.
--   session → sekali per sesi browser (tab baru dalam sesi sama tidak muncul).
--   once    → sekali selamanya per perangkat/browser.
--   (default 'session')
--
-- dismissible:
--   true  → bisa ditutup (tombol X, klik luar, Esc, "Nanti Saja").
--   false → wajib klik tombol aksi untuk menutup (tombol X/"Nanti Saja"
--           hilang; kalau button_label kosong, muncul tombol "Tutup").
--   (default true)
--
-- Catatan: body pakai plain text; baris baru (\n) dirender apa adanya.

create table if not exists public.site_modals (
  id bigint generated always as identity primary key,
  active boolean not null default false,
  title text not null default '',
  body text not null default '',
  image_url text not null default '',
  button_label text not null default '',
  button_url text not null default '',
  frequency text not null default 'session'
    check (frequency in ('always', 'session', 'once')),
  dismissible boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.site_modals enable row level security;

drop policy if exists "modal select" on public.site_modals;
create policy "modal select" on public.site_modals
  for select to anon, authenticated using (true);

grant select on public.site_modals to anon, authenticated;

-- Seed awal: 1 baris nonaktif bila tabel masih kosong.
insert into public.site_modals (active)
select false
where not exists (select 1 from public.site_modals);

-- Hanya 1 modal aktif: menonaktifkan yang lain saat ada yang jadi aktif.
create or replace function public.site_modals_deactivate_others()
returns trigger
language plpgsql security definer set search_path = public
as $$
begin
  if new.active then
    update public.site_modals set active = false where id <> new.id;
  end if;
  return new;
end $$;

drop trigger if exists site_modals_one_active on public.site_modals;
create trigger site_modals_one_active
  before insert or update of active on public.site_modals
  for each row execute function public.site_modals_deactivate_others();
