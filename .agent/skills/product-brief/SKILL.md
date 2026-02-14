---
name: product-brief
description: "Define the product brief with problem, proposed solution, users, scope, and success metrics."
metadata:
  short-description: "Define the product brief with problem, proposed solution, users, scope, and success metrics."
---

# Skill: product_brief

## Purpose
Define the product brief with problem, proposed solution, users, scope, and success metrics.

## Inputs
- `context/task.md` or a user-provided problem statement
- `artifacts/research.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Any linked files or references

## Output
- `artifacts/product-brief.md` (use `templates/product-brief.md`)

## Responsibilities
- Include executive summary, problem, solution, differentiation, and metrics.
- Capture assumptions, financial impact, strategic alignment, risks, and open questions.
- Ask for missing inputs before finalizing if needed.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Creating scope without a problem statement.
- Hiding open questions to advance the workflow.

## Checklist
- [ ] Review inputs and constraints
- [ ] Populate `artifacts/product-brief.md` using the template
- [ ] Identify risks and open questions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
