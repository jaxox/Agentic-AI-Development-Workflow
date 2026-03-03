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

## Reliability checks
- Idempotency: repeated requests/events must not duplicate side effects.
- Caching: define invalidation triggers and stale-read boundaries.
- Streaming: define reconnect behavior, heartbeat/timeout, and backpressure handling.
- Async boundaries: handle partial success and ensure compensation or retry strategy.
- Time behavior: avoid flaky tests by controlling clocks or time windows explicitly.

## Observability minimums
- Emit a metric for success/failure rate of changed critical path.
- Emit a latency metric or histogram for the critical operation.
- Add at least one trace span around the changed boundary.
- Ensure errors include stable classification fields for alerting.

## Test expectations
- Add at least one retry/idempotency test for side-effecting paths.
- Add at least one cache correctness test if caching is touched.
- Add at least one reconnect/backpressure test for SSE/WebSocket paths.

## Output format
Return a concise report with:
- Top reliability risks and severity.
- Required code/test/instrumentation changes.
- Residual operational risks after merge.
