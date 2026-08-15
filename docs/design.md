# Sekta — Product & UI Design Specification

**Product:** Sekta — Sekejap Fakta  
**Document:** MVP Product & UI Design  
**Version:** 0.1  
**Date:** 2026-08-14

---

## 1. Product Vision

Sekta adalah platform pengetahuan interaktif yang menggabungkan:

- Artikel informatif
- Fakta singkat
- Konten visual
- Pembelajaran
- Kuis interaktif
- Kontribusi artikel dari pengguna

Sekta bukan sekadar blog.

Prinsip utama:

> **Datang karena penasaran, membaca karena tertarik, pulang karena tahu sesuatu yang baru.**

Pengalaman Sekta harus terasa:

- Fun
- Modern
- Cepat
- Visual
- Mudah dipahami
- Tidak terasa seperti membaca ensiklopedia
- Tetap terpercaya

---

# 2. MVP Scope

Versi pertama hanya fokus pada fitur inti.

### Core Features

1. Homepage
2. Article
3. Article Editor
4. Category
5. Quiz
6. Authentication
7. Contributor
8. Admin moderation

### Ditunda

Fitur berikut belum masuk MVP:

- XP
- Badge
- Leaderboard
- Following
- Knowledge Graph
- Rabbit Hole
- Detektif Fakta
- Gamifikasi kompleks
- Komentar
- AI Writer

Fondasi sistem harus tetap memungkinkan fitur tersebut ditambahkan di masa depan.

---

# 3. Information Architecture

```text
SEKTA
│
├── Home
│
├── Explore
│   ├── Semua Artikel
│   └── Kategori
│       ├── Sains
│       ├── Sejarah
│       ├── Teknologi
│       ├── Dunia
│       ├── Hewan
│       ├── Manusia
│       └── Fakta Unik
│
├── Article
│   └── Article Detail
│       └── Optional Quiz
│
├── Quiz
│   ├── Quiz List
│   └── Quiz Detail
│
├── Auth
│   ├── Login
│   ├── Register
│   └── Forgot Password
│
├── Profile
│   ├── My Articles
│   ├── Saved Articles
│   └── Quiz History
│
├── Contributor
│   ├── Dashboard
│   ├── Create Article
│   ├── Draft
│   └── Submitted Articles
│
└── Admin
    ├── Dashboard
    ├── Articles
    ├── Review
    ├── Categories
    ├── Quizzes
    └── Users
```

---

# 4. Design Principles

## 4.1 Mobile First

Sebagian besar traffic Sekta kemungkinan berasal dari TikTok.

Karena itu desain harus:

- Mobile-first
- Nyaman dibaca dengan satu tangan
- Tombol cukup besar
- Typography jelas
- Gambar optimal
- Loading cepat

Desktop tetap didukung sebagai pengalaman kedua.

---

## 4.2 Content First

Artikel adalah pusat produk.

UI tidak boleh mengalahkan konten.

Prioritas visual:

```text
Judul
↓
Visual utama
↓
Isi artikel
↓
Interactive content
↓
Quiz
↓
Related content
```

---

## 4.3 Fun, tetapi tidak kekanak-kanakan

Sekta boleh menggunakan:

- Rounded card
- Micro animation
- Icon
- Badge
- Highlight
- Interactive element

Tetapi jangan terlihat seperti aplikasi anak-anak.

Target visual:

> Modern media × learning platform × playful internet culture

---

# 5. Brand Direction

## Brand Personality

Sekta harus terasa:

**Penasaran**  
**Cerdas**  
**Santai**  
**Berani**  
**Fun**  
**Terpercaya**

Bukan:

- Terlalu formal
- Terlalu akademis
- Terlalu korporat
- Terlalu childish

---

# 6. Color System

Gunakan sistem warna yang sederhana.

### Primary

```text
Primary
Accent
Background
Surface
Text
Muted
Border
Success
Error
Warning
```

Warna utama brand sebaiknya memiliki satu warna yang langsung dikenali sebagai identitas public.

Contoh arah:

```text
Primary      → warna brand Sekta
Accent       → warna kontras untuk CTA
Background   → off-white / light neutral
Surface      → white
Text         → near-black
Muted        → gray
Success      → green
Error        → red
Warning      → yellow/orange
```

Dark mode dapat ditambahkan setelah MVP.

---

# 7. Typography

Typography harus sangat mudah dibaca.

### Heading

Gunakan font sans-serif modern dengan karakter kuat.

Contoh:

- Inter
- Plus Jakarta Sans
- Geist
- Manrope

### Body

Prioritas:

- readability
- line-height tinggi
- ukuran nyaman di mobile

Rekomendasi:

```text
Article body
18px mobile
20px desktop

Line height
1.6–1.8
```

Judul artikel harus memiliki hierarchy yang kuat.

---

# 8. Navigation

## Mobile

Bottom navigation:

```text
┌─────────────────────────────────┐
│                                 │
│                                 │
│           CONTENT               │
│                                 │
├─────────────────────────────────┤
│  Home   Explore   Quiz   Profil │
└─────────────────────────────────┘
```

Jika user adalah contributor, tombol create dapat menggunakan floating action button atau tombol `+`.

---

## Desktop

Header:

```text
┌──────────────────────────────────────────────────────────┐
│ SEKTA     Explore     Quiz     Search       Login         │
└──────────────────────────────────────────────────────────┘
```

Logo Sekta berada di kiri.

Primary action berada di kanan.

---

# 9. Homepage

Homepage adalah halaman terpenting setelah artikel.

## Struktur

```text
HEADER

Hero / Featured Content

"SEKEJAP FAKTA"

Short Facts

Popular Articles

Categories

Latest Articles

Quiz Section

Footer
```

---

## Hero

Hero tidak perlu berupa carousel yang kompleks.

Gunakan satu konten utama:

```text
┌───────────────────────────────────┐
│                                   │
│         FEATURE IMAGE             │
│                                   │
│  SAINS                            │
│                                   │
│  Kenapa Langit                    │
│  Berwarna Biru?                   │
│                                   │
│  Pelajari dalam 3 menit           │
│                                   │
│              Baca →              │
└───────────────────────────────────┘
```

Tujuannya:

**User langsung menemukan sesuatu yang menarik.**

---

# 10. Sekejap Fakta

Ini menjadi salah satu signature component public.

Format:

```text
SEKEJAP FAKTA

Tahukah kamu?

Gurita memiliki tiga jantung.

[ Baca selengkapnya → ]
```

Bisa muncul di homepage maupun di antara artikel.

Karakter:

- Sangat singkat
- Satu fakta
- Satu visual opsional
- CTA jelas

---

# 11. Article Card

Card artikel harus sederhana.

```text
┌─────────────────────────────┐
│                             │
│          IMAGE              │
│                             │
├─────────────────────────────┤
│ SAINS                       │
│                             │
│ Kenapa Langit Berwarna      │
│ Biru?                       │
│                             │
│ 5 menit • Sekta             │
└─────────────────────────────┘
```

Informasi minimum:

- Thumbnail
- Category
- Title
- Reading time
- Author

---

# 12. Article Detail

Artikel adalah pengalaman utama.

## Header

```text
SAINS

Kenapa Langit
Berwarna Biru?

Kenali alasan sederhana
di balik fenomena yang kita lihat
setiap hari.

Sekta
5 menit baca
```

Kemudian hero image.

---

## Article Body

Editor menggunakan konsep block.

Contoh:

```text
[Heading]

[Paragraph]

[Image]

[Caption]

[Paragraph]

[Quote]

[Paragraph]

[Fact Block]

[Paragraph]

[Quiz]
```

Ini jauh lebih fleksibel dibanding artikel dengan HTML/content field biasa.

---

# 13. Inline Image

Foto harus dapat ditempatkan di antara teks.

Contoh:

```text
Langit terlihat biru karena cahaya
matahari mengalami proses penyebaran
ketika melewati atmosfer.

        ┌───────────────────┐
        │                   │
        │      IMAGE        │
        │                   │
        └───────────────────┘
        Foto: NASA

Cahaya dengan panjang gelombang
lebih pendek tersebar lebih kuat.
```

User tidak boleh dipaksa memasukkan semua gambar di awal artikel.

---

# 14. Article Editor

Editor adalah salah satu fitur terpenting.

Pengalaman harus mendekati:

**Word + Notion**

bukan CMS tradisional.

---

## Editor Layout

```text
┌─────────────────────────────────────────────┐
│ ← Back       Draft Saved        Publish     │
├─────────────────────────────────────────────┤
│                                             │
│ Judul artikel                               │
│                                             │
│ Tulis judul yang menarik...                 │
│                                             │
│ [ + ] Tulis sesuatu...                      │
│                                             │
│ [Paragraph]                                 │
│                                             │
│ [ + ]                                       │
│                                             │
│ [Image]                                      │
│                                             │
│ [ + ]                                       │
│                                             │
└─────────────────────────────────────────────┘
```

---

# 15. Editor Blocks

MVP block:

```text
paragraph
heading
image
quote
bullet list
numbered list
divider
quiz
fact
```

Future:

```text
video
embed
gallery
poll
interactive
table
callout
```

---

# 16. Add Block Menu

Ketika user menekan `+`:

```text
Tambah

Teks
Heading
Gambar
Quote
List
Divider

Interaktif
Fakta
Kuis
```

Menu harus terasa ringan dan tidak memenuhi layar.

---

# 17. Image Upload

User dapat:

- Upload dari device
- Drag & drop desktop
- Paste image
- Preview
- Delete
- Reposition

Image properties:

```text
Image
├── URL / storage reference
├── Alt text
├── Caption
├── Width
└── Alignment
```

---

# 18. Draft System

Setiap artikel otomatis disimpan sebagai draft.

Status:

```text
Draft
↓
Submitted
↓
Under Review
↓
Published
```

Jika ditolak:

```text
Rejected
↓
Edit
↓
Resubmit
```

User tidak kehilangan artikel ketika browser tertutup.

---

# 19. Article Status

```text
DRAFT
SUBMITTED
IN_REVIEW
PUBLISHED
REJECTED
ARCHIVED
```

---

# 20. Contributor Dashboard

```text
Halo, [Nama]

[ + Buat Artikel ]

Artikel Kamu

┌──────────────────────────────┐
│ Kenapa Langit Biru?          │
│ Draft                        │
│ Terakhir diedit 2 jam lalu   │
│ [Edit]                       │
└──────────────────────────────┘

┌──────────────────────────────┐
│ 5 Fakta Tentang Gurita       │
│ Published                    │
│ 1.2K views                   │
└──────────────────────────────┘
```

---

# 21. Quiz

Quiz dapat berdiri sendiri maupun terhubung dengan artikel.

## Quiz Flow

```text
Quiz Intro
    ↓
Question
    ↓
Answer
    ↓
Feedback
    ↓
Next Question
    ↓
Result
```

---

# 22. Quiz UI

```text
KUIS

Pertanyaan 2 dari 5

Kenapa langit terlihat biru?

○ A. Karena air di atmosfer
○ B. Karena penyebaran cahaya
○ C. Karena warna matahari
○ D. Karena awan

                [ Jawab ]
```

Setelah menjawab:

```text
✓ Benar!

Cahaya biru lebih mudah
tersebar di atmosfer.

[ Lanjut → ]
```

---

# 23. Quiz Result

```text
SELESAI

4 / 5

Hebat!

Kamu sudah memahami
dasar materi ini.

[ Coba Lagi ]

[ Baca Artikel ]
```

Jangan langsung membuat sistem XP kompleks.

Score saja cukup untuk MVP.

---

# 24. Category Page

```text
SAINS

Temukan artikel tentang
sains dan dunia di sekitar kita.

[ Semua ] [ Biologi ] [ Fisika ] [ Antariksa ]

Featured

Latest

Popular
```

Filter dapat ditambahkan kemudian.

---

# 25. Search

Search MVP:

```text
Cari di public...

"black hole"
```

Result:

```text
3 artikel ditemukan

Black Hole: Apa yang Sebenarnya...
Kenapa Black Hole Bisa...
5 Fakta Tentang Black Hole
```

Search harus mencari minimal:

- Judul
- Isi
- Category
- Tags

---

# 26. Profile

Profile sederhana:

```text
[Avatar]

Nama User
@username

Artikel
12

Kuis
34

Tersimpan
8
```

Tabs:

```text
Artikel
Tersimpan
Kuis
```

---

# 27. Authentication

MVP:

- Email
- Password
- Google login jika diperlukan

Role:

```text
USER
CONTRIBUTOR
ADMIN
```

Tidak perlu sistem role yang terlalu kompleks pada tahap pertama.

---

# 28. Admin Dashboard

Admin membutuhkan kontrol sederhana.

```text
Dashboard

Articles
Pending Review: 12

Users
1,240

Quizzes
43

Categories
8
```

---

# 29. Article Review

Admin melihat:

```text
Article Preview

Title
Author
Category
Content
Images
Quiz

[ Reject ]

[ Publish ]
```

Jika reject:

```text
Alasan penolakan

[________________________]

[ Reject Article ]
```

---

# 30. Content Trust

Karena Sekta berbicara tentang fakta, sistem harus sejak awal mendukung sumber.

Article metadata:

```text
Title
Author
Category
Tags
Content
Cover
Sources
Published date
Updated date
```

Di artikel:

```text
Sumber

1. NASA
2. Scientific American
3. Research paper
```

Sumber tidak harus terlihat mengganggu pembaca, tetapi tersedia ketika dibutuhkan.

---

# 31. Future Signature Features

Arsitektur MVP harus memungkinkan fitur berikut ditambahkan.

## Fakta vs Mitos

```text
BENARKAH?

Manusia hanya menggunakan
10% otaknya.

[ MITOS ] [ FAKTA ]
```

---

## Detektif Fakta

```text
CASE #001

Apakah informasi ini benar?

[ Evidence ]

[ Evidence ]

[ Evidence ]

Kesimpulan:

[ VALID ]
[ MERAGUKAN ]
[ PALSU ]
```

---

## Rabbit Hole

Setelah artikel:

```text
Masih penasaran?

Kenapa kita bermimpi?
        ↓
Apa yang terjadi saat tidur?
        ↓
Kenapa sleep paralysis terjadi?
        ↓
Apa itu déjà vu?
```

---

## Random Fact

```text
🎲

Kasih aku fakta!

[ Lagi ]
```

---

# 32. Content Model

Secara konsep:

```text
User
├── id
├── name
├── username
├── avatar
├── role
└── created_at

Article
├── id
├── author_id
├── category_id
├── title
├── slug
├── excerpt
├── cover_image
├── content
├── status
├── published_at
└── updated_at

ArticleBlock
├── id
├── article_id
├── type
├── position
└── data

Category
├── id
├── name
├── slug
└── description

Quiz
├── id
├── article_id
├── title
└── description

QuizQuestion
├── id
├── quiz_id
├── question
└── position

QuizOption
├── id
├── question_id
├── label
└── is_correct

Source
├── id
├── article_id
├── title
├── url
└── publisher
```

---

# 33. Important Technical Decision

Content artikel **jangan disimpan sebagai satu string HTML panjang**.

Gunakan block-based document model.

Contoh:

```json
[
  {
    "type": "paragraph",
    "data": {
      "text": "Langit terlihat biru..."
    }
  },
  {
    "type": "image",
    "data": {
      "url": "...",
      "caption": "Atmosfer bumi"
    }
  },
  {
    "type": "paragraph",
    "data": {
      "text": "Cahaya matahari..."
    }
  },
  {
    "type": "quiz",
    "data": {
      "quizId": "quiz_123"
    }
  }
]
```

Keuntungan:

- Foto bisa berada di posisi mana pun
- Quiz bisa berada di tengah artikel
- Interactive block mudah ditambahkan
- Editor lebih fleksibel
- Konten dapat dirender ke berbagai platform
- Lebih mudah dikembangkan di masa depan

---

# 34. Core User Journey

## Reader

```text
TikTok
  ↓
Sekta
  ↓
Interesting Article
  ↓
Read
  ↓
Interactive Fact
  ↓
Quiz
  ↓
Score
  ↓
Related Article
```

Targetnya adalah menciptakan loop:

> **Penasaran → Baca → Interaksi → Belajar → Penasaran lagi**

---

## Contributor

```text
Register
  ↓
Create Article
  ↓
Write
  ↓
Add Images
  ↓
Add Quiz
  ↓
Preview
  ↓
Submit
  ↓
Admin Review
  ↓
Published
```

---

# 35. MVP Success Criteria

MVP dianggap berhasil apabila:

### Reader

- User dapat menemukan artikel dengan cepat
- Artikel nyaman dibaca di mobile
- User dapat mengikuti kuis
- User memahami hasil kuis

### Contributor

- User dapat membuat artikel tanpa belajar CMS
- User dapat memasukkan gambar di antara teks
- Draft otomatis tersimpan
- User dapat submit artikel

### Admin

- Admin dapat melihat artikel yang masuk
- Admin dapat melakukan review
- Admin dapat publish/reject
- Admin dapat mengelola kategori

---

# 36. Product North Star

Semua fitur Sekta nantinya harus menjawab satu pertanyaan:

> **"Apakah ini membuat orang semakin penasaran untuk mengetahui sesuatu?"**

Jika iya, pertimbangkan.

Jika tidak, jangan menambahkan fitur hanya karena platform lain memilikinya.

---

# 37. MVP Prioritas

Urutan development:

```text
PHASE 1
├── Design System
├── Authentication
├── Database
└── Basic Navigation

PHASE 2
├── Article
├── Article Editor
├── Image Upload
├── Draft
└── Publish

PHASE 3
├── Categories
├── Search
└── Explore

PHASE 4
├── Quiz
├── Article Quiz
└── Quiz Result

PHASE 5
├── Contributor Dashboard
├── Admin Dashboard
└── Moderation

PHASE 6
├── Polish UI
├── Animation
├── Performance
└── Analytics
```

---

# 38. Design Direction Summary

Sekta harus terlihat seperti:

> **"Media digital yang bisa dimainkan."**

Bukan:

> "Blog yang diberi fitur quiz."

Fondasi produk:

```text
             SEKTA
               │
       ┌───────┴───────┐
       │               │
    CONTENT         LEARNING
       │               │
    Article           Quiz
       │               │
    Image          Interaction
       │               │
       └───────┬───────┘
               │
            CURIOSITY
               │
               ↓
         "Aku mau tahu lagi."
```

**Prioritas utama MVP:**

1. Editor artikel yang nyaman
2. Artikel yang enak dibaca
3. Gambar inline
4. Kategori
5. Contributor
6. Kuis yang terhubung dengan artikel
7. Admin moderation

Semua fitur keren lainnya dibangun **di atas fondasi ini**, bukan menggantikannya.