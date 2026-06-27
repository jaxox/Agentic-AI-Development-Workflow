---
name: "reliability-triage"
description: "Use for production reliability incident triage or backend changes involving caching, real-time delivery (SSE/WebSocket), retries, idempotency, async events, gRPC/upstream failures, Kubernetes readiness, observability, Sentry/Grafana/Kibana investigation, or incident-prone paths. Apply this skill to separate evidence from hypotheses, identify reliability risks early, prefer root-cause fixes over mitigations, require deterministic tests, and add instrumentation needed for safe production operation."
---

# Reliability Triage

## Outcome
Ship changes and triage incidents in a way that stays correct under retries, load, partial failures, and reconnect scenarios.

## Required workflow
1. Build an evidence ledger.
List proven facts with their source, timestamp, query, log line, metric, trace, or code reference. Separately list ruled-out causes and remaining hypotheses. Do not use "most likely" unless the supporting evidence and remaining proof gap are explicit.
2. Identify failure-prone paths.
Focus on cache invalidation boundaries, event streams, retries, and side effects.
3. Run reliability checks.
Validate idempotency, timeout behavior, reconnect semantics, and failure isolation.
4. Enforce observability minimums.
Add logs/metrics/traces needed to detect and diagnose regressions.
5. Add deterministic tests.
Cover replay/retry, stale cache, and stream reconnect behavior.
6. Check convergence after read boundaries.
Verify that refresh, refetch, reconnect, or second-session reads converge back to the same backend-authoritative state.

## Evidence-first incident triage
- Separate confirmed facts, disproven causes, and hypotheses in the response.
- Prefer root-cause fixes over changes that only hide the symptom. If a mitigation is still useful, label it as blast-radius reduction and do not present it as the primary fix.
- For caller/upstream failures, prove whether the upstream was unavailable, overloaded, draining, timing out, or healthy-but-unreachable before recommending the fix.
- For Kubernetes readiness or liveness issues, distinguish broad health-check failures from actual request-serving failures.
- For Jira tickets derived from incidents, make acceptance criteria directly test the proposed change and the observed failure mode. Avoid vague alternatives like "or equivalent" when a concrete value can be tested.

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
- Keep metric labels low-cardinality. Do not use request IDs, customer IDs, IPs, pod names, raw exception messages, stack traces, or other unbounded values as labels.
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
- Evidence ledger: confirmed facts, ruled-out causes, and remaining hypotheses.
- Top reliability risks and severity.
- Recommended root-cause fix, plus any separate blast-radius mitigations.
- Required code/test/instrumentation changes.
- Residual operational risks after merge.
- Convergence verdict for refresh/refetch/reconnect behavior.
- If messaging/shared-state is in scope, include a race verdict for bootstrap, duplicate suppression, and authorization-drift handling.
