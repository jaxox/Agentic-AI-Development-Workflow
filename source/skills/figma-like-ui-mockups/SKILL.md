---
name: figma-like-ui-mockups
description: Create high-quality, Figma-like HTML UI mockups and approved mockup locks grounded in the real current frontend app. Use when users ask for visual mockups, UI concepts, mobile flows, Figma-like previews, implementation-ready design artifacts, approved UI source-of-truth records, or design changes that must match an existing product instead of generic SaaS/startup UI.
---

# Figma-Like UI Mockups

## Purpose

Produce implementation-useful, Figma-like HTML mockups that look like they belong inside the existing app. The mockup must be based on real frontend code, screens, components, modals, navigation patterns, theme tokens, and mobile behavior.

Do not produce text-only mockups. Do not start from a generic design system.

The default deliverable is an **existing-product screen mockup**, not a presentation board. When the user is evaluating a change to an existing app, recreate the real current page/modal/sheet as the canvas and insert only the proposed change where it would actually appear.

Do not mix explanatory planning copy into the mocked app UI. Explanations, labels, rationale, callouts, and implementation notes belong in the final response or outside the app frame, never inside the screen unless that text would really ship in the product.

## Required Inputs

- User request and target feature or flow.
- Frontend app path, if provided. If not provided, discover it from the workspace using `rg --files`, `package.json`, route files, and feature folders.
- Any relevant product constraints, screenshots, or Figma links.

If the frontend cannot be inspected, stop and report that the mockup is blocked. Do not invent the app.

## Required Skill Chaining

Use related UI/UX skills when they are available and relevant. For existing-product UI changes, UI/UX skill chaining is mandatory, not optional:

- Use the appropriate agent skills for **UI and UX** before creating the mockup.
- Use `frontend-design` for visual craft, but constrain it to the app's existing visual language.
- Use `create-ux-design` for user journeys, task flow, interaction states, and accessibility notes.
- Use `adapt` for mobile-first and responsive behavior.
- Use `figma` only when the user provides a real Figma URL or node.
- Use `web-design-guidelines`, `frontend-pre-commit-review`, or similar frontend review skills for quality checks when reviewing code or final UI.

These skills support the workflow; they do not replace the mandatory app-code inspection.

## Required Specialist Review

For non-trivial product UI changes, use an appropriate specialist UI/UX agent before producing the final mockup. The specialist must review:

- Whether the proposed interaction model matches the real product semantics.
- Whether the mockup uses the existing production page, modal, sheet, wizard step, or component as its canvas.
- Whether any copy inside the mocked UI would actually ship in the product.
- Whether the design avoids confusing nearby product concepts, such as user role, workflow state, selection state, payment state, inventory/capacity state, or permission state.
- Whether the proposed control belongs in the chosen surface or should live elsewhere.

If no dedicated UI/UX specialist agent is available in the current toolset, use the closest available frontend/product design specialist and state that fallback in the final response.

If the harness exposes a canonical UI/UX reviewer agent, use that named agent. If not, use a frontend/product design specialist agent with explicit UI/UX review instructions.

Do not finalize a mockup until the specialist feedback is either incorporated or explicitly rejected with a short reason.

## Workflow

### 1. Inspect the real frontend first

Before designing anything, read the closest real implementation:

- Routes/screens for the target flow.
- Existing modals, sheets, cards, forms, docks, nav, tabs, and settings sections.
- Shared UI components and icon utilities.
- Theme and styling sources such as Tailwind config, CSS variables, global styles, typography utilities, spacing tokens, and component class names.
- Existing tests or stories if they reveal intended states.

Use `rg`/`rg --files` first. Capture exact file paths for the final response.

### 1.5. Validate the UX model before drawing

Before creating HTML, identify the product concepts involved and keep them separate in the mockup. For example:

- A user role is not automatically the same thing as a workflow state.
- A workflow state, selected option, payment state, permission state, and inventory/capacity state should remain visually and semantically distinct unless the product intentionally combines them.
- A management, destructive, or administrative action should not be mocked as a normal user choice unless the real product intentionally models it that way.

If the interaction model is unclear, pause and resolve the UX model before drawing screens. Do not use the mockup to invent or hide product semantics.

### 2. Choose the nearest existing surface

Identify the closest existing page, modal, component, or flow. Prefer adapting that surface over creating a new one.

Only introduce a new component when no similar component exists. If adding one, explain why the existing components are insufficient.

For product-change mockups, choose the real current screen as the primary frame:

- If the change affects an event detail page, mock the event detail page, not a separate concept board.
- If the change affects a modal or sheet, mock the modal/sheet opened over the real underlying page.
- If the change affects a wizard step, mock that exact wizard step, header, footer, and surrounding controls.
- If several states are needed, create separate app-like frames or artifacts for each state. Do not turn the artifact into a slide deck with large explanatory headings inside the UI.

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
- Preserve the current page hierarchy, header, content order, bottom dock/footer, modal placement, and surrounding context unless the requested change explicitly modifies them.
- Show key states when useful: default, loading, error, empty, disabled, expired, selected, or confirmed.
- Use existing colors, typography, spacing, icons, and component patterns.
- Be practical enough for frontend engineers to implement.

Image generation is not the primary deliverable. If a static image is useful, generate it only after the HTML mockup is grounded in real frontend code.

Keep the mockup artifact visually clean:

- Do not put explanation paragraphs, implementation intent, “why this works,” or critique text inside the app screen.
- Do not add fake onboarding/help copy unless the production UI would include that copy.
- Do not add external headings inside a phone/app frame. Short frame labels may appear outside the app frame when showing multiple states.
- Do not use decorative containers around the real screen if they make the result harder to compare with the current app.
- Do not rename existing product concepts casually. Use the product's real labels unless the requested change is specifically to change the label.
- Do not place management, destructive, or administrative actions inside normal choice controls unless the existing product intentionally treats those actions as choices in that control.

### 5. Verify visually

When possible, open or render the HTML mockup and inspect it at mobile width first. Check that:

- Text is readable and does not overflow.
- Touch targets are usable.
- The layout fits the existing app style.
- The design does not create a new page or navigation pattern unless explicitly required.
- The mockup is implementable with existing frontend components.

### 6. Lock approved mockups

When the user approves a mockup or says to lock it in, create or update an approved mockup lock. The lock may be a section in the feature plan, execution ledger, or mockup artifact index. Keep it product-agnostic and specific to the approved UI, not to one feature type.

The lock must include:

- Approved artifact path and timestamp or approval note.
- Production screens/components used as the canvas.
- Approved states, viewports, and variants.
- Required implementation surfaces.
- Required screenshot or browser proof after implementation.
- Explicit non-goals: text, controls, states, or layout ideas that should not be implemented yet.
- Drift rule: implementation must match the approved mockup unless the user approves a revised lock.

For UI implementation tasks, reference the lock from the task checklist and Plan Enforcer review.

### 7. Final response requirements

Return:

- Mockup artifact path.
- Approved mockup lock location when applicable.
- Existing screens/components used as references, with real file paths.
- Visual language extracted from the app.
- What changed in the mockup.
- What should be implemented.
- What should not be implemented yet.
- UX notes and edge cases relevant to the flow.
- Any verification performed.

## Quality Checklist

- [ ] Real frontend code was inspected before design work.
- [ ] Appropriate UI/UX skills were used before mockup creation.
- [ ] A specialist UI/UX agent reviewed the interaction model, or the closest available specialist fallback was documented.
- [ ] The closest existing page/modal/component was identified.
- [ ] The mockup uses an existing product page, modal, sheet, or flow as its canvas.
- [ ] Approved mockups are captured in a mockup lock before implementation when the user approves them.
- [ ] Explanatory, critique, rationale, and implementation text stays outside the mocked app UI.
- [ ] Product concepts are not mixed together, especially user role, workflow state, selection state, payment state, permission state, and inventory/capacity state.
- [ ] The mockup is HTML/CSS, not a text-only wireframe.
- [ ] The mockup is mobile-first unless explicitly told otherwise.
- [ ] Colors, typography, spacing, icons, and component patterns match the app.
- [ ] No random components were invented when similar ones already exist.
- [ ] The final answer cites real existing frontend files.
- [ ] The result is clear enough for an engineer to build.

## Anti-Patterns

Never do these:

- Produce only a textual mockup or ASCII layout.
- Produce a concept board when the user needs to see the existing screen with a change applied.
- Skip UI/UX skill chaining or specialist UI/UX review before creating the mockup.
- Create generic SaaS/startup UI.
- Invent random colors, fonts, cards, nav, or components.
- Use desktop-first layout by default.
- Create a new page when an existing screen, sheet, modal, or settings section fits.
- Ignore real app theme/classes and rely on generic design taste.
- Produce a pretty image that is not grounded in source code.
- Use fake components that would be expensive or awkward to implement.
- Hide critical mobile functionality or rely on hover-only interactions.
- Add marketing/landing-page composition to an operational app surface.
- Add explanatory text inside the UI to describe the feature, state, design intent, keyboard shortcuts, or implementation.
- Mix review notes, rationale, callouts, or critique labels into the app UI itself.
- Create a detached design board when the requested change belongs on an existing product surface.
- Mix distinct product concepts in ways the product does not support.
- Add management, destructive, or administrative actions as if they were normal user choices unless that is explicitly the approved product model.

## Good Prompts

- "Use this skill to mock up SMS opt-in inside the existing settings page and notification sheet."
- "Create a mobile-first mockup for the waitlist claim state using the current event detail page."
- "Show a Figma-like HTML mockup for this admin dashboard change, based on the existing modal."
- "Mock up the new payment failure state using the current checkout/payment UI patterns."

## Bad/Generic Behavior To Avoid

- "Here is a text mockup: [button] [input] [card]."
- "Here is a clean SaaS dashboard with a sidebar, gradient hero, and generic cards."
- "I made a new mobile page even though the app already has a modal for this flow."
- "I used random blue/purple gradients because they look modern."
- "I generated an image without reading the frontend components first."
