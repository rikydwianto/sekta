import posthog from 'posthog-js';

let pendingIdentify: { id: string; props: Record<string, unknown> } | null = null;

export function track(event: string, properties?: Record<string, unknown>) {
  if (typeof window !== 'undefined' && posthog.__loaded) {
    posthog.capture(event, properties);
  }
}

export function identifyPostHog(id: string, props?: Record<string, unknown>) {
  if (typeof window !== 'undefined' && posthog.__loaded) {
    posthog.identify(id, props);
  } else {
    pendingIdentify = { id, props: props ?? {} };
  }
}

export function flushPendingIdentify() {
  if (pendingIdentify && typeof window !== 'undefined' && posthog.__loaded) {
    posthog.identify(pendingIdentify.id, pendingIdentify.props);
    pendingIdentify = null;
  }
}

export function resetPostHog() {
  pendingIdentify = null;
  if (typeof window !== 'undefined' && posthog.__loaded) {
    posthog.reset();
  }
}
