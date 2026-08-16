<script lang="ts">
  import PageHeader from '$lib/components/PageHeader.svelte';
  import { CheckCircle2, Upload, LoaderCircle } from '@lucide/svelte';
  import { updateProfile, uploadAvatar, USERNAME_PATTERN } from '$lib/api';
  import { app, updateUser } from '$lib/stores/app.svelte';
  import AvatarInitials from '$lib/components/AvatarInitials.svelte';

  let isDark = $derived(app.theme === 'dark');

  let name = $state(app.user.name);
  let username = $state(app.user.username);
  let bio = $state(app.user.bio);
  let saved = $state(false);
  let avatarUploading = $state(false);
  let avatarError = $state('');
  let usernameError = $derived(!USERNAME_PATTERN.test(username) ? 'Hanya huruf kecil, angka, dan underscore (a-z, 0-9, _)' : '');

  async function handleAvatarFile(e: Event) {
    const input = e.currentTarget as HTMLInputElement;
    const file = input.files?.[0];
    if (!file) return;
    if (!file.type.startsWith('image/')) {
      avatarError = 'File harus berupa gambar';
      return;
    }
    if (file.size > 2 * 1024 * 1024) {
      avatarError = 'Ukuran maksimal 2 MB';
      return;
    }
    avatarError = '';
    avatarUploading = true;
    try {
      const url = await uploadAvatar(file);
      updateUser({ avatar: url });
      await updateProfile({ avatar: url });
    } catch {
      avatarError = 'Gagal mengunggah foto. Coba lagi.';
    } finally {
      avatarUploading = false;
      input.value = '';
    }
  }

  function handleSave() {
    if (usernameError) return;
    updateUser({ name, username, bio });
    updateProfile({ name, username, bio });
    saved = true;
    setTimeout(() => {
      saved = false;
      history.back();
    }, 800);
  }
</script>

<div class="min-h-full flex flex-col transition-colors duration-300 {isDark ? 'text-slate-100 bg-slate-950' : 'text-slate-900 bg-white'}">
  <PageHeader title="Edit Profil" type="page" backHref="/profile" />

  <div class="px-6 py-5 flex-1 space-y-5">

    <!-- Avatar Preview -->
    <div class="flex flex-col items-center py-2">
      <div class="flex flex-col items-center">
        <div class="relative mb-3">
          <AvatarInitials src={app.user.avatar} name={name || app.user.name} size="xl" class="shadow-inner" />
          {#if avatarUploading}
            <div class="absolute inset-0 rounded-full flex items-center justify-center bg-black/40">
              <LoaderCircle class="w-6 h-6 text-white animate-spin" />
            </div>
          {/if}
          <label
            for="avatar-file"
            class="absolute -bottom-1 -right-1 w-8 h-8 rounded-full flex items-center justify-center cursor-pointer border-2 transition-colors {isDark
              ? 'bg-slate-800 border-slate-950 text-slate-200 hover:bg-slate-700'
              : 'bg-white border-white text-slate-600 hover:bg-slate-100'}"
            title="Ganti foto profil"
          >
            <Upload class="w-4 h-4" />
          </label>
          <input
            id="avatar-file"
            type="file"
            accept="image/*"
            class="hidden"
            onchange={handleAvatarFile}
          />
        </div>
        <p class="text-xs font-medium {isDark ? 'text-slate-500' : 'text-slate-400'}">
          {app.user.avatar ? 'Ketuk ikon kamera untuk ganti foto' : 'Ketuk ikon kamera untuk menambah foto'}
        </p>
        {#if avatarError}
          <p class="mt-2 text-xs font-semibold text-red-500">{avatarError}</p>
        {/if}
      </div>
    </div>

    <!-- Name -->
    <div>
      <label for="edit-name" class="block text-xs font-bold mb-1.5 {isDark ? 'text-slate-400' : 'text-slate-600'}">
        Nama Lengkap
      </label>
      <input
        id="edit-name"
        type="text"
        bind:value={name}
        placeholder="Nama lengkap kamu"
        class="w-full border rounded-xl px-4 py-3 text-sm font-medium focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20 transition-all {isDark
          ? 'bg-[#141720] border-slate-800 text-slate-100 placeholder:text-slate-600'
          : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
      />
    </div>

    <!-- Username -->
    <div>
      <label for="edit-username" class="block text-xs font-bold mb-1.5 {isDark ? 'text-slate-400' : 'text-slate-600'}">
        Username
      </label>
      <input
        id="edit-username"
        type="text"
        bind:value={username}
        placeholder="@username"
        class="w-full border rounded-xl px-4 py-3 text-sm font-medium focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20 transition-all {usernameError
          ? 'border-red-500 focus:border-red-500 focus:ring-red-500/20'
          : 'focus:border-blue-600 focus:ring-blue-600/20'} {isDark
          ? 'bg-[#141720] border-slate-800 text-slate-100 placeholder:text-slate-600'
          : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
      />
      {#if usernameError}
        <p class="mt-1.5 text-xs font-semibold text-red-500">{usernameError}</p>
      {/if}
    </div>

    <!-- Bio -->
    <div>
      <label for="edit-bio" class="block text-xs font-bold mb-1.5 {isDark ? 'text-slate-400' : 'text-slate-600'}">
        Bio
      </label>
      <textarea
        id="edit-bio"
        rows="3"
        bind:value={bio}
        placeholder="Ceritakan sedikit tentang dirimu..."
        class="w-full border rounded-xl px-4 py-3 text-sm font-medium resize-none focus:outline-none focus:border-blue-600 focus:ring-2 focus:ring-blue-600/20 transition-all {isDark
          ? 'bg-[#141720] border-slate-800 text-slate-100 placeholder:text-slate-600'
          : 'bg-white border-slate-200 text-slate-900 placeholder:text-slate-400'}"
      ></textarea>
    </div>

  </div>

  <!-- Save Button -->
  <div class="px-6 pb-8 pt-2">
    <button
      onclick={handleSave}
      disabled={!!usernameError}
      class="w-full font-bold py-3.5 rounded-xl text-sm transition-all active:scale-95 flex items-center justify-center gap-2 disabled:opacity-50 disabled:active:scale-100 {saved
        ? 'bg-emerald-600 text-white shadow-lg shadow-emerald-600/30'
        : 'bg-blue-600 hover:bg-blue-500 text-white shadow-lg shadow-blue-600/30'}"
    >
      {#if saved}
        <CheckCircle2 class="w-4 h-4" />
        Tersimpan!
      {:else}
        Simpan Perubahan
      {/if}
    </button>
  </div>
</div>
