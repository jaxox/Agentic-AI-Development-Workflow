---
name: ui-reuse-first
description: Use for any UI, UX, frontend design, mockup, component, or visual implementation task. Enforces reuse of existing product surfaces, shared components, design tokens, interaction patterns, tests, and accessibility behavior before introducing new UI abstractions.
---

# UI Reuse First

For every UI/UX task, default to reusing what already exists.

## Required Workflow

1. Inspect the nearest existing screen, modal, sheet, form, card, toolbar, route, shared component, hook, utility, style token, and test before proposing or coding UI.
2. Prefer extending or parameterizing an existing component over creating a new one.
3. If two UI elements have the same behavior, state, validation, formatting controls, accessibility behavior, or visual structure, they should usually share one component.
4. Create a new component only when existing components are genuinely insufficient. Document the reason in the final response or implementation notes.
5. Keep user-facing behavior consistent across surfaces by reusing existing labels, icon patterns, focus handling, validation, empty/error states, and responsive behavior.
6. Add or update tests at the shared component level when behavior is reused by multiple consumers; add consumer tests only for wiring or surface-specific behavior.

## Review Gate

Before finishing UI/UX work, ask:

- Did I search for existing components and patterns first?
- Am I duplicating behavior that should be shared?
- Would a future change need to be made in two places because of my design?
- If I added a new component, did I explain why reuse was not enough?

If the answer exposes avoidable duplication, refactor to a shared component before finalizing.
