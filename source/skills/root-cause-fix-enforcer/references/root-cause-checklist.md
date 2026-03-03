# Root-Cause Completion Checklist

Use this checklist before marking work complete.

## A. Flow Understanding

- Reproduce or deterministically reason about the failure path.
- Identify authoritative source of truth for the failing behavior.
- Confirm whether similar paths share the same defect class.

## B. Fix Quality

- Root cause fixed at authoritative layer when feasible.
- No fake data introduced.
- No temporary state used as long-term authority.
- No UI-only masking of unresolved backend/contract issues.
- Error handling uses stable codes/contracts instead of brittle text matching.

## C. Contract and Consistency

- API/types/DTOs synchronized when payload behavior changes.
- Frontend guards/state use the same authority as backend responses.
- Fallback paths do not conflict with primary logic.

## D. Tests

- Regression test added or updated for the primary failing case.
- At least one adjacent path test added/updated for shared root-cause class.
- Test setup/teardown is deterministic; global listeners cleaned in `finally`.
- Tests assert behaviorally important outcomes, not incidental implementation details.

## E. Validation

- Targeted tests run and pass.
- Broader validation run (build/integration/E2E) when affected.
- Final report states root cause, fix strategy, and why recurrence risk is reduced.

## F. Invariant Closure (Anti-Loop)

- Invariants are explicitly listed before implementation.
- Entrypoint matrix is complete for all sibling paths in scope.
- Every matrix row has a validation artifact (test/check/manual proof).
- No path still relies on old/brittle behavior while primary path is fixed.
- Final report explicitly marks each invariant as `closed` or `open`.
- If any invariant is open, do not claim completion.

## G. Findings Ledger Closure

- Every input review finding ID is listed with status (`open` / `closed`).
- Every `closed` ID includes concrete validation evidence.
- Any repeated ID across cycles has an added escalation action (guardrail/test/process gate).
- If any P0/P1 ID remains `open`, do not claim completion.

## H. Guardrail and Backend-Sync Compliance

- Repository `AGENTS.md` guarded-scope requirements were checked and applied.
- If guarded scope requires backend sync/proof, evidence is updated in the same cycle.
- Project guardrail command/check (if defined) was executed and passed.
