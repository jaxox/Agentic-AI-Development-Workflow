---
name: dinkify-ios-safari-user-stories-audit
description: Validate Dinkify critical user stories on a real iPhone Simulator with Mobile Safari, Appium, and XCUITest. Use when the user asks to test all Dinkify user stories on iPhone/iOS/Safari simulator, extend `tests-ios/user-stories`, run the `ios:safari` E2E gates, create an iOS Safari user-story audit ledger, or distinguish real simulator proof from Chrome phone viewport, desktop WebKit, or Playwright mobile emulation.
---

# Dinkify iOS Safari User Stories Audit

## Overview

Use this skill to certify Dinkify user stories through the real Mobile Safari path. It composes the Dinkify story checklist/reporting workflow with the frontend repo's iOS Safari harness.

## Default Inputs

- Frontend repo: `/Users/wlyu/dev/AI-PROJECT/dinkify-frontend`
- Backend repo, when fixes need backend changes: `/Users/wlyu/dev/AI-PROJECT/dinkify-backend`
- Infra repo, when simulator/release wiring needs infra changes: `/Users/wlyu/dev/AI-PROJECT/dinkify-infra`
- Story source: `docs/critical-user-stories-checklist.md`
- Existing frontend harness skill, if present: `skills/ios-safari-user-stories/SKILL.md`
- Existing audit outputs to preserve: `artifacts/ios-safari/critical-user-stories-results.json` and `artifacts/ios-safari/critical-user-stories-results.md`
- Dated report, when the user asks for certification evidence: `docs/user-stories-ios-safari-checklist_mm_dd_yy.md`

## Required Composition

1. Read the frontend-local `skills/ios-safari-user-stories/SKILL.md` when it exists. Use it for harness file maps, port conventions, and test-extension patterns.
2. Use `dinkify-user-stories-browser-audit` for story inventory, ledger discipline, coverage-gap analysis, and bug-to-regression expectations.
3. Use `root-cause-fix-enforcer` before editing product/test code for a failed story.
4. Prefer existing frontend scripts and fixtures over ad hoc simulator automation.

## Non-Negotiables

- Use real iPhone Simulator plus Mobile Safari as the proof path.
- Do not treat Chrome phone viewport, desktop WebKit, Playwright device emulation, screenshots from responsive mode, API calls, or code inspection as equivalent iOS Safari proof.
- Use backend/API helpers only for setup and diagnostics. A story passes only from visible Mobile Safari behavior plus backend verification when relevant.
- Keep broad product coverage in Playwright; move only iOS-specific, focus/viewport/upload/install, or high-risk host/player parity checks into `tests-ios`.
- If the simulator, Appium, XCUITest, Xcode, or device runtime is unavailable, mark the run `BLOCKED` or `NOT READY` with the exact command and error.
- Do not use production/live Stripe or real-money actions while testing. Use sandbox/test-mode paths only.

## Quick Start

Run from the frontend repo:

```bash
npm run ios:safari:setup
npm run test:e2e:ios:safari:core
npm run test:e2e:ios:safari:user-stories
npm run test:e2e:user-stories:coverage
```

Useful focused commands:

```bash
npm run test:e2e:ios:safari:smoke
npm run test:e2e:ios:safari:host-player
xcrun simctl list devices available
IOS_MULTIUSER_SIM_UDIDS="<host-udid>,<player-udid>" npm run test:e2e:ios:safari:user-stories
IOS_SAFARI_APPIUM_PORT=4823 IOS_SAFARI_BASE_URL=http://127.0.0.1:4273 npm run test:e2e:ios:safari:user-stories
```

## Workflow

1. Inventory stories.
   - Read `docs/critical-user-stories-checklist.md`.
   - Compare against `tests-ios/user-stories`, `tests-ios/*.spec.mjs`, and `tests/user-stories`.
   - Decide whether the user asked for full certification, targeted regression proof, or gap-filling.

2. Prove the harness is ready.
   - Run `npm run ios:safari:setup`.
   - Record simulator model, iOS runtime, UDIDs when pinned, Appium ports, app URL, API URL, and whether the backend is managed by the runner or already running.
   - Run smoke/core before broad user-story certification.

3. Run existing iOS Safari coverage.
   - Run `npm run test:e2e:ios:safari:core`.
   - Run `npm run test:e2e:ios:safari:user-stories`.
   - Save artifact paths and failure snippets.

4. Fill checklist gaps.
   - For missing high-value stories, add or extend specs under `tests-ios/user-stories`.
   - Use `scripts/ios-safari-multiuser-e2e.mjs` for host/player stories.
   - Use `tests-ios/fixtures/apiClient.mjs` for deterministic setup.
   - Drive user-visible behavior through the iOS Safari page/harness helpers, then verify persisted state and refetched visible UI.

5. Handle failures.
   - Classify each failure as product, test, fixture, harness, simulator environment, backend, or external service.
   - For product bugs, use `root-cause-fix-enforcer`, patch the authoritative layer, add/update regression coverage, and rerun the affected iOS story from the beginning.
   - For harness/setup bugs, fix the harness or document the exact blocker; do not call the story passed.

6. Report.
   - Include simulator model/iOS version, commands run, services/URLs, story ledger, pass/fail/blocked status, artifacts, bugs fixed, and remaining risks.
   - If full certification was requested, every checklist story must be `passed`, `failed`, or `blocked`; no silent omissions.

## Story Ledger Fields

Use these fields in the report or dated checklist:

- `storyId`
- `storyFamily`
- `actors`
- `simulatorEvidence`
- `backendEvidence`
- `status`: `not_run`, `passed`, `failed`, or `blocked`
- `artifacts`
- `fixCommitOrFiles`
- `coverageOutcome`: `ios_spec_existing`, `ios_spec_added`, `playwright_only_with_reason`, `manual_only_with_reason`, or `coverage_debt`
