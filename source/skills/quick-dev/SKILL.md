---
name: quick-dev
description: "Deliver a small change quickly with minimal overhead while preserving quality."
metadata:
  short-description: "Deliver a small change quickly with minimal overhead while preserving quality."
---

# Skill: quick_dev

## Purpose
Deliver a small change quickly with minimal overhead while preserving quality.

## Inputs
- `artifacts/tech-spec.md` if available
- User request or problem statement
- Repository codebase and relevant docs
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`

## Output
- Code changes and tests
- `artifacts/quick-dev-report.md` (use `templates/quick-dev-report.md`)

## Responsibilities
- Implement the smallest viable change that meets requirements.
- For UI changes, inspect nearby shared components, hooks, utilities, tokens, tests, and interaction patterns before creating anything new.
- Prefer reusing, composing, extending, or parameterizing existing UI over adding a duplicate component.
- Add or update tests and capture test logs per `docs/specs/test-logging.md`.
- Document scope, tests, and risks in the report.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Skipping tests without explicitly documenting why.
- Expanding scope beyond the quick spec.
- Creating a new UI component when an existing component can reasonably be reused or extended.

## Checklist
- [ ] Confirm scope and constraints
- [ ] For UI changes, identify reusable existing components/patterns before editing
- [ ] Implement code changes and tests
- [ ] Populate `artifacts/quick-dev-report.md` using the template
- [ ] Attach test logs per spec
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
