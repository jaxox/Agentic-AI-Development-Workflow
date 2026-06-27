---
name: figma-like-ui-mockups
description: Create high-quality, Figma-like HTML UI mockups and approved mockup locks grounded in the real current frontend app, with explicit change-scope indicators for existing-product UI changes. Use when users ask for visual mockups, UI concepts, mobile flows, Figma-like previews, implementation-ready design artifacts, approved UI source-of-truth records, or design changes that must match an existing product instead of generic SaaS/startup UI.
---

# Figma-Like UI Mockups

## Purpose

Produce implementation-useful, Figma-like HTML mockups that look like they belong inside the existing app. The mockup must be based on real frontend code, screens, components, modals, navigation patterns, theme tokens, and mobile behavior.

Do not produce text-only mockups. Do not start from a generic design system.

The default deliverable is an **existing-product screen mockup**, not a presentation board. When the user is evaluating a change to an existing app, recreate the real current page/modal/sheet as the canvas and insert only the proposed change where it would actually appear.

Source-of-truth rule: **do not make up product surfaces, routes, modals, buttons, labels, state flows, or destinations**. If the real app already has a page, sheet, modal, card, dock, route, or notification flow for the requested job, use that exact surface as the reference canvas. A new page, new modal, or new interaction surface is allowed only when code inspection proves no existing surface fits, or when the user explicitly asks for a new surface.

Reuse-first rule: if the existing product already has a component, control, validation pattern, formatting toolbar, expand/collapse behavior, empty/error state, or accessibility behavior that does the same job, the mockup should reuse or extend that pattern instead of introducing a duplicate. New components must be marked as new and justified by an actual gap.

Do not mix explanatory planning copy into the mocked app UI. Explanations, labels, rationale, callouts, and implementation notes belong in the final response or outside the app frame, never inside the screen unless that text would really ship in the product.

For existing-product UI-change mockups, a visible change-scope layer is a required part of the deliverable, not an optional enhancement. The artifact must make it obvious which exact UI regions are new, changed, verify-only/current behavior, removed, open questions, and reference-only context. The default scope treatment is: visual indicators may outline or subtly underlay the exact changed regions inside the app frame, and small reference ID badges may attach to those outlines; all explanatory comments/text/labels must live outside the app frame.

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

If the requested flow has multiple user actions or destinations, trace each action in code before drawing. For every CTA or navigation path in the mockup, verify where it currently goes and label it outside the app frame if the destination is part of the approval discussion. Do not infer that two actions share the same modal, page, or payment flow unless the implementation proves it.

When the current implementation has an existing page/modal/sheet but the visual artifact cannot recreate it perfectly, mark the surrounding surface as reference-only and lock only the proposed changed areas. Never let approximate chrome, icons, button copy, or unrelated content accidentally become implementation scope.

### 1.5. Validate the UX model before drawing

Before creating HTML, identify the product concepts involved and keep them separate in the mockup. For example:

- A user role is not automatically the same thing as a workflow state.
- A workflow state, selected option, payment state, permission state, and inventory/capacity state should remain visually and semantically distinct unless the product intentionally combines them.
- A management, destructive, or administrative action should not be mocked as a normal user choice unless the real product intentionally models it that way.

If the interaction model is unclear, pause and resolve the UX model before drawing screens. Do not use the mockup to invent or hide product semantics.

### 1.75. Compare current implementation against the proposal

Before drawing or marking anything as a proposed change, compare the requested target behavior against the current implementation and tests.

- Verify whether each visible state already exists and behaves correctly.
- Separate "this is important to the flow" from "this is actually changing." Do not mark an area as a proposed change just because it is logically related.
- For each state or variant, write a compact current-vs-proposed note before or alongside the mockup:
  - `No UI change`: current implementation already matches the target and should only be protected by tests.
  - `Verify only`: current behavior is expected to remain, but should be explicitly checked.
  - `Change`: current behavior differs; show `old -> new` for labels, copy, values, controls, or state treatment.
  - `New`: the UI element or copy does not currently exist.
  - `Remove`: a real current production UI element or copy should disappear.
  - `Open question`: the implementation cannot be inferred safely from code or product semantics.
- Never mark something as `Remove` when it only appeared in a previous mockup, draft, comment, or explanation. Prior mockup cleanup belongs in the outside-frame notes or final response, not in the product UI scope map.
- For existing production surfaces such as a current modal, sheet, page, dock, or tab view, inspect and recreate the actual labels, tabs, button names, empty states, and layout before proposing changes. If the artifact cannot faithfully recreate that surface, mark the surrounding surface as `Verify only`/reference and mark only the exact proposed deltas.
- Scope outlines must wrap the exact changed/new/removed element, not a whole list, menu, tab, card, or page unless that entire production surface is genuinely new or genuinely replaced.
- If a new multi-tab surface is proposed, include separate frames for every tab shown in the tab control, or state outside the frame that the unshown tabs are out of scope. Do not show tabs whose contents are not mocked or intentionally deferred.
- Do not model a stateful, ordered workflow as equal tabs. If the user task depends on ordered states, prerequisites, or a visibility boundary, use a stepper, wizard, run center, or explicit state frames instead. Show the before state, the single primary action for that state, and the after state caused by that action.
- Do not duplicate a primary workflow action across multiple surfaces. If a button such as Generate, Publish, Submit, or Start appears in more than one frame, each occurrence must represent a distinct state or be explicitly marked outside the frame as repeated persistent chrome.
- For workflows that affect player visibility, include the private/non-public state, the publish/confirm state, and the player-visible live state as separate frames.
- Convert those notes into a change-scope map before finalizing the mockup:
  - Every `New`, `Change`, `Remove`, `Verify only`, and `Open question` item must map to a visible indicator on the relevant screen, sheet, modal, or frame.
  - `No UI change` items may be documented outside the app frame when no visual region needs protection.
  - Reference-only surrounding chrome must either be unmarked or explicitly identified outside the app frame as reference context.
- When a mockup covers several personas, roles, or workflow states, split them into separate frames or variants. Do not combine different viewers, permissions, payment states, inventory states, or lifecycle states into one ambiguous screen.
- Cite the current implementation files in the final response so reviewers can trace which parts are existing behavior and which parts are proposed changes.

### 2. Choose the nearest existing surface

Identify the closest existing page, modal, component, or flow. Prefer adapting that surface over creating a new one.

Only introduce a new component when no similar component exists. If adding one, explain why the existing components are insufficient.

Before choosing a new surface, explicitly ask: "What existing production surface already does this job?" If the answer is an existing event page, RSVP sheet, payment step, notification item, claim page, settings section, or modal, mock that surface instead of inventing a detached replacement.

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

### 4.5. Add a mandatory non-shipping change-scope layer

For every existing-product UI-change mockup, add a clear non-shipping change-scope layer. This is mandatory whenever the artifact compares current UI to proposed UI, even when the change seems small.

The only exceptions are:

- The user explicitly asks for an unannotated visual-only mockup.
- The artifact is pure greenfield UI with no current product surface to compare against.

If an exception applies, state it in the final response.

The explanatory change-scope layer must live outside the app frame by default, usually as a scope table/panel beside or below each screen. Visual indicators such as outlines or subtle underlays should appear inside the app frame to identify exact regions. A small reference ID badge such as `N1`, `C0`, `Q4`, or `V2` may be attached to the outline itself so reviewers can refer to the region. Do not place explanatory comments, prose labels, connector anchors, or callout boxes inside the phone/app/modal/screen frame unless the user explicitly requests a commented variant.

Keep all explanatory annotation text outside the app, phone, modal, or screen frame. The mocked product UI must remain inspectable as a shipping-like screen with non-shipping visual outlines and small reference ID badges only. Put the explanatory `Change`, `New`, `Remove`, `Verify only`, and `Open question` copy in a scope panel outside the frame and map it back by stable frame names, reference IDs, and human-readable element references, such as `N1 | Frame 1B: Event Mode select` or `N2b | Round Robin Setup modal: Score entry row`.

If a visible in-frame mapping is genuinely necessary for a complex review, provide two artifacts or two side-by-side variants:

- **Outlined approval frame**: exact changed regions have outlines/underlays and small reference ID badges attached to the outlines, with all explanations outside the app frame. This is the default implementation reference.
- **Commented review frame**: optional, only when explicitly requested by the user, and clearly labeled non-shipping; may include prose callouts.

The annotation layer must make approval scope unambiguous:

- Mark exact proposed changes separately from verify-only/current behavior.
- Include a visible scope table near the clean mockup, using rows such as `Change`, `New`, `Remove`, `Verify only`, `Open question`, and `Reference only`.
- Every changed/new/removed/verify/open item must identify the exact frame and product element using words already visible in the UI or stable component names.
- For `Change`, include the current value and proposed value, for example `Reserved for waitlist -> Full`.
- For `New`, state that the element does not exist today.
- For `Remove`, state what existing copy/control/state disappears.
- Do not use in-frame outlines/underlays to mean "important" or "related to the logic"; use them only to identify exact implementation scope.
- If buttons, icons, headers, avatars, images, or unrelated rows are approximate reference context, state that they are not locked by the mockup.
- The scope table should be textually precise enough for implementation. Reference-only areas may be approximate, but must not imply approval.
- Explanatory annotation text must not appear inside or block the actual UI. In-frame outlines/underlays and small reference ID badges must keep the UI readable first, especially in mobile phone frames.

Hard requirement: each proposed UI-change state must include app-frame visual scope indicators with reference ID badges plus an adjacent/outside-frame scope table that maps those IDs to exact frame/element names. The product UI must never contain explanatory comments or prose labels inside the phone frame.

Good scope indicator examples:

- A scope row outside the phone: `New | Frame 1: Event Mode select | Adds CustomSelect below Match Type`.
- A scope row outside the phone: `Change | Frame 1: Match Type select | Play Format -> Match Type; control unchanged`.
- A scope row outside the phone: `Verify only | Frame 2: Capacity | Split lines remain RSVP pools`.
- A cyan outline around the Event Mode select inside the phone, with a small `N1` badge attached to the outline and the explanatory text outside the phone.
- An outside-frame note that surrounding headers, avatars, and content are reference context only.

Bad scope indicator examples:

- Putting prose comments such as `New: Event Mode select`, `Open: decide MVP`, or implementation notes inside the app/phone/modal frame.
- Drawing connector anchors or comment pins around product UI in the default approval frame.
- Putting explanatory text labels inside the product UI, even if they are styled as non-shipping annotations.
- A top panel that says "New: add clone action" without identifying the exact frame and UI element in a scope row.
- Putting `New`, `Change`, `Verify only`, or implementation notes inside the product UI as if they were shipping labels.
- Marking existing surrounding chrome as changed just because it is relevant to the story.

### 5. Verify visually

When possible, open or render the HTML mockup and inspect it at mobile width first. Check that:

- Text is readable and does not overflow.
- Touch targets are usable.
- The layout fits the existing app style.
- The design does not create a new page or navigation pattern unless explicitly required.
- The mockup is implementable with existing frontend components.
- Any new component/control is justified by a real gap; duplicated behavior is refactored back toward a shared component.
- For existing-product UI changes, app-frame visual indicators and the outside-frame scope table are both visible in the screenshots.
- The first mobile screenshot makes the actual changed/new UI regions understandable through in-frame outlines/underlays with reference ID badges plus adjacent scope rows, without relying on the final response.
- Annotation text does not appear inside, cover, or obscure the app UI. Explanatory labels, comment pins, connector anchors, and callout boxes are absent unless the user explicitly requested a commented variant.

### 6. Lock approved mockups

When the user approves a mockup or says to lock it in, create or update an approved mockup lock. The lock may be a section in the feature plan, execution ledger, or mockup artifact index. Keep it product-agnostic and specific to the approved UI, not to one feature type.

The lock must include:

- Approved artifact path and timestamp or approval note.
- Production screens/components used as the canvas.
- Approved states, viewports, and variants.
- Explicit change scope, including `No UI change`, `Verify only`, `Change`, `New`, `Remove`, and `Open question` items when applicable.
- Current-vs-proposed diffs for every approved change.
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
- Current behavior vs proposed behavior, including old -> new values for actual changes.
- Which mocked areas are actual implementation changes, verify-only/current behavior, and reference-only context.
- A short description of the change-scope indicator system used in the artifact.
- What should be implemented.
- What should not be implemented yet.
- UX notes and edge cases relevant to the flow.
- Any verification performed.

## Quality Checklist

- [ ] Real frontend code was inspected before design work.
- [ ] Appropriate UI/UX skills were used before mockup creation.
- [ ] A specialist UI/UX agent reviewed the interaction model, or the closest available specialist fallback was documented.
- [ ] The closest existing page/modal/component was identified.
- [ ] Existing components and interaction patterns were reused or explicitly ruled out with a reason.
- [ ] Current implementation and relevant tests were compared against the proposal before drawing or marking changes.
- [ ] States that already match current behavior are labeled as no-change or verify-only, not proposed changes.
- [ ] Actual changes include old -> new values, or are clearly labeled as new/remove.
- [ ] For existing-product UI changes, visual scope indicators are present in the app frame and a scope table/panel is present outside the app frames in the mockup artifact, not only in the final response or lock document.
- [ ] Every `New`, `Change`, `Remove`, `Verify only`, and `Open question` item that maps to UI identifies the relevant frame and product element in an outside-frame scope row.
- [ ] The artifact keeps app/phone/modal frames free of explanatory comments, prose labels, connector anchors, and callouts unless explicitly requested; small reference ID badges may attach to outlines.
- [ ] Different personas, permissions, payment states, inventory states, and lifecycle states are split into separate frames when they would see different UI.
- [ ] Any optional commented variant is clearly separated from the outlined approval frame and marked non-shipping.
- [ ] Explanatory annotation text is outside the app/phone/screen frame; the app frames contain only UI plus textless visual scope indicators.
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
- Mark existing UI as a proposed change just because it is relevant to the feature.
- Omit old -> new copy/value/control details for actual changes.
- Rely on a final response alone to describe scope without an outside-frame scope table/panel in the mockup artifact.
- Put explanatory comments, prose labels, connector anchors, or callout boxes inside the product UI.
- Put explanatory annotation text or callout boxes over the product UI in a way that blocks users from inspecting the actual screen.
- Treat the change-scope layer as optional for an existing-product UI-change mockup.
- Combine multiple personas or workflow states into one frame in a way that makes the UI state ambiguous.
- Let approximate reference-only buttons, icons, headers, avatars, or surrounding chrome become accidentally approved implementation scope.
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
