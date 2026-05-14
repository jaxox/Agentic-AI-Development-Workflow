---
name: dinkify-user-stories-browser-audit
description: Run the Dinkify critical user stories checklist through manual Computer Use browser testing, write a dated `docs/user-stories-checklist_mm_dd_yy.md` pass/fail checklist, and use root-cause-fix-enforcer to fix failed app stories until they pass. Use when the user asks to validate `docs/critical-user-stories-checklist.md`, audit all current Dinkify user stories, create a dated user-story checklist, or manually browser-test Dinkify stories end to end.
---

# Dinkify User Stories Browser Audit

## Overview

Use this skill to turn the Dinkify critical user stories checklist into a dated, evidence-backed browser-testing ledger. Compose it with `manual-computer-use-browser-testing` for UI validation and `root-cause-fix-enforcer` for any product defect found during the pass.

## Default Inputs

- Frontend repo: `/Users/wlyu/dev/AI-PROJECT/dinkify-frontend`
- Story source: `docs/critical-user-stories-checklist.md`
- E2E coverage-gap guide: `docs/browser-audit/e2e-coverage-gap-guidelines.md`
- Output file: `docs/user-stories-checklist_mm_dd_yy.md`, where `mm_dd_yy` comes from the local current date.
- Backend repo for fixes when needed: `/Users/wlyu/dev/AI-PROJECT/dinkify-backend`
- Infra repo for environment/release wiring issues when needed: `/Users/wlyu/dev/AI-PROJECT/dinkify-infra`

## Required Skill Composition

1. Read and follow `manual-computer-use-browser-testing` before touching the browser.
2. Use Computer Use for Chrome interactions whenever available.
3. If any story fails because of app behavior, invoke `root-cause-fix-enforcer` before editing and continue until the story passes after a fresh manual retest.
4. If Computer Use, browser access, backend availability, credentials, sandbox Stripe, or another external dependency blocks testing, mark the story `blocked` with evidence and do not call it passed.
5. Do not silently substitute Playwright, API calls, unit tests, code inspection, or backend-only proof for Computer Use manual browser evidence. If Computer Use cannot provide manual proof, mark the affected story `blocked` and explain why.
6. Use retrospective learning during the run. Record each recurring blocker, speedup, stale setup problem, and tool limitation in the dated report so the next audit does not rediscover the same issue.
7. For every Computer Use bug found, perform E2E coverage-gap analysis before closing the issue: identify whether an existing Playwright test should have caught it, why it did not, and what test or selector/data improvement is needed.
8. Read the frontend coverage-gap guide before closing a manual product bug. If the bug matches a known Dinkify gap pattern, add or update the recommended deterministic regression before marking the story fixed.
9. For paid release/refund bugs, do not close from backend payment status alone. Add or update a visible host-session assertion for the correct destination bucket after refetch: `Maybe` release appears under Maybe, `Can't Go` appears under Declined, and badges show the final payment state rather than stale `Paid`.
10. When using parallel fix agents, keep one uninterrupted main testing lane. Fix agents may inspect code, patch scoped files, and run unit/static checks immediately, but they must not run E2E commands that reclaim or stop the main backend port. E2E retests either go into a retest queue or run on an isolated backend/API port such as `E2E_API_BASE_URL=http://127.0.0.1:18080/api`.

## Audit Modes

Use the smallest mode that matches the user's intent.

### Weekly Scout Mode

Use this when the goal is to find bugs after many changes. This is the default for "weekly" or "big change" audits.

- Treat 60 minutes as the normal target, not a guarantee for full checklist coverage.
- Before opening Computer Use, run the frontend preflight from `/Users/wlyu/dev/AI-PROJECT/dinkify-frontend`:
  `npm run browser-scout:preflight:strict`.
- If strict preflight fails, stop the browser run and fix setup/manifest/service readiness first. Do not click through a known-bad setup hoping to recover manually.
- Use `docs/browser-audit/scout-manifest.local.json` as the actor source of truth. If host/player account identity is uncertain, mark setup blocked before story execution.
- Follow `docs/browser-audit/fast-weekly-scout-runbook.md` for the 60-minute story family order and timeboxes.
- If the manifest includes expected event ids, host emails, profile bundle ids, or start URLs, validate them before story execution. Actor/session drift is a setup failure, not a flaky product bug.
- Do not manually replay every low-risk happy path that Playwright already covers well.
- Prioritize high-risk, recently changed, and historically brittle flows.
- Use Computer Use to validate real app UX surfaces, visual state, multi-user state, modal/dock behavior, mobile viewport usability, and integration seams that automated tests often miss.
- Stop at the first credible product bug in a story family, capture evidence, run root-cause analysis, and create/update the missing E2E regression test.
- Timebox each story family. If no bug appears after the risk path and one adjacent path, move on.
- Output is a bug-discovery and E2E-gap ledger, not only a pass/fail checklist.

### Full Certification Mode

Use this only when the user explicitly asks for every story to be manually proven.

- Execute every checklist story through Computer Use unless blocked.
- Expect this mode to be much slower.
- Still use all speed rules, timing metrics, and E2E gap analysis.

## Computer Use Speed Protocol

Computer Use is expensive because every observe/click/type cycle involves tool latency plus model reasoning. Reduce round trips without weakening proof:

- Prefer `set_value` for normal settable text fields when Computer Use exposes the field, then visually verify the value once. Use `type_text` when the app behavior depends on keystrokes, masks, autocomplete, validation timing, or IME-like behavior.
- Use one `get_app_state` per screen/state transition, then perform the next known action. Do not re-observe after every harmless click unless the UI is expected to change.
- Use stable element-index clicks when the accessibility tree is small and clear.
- Use visible coordinate clicks when DevTools or complex pages make the accessibility tree too large, but record the coordinate target and verify the visible result.
- Keep a run-local click map for repeated app surfaces: bottom nav, RSVP dock, Players modal tabs, Settings payout button, event wizard Next/Save buttons, and common modal close/confirm actions.
- Batch text entry by field, not character. Avoid slow literal typing for long names, descriptions, addresses, or emails unless testing typing behavior itself.
- Use backend/API/DB helpers only for setup and diagnostics, never as proof. Good setup examples: creating seed users, ensuring a host has sandbox payout connected, clearing expired orders, or confirming current event ID.
- Reuse logged-in actor windows and prepared event fixtures across stories unless the story tests login, onboarding, payout setup, or event creation itself.
- Prefer app UI navigation for proof, but do not waste time navigating from Home for every related story. Once a story family is on the correct page through visible UI, continue adjacent checks from that state.
- Keep Stripe hosted Checkout out of the main Computer Use loop when the goal is Dinkify UX coverage. Use one dedicated sandbox Checkout smoke path, then verify Dinkify return state and backend state.
- Record model/tool latency as `Computer Use overhead` when a click/input action is visibly instant but the next assistant/tool step takes significant time.

## Bug-To-E2E Gap Loop

Every manual bug found must produce a test-learning outcome.

For each bug, answer:

1. Was there an existing E2E test for this user story?
2. If yes, why did it miss the bug?
   - wrong flow path
   - mocked/fake backend hid the integration issue
   - no real UI assertion after refresh/refetch
   - no mobile viewport coverage
   - no organizer/player second-session verification
   - selector clicked the wrong thing or skipped visible UX
   - test used direct URL/localStorage/API setup where real users use navigation
   - test asserted API success but not visible UI state
   - test omitted Stripe sandbox or webhook behavior
   - test data did not match production-like conditions
   - test merged distinct user choices into one generic path, such as treating `Maybe` and `Can't Go` as the same paid-release bucket
   - broad text assertions matched unrelated title/copy instead of exact badge text
3. If no, which test level should cover it?
   - unit/component
   - backend integration
   - Playwright fake-mode E2E
   - Playwright real sandbox smoke
   - weekly Computer Use scout only
4. What new assertion would have failed before the fix?
5. What fixture/setup change prevents this gap from recurring?

Add one of these outcomes to the dated report:

- `e2e_added`: regression E2E added or updated.
- `unit_or_integration_added`: lower-level regression added because E2E would be too slow/brittle.
- `sandbox_smoke_added`: real Stripe/sandbox smoke added or updated.
- `manual_only_with_reason`: not practical for E2E; keep in weekly Computer Use scout with explicit reason.
- `coverage_debt`: follow-up required before release.

Also record these structured fields so future agents can convert the finding into better automated coverage:

- `storyFamily`
- `bugClass`
- `existingPlaywrightSpec`
- `whyMissed`
- `newAssertion`
- `coverageOutcome`
- `owner`
- `followupLink`

## Performance Instrumentation Contract

Treat each audit as a measured reliability run, not an ad hoc click-through.

Capture these metrics for the whole run:

- `runId`: stable timestamp-based ID.
- `startedAt` / `finishedAt`.
- `totalDuration`.
- `browserStartupDuration`: app/window launch or first `get_app_state` to first usable page interaction.
- `preflightDuration`: service, actor, Computer Use, DevTools, viewport, and sandbox checks.
- `totalWaitDuration`: loader waits, API waits, Stripe redirects, polling, hard waits, retry backoff, and Computer Use latency.
- `totalExecutionDuration`: actual UI interactions and assertions, excluding known waits when separable.
- `totalRetries`: story retries and action retries.
- `slowestStories`, `slowestSteps`, `slowestActions`, and `slowestNetworkRequests`.
- `blockedDuration`: time spent before declaring a tool or external dependency blocked.
- `computerUseOverheadDuration`: observed time lost to tool/model interaction latency.
- `e2eGapCount`: bugs found manually that lacked adequate automated coverage.

Capture these metrics for each story:

- Story ID, actor/window, status, failure class, and retry count.
- Total story duration.
- Per-step duration for navigation, form entry, submit/save, page transition, payment handoff, backend confirmation, and final evidence capture.
- Wait vs execution split when observable.
- Slowest action in the story.
- First failure point, including visible state and Network/backend evidence.
- Important API/network timings: route, method, status, duration, retry/failure notes.
- E2E gap outcome when a bug is found.

Classify each non-pass:

- `deterministic`: reproducible with the same setup, including setup debt like first-run coach marks intercepting clicks, stale checkout sessions, missing credentials, or known 4xx/5xx responses.
- `flaky`: inconsistent under the same setup after at least one clean retry, including intermittent accessibility tree loss, transient network timeouts, or animation/race timing.
- `blocked`: Computer Use, browser access, backend availability, credentials, sandbox Stripe, permissions, or another external dependency prevents proof.

Do not call a deterministic setup issue "flaky." Fix or preflight it.

## Fast-Fail Rules

- If a visible overlay, coach mark, modal, or DevTools pane intercepts a click, record the blocked selector and clear it through visible UI once. If it repeats, classify it as deterministic setup debt and stop that story until the setup is fixed.
- If Computer Use returns an empty or unusable accessibility tree for a browser surface, take one fresh `get_app_state` after raising the app. If still unusable, mark that surface blocked and record the screenshot/tree symptom.
- If a third-party hosted surface such as Stripe Checkout is not controllable through Computer Use, do not spend more than three minutes trying alternate clicks. Mark manual proof blocked for that surface and use a separate approved automated sandbox smoke only as supplemental evidence.
- If a locator/action retries for more than 15 seconds, capture the blocker and decide whether it is an app issue, setup issue, tool issue, or expected wait. Do not allow default 30-60 second retries to hide root cause.
- If a story requires the same login/setup already proven earlier in the run, reuse the prepared actor window unless the story specifically tests login/setup.
- Prefer one deterministic setup pass, then story execution. Avoid repeatedly creating users, reopening browsers, or recreating Stripe/host setup inside every story unless the story requires it.

## Parallel QA + Fix Pipeline

Use this pattern when the user wants continuous testing with parallel root-cause fixing.

- Main tester owns the primary browser/manual or Playwright suite and does not stop at the first bug unless the environment itself is invalid.
- Each bug is recorded with status `found`, then either assigned to a fix agent or queued if it blocks the whole environment.
- Fix agents receive one bug and a disjoint write scope. They must not revert other worktree changes.
- Fix agents use root-cause-fix-enforcer and update tests or coverage notes with the fix.
- Fix agents run only unit/static checks unless they can run E2E on an isolated backend port without touching the main tester's backend.
- Retest queue entries include the exact command, required backend mode, required actor/session state, and whether the retest can run in parallel.
- Main tester periodically drains the retest queue after a suite finishes or during safe idle windows.
- If many downstream tests fail with `ECONNREFUSED`, `socket hang up`, or backend listener disappearance, classify the run as environment-contaminated and investigate backend ownership before treating those as product failures.
- If many unrelated specs fail with `Request context disposed`, setup timeouts, or internal provisioning fallback errors under a high worker count, classify the run as setup/backend saturation. Stop the noisy run, lower the main lane worker count, and fix tests so expensive provisioning happens in fixture setup with its own budget instead of inside the UI action timeout.
- Do not keep adding fix agents when coordination becomes slower than execution. Use the hybrid mode: one uninterrupted main lane, one or two scoped fix agents only for deterministic failures, and queued retests for everything else.
- Prefer focused deterministic retests over a broad rerun immediately after every fix. Once the focused retest passes, schedule broader evidence as domain-partitioned runs or one-worker full certification.
- Do not let child agents own, kill, reclaim, or restart the primary backend/browser. The main lane is the only owner of the active manual browser and default backend port. Child agents may run E2E only on an explicitly isolated backend/API port and must include that port in the retest command they report.
- If multi-agent orchestration spends more time coordinating than testing, downgrade immediately to single-main-lane mode with written bug packets. The goal is continuous useful testing, not maximizing agent count.

## Workflow

1. Read project rules.
   - Read the frontend repo `AGENTS.md`.
   - If a failure touches backend, read the backend repo `AGENTS.md`.
   - If a failure touches deploy/env wiring, read the infra repo `AGENTS.md`.

2. Load and normalize the story checklist.
   - Read `docs/critical-user-stories-checklist.md`.
   - Assign stable IDs by section, for example `AUTH-01`, `EVENT-04`, `PAID-07`, `COURT-03`.
   - Preserve the source story text exactly enough that each checklist item remains traceable.
   - Split only when a single checkbox contains multiple independently testable outcomes.

3. Create the dated output checklist before testing.
   - Use the local date to create `docs/user-stories-checklist_mm_dd_yy.md`.
   - If today's file already exists, update it instead of creating a duplicate.
   - Include a run summary, environment, actor accounts, timing summary, retrospective, and one row per story.

4. Prepare manual browser testing.
   - Follow all `manual-computer-use-browser-testing` non-negotiables.
   - In Weekly Scout Mode, run `npm run browser-scout:preflight:strict` from `/Users/wlyu/dev/AI-PROJECT/dinkify-frontend` before the first browser action.
   - If the strict preflight fails, record the failure and fix the setup issue before using Computer Use. Do not spend the scout budget debugging missing actors, stale Stripe sessions, or missing webhook listeners through clicks.
   - Load `docs/browser-audit/scout-manifest.local.json` and explicitly verify the visible host/player accounts against the manifest before testing story families.
   - Capture browser startup time from launch request to first usable page interaction.
   - Run a deterministic preflight before story execution: confirm URLs, auth state, backend health, test credentials, Stripe sandbox mode when relevant, Computer Use accessibility, and any required seed/setup state.
   - Fail fast if Computer Use accessibility, browser control, screen observation, or required credentials are blocked. Record the blocker and do not spend the run attempting partial substitutes.
   - Avoid repeated login/setup. Reuse verified authenticated browser profiles, windows, and prepared actor state across stories when it does not weaken the proof.
   - Use visible UI navigation after initial setup.
   - Keep DevTools Network visible when requested or when diagnosing failures.
   - Use one browser profile/window per actor for multi-user flows.
   - Use sandbox/test mode only for Stripe or payment flows.

5. Execute the story scope for the selected audit mode.
   - In Weekly Scout Mode, execute the prioritized runbook story families and stop low-risk replay when the timebox expires.
   - In Full Certification Mode, test every normalized checklist story.
   - Mark each story `not_run`, `passed`, `failed`, or `blocked`.
   - Record visible evidence: labels, state, toasts, list updates, URLs shown by app navigation, and important Network status codes.
   - Record total timing for each user story from first story-specific action through final evidence capture.
   - Record per-step timing for meaningful actions, including navigation, form entry, submit/save, page transition, network/API wait, payment handoff, toast/state confirmation, and retest steps.
   - Separate waiting time from execution time where possible. Treat loader waits, API waits, Stripe redirects, backend cold starts, and manual Computer Use latency as waiting time.
   - Capture retry counts for each story and for any individual action that needed another attempt.
   - Identify the slowest actions in the run and the slowest action inside each story when material.
   - Capture API/network timing where possible from DevTools Network or visible diagnostics, especially slow requests, non-2xx responses, retries, and endpoint names.
   - Record failure points at the step where the user-facing flow first diverged from the expected behavior.
   - Classify failures and blockers as `flaky` or `deterministic`. Use `flaky` only when the same step produces inconsistent outcomes under the same setup; otherwise classify as `deterministic`.
   - Prefer real user flows over API setup. If API/DB helpers are unavoidable for setup, label them as setup and still prove the story through the UI.
   - Do not mark a story passed from code inspection, existing tests, backend calls, mocked data, or direct route/localStorage manipulation.

6. Record retrospective learnings continuously.
   - When a blocker or speed issue appears, write it into the report immediately under `Retrospective Notes`.
   - Include the observed symptom, likely root cause, time lost, whether it is flaky or deterministic, and the next-run guardrail.
   - Promote repeated deterministic setup problems into preflight requirements before continuing the suite.

7. Analyze E2E coverage gaps for every Computer Use bug.
   - Search existing Playwright/unit/backend tests for the story and failed state.
   - Identify why existing tests missed the issue.
   - Add or update the missing automated regression where practical.
   - If the bug should remain manual-only, record why automation would be low-signal or too brittle.
   - Do not close a fixed bug without either automated coverage or an explicit `manual_only_with_reason` entry.

8. Fix failures with root-cause enforcement.
   - Stop testing that story family when a failure appears.
   - Use `root-cause-fix-enforcer` to define invariants, map entrypoints, select the authoritative fix layer, and add tests.
   - Fix frontend, backend, API contract, docs, and tests as required by the root cause.
   - Run targeted tests and repository guardrails for the changed scope.
   - Retest the failed story manually from the beginning through the UI.
   - Update the dated checklist with the failure, fix summary, test evidence, and retest result.

9. Close the run.
   - In Weekly Scout Mode, continue until the selected runbook scope is `passed`, `fixed_and_passed`, or explicitly `blocked`; leave out-of-scope stories as `not_run_weekly_scope` instead of pretending they were certified.
   - In Full Certification Mode, continue until every story is `passed` or explicitly `blocked`; no story may remain `failed` or `not_run`.
   - Run relevant final guardrails for any repo changed.
   - Compare timing, retry counts, blockers, and slowest actions against previous dated reports in `docs/` when any exist. Note historical trends, repeated blockers, and regressions.
   - Write a retrospective section in the dated report that records learned blockers, setup shortcuts that were safe, flaky areas, deterministic failure patterns, and recommendations for the next manual Computer Use audit.
   - Summarize passed, fixed, blocked, and not-applicable counts.

## Dated Checklist Format

Use this structure for `docs/user-stories-checklist_mm_dd_yy.md`:

```markdown
# User Stories Checklist MM/DD/YY

Source: `docs/critical-user-stories-checklist.md`
Run date: YYYY-MM-DD
Tester:
Frontend URL:
Backend/API URL:
Browser/device:
Run ID:

## Summary

- Passed:
- Fixed and passed:
- Blocked:
- Not applicable:

## Performance Instrumentation

- Browser startup:
- Total audit duration:
- Total waiting time:
- Total execution time:
- Slowest stories:
- Slowest actions:
- Retry count:
- API/network timing notes:
- Historical trends:
- Computer Use overhead:
- E2E gaps found:

## Preflight

| Check | Status | Duration | Evidence | Notes |
| --- | --- | --- | --- | --- |
| Frontend reachable | passed | 2s | Home/Login rendered |  |
| Backend reachable | passed | 1s | `/api/auth/me` expected 401 when logged out |  |
| Computer Use accessible | passed | 3s | `get_app_state` returned visible app tree |  |
| Actor sessions ready | passed | 10s | Host/player windows confirmed |  |
| Stripe sandbox ready | passed | 4s | Sandbox Checkout/listener available | Required only for paid flows |

## Checklist

| ID | Story | Status | Duration | Wait | Retries | Failure class | Evidence | Fix/notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AUTH-01 | As a new player... | passed | 1m 42s | 24s | 0 | n/a | Visible profile completion screen redirected to Home; Network 200 for `/api/auth/me` in 180ms. |  |
```

For each story, include step timing when the table would become too dense:

```text
Step timing:
- Open signup form: 8s total, 5s wait, 0 retries
- Submit profile: 14s total, 11s wait, Network 200 `/api/auth/me` in 180ms
Slowest action:
Failure point:
Failure class: flaky | deterministic | n/a
```

For each important Network/API observation, include:

```text
Network timing:
- GET /api/events/{id}: 200 in 318ms
- POST /api/events/{id}/checkout: 200 in 1.2s
- Stripe Checkout redirect: 4.8s
- Unexpected responses: none
```

For each failed-then-fixed story, include:

```text
Initial failure:
Root cause:
Files changed:
Automated validation:
Manual retest evidence:
Retest timing:
E2E gap analysis:
- Existing coverage:
- Why it missed:
- Regression added:
- Remaining coverage debt:
```

Include this retrospective before completion notes:

```markdown
## Retrospective

- Learned blockers:
- Safe speedups for next run:
- Repeated setup/auth issues:
- Flaky behaviors:
- Deterministic failure patterns:
- Performance regressions or improvements versus previous reports:
- Next audit recommendations:
```

For every learned blocker, use this compact format:

```text
Learned blocker:
- Symptom:
- Root cause category: app | setup | Computer Use | third-party | network | AI orchestration
- Failure class: flaky | deterministic | blocked
- Time lost:
- Guardrail added for next run:
```

For every manually discovered bug, use this coverage-gap format:

```text
E2E coverage gap:
- Manual bug:
- Existing tests checked:
- Miss reason:
- New/updated automated coverage:
- Manual-only reason, if any:
- Owner/follow-up:
```

## Known Dinkify Browser-Audit Guardrails

Carry these forward unless a newer report proves they are obsolete:

- Complete or skip first-run coach marks before story execution; coach mark overlays intercept clicks and can burn a full action timeout.
- Keep `localhost` vs `127.0.0.1` consistent per actor/browser. Mixed loopback hosts can cause auth/session and return-url confusion.
- Treat stale Stripe Checkout sessions as expired setup state. Start a fresh checkout from the app UI instead of reusing old Stripe URLs.
- Stripe Checkout is a third-party secure surface. Computer Use proof can be blocked or inconsistent there; use sandbox-only automated completion as supplemental evidence, then verify Dinkify's returned UI and backend state manually.
- DevTools can enlarge or destabilize the accessibility tree. If element-index clicks become unreliable, use visible coordinate clicks only for the current target and record that decision.
- Do not let Playwright or Computer Use default timeouts obscure root cause. Record any single action taking over 15 seconds.
- Use Computer Use as the bug-finding scout and Playwright as the regression net. A manual bug is not fully closed until the regression net is improved or the manual-only reason is documented.
- Discover/search coverage must include at least one target item that is not in the first backend page. Otherwise the test can accidentally prove only client-side filtering of already-loaded data.
- Payment Playwright runs must verify or own the backend payment mode. If a manually started backend is already running, use the repo runner's managed-backend mode or sandbox mode deliberately; do not assume `/api/health` means fake Stripe, real sandbox, webhook secret, and payout setup all match the test.
- For React-controlled search, autocomplete, masked, or validation-sensitive fields, prefer `type_text` over `set_value` unless the run verifies the expected network request and visible refetch. DOM value changes that skip normal user-input handlers are setup/tool artifacts, not product proof.
- Manual multi-actor closure requires the second actor's visible UI state after a refetch or navigation. Do not close host tracking from the player-side success alone.

## Completion Criteria

- The dated checklist exists under `docs/`.
- Every source checklist item is represented.
- Every represented story has evidence.
- Every represented story has total timing, retry count, failure class, and per-step timing or a clear reason timing was unavailable.
- The report distinguishes waiting time from execution time where possible and identifies slowest actions.
- Browser startup time and API/network timing notes are captured where available.
- The report includes historical trend notes when previous dated reports exist.
- The retrospective records learned blockers and speedups for future manual Computer Use audits.
- Every Computer Use product bug includes E2E coverage-gap analysis.
- Every app failure has a root-cause fix and a successful manual retest.
- Every fixed app failure has automated regression coverage or an explicit manual-only reason.
- No product story is hidden behind fake data, direct state mutation, or local-only UI authority.
- Remaining blocked stories are external/tooling blockers with enough evidence for a human to unblock them.
