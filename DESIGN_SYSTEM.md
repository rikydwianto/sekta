# 🎨 Sekejap Fakta - Design System & UI Guide

## Target Audience
**Ages 13-25** (Teens to Young Adults)
- Modern, engaging visual language
- Clear hierarchy and navigation
- Accessible and inclusive
- Fast, responsive interactions

---

## 📐 Design Principles

1. **Minimalist Aesthetic** — No gradients, shadows, or excessive effects
2. **Solid Colors** — Bold, clean color palette
3. **Simple Borders** — Consistent border-radius and border usage
4. **Clear Hierarchy** — Typography and spacing create visual flow
5. **Purposeful Interactions** — Hover, focus, and active states guide users
6. **Consistency** — Same patterns across all pages

---

## 🎨 Color Palette

### Primary Colors
- **Blue 600** (`bg-blue-600`, `text-blue-600`) — Main CTAs, badges, active states
- **Purple 600-700** (`bg-purple-600`, `bg-purple-700`) — Quiz, secondary actions
- **Emerald 900** (`bg-emerald-900`) — Facts/highlights

### Neutral Colors (Light Mode)
- **Background:** `bg-white`
- **Surface:** `bg-slate-50`, `bg-slate-100`
- **Borders:** `border-slate-200`, `border-slate-300`
- **Text:** `text-slate-900` (dark), `text-slate-500` (muted)

### Neutral Colors (Dark Mode)
- **Background:** `bg-slate-950`
- **Surface:** `bg-slate-900`, `bg-slate-800`
- **Borders:** `border-slate-800`, `border-slate-700`
- **Text:** `text-slate-100` (light), `text-slate-400` (muted)

### Semantic Colors
- **Error:** `bg-rose-50` / `bg-rose-950/30`, `text-rose-600` / `text-rose-200`
- **Success:** `bg-emerald-50`, `text-emerald-600`

---

## 📝 Typography

### Scale
- **Display (Hero)** — `text-[28px] font-black tracking-tight` (Login/Signup headings)
- **Large Heading** — `text-2xl font-black tracking-tight` (Page titles)
- **Medium Heading** — `text-lg font-black` (Section headings)
- **Base** — `text-sm font-medium` (Body text, descriptions)
- **Label** — `text-xs font-bold uppercase` (Form labels, badges)
- **Caption** — `text-[11px] font-semibold` (Metadata, timestamps)

### Font Weights
- **Bold Display** — `font-black` (Headlines, CTAs)
- **Bold** — `font-bold` (Labels, strong emphasis)
- **Semibold** — `font-semibold` (Slightly emphasized)
- **Medium** — `font-medium` (Body, descriptions)

---

## 🔲 Components

### Primary Button
**Usage:** Main CTAs (Login, Sign Up, Start Quiz, Continue)

```svelte
<button
  class="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold py-3.5 rounded px-6 text-sm transition-all active:scale-95"
>
  Buat Akun
</button>
```

**Styling:**
- Background: `bg-blue-600`
- Hover: `hover:bg-blue-500`
- Border radius: `rounded` (medium)
- Padding: `py-3.5 px-6` (generous vertical)
- Font: `font-bold text-sm`
- Interaction: `active:scale-95`, `transition-all`

### Secondary Button (Outline)
**Usage:** Alternative actions, Google OAuth

```svelte
<button
  class="w-full border bg-white hover:bg-slate-50 text-slate-900 font-bold py-3.5 rounded px-6 text-sm transition-all active:scale-95 border-slate-200"
>
  Lanjut dengan Google
</button>
```

**Styling:**
- Border: `border border-slate-200/700`
- Background: `bg-white` / `bg-slate-900` (dark)
- Hover: `hover:bg-slate-50` / `hover:bg-slate-800`

### Input Fields
**Usage:** Email, password, text inputs

```svelte
<input
  type="email"
  placeholder="nama@email.com"
  class="w-full border rounded px-5 py-3.5 focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20 font-medium bg-white text-slate-900 border-slate-200"
/>
```

**Styling:**
- Border radius: `rounded`
- Padding: `px-5 py-3.5`
- Focus: `focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20`
- Font: `font-medium`

### Cards/Containers
**Usage:** Article cards, quiz cards, profile sections

```svelte
<div
  class="border rounded p-4 bg-white hover:bg-slate-50 transition-all border-slate-200 dark:bg-slate-900 dark:border-slate-800"
>
  <!-- Content -->
</div>
```

**Styling:**
- Border radius: `rounded` (small/medium)
- Padding: `p-4` or `p-5`
- Borders: `border border-slate-200/800`
- Hover: Optional `hover:bg-slate-50/800`

### Skeleton Loaders
**Usage:** Show loading state while fetching data from Supabase

```svelte
<SkeletonLoader type="card" />
<SkeletonLoader type="heading" width="w-3/4" height="h-5" />
<SkeletonLoader type="text" width="w-full" count={3} />
```

**Animation:**
- Duration: **2.8 seconds** (just under 3 seconds for comfortable viewing)
- Opacity: 0.5 → 0.75 → 0.5 (subtle pulse)
- Timing: `ease-in-out` (smooth, natural flow)
- Continuous loop (never stops for data-loading scenarios)

**Available Types:**
- `card` — Full card with image and text placeholders
- `text` — Line text (supports `count` for multiple lines)
- `heading` — Large heading placeholder
- `button` — Button-sized skeleton
- `avatar` — Circular/avatar skeleton
- `image` — Generic image placeholder
- `line` — Simple single line

**Best Practices:**
- Match skeleton shape to actual content
- Use while API requests are in-flight
- Don't use for loading > 3-5 seconds (show error instead)
- Subtle animation improves perceived performance

### Badge/Tag
**Usage:** Category labels, status indicators

```svelte
<span class="inline-block px-3 py-1.5 bg-blue-600 text-white text-xs font-bold rounded">
  News
</span>
```

**Styling:**
- Padding: `px-3 py-1.5`
- Border radius: `rounded` (small)
- Font: `text-xs font-bold`

---

## 📏 Spacing Scale

| Token | Size | Usage |
|-------|------|-------|
| `gap-1` | 0.25rem | Tight spacing between icons |
| `gap-2` | 0.5rem | Small spacing |
| `gap-3` | 0.75rem | Regular spacing |
| `gap-4` | 1rem | Large spacing |
| `space-y-3` | 0.75rem | Vertical spacing between elements |
| `space-y-4` | 1rem | Large vertical spacing |
| `px-6` | 1.5rem | Horizontal page padding |
| `py-3.5` | 0.875rem | Button vertical padding |
| `py-4` | 1rem | Section vertical padding |

---

## 🎯 Border Radius Scale

| Token | Size | Usage |
|-------|------|-------|
| `rounded` | 0.375rem | Inputs, small buttons |
| `rounded-lg` | 0.5rem | Cards, medium elements |
| `rounded-xl` | 0.75rem | Larger cards, buttons |
| `rounded-2xl` | 1rem | Large sections, hero cards |

---

## 🔄 Interactive States

### Hover
- Buttons: `hover:bg-blue-500` (darker shade)
- Cards: `hover:bg-slate-50/800` (subtle background change)
- Links: `hover:text-blue-600` (color change)

### Focus
- Inputs: `focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20`
- Buttons: Natural browser focus visible

### Active/Pressed
- Buttons: `active:scale-95` (slight scale down)
- Cards: No special active state

### Disabled
- Buttons: `disabled:opacity-60 disabled:cursor-not-allowed`

---

## 📱 Layout Patterns

### Page Structure
```
┌─ Sticky Header (Border Bottom)
├─ Sticky Top = 0, z-30
├─ Padding = px-6, py-4
│
├─ Content Area
├─ Padding = px-6
├─ Spacing = space-y-4, space-y-6
│
└─ Footer
  └─ Padding = pb-12 (accounts for bottom nav)
```

### Responsive Grid
```svelte
<!-- Single column on mobile, 2 columns on tablet+ -->
<div class="space-y-3 sm:grid sm:grid-cols-2 sm:gap-3 sm:space-y-0">
```

---

## 🎬 Animations & Transitions

### Page Enter
```svelte
class="page-enter"
/* Smooth fade-in, 200ms ease-out */
```

### Card Hover
```svelte
class="card-hover"
/* Subtle lift on hover, -2px translateY */
```

### Button Press
```svelte
class="active:scale-95"
/* Brief scale-down on click */
```

### General Transition
```svelte
class="transition-all duration-200"
```

---

## 🛠️ Dark Mode Implementation

**Approach:** Conditional classes using `isDark` derived value

```svelte
<div class="{isDark ? 'bg-slate-900 text-slate-100' : 'bg-white text-slate-900'}">
```

**Or:** Using Tailwind's `dark:` prefix (alternative)

```svelte
<div class="bg-white dark:bg-slate-900 text-slate-900 dark:text-slate-100">
```

**For consistency:** Use the conditional ternary approach as seen in all pages.

---

## 📋 Form Patterns

### Form Container
```svelte
<div class="space-y-4">
  <!-- Fields -->
</div>
```

### Label + Input
```svelte
<div>
  <label class="block text-xs font-bold mb-1.5 text-slate-600">Email</label>
  <input type="email" class="w-full border rounded px-5 py-3.5 focus:..." />
</div>
```

### Error State
```svelte
{#if error}
  <div class="border rounded-xl p-3 flex gap-2 bg-rose-50 border-rose-200 text-rose-600 text-xs font-semibold">
    <AlertCircle class="w-4 h-4 flex-shrink-0" />
    {error}
  </div>
{/if}
```

### Divider
```svelte
<div class="flex items-center gap-3 my-4">
  <div class="flex-1 h-px border-t border-slate-200"></div>
  <span class="text-xs font-semibold text-slate-500">atau</span>
  <div class="flex-1 h-px border-t border-slate-200"></div>
</div>
```

---

## 📱 Mobile Optimization

### Breakpoints (Tailwind)
- **Mobile first** — Design for mobile, then enhance with `sm:`, `md:`, `lg:`
- **sm** (640px+) — Tablet
- **md** (768px+) — Small desktop
- **lg** (1024px+) — Desktop

### Safe Spacing
- Horizontal: Always use `px-6` minimum
- Top: `pt-10` - `pt-12` for headers
- Bottom: `pb-12` for pages with bottom nav, `pb-8` for full-height

---

## ✅ Accessibility Considerations

1. **Form Labels** — Associate `<label>` with `<input>` via `for`/`id`
2. **Button Text** — Use descriptive text, not just icons
3. **Color Contrast** — Use tools to verify WCAG compliance
4. **Focus States** — Always provide clear focus rings
5. **Semantic HTML** — Use `<button>` for actions, `<a>` for navigation
6. **Icons + Text** — Combine icons with text labels

---

## 🎯 Pages Covered

### Auth Pages (Consistent Design)
- ✅ Login (`/login`)
- ✅ Sign Up (`/signup`)
- ✅ Forgot Password (`/forgot-password`)

### Main Pages (Consistent Design)
- ✅ Homepage (`/`)
- ✅ Explore (`/explore`)
- ✅ Quiz (`/quiz`)
- ✅ Profile (`/(protected)/profile`)

### Components
- ✅ BottomNav
- ✅ TopBar
- ✅ AvatarInitials
- ✅ CoverImage

---

## 🚀 Quick Reference

**When adding a new feature:**

1. Use color palette (blue-600 primary, purple-700 secondary)
2. Apply `rounded` border radius
3. Use button patterns (primary/secondary)
4. Add `transition-all duration-200` for smoothness
5. Include `active:scale-95` on interactive elements
6. Test in both light and dark modes
7. Ensure mobile-first responsive design
8. Verify accessibility

---

*Last updated: 2026-08-15*
*Target audience: Ages 13-25*
*Aesthetic: Minimalist, solid colors, clean borders*
