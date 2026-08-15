export function timeAgo(iso: string | null | undefined): string {
  if (!iso) return '';
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return '';
  const sec = Math.floor((Date.now() - d.getTime()) / 1000);
  if (sec < 60) return 'baru saja';
  const min = Math.floor(sec / 60);
  if (min < 60) return `${min} menit lalu`;
  const hr = Math.floor(min / 60);
  if (hr < 24) return `${hr} jam lalu`;
  const day = Math.floor(hr / 24);
  if (day < 7) return `${day} hari lalu`;
  return d.toLocaleDateString('id-ID', { day: 'numeric', month: 'short', year: 'numeric' });
}

// Ubah URL YouTube menjadi URL embed; selain itu (mp4, dll.) kembalikan null.
export function videoEmbedUrl(url: string): string | null {
  const m = url.match(/(?:youtube\.com\/(?:watch\?v=|embed\/|shorts\/)|youtu\.be\/)([\w-]{11})/);
  return m ? `https://www.youtube.com/embed/${m[1]}` : null;
}

// ID video TikTok dari URL seperti tiktok.com/@user/video/123; selain itu null.
export function tiktokVideoId(url: string): string | null {
  const m = url.match(/tiktok\.com\/@[^/]+\/video\/(\d+)/);
  return m ? m[1] : null;
}

// URL profil TikTok (tiktok.com/@user); selain itu null. Profil tidak bisa di-embed,
// dipakai untuk kartu "Ikuti di TikTok".
export function tiktokProfile(url: string): string | null {
  const m = url.match(/tiktok\.com\/@([^/]+)/);
  return m ? `https://www.tiktok.com/@${m[1]}` : null;
}

// Bersihkan HTML hasil WYSIWYG sebelum disimpan: buang elemen berbahaya & atribut event.
// Dipanggil saat submit artikel (client-side), bukan saat render.
export function sanitizeHtml(html: string): string {
  const doc = new DOMParser().parseFromString(html, 'text/html');
  doc.querySelectorAll('script, style, iframe, object, embed, link, meta, form').forEach((el) => el.remove());
  for (const el of doc.body.querySelectorAll('*')) {
    for (const attr of Array.from(el.attributes)) {
      const n = attr.name.toLowerCase();
      if (n.startsWith('on') || (n === 'href' && attr.value.toLowerCase().startsWith('javascript:'))) {
        el.removeAttribute(attr.name);
      }
    }
  }
  return doc.body.innerHTML;
}
