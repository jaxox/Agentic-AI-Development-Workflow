---
name: manual-computer-use-browser-testing
description: Manually validate product user stories in Chrome using the Computer Use plugin like a real user. Use when the user asks for human-style browser testing, direct UI testing, two-browser or multi-user testing, Chrome DevTools Network inspection, mobile/phone viewport validation, or iterative fix-and-retry validation. If issues are found, use root-cause-fix-enforcer before retrying.
---

# Manual Computer-Use Browser Testing

## Non-Negotiables

- Use `mcp__computer_use__` for browser interaction whenever it is available.
- Call `mcp__computer_use__.get_app_state({"app":"Google Chrome"})` once before the first Chrome interaction in each assistant turn.
- Test through visible UI controls like a human: click buttons, tabs, menus, list items, modals, and form fields.
- Do not use address-bar navigation, deep links, localStorage edits, app-state injection, or backend/API mutations as proof that a user story works.
- Use backend/API helpers only for setup or diagnostics when unavoidable, and label them as setup, not UI proof.
- Keep DevTools open if the user asked for it. Do not close, hide, undock, or reset DevTools unless the user explicitly approves it.
- Keep the viewport phone-sized if requested. Do not switch back to desktop unless the user explicitly approves it.
- If Computer Use breaks, state that manual Computer Use testing is blocked. Do not silently substitute Playwright, curl, AppleScript, or route jumps as equivalent manual proof.
- For Dinkify Stripe sandbox/test-mode testing, the user has granted standing permission to complete sandbox-only payment actions without pausing, including Stripe onboarding submit, test Checkout, test refunds, test disconnect/reconnect, and test cancellation flows. This permission does not apply to production/live Stripe accounts, live keys, or real-money actions.

## Browser Setup

1. Prefer the user's already-open Chrome windows and logged-in profiles.
2. If a new browser is needed, open Chrome through the normal app surface and navigate only as an initial setup step. After the app is loaded, do not use the address bar for story navigation.
3. Open DevTools with visible UI or keyboard shortcut, then select the Network tab.
4. Enable a phone-sized viewport through the DevTools device toolbar. Use an existing phone preset such as Pixel/iPhone when available.
5. Leave DevTools open for the whole pass. Network 4xx/5xx responses for user-triggered app requests are story failures unless they are expected and documented.
6. For multi-user testing, keep one actor per Chrome profile/window. Never mix sessions or reuse one user's browser for another user's story.

## Human-Style Interaction Rules

- Navigate using the app's own UI: nav bars, back buttons, cards, search, tabs, settings, profile menus, and modal actions.
- Type into fields normally. Do not set DOM values directly unless Computer Use exposes a normal settable field and the visible result is verified.
- Wait for visible UI completion after each important action: loading states disappear, modal closes, toast appears, list updates, or the next screen is shown.
- Prefer element-index clicks from Computer Use. If the accessibility tree is too large because DevTools is open, use coordinate clicks from the Computer Use screenshot, but still click visible UI targets only.
- Do not claim a story passed from code inspection alone. A pass requires the user-visible state and, when relevant, Network/backend evidence.

## Story Ledger

Before testing, create a ledger with one row per user story:

```text
Story ID:
Actor/window:
Starting UI state:
Human steps:
Expected UI result:
Expected Network/backend result:
Status: not_run | passed | failed | blocked
Evidence:
Issue/fix link:
```

Update the ledger as each story progresses. Do not wait until the end to mark all items.

## Testing Workflow

1. Inventory the stories.
   - Derive stories from the user's request, acceptance criteria, existing test plan, and app behavior.
   - Include host/admin/player flows, happy paths, edge cases, cancellation/refund paths, waitlist/capacity paths, and error states when in scope.

2. Prepare browsers.
   - Confirm the intended actor is visible in each Chrome window.
   - Confirm DevTools Network is open.
   - Confirm the app viewport is phone-sized.
   - Confirm backend/frontend services are running only through normal health checks or visible app behavior.

3. Execute one story at a time.
   - Use only UI clicks and typing for story actions.
   - Watch Network for failed user-triggered requests.
   - Capture visible evidence in the ledger: exact labels, statuses, amounts, player names, buttons, toasts, and request status codes.

4. On any issue, stop and fix the root cause.
   - Use `root-cause-fix-enforcer`.
   - Define invariants and entrypoints before editing.
   - Trace UI, state, API, backend, persistence, and refetch/reload boundaries.
   - Fix the authoritative layer, not just the visible symptom.
   - Add or update tests that would have failed before the fix.
   - Run targeted tests, then rerun the failed manual story from the beginning.

5. Retry until closed.
   - A story is passed only after it succeeds through the UI after the fix.
   - A story is blocked only when the blocker is external to the app or the requested tool is unavailable.
   - Do not proceed to commit or release workflow until every in-scope story is passed or explicitly blocked with evidence.

## Issue Report Format

When a story fails, record:

```text
Story:
Visible failure:
Network evidence:
Console/backend evidence:
Expected behavior:
Suspected authoritative owner:
Root-cause-fix-enforcer invariant:
Fix validation:
Retest result:
```

## Completion Gate

Before saying the work is done, verify:

- Every story in the ledger is `passed` or explicitly `blocked`.
- Every failed story was rerun after the fix.
- DevTools Network showed no unexplained failed app requests during passing flows.
- Phone viewport layout stayed usable: no clipped primary actions, overlapping text, hidden required fields, or inaccessible modals.
- Multi-user state was verified in the relevant second browser after refresh/refetch or navigation through the UI.
- All code changes from fixes have targeted tests and repo guardrails appropriate to the changed scope.
- The final response separates manual UI evidence from automated E2E/unit evidence.
