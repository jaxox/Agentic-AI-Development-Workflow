---
name: "api-contract-guard"
description: "Use when API request/response fields, DTOs, schemas, serializers, or OpenAPI specs are added, renamed, removed, or retyped. Apply this skill to keep implementation and contract in sync, prevent silent breaking changes, and enforce contract-level tests in backend PRs."
---

# API Contract Guard

## Outcome
Keep API behavior, DTOs, and OpenAPI documentation aligned across every change.

## Required workflow
1. Detect contract surface changes.
List endpoint, method, path params, query params, request body, response body, and status code changes.
2. Verify implementation-contract sync.
Ensure DTO/model mapping and OpenAPI/schema changes are updated together.
3. Classify compatibility impact.
Mark as non-breaking, conditionally breaking, or breaking.
4. Run a contract-sync triad.
Verify:
- backend schema/OpenAPI or equivalent contract source changed or was explicitly re-verified unchanged
- frontend/client-facing contract types and adapters were updated together
- at least one consumer path proves the new field/shape is actually read and rendered correctly
5. Add contract tests.
Cover changed fields, nullability, type expectations, status codes, and consumer parsing expectations.
6. Check source-of-truth boundaries.
Confirm the changed flow is authoritative in backend persistence and API reads rather than derived from local-only client state.
7. Check reload and refetch semantics.
Confirm a fresh read after mutation reproduces the same state and counters from persisted backend data.

## Backend-authoritative checklist
- Identify whether the flow involves shared state, counters, snapshots, attendance, chat, notifications, or other data that can drift across clients.
- Verify the backend computes authoritative counters and derived values. Do not allow UI-only arithmetic to become the contract by accident.
- Verify mutation success means backend persistence succeeded. If persistence can fail, require an explicit error contract instead of local-only success.
- Verify follow-up reads return the same post-mutation state after refresh, reconnect, or refetch.
- When backend and frontend live in separate repos, require evidence that both contract sides were updated together.
- When OpenAPI snapshots, generated clients, or hand-maintained contract files exist, treat contract drift as unresolved until all three surfaces agree: schema, adapter, and consumer.

## Snapshot drift triage
- If schema artifacts changed, identify whether the source of truth is backend-generated OpenAPI, generated client output, or hand-maintained contract files.
- Compare changed schema fields against adapters and downstream parsing code before approving the diff.
- If CI/workflow conditionals gate contract checks, verify the gate itself cannot silently skip validation in common branches, forks, or secret-unavailable contexts.
- Record which files prove contract alignment, for example schema snapshot, frontend contract types, adapter mapping, and one consumer/test.

## Guardrails
- Never ship renamed or removed fields without explicit compatibility notes.
- If a field changes type or nullability, add migration/compatibility handling.
- If endpoint semantics changed, update examples and error responses in schema.
- If OpenAPI changed, confirm generated clients or consumers are not silently broken.
- Never accept a frontend-only patch as the real fix when the contract drift is caused by backend persistence, backend calculation, or missing API fields.

## Test expectations
- Add integration tests validating response shape and key status codes.
- Add negative tests for validation errors and unsupported input combinations.
- If change is breaking, include an explicit test proving old behavior is rejected or deprecated intentionally.
- When the contract represents shared or persisted state, add at least one test that mutates then re-reads the resource to prove post-refresh correctness.
- When the flow is collaborative or multi-user, add at least one test proving different clients converge on the same backend-returned state.
- When frontend consumers are in scope, add at least one test that proves the changed field survives adapter parsing and is visible through the user-facing read path after reload/refetch.

## Output format
Return a concise report with:
- Contract changes detected.
- Compatibility classification and rationale.
- Required schema/adapter/consumer/test deltas.
- Source-of-truth verdict and any backend-authoritative risks.
