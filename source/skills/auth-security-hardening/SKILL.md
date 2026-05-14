---
name: "auth-security-hardening"
description: "Use when changing or reviewing authentication/authorization flows in backend services, especially sessions, cookies, CSRF, OAuth, token validation, login abuse controls, and auth-adjacent API behavior. Apply this skill to prevent security regressions by enforcing threat-aware checks, required tests, and safe rollout practices."
---

# Auth Security Hardening

## Outcome
Ship auth changes without introducing exploitable regressions.

## Required workflow
1. Map trust boundaries.
Identify user-controlled inputs, session/token issuance, and privileged transitions.
2. Run the hardening checklist.
Cover cookies, CSRF, token verification, authorization checks, and abuse protection.
3. Add or update tests.
Cover both success paths and abuse/negative paths.
4. Define rollout safety.
Document fallback behavior, monitoring, and rollback trigger.
5. Check auth-adjacent state transitions.
Verify how session, agreement, membership, or token-refresh state changes affect in-flight mutations, subscriptions, notifications, and other shared-state features.

## Hardening checklist
- Cookies: set `HttpOnly`, `Secure`, and explicit `SameSite` policy appropriate to the flow.
- CSRF: enforce token/origin validation for cookie-authenticated state-changing requests.
- Token validation: verify issuer, audience, signature, expiration, and clock-skew handling.
- Authorization: verify resource ownership and role constraints on all sensitive endpoints.
- Abuse protection: include per-IP and per-identity rate limiting on login/reset/register flows.
- Error handling: avoid leaking credential validity or sensitive internals in auth error responses.
- Session transitions: define what happens when refresh fails, agreement is required, or the user loses access mid-flow.
- Shared-state features: ensure chat, notifications, background sync, and pending writes do not present stale success after auth or membership loss.

## Test expectations
- Add at least one regression test for each changed auth control.
- Include a negative test for unauthorized access and malformed/expired token handling.
- Include a rate-limit behavior test if auth endpoints are changed.
- When auth state gates a feature, add a test covering the gated transition, for example session valid -> agreement required, member -> removed, or token refresh success -> refresh denied.

## Output format
Return a concise report with:
- Risks found and their severity.
- Code/test changes made.
- Remaining risks and recommended follow-up.
- Auth-adjacent state verdict for in-flight mutations, subscriptions, and shared-state UI.
