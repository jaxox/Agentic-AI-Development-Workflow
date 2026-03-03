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
4. Add contract tests.
Cover changed fields, nullability, type expectations, and status codes.

## Guardrails
- Never ship renamed or removed fields without explicit compatibility notes.
- If a field changes type or nullability, add migration/compatibility handling.
- If endpoint semantics changed, update examples and error responses in schema.
- If OpenAPI changed, confirm generated clients or consumers are not silently broken.

## Test expectations
- Add integration tests validating response shape and key status codes.
- Add negative tests for validation errors and unsupported input combinations.
- If change is breaking, include an explicit test proving old behavior is rejected or deprecated intentionally.

## Output format
Return a concise report with:
- Contract changes detected.
- Compatibility classification and rationale.
- Required code/spec/test deltas.
