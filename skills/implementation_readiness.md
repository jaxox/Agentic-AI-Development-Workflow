# Skill: implementation_readiness

## Purpose
Assess readiness to implement based on requirements, architecture, and planning artifacts.

## Inputs
- `artifacts/prd.md`
- `artifacts/architecture.md`
- `artifacts/epics-and-stories.md`
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Delivery constraints and staffing assumptions

## Output
- `artifacts/implementation-readiness.md` (use `templates/implementation-readiness.md`)

## Responsibilities
- Determine readiness state (PASS/CONCERNS/FAIL).
- Assess completeness, alignment, and quality of artifacts.
- Identify gaps, blockers, and mitigations.
- Capture rollout readiness and open questions.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Marking PASS with unresolved blockers.
- Ignoring missing artifacts.

## Checklist
- [ ] Review planning artifacts
- [ ] Populate `artifacts/implementation-readiness.md` using the template
- [ ] List gaps and mitigations
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
