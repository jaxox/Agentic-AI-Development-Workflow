---
name: "reliability-triage"
description: "Use when backend changes affect caching, real-time delivery (SSE/WebSocket), retries, idempotency, async events, observability, or incident-prone paths. Apply this skill to identify reliability risks early, require deterministic tests, and add instrumentation needed for safe production operation."
---

# Reliability Triage

## Outcome
Ship changes that stay correct under retries, load, partial failures, and reconnect scenarios.

## Required workflow
1. Identify failure-prone paths.
Focus on cache invalidation boundaries, event streams, retries, and side effects.
2. Run reliability checks.
Validate idempotency, timeout behavior, reconnect semantics, and failure isolation.
3. Enforce observability minimums.
Add logs/metrics/traces needed to detect and diagnose regressions.
4. Add deterministic tests.
Cover replay/retry, stale cache, and stream reconnect behavior.
5. Check convergence after read boundaries.
Verify that refresh, refetch, reconnect, or second-session reads converge back to the same backend-authoritative state.

## Shared-state reliability checklist
- Identify whether the changed path exposes shared state across users, tabs, devices, or background consumers.
- Define the authoritative owner of each visible state field: persistence layer, backend projection, cache, stream event, or client-local draft.
- Verify that reconnect, retry, and stale cache recovery cannot leave the UI permanently ahead of or behind backend truth.
- Verify that stream events and polling/refetch paths converge to the same result instead of competing to overwrite one another.
- When authorization or membership can change mid-session, define what happens to subscriptions, unread state, and pending sends after permission loss.
- For chat or DM flows, explicitly inspect duplicate delivery, unread bootstrap, stale badge sync, reconnect races, and out-of-order event handling.

## Reliability checks
- Idempotency: repeated requests/events must not duplicate side effects.
- Caching: define invalidation triggers and stale-read boundaries.
- Streaming: define reconnect behavior, heartbeat/timeout, and backpressure handling.
- Async boundaries: handle partial success and ensure compensation or retry strategy.
- Time behavior: avoid flaky tests by controlling clocks or time windows explicitly.
- Authorization drift: handle membership/session loss during active streams or retries without leaking stale success state.
- Convergence: define how a second read boundary (refresh/refetch/reconnect) heals temporary divergence.
- Multi-writer coordination: define what happens when send, sync, and unread/accounting updates race each other.
- Bootstrap correctness: ensure initial snapshot and realtime updates compose without gaps or double-application.

## Observability minimums
- Emit a metric for success/failure rate of changed critical path.
- Emit a latency metric or histogram for the critical operation.
- Add at least one trace span around the changed boundary.
- Ensure errors include stable classification fields for alerting.
- For realtime/shared-state paths, log or classify reconnect failures, authorization drops, and replay/retry suppression decisions.
- For messaging/shared counters, add enough classification to distinguish duplicate suppression, bootstrap repair, stale snapshot repair, and permission-loss teardown.

## Test expectations
- Add at least one retry/idempotency test for side-effecting paths.
- Add at least one cache correctness test if caching is touched.
- Add at least one reconnect/backpressure test for SSE/WebSocket paths.
- For realtime or shared-state paths, add at least one test that proves post-reconnect or post-refetch convergence to backend truth.
- For authorization-sensitive streams, add at least one test covering permission loss, removal, or stale membership during an active session.
- For chat/DM systems, add at least one test around initial snapshot plus incremental event composition and one test around duplicate or replay suppression.

## Output format
Return a concise report with:
- Top reliability risks and severity.
- Required code/test/instrumentation changes.
- Residual operational risks after merge.
- Convergence verdict for refresh/refetch/reconnect behavior.
- If messaging/shared-state is in scope, include a race verdict for bootstrap, duplicate suppression, and authorization-drift handling.
