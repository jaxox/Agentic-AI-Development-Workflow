# Skill: dev_story

## Purpose
Implement a story in code with tests and a concise implementation report.

## Inputs
- `artifacts/stories/story-<slug>.md`
- Repository codebase and architecture references
- `artifacts/prd.md` and `artifacts/architecture.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`

## Output
- Code changes and tests
- `artifacts/dev-story-report.md` (use `templates/dev-story-report.md`)

## Responsibilities
- Implement the story per acceptance criteria and ADR guidance.
- Add or update tests and capture test logs per `docs/specs/test-logging.md`.
- Update sprint status to READY FOR REVIEW when applicable.
- Document changes, tests, and risks in the report.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Shipping without tests or without explaining test gaps.
- Introducing mock data in UI/services without an explicit boundary.

## Checklist
- [ ] Review story and architecture inputs
- [ ] Implement code changes and tests
- [ ] Populate `artifacts/dev-story-report.md` using the template
- [ ] Attach test logs per spec
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
