---
name: figma-like-ui-mockups
description: Create high-quality, Figma-like HTML UI mockups grounded in the real current frontend app. Use when users ask for visual mockups, UI concepts, mobile flows, Figma-like previews, implementation-ready design artifacts, or design changes that must match an existing product instead of generic SaaS/startup UI.
---

# Figma-Like UI Mockups

## Purpose

Produce implementation-useful, Figma-like HTML mockups that look like they belong inside the existing app. The mockup must be based on real frontend code, screens, components, modals, navigation patterns, theme tokens, and mobile behavior.

Do not produce text-only mockups. Do not start from a generic design system.

## Required Inputs

- User request and target feature or flow.
- Frontend app path, if provided. If not provided, discover it from the workspace using `rg --files`, `package.json`, route files, and feature folders.
- Any relevant product constraints, screenshots, or Figma links.

If the frontend cannot be inspected, stop and report that the mockup is blocked. Do not invent the app.

## Required Skill Chaining

Use related UI/UX skills when they are available and relevant:

- Use `frontend-design` for visual craft, but constrain it to the app's existing visual language.
- Use `create-ux-design` for user journeys, task flow, interaction states, and accessibility notes.
- Use `adapt` for mobile-first and responsive behavior.
- Use `figma` only when the user provides a real Figma URL or node.
- Use `web-design-guidelines`, `frontend-pre-commit-review`, or similar frontend review skills for quality checks when reviewing code or final UI.

These skills support the workflow; they do not replace the mandatory app-code inspection.

## Workflow

### 1. Inspect the real frontend first

Before designing anything, read the closest real implementation:

- Routes/screens for the target flow.
- Existing modals, sheets, cards, forms, docks, nav, tabs, and settings sections.
- Shared UI components and icon utilities.
- Theme and styling sources such as Tailwind config, CSS variables, global styles, typography utilities, spacing tokens, and component class names.
- Existing tests or stories if they reveal intended states.

Use `rg`/`rg --files` first. Capture exact file paths for the final response.

### 2. Choose the nearest existing surface

Identify the closest existing page, modal, component, or flow. Prefer adapting that surface over creating a new one.

Only introduce a new component when no similar component exists. If adding one, explain why the existing components are insufficient.

### 3. Extract the visual language

Record the real app's design traits before creating the mockup:

- Theme mode and dominant surfaces.
- Color tokens/classes and accent colors.
- Typography scale, weights, casing, letter spacing, and labels.
- Spacing rhythm, border radius, border treatment, shadows, and density.
- Icon family and icon sizing.
- Navigation, modal, sheet, action dock, and form patterns.
- Mobile-first layout rules and breakpoint behavior.

The mockup must reuse these traits.

### 4. Create a Figma-like HTML mockup

Create a real HTML/CSS mockup artifact, usually under `artifacts/mockups/<feature-name>.html` in the relevant repo unless the user specifies another location.

The artifact should:

- Be mobile-first by default.
- Recreate the chosen existing app surface closely.
- Use realistic app copy and state, not filler marketing text.
- Include the requested new UI only where it would actually live.
- Show key states when useful: default, loading, error, empty, disabled, expired, selected, or confirmed.
- Use existing colors, typography, spacing, icons, and component patterns.
- Be practical enough for frontend engineers to implement.

Image generation is not the primary deliverable. If a static image is useful, generate it only after the HTML mockup is grounded in real frontend code.

### 5. Verify visually

When possible, open or render the HTML mockup and inspect it at mobile width first. Check that:

- Text is readable and does not overflow.
- Touch targets are usable.
- The layout fits the existing app style.
- The design does not create a new page or navigation pattern unless explicitly required.
- The mockup is implementable with existing frontend components.

### 6. Final response requirements

Return:

- Mockup artifact path.
- Existing screens/components used as references, with real file paths.
- Visual language extracted from the app.
- What changed in the mockup.
- What should be implemented.
- What should not be implemented yet.
- UX notes and edge cases relevant to the flow.
- Any verification performed.

## Quality Checklist

- [ ] Real frontend code was inspected before design work.
- [ ] The closest existing page/modal/component was identified.
- [ ] The mockup is HTML/CSS, not a text-only wireframe.
- [ ] The mockup is mobile-first unless explicitly told otherwise.
- [ ] Colors, typography, spacing, icons, and component patterns match the app.
- [ ] No random components were invented when similar ones already exist.
- [ ] The final answer cites real existing frontend files.
- [ ] The result is clear enough for an engineer to build.

## Anti-Patterns

Never do these:

- Produce only a textual mockup or ASCII layout.
- Create generic SaaS/startup UI.
- Invent random colors, fonts, cards, nav, or components.
- Use desktop-first layout by default.
- Create a new page when an existing screen, sheet, modal, or settings section fits.
- Ignore real app theme/classes and rely on generic design taste.
- Produce a pretty image that is not grounded in source code.
- Use fake components that would be expensive or awkward to implement.
- Hide critical mobile functionality or rely on hover-only interactions.
- Add marketing/landing-page composition to an operational app surface.

## Good Prompts

- "Use this skill to mock up SMS opt-in inside the existing RSVP sheet and settings page."
- "Create a mobile-first mockup for the waitlist claim state using the current event detail page."
- "Show a Figma-like HTML mockup for this host dashboard change, based on the existing modal."
- "Mock up the new payment failure state using the current checkout/payment UI patterns."

## Bad/Generic Behavior To Avoid

- "Here is a text mockup: [button] [input] [card]."
- "Here is a clean SaaS dashboard with a sidebar, gradient hero, and generic cards."
- "I made a new mobile page even though the app already has a modal for this flow."
- "I used random blue/purple gradients because they look modern."
- "I generated an image without reading the frontend components first."
