# Sekejap Fakta — Design System

> Version 1.0 · August 2026  
> Target audience: Teens & young adults, ages 13–25  
> Aesthetic: Minimalist · Solid colors · Clean typography · High contrast

---

## 1. Design Principles

| Principle | Description |
|-----------|-------------|
| **Minimal** | Remove what's unnecessary. White space is a feature, not a waste. |
| **Bold** | Strong typography creates hierarchy without decoration. |
| **Solid** | Flat solid colors over gradients for cards and buttons. Gradients only for avatar initials. |
| **Fast** | Short page transitions (200ms ease-out). Active states use `scale-95`. |
| **Dark-aware** | Every component supports both light and dark mode via `isDark` derived state. |

---

## 2. Color Palette

### Brand Colors
| Name | Light value | Dark value | Usage |
|------|-------------|------------|-------|
| `brand-primary` | `bg-blue-600` `#2563eb` | same | Primary buttons, active states, links |
| `brand-primary-hover` | `bg-blue-500` `#3b82f6` | same | Hover on primary buttons |
| `brand-secondary` | `bg-purple-600` `#9333ea` | same | Quiz-related actions |
| `brand-danger` | `bg-rose-600` `#e11d48` | same | Destructive actions (logout, delete) |
| `brand-success` | `bg-emerald-600` `#059669` | same | Success states |
| `brand-warning` | `bg-orange-500` `#f97316` | same | Streak, warnings |

### Surface Colors
| Name | Light | Dark |
|------|-------|------|
| **Page background** | `bg-slate-50` | `bg-slate-950` |
| **Card / Container** | `bg-white` | `bg-slate-900` |
| **Card secondary** | `bg-slate-100` | `bg-[#141720]` |
| **Input background** | `bg-white` | `bg-[#141720]` |
| **Sticky header** | `bg-white` | `bg-slate-950` |

### Border Colors
| Name | Light | Dark |
|------|-------|------|
| **Default border** | `border-slate-200` | `border-slate-800` |
| **Subtle border** | `border-slate-100` | `border-slate-900` |
| **Strong border** | `border-slate-300` | `border-slate-700` |

### Text Colors
| Level | Light | Dark |
|-------|-------|------|
| **Primary** | `text-slate-900` | `text-slate-100` |
| **Secondary** | `text-slate-600` | `text-slate-400` |
| **Tertiary / muted** | `text-slate-400` | `text-slate-500` |
| **Inverted (on colored bg)** | `text-white` | `text-white` |

---

## 3. Typography Scale

All text uses the system font stack (Tailwind default). `font-black` = 900 weight.

| Token | Classes | Use |
|-------|---------|-----|
| **Display** | `text-[28px] font-black tracking-tight leading-tight` | Auth page headlines |
| **H1** | `text-2xl font-black tracking-tight` | Page headers (sticky bars) |
| **H2** | `text-xl font-black` | Section headers, card titles |
| **H3** | `text-lg font-black` | Sub-section titles |
| **H4** | `text-base font-black` | Card headings |
| **Body** | `text-sm font-medium` | Body text, descriptions |
| **Small** | `text-xs font-semibold` | Labels, metadata |
| **Micro** | `text-[11px] font-semibold` | Timestamps, hints |
| **Nano** | `text-[10px] font-black uppercase tracking-wide` | Category badges, section labels |

---

## 4. Spacing Scale

The app uses `px-6` for horizontal padding on all main content sections consistently.

| Token | Value | Use |
|-------|-------|-----|
| `pt-10` | 40px | Auth/standalone page top padding |
| `pt-5` | 20px | Protected page content start |
| `px-6` | 24px | Universal horizontal margin |
| `pb-20` | 80px | Bottom padding (above BottomNav) |
| `pb-12` | 48px | Alternative bottom padding |
| `gap-2` | 8px | Button/chip gaps |
| `gap-3` | 12px | Card content gaps |
| `gap-4` | 16px | Section gaps |
| `py-3.5` | 14px | Button vertical padding |
| `py-2.5` | 10px | Smaller button / tab padding |

---

## 5. Border Radius Scale

| Token | Classes | Use |
|-------|---------|-----|
| **Full** | `rounded-full` | Pill buttons, avatars in nav |
| **3xl** | `rounded-3xl` | Avatar XL |
| **2xl** | `rounded-2xl` | Primary cards, inputs, modals |
| **xl** | `rounded-xl` | Avatar SM/MD, action cards, small buttons |
| **lg** | `rounded-lg` | Category chips, thumbnails |
| **md** | `rounded` | Flat list items, compact elements |

---

## 6. Component Specs

### 6.1 Primary Button
```svelte
<button
  class="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-2xl py-3.5
         transition-all shadow-lg shadow-blue-600/30 active:scale-95
         flex items-center justify-center
         disabled:opacity-60 disabled:cursor-not-allowed"
>
  Label
</button>
```
- Full-width for form pages, auto-width inline
- Shadow: `shadow-lg shadow-blue-600/30`
- Variant colors: `bg-purple-600` for quiz, `bg-rose-600` for danger

### 6.2 Secondary Button (Outlined)
```svelte
<!-- Light mode -->
<button
  class="border rounded-2xl py-3.5 px-4 font-bold text-sm transition-all active:scale-95
         bg-white border-slate-200 text-slate-800 hover:bg-slate-50"
>
  Label
</button>

<!-- Dark mode -->
<button
  class="border rounded-2xl py-3.5 px-4 font-bold text-sm transition-all active:scale-95
         bg-[#141720] border-slate-800 text-slate-200 hover:bg-slate-800"
>
  Label
</button>
```

### 6.3 Ghost / Pill Button (Navigation)
```svelte
<!-- Used in auth pages for navigation pills -->
<a class="px-4 py-2 rounded-full border text-xs font-bold transition-all active:scale-95
           border-slate-200 text-slate-600 hover:bg-slate-100">
  Label →
</a>
```

### 6.4 Icon Button
```svelte
<button class="p-2.5 rounded-xl border transition-all active:scale-95
               bg-white border-slate-200 text-slate-600 hover:bg-slate-100">
  <Icon class="w-4.5 h-4.5" />
</button>
```

### 6.5 Input Field
```svelte
<input
  class="w-full border rounded-2xl px-4 py-3.5 font-medium
         focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20
         transition-all
         bg-white border-slate-200 text-slate-900 placeholder:text-slate-400
         dark: bg-[#141720] border-slate-800 text-slate-100 placeholder:text-slate-600"
/>
```
- Always uses `rounded-2xl` (never pill)
- Focus ring: `focus:ring-2 focus:ring-blue-600/20`
- Border accent on focus: `focus:border-blue-600`

### 6.6 Card / Container
```svelte
<!-- Standard card -->
<div class="border rounded-2xl p-4
             bg-white border-slate-200
             dark: bg-slate-900 border-slate-800">
  ...
</div>

<!-- Subtle card (section bg) -->
<div class="border rounded-2xl p-4
             bg-slate-50 border-slate-100
             dark: bg-[#141720] border-slate-800">
  ...
</div>
```
- Use `rounded-[1.75rem]` or `rounded-[2rem]` for hero / featured cards
- Card hover: add `card-hover` class (defined in `app.css`) + `hover:bg-slate-50`

### 6.7 Tab Switcher
```svelte
<div class="flex p-1 rounded-2xl border
             bg-slate-100 border-slate-200
             dark: bg-slate-900 border-slate-800">
  <button class="flex-1 py-2.5 text-xs font-bold rounded-xl transition-all
                  {active ? 'bg-blue-600 text-white shadow-sm' : 'text-slate-600 hover:text-slate-800'}">
    Tab Label
  </button>
</div>
```

### 6.8 Section Label (Category / Divider text)
```svelte
<span class="text-[10px] font-black uppercase tracking-wider text-slate-400 dark:text-slate-500 block mb-2">
  SECTION NAME
</span>
```

### 6.9 Error / Alert Banners
```svelte
<!-- Error -->
<div class="border p-3 rounded-2xl flex items-center text-xs font-semibold
             bg-rose-50 border-rose-200 text-rose-600
             dark: bg-rose-950/30 border-rose-900/50 text-rose-200">
  <AlertCircle class="w-4 h-4 mr-2 flex-shrink-0" /> Message
</div>

<!-- Success -->
<div class="border p-3 rounded-2xl flex items-center text-xs font-semibold
             bg-emerald-50 border-emerald-200 text-emerald-700
             dark: bg-emerald-950/30 border-emerald-900/50 text-emerald-200">
  <CheckCircle2 class="w-4 h-4 mr-2 flex-shrink-0" /> Message
</div>
```

### 6.10 TopBar Component
```svelte
<TopBar title="Page Title" backHref="/parent-path">
  {#snippet right()}
    <!-- Optional right slot: icon button, text action -->
  {/snippet}
</TopBar>
```
- Sticky (`sticky top-0 z-40`)
- Bordered bottom
- Always uses `ChevronLeft` for back navigation

### 6.11 Avatar / Initials
```svelte
<AvatarInitials name={user.name} size="lg" />
```
| Size | Classes |
|------|---------|
| `sm` | `w-8 h-8 text-xs rounded-xl` |
| `md` | `w-12 h-12 text-sm rounded-2xl` |
| `lg` | `w-16 h-16 text-base rounded-2xl` |
| `xl` | `w-20 h-20 text-xl rounded-3xl` |

---

## 7. Page Layout Patterns

### 7.1 Auth Pages (login, signup, forgot-password)
```
[sticky-less header: back link + pill nav button]
[brand block: logo icon + app name + headline + subtext]
[form: inputs + error/success banners]
[primary CTA button]
[divider — OR —]
[secondary method button]
[guest CTA info box]
[footer: link to alternate auth page]
```

### 7.2 Protected Pages with BottomNav
```
[sticky header: title + action icon buttons]
[page content with px-6 horizontal padding]
[pb-20 for BottomNav clearance]
```

### 7.3 Subpages (settings, notifications, etc.)
```
[<TopBar title="..." backHref="..."> with optional right slot]
[page content with px-6 py-4]
[pb-12 bottom padding]
```

---

## 8. Motion & Interaction

| Property | Value |
|----------|-------|
| Page enter | `opacity: 0 → 1` over `200ms ease-out` (`.page-enter` class) |
| Color transitions | `transition-colors duration-200` on `*` (global in app.css) |
| Button press | `active:scale-95 transition-transform duration-150` |
| Card hover lift | `translateY(-2px)` via `.card-hover` class |
| All transitions | `transition-all` on interactive elements |

---

## 9. Dark Mode Strategy

Dark mode is stored in `localStorage` as `sekta-theme` and applied via the `app.theme` reactive store. Components use:

```svelte
let isDark = $derived(app.theme === 'dark');
// Then inline:
class={isDark ? 'bg-slate-900 border-slate-800 text-slate-100' : 'bg-white border-slate-200 text-slate-900'}
```

The root `<html>` or `<body>` does NOT use Tailwind's `dark:` selector — all dark/light variants are applied manually via `isDark` boolean.

---

## 10. Component Inventory

| Component | Path | Used by |
|-----------|------|---------|
| `TopBar` | `$lib/components/TopBar.svelte` | Settings, Notifications, and any subpage |
| `BottomNav` | `$lib/components/BottomNav.svelte` | Root layout (all main tabs) |
| `CoverImage` | `$lib/components/CoverImage.svelte` | Article cards, saved list |
| `AvatarInitials` | `$lib/components/AvatarInitials.svelte` | Profile page, homepage nav |
| `LogoutModal` | `$lib/components/LogoutModal.svelte` | Settings page |

---

## 11. Consistent Patterns Across Pages

| Pattern | Where it appears |
|---------|-----------------|
| Sticky header with `border-b` | Homepage, Explore, Profile |
| `px-6` horizontal padding | All pages |
| `font-black` for all headings | All pages |
| `rounded-2xl` for all cards and inputs | All pages |
| `bg-blue-600` primary CTA | Auth pages, empty states, explore chips |
| Tab switcher with `bg-blue-600` active | Profile, (reusable) |
| Section label `text-[10px] font-black uppercase` | Settings, Profile |
| Card list with `divide-y` | Settings menu groups |
| `ChevronRight` on navigable list items | Settings, article lists |
| Error banner with `AlertCircle` | Auth forms |
| Success banner with `CheckCircle2` | Auth forms |

---

*This document should be kept in sync with `app.css`, `TopBar.svelte`, and the shared store when design tokens change.*
