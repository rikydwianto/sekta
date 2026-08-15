# SEKTA — Schema & SQL Supabase

> **Untuk eksekusi langsung:** buka `docs/supabase.sql`, salin seluruh isinya ke **Supabase Dashboard → SQL Editor → New query**, lalu klik **Run**. Satu file, langsung jalan dari awal sampai akhir (aman diulang).

Skema ini mengikuti **Content Model** di `docs/design.md` (#32–#33): konten artikel **block-based** (bukan satu string HTML panjang), kategori terpisah, kuis + soal + opsi terpisah, serta tabel `sekejap_facts` dan `sources`.

## Ringkasan tabel

| Tabel | Dipakai untuk |
|---|---|
| `profiles` | Profil user (padanan `UserProfile`), dibuat otomatis saat signup |
| `categories` | Kategori artikel (padanan `Category`) |
| `articles` | Artikel; `content` = JSONB array blok, `cover_image` = **URL gambar** (bukan CSS class), `category_id` FK ke `categories`, `featured` = flag artikel unggulan (dipakai hero beranda & sorotan explore), `view_count` = penghitung baca (naik via RPC `increment_article_view`), `search` = **tsvector** untuk full-text search (diisi otomatis dari `title` + `excerpt`), `published_at` diisi otomatis oleh trigger saat status jadi `PUBLISHED` |
| `sekejap_facts` | Fakta singkat di halaman beranda (padanan `SekejapFact`) |
| `quizzes` / `quiz_questions` / `quiz_options` | Daftar kuis + soal + pilihan jawaban |
| `sources` | Sumber referensi artikel (trust) |
| `saved_articles` | Artikel tersimpan (junction user–article) |
| `article_reactions` | Reaksi/suka artikel (LIKE/WOW/FUNNY/SAD). `user_id` NULL = reaksi anonim (tanpa login, tanpa dedup); login = satu reaksi per user (partial unique index `user_id+article_id`, klik lagi = hapus) |
| `comments` | Komentar artikel (`author_name` disalin dari profil karena RLS profil read-only-milik-sendiri) |
| `notifications` | Notifikasi (padanan `NotificationItem`); `link` = tujuan navigasi tombol "Lihat Konten" (kosong = tanpa aksi); waktu tampil dihitung dari `created_at` (format relatif di client) |
| `quiz_results` | Riwayat skor kuis |
| `videos` | Video yang diunggah user (feed `/video`); langsung tampil tanpa moderasi (`author_name` disalin dari profil) |

Seluruh tabel berada di **schema `public`** (schema default Supabase). Client Supabase di app memakai `db: { schema: 'public' }`, jadi `from('articles')` dst. otomatis membaca `public.articles`.

## Blok konten artikel (`articles.content`)

```json
[
  { "type": "paragraph", "data": { "text": "..." } },
  { "type": "heading",    "data": { "text": "..." } },
  { "type": "quote",      "data": { "text": "..." } },
  { "type": "list",       "data": { "items": ["...", "..."] } },
  { "type": "fact",       "data": { "text": "..." } },
  { "type": "divider",    "data": {} },
  { "type": "quiz",       "data": { "quizId": "..." } },
  { "type": "video",      "data": { "url": "...", "caption": "..." } }
]
```

`url` pada blok video bisa berupa **link YouTube** (otomatis dirender sebagai iframe embed) atau **link file video** (mp4, mis. hasil upload ke Storage `videos`) yang dirender sebagai `<video controls>`. Render dilakukan dinamis di `src/routes/article/[slug]/+page.svelte`.

## Alur kirim artikel dari user (approval admin)

1. **User** login → `/tulis` → isi judul, kategori, ringkasan, sampul (upload ke Storage `covers` atau tempel URL), dan konten blok (paragraf/judul/video) → `submitArticle()` insert dengan `status = 'SUBMITTED'`.
2. **Admin** (`profiles.role = 'ADMIN'`) → `/admin` melihat semua artikel non-published via `getModeratableArticles()` → tombol **Terbitkan** (`status = 'PUBLISHED'`, `published_at` diisi otomatis trigger) atau **Tolak** (`REJECTED`).
3. `adminSetArticleStatus()` otomatis membuat **notifikasi** untuk penulis (butuh policy `notif: tulis admin`).

## RLS (Row Level Security)

- **Konten publik** (baca semua): `categories`, `articles` (hanya `status = 'PUBLISHED'` atau milik sendiri **atau admin**), `sekejap_facts`, `quizzes`, `quiz_questions`, `quiz_options`, `sources`, `videos`.
- **Milik sendiri**: `profiles`, `saved_articles`, `notifications`, `quiz_results`, `videos` (unggah/ubah/hapus).
- **Alur contributor**: user bisa `INSERT`/`UPDATE` artikel dengan `author_id` sama dengan `auth.uid()` — cocok untuk alur tulis → DRAFT/SUBMITTED. Status `PUBLISHED`/`REJECTED` hanya dari sisi admin.
- **Admin**: policy `artikel: baca/kelola/tulis admin` memberi akses penuh ke semua artikel; `notif: tulis admin` mengizinkan membuat notifikasi untuk user lain.
- **Storage `avatars`**: bucket publik; file disimpan di `<user_id>/<file>`. Read bebas, upload/update/hapus hanya untuk path yang folder pertamanya = `auth.uid()`.
- **Storage `videos` & `covers`**: bucket publik untuk video unggahan dan sampul artikel; aturan folder sama (upload ke `<user_id>/<file>`).

## Trigger & fitur otomatis

- `handle_new_user` → buat profil saat user baru mendaftar; username dinormalisasi (`a-z0-9_`) dan diberi suffix `1`, `2`, ... bila sudah dipakai.
- `set_updated_at` → perbarui `updated_at` saat `profiles`/`articles` di-update.
- `articles_set_published_at` → isi `published_at = now()` saat status artikel pertama kali menjadi `PUBLISHED`.
- `increment_article_view(aid)` → `security definer`, menaikkan `articles.view_count` (dipanggil dari load halaman artikel; di-`grant` ke anon & authenticated).
- `articles.search` (generated column) → `to_tsvector('indonesian', title || ' ' || excerpt)`, diindeks GIN (`articles_search_idx`). Dipakai `searchArticles()` via `textSearch('search', q, { type: 'websearch' })`.

## Data layer app

- `src/lib/api.ts`: `getCategories()`, `getArticles()`, `getArticleBySlug()`, `getRelatedArticles()`, `searchArticles()`, `getSekejapFacts()`, `getQuizList()`, `getQuizQuestions(quizId)`, `getSavedArticles()`, `setArticleSaved()`, `getProfile()`, `updateProfile()`, `uploadAvatar()`, `getNotifications()`, `markAllNotificationsRead()`, `addQuizResult()`, `submitArticle()`, `getModeratableArticles()`, `adminSetArticleStatus()`, `getVideos()`, `uploadVideo()`, `uploadArticleImage()`, `uploadVideoFile()`.
- Semua fungsi **murni query Supabase** — tidak ada fallback mock. Bila query gagal, fungsi melempar error dan halaman menampilkan empty state.
- **Cache ringan (TTL 30 dtk)** di dalam `api.ts` untuk data publik (`getCategories`, `getArticles`, `getArticleBySlug`, `searchArticles`, `getSekejapFacts`, `getQuizList`, `getQuizQuestions`) — mengurangi query berulang saat navigasi.
- **Data publik** (beranda, explore, kuis, artikel, pencarian) di-load **server-side** lewat `+page.ts` (`load()`), sehingga halaman langsung terisi tanpa skeleton. **Data pribadi** tersinkron setelah Supabase Auth login (login/signup sudah terhubung ke `supabase.auth` — email/password dan Google OAuth).
- **Upload avatar**: `uploadAvatar(file)` mengunggah ke Storage `avatars/<user_id>/<file>` lalu menyimpan URL publik ke `profiles.avatar`. UI-nya di halaman Edit Profil (ikon kamera di pojok avatar, batas 2 MB, hanya gambar). Username divalidasi client dengan pola `^[a-z0-9_]*$`.
- **Video**: `uploadVideoFile()`/`uploadArticleImage()` mengunggah ke Storage `videos`/`covers` (`<user_id>/<file>`) dan mengembalikan URL publik. `getVideos()` + `uploadVideo()` dipakai feed `/video` (langsung tampil, FB-like).

Akses publik cukup memakai `PUBLIC_SUPABASE_URL` dan `PUBLIC_SUPABASE_ANON_KEY` yang sudah ada di `.env`.
