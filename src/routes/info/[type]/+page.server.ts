import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

const redirects: Record<string, string> = {
  privacy: '/privacy',
  terms: '/terms',
  about: '/about'
};

export const load: PageServerLoad = ({ params }) => {
  const target = redirects[params.type as string];
  if (target) redirect(301, target);
  redirect(301, '/about');
};
