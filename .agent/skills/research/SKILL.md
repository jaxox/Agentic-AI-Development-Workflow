---
name: research
description: "Plan and summarize research that informs product and technical decisions."
---

# Skill: research

## Purpose
Plan and summarize research that informs product and technical decisions.

## Inputs
- Research questions and scope
- `artifacts/brief.md` or `artifacts/product-brief.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Any provided sources or links

## Output
- `artifacts/research.md` (use `templates/research.md`)

## Responsibilities
- Define research type, depth, scope, and questions.
- Capture sources and evidence clearly.
- Summarize implications, recommendations, risks, and open questions.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Inventing sources or evidence.
- Overstating confidence without data.

## Checklist
- [ ] Confirm research questions and scope
- [ ] Populate `artifacts/research.md` using the template
- [ ] List evidence and implications
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
