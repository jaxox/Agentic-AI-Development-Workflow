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
- Add or update tests and capture test logs per `docs/specs/test-logging.md`.
- Document scope, tests, and risks in the report.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Skipping tests without explicitly documenting why.
- Expanding scope beyond the quick spec.

## Checklist
- [ ] Confirm scope and constraints
- [ ] Implement code changes and tests
- [ ] Populate `artifacts/quick-dev-report.md` using the template
- [ ] Attach test logs per spec
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
