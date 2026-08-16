import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig, loadEnv } from 'vite';

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  const port = parseInt(env.PORT || '5173', 10);

  return {
    plugins: [sveltekit()],
    server: {
      port,
      allowedHosts: ['sekta.my.id', '.sekta.my.id']
    },
    preview: { port }
  };
});
