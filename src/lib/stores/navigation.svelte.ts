import { page } from '$app/stores';
import { browser } from '$app/environment';
import { goto } from '$app/navigation';

/**
 * Navigation History Store
 * Back navigation memakai history asli browser (window.history.back()).
 * Karena `goto()` SvelteKit memakai pushState, urutan back/forward mengikuti
 * kunjungan sungguhan (list → detail → back → list → back → sebelumnya, dst.).
 * Guard: jika belum ada navigasi internal (deep-link langsung ke halaman),
 * fallback ke home agar tidak keluar dari app.
 */

let navigatedInsideApp = false;
let lastPath: string | null = null;

if (browser) {
  page.subscribe((p) => {
    const path = p?.url?.pathname;
    if (!path) return;
    if (lastPath !== null && lastPath !== path) navigatedInsideApp = true;
    lastPath = path;
  });
}

export function goBack() {
  if (!browser) return;
  if (navigatedInsideApp) window.history.back();
  else goto('/');
}
