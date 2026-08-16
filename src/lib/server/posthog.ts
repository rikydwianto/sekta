import { env } from '$env/dynamic/private';

export type HogQLRow = (string | number | null)[];
export type HogQLResult = { columns: string[]; rows: HogQLRow[] };

export async function posthogQuery(hogql: string): Promise<HogQLResult> {
  const key = env.POSTHOG_API_KEY;
  const projectId = env.POSTHOG_PROJECT_ID;
  const host = env.PUBLIC_POSTHOG_HOST || 'https://us.i.posthog.com';

  if (!key || !projectId) {
    throw new Error('POSTHOG_API_KEY / POSTHOG_PROJECT_ID belum dikonfigurasi di .env');
  }

  const res = await fetch(`${host.replace(/\/$/, '')}/api/projects/${projectId}/query/`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${key}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ query: { kind: 'HogQLQuery', query: hogql } })
  });

  if (!res.ok) {
    const body = await res.text();
    throw new Error(`PostHog API ${res.status}: ${body.slice(0, 300)}`);
  }

  const data = (await res.json()) as { results?: unknown[]; columns?: string[]; detail?: string; error?: string };
  if (!Array.isArray(data.results)) {
    const msg = data.detail ?? data.error ?? 'Respons PostHog tidak memiliki results';
    throw new Error(`PostHog API: ${msg}`);
  }

  return {
    columns: data.columns ?? [],
    rows: (data.results ?? []).filter((r): r is HogQLRow => Array.isArray(r))
  };
}

export function scalar(row: HogQLRow | undefined): number {
  const v = row?.[0];
  const n = typeof v === 'number' ? v : Number(v);
  return Number.isFinite(n) ? n : 0;
}
