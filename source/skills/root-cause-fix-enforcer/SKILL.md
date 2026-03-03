---
name: root-cause-fix-enforcer
description: Enforce production-grade root-cause fixes instead of quick patches. Use when users report repeated regressions, ask to "fix properly," request adherence to AGENTS.md rules, or call out band-aids, fake data, temp state, or UI-only hacks. Apply to frontend, backend, API contract, and tests so fixes are flow-complete and durable.
---

# Root-Cause Fix Enforcer

## Overview

Use this skill to stabilize recurring issues by fixing the authoritative cause across the full request-to-state-to-UI flow.
Prioritize correctness, determinism, and long-term maintainability over speed-only patches.

## Required Operating Rules

1. Read and follow the target repository `AGENTS.md` before editing.
2. Trace the end-to-end flow first: entrypoint, guards, API calls, persistence/state, error propagation, UI behavior, and tests.
3. Fix the highest-authority layer that can eliminate the defect for all callers.
4. Update contracts and types whenever behavior or payload shape changes.
5. Add or update tests that would have failed before the fix and now pass.
6. Never ship speculative or cosmetic-only fixes without flow verification.
7. Use invariant-driven closure for recurring issues: define non-negotiable flow invariants before coding and verify all are satisfied before completion.
8. If repository guardrails require backend-sync evidence for touched scope, treat that as mandatory implementation scope (backend changes and/or proof artifact updates in the same cycle).

## Hard Prohibitions

1. Do not use fake data to hide broken integrations.
2. Do not rely on temporary local state as authority when backend or shared state is authoritative.
3. Do not add UI hacks that mask backend or contract bugs.
4. Do not special-case message text when stable error codes exist or can be added.
5. Do not stop at a single symptom if sibling paths share the same defect pattern.
6. Do not mark work complete when any entrypoint in scope lacks the same durability guarantees as the primary fixed path.
7. Do not claim completion when any incoming `P0/P1` finding ID remains open.

## Anti-Loop Protocol (Mandatory for 2nd+ Iteration on Same Issue Family)

When an issue recurs (for example auth/legal/RSVP loops), execute this protocol before editing:

1. Define invariant set.
- Write 3-7 explicit invariants that must always hold after the fix.
- Use behavioral language, not implementation language.
- Example: "Every transactional auth success path must verify refreshed auth state before navigation."

2. Build entrypoint matrix.
- Enumerate every entrypoint that touches the invariant.
- Include primary path and sibling paths.
- Map each path to owner layer and expected post-condition.

3. Select closure strategy.
- Pick the smallest authoritative-layer change that enforces the invariant across all entrypoints.
- If this is impossible, split into ordered remediations and mark blockers explicitly.

4. Add stop-ship validations.
- Add tests or checks that fail whenever an invariant regresses.
- Include at least one adjacent-path test per invariant.

5. Do not finalize until matrix is closed.
- Any unclosed entrypoint means "not done."

## Review-to-Fix Handshake (Required with Uncommitted Code Review)

When this skill is used after `uncommitted-code-review`, treat review findings as a closure contract:

1. Build a findings ledger.
- Copy each P0/P1/P2 item into a checklist with stable IDs (for example `P1-1`, `P2-1`).
- Map each ID to files, entrypoints, and planned validation.

2. Implement by ledger ID, not by narrative.
- Apply code/test changes that close each ID.
- Mark each ID `open` or `closed` only after validation evidence exists.

3. Run closure review before finalizing.
- Re-run uncommitted review or equivalent checks.
- If any previously open ID remains open, continue iterating.

4. Escalate after 2 failed loops on same ID.
- If the same ID reappears twice, pause and add:
  - one new guardrail/static check, or
  - one invariant regression test at a higher-authority layer.
- Do not continue line-level patching without this escalation.

## Invariant + Entrypoint Matrix Template

Use this template in notes or status updates before implementation:

```text
Invariant:
Entrypoints in scope:
Authoritative owner layer:
Expected post-condition:
Validation proving closure:
Finding IDs covered:
```

## Execution Workflow

1. Define failure contract and invariants.
- Capture expected behavior, current behavior, and exact failing paths.
- Identify whether the bug is contract, state, routing, authorization, or rendering.
- Declare invariants that must hold after fix.

2. Map the full flow and sibling entrypoints.
- Start from user action and trace through route guards, service layer, API adapter, backend contract, and persistence.
- Record where authoritative truth is set and where it is consumed.
- Build entrypoint matrix for all sibling paths that can violate the same invariant.

3. Select fix layer by precedence.
- Contract/data integrity layer (preferred).
- Shared state/session/auth layer.
- Route/guard enforcement layer.
- UI rendering layer (last).

4. Implement complete fix set.
- Patch root cause.
- Patch all affected sibling paths discovered during trace.
- Remove contradictory fallback logic that reintroduces drift.
- Prefer shared helpers/contracts over duplicated ad-hoc logic.

5. Harden tests.
- Add regression tests for the original failure.
- Add at least one adjacent-path test for the same root cause class.
- Ensure cleanup in tests uses `finally` when global listeners/hooks are involved.
- Add one invariant-level test/check that blocks recurrence.

6. Validate and report.
- Run targeted tests first, then broader suite/build as needed.
- Run repo guardrail checks defined by project rules (for example `guardrails:check`) before finalizing.
- Report root cause, changed files, and why the fix is durable.
- Explicitly report invariant closure status for each entrypoint in scope.
- Include findings ledger status (`open`/`closed`) for every input review ID.

## Quality Gate Before Final Response

Pass all checks in [root-cause-checklist.md](references/root-cause-checklist.md).
If any check fails, continue iterating before presenting completion.
