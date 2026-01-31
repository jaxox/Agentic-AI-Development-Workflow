---
name: brainstorm-project
description: "Generate structured solution ideas across architecture, UX, integration, and value tracks with trade-offs."
---

# Skill: brainstorm_project

## Purpose
Generate structured solution ideas across architecture, UX, integration, and value tracks with trade-offs.

## Inputs
- `context/task.md` or a user-provided problem statement
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Any linked files referenced by the task

## Output
- `artifacts/brainstorm.md` (use `templates/brainstorm.md`)

## Responsibilities
- Produce multiple solution approaches, not a single answer.
- Include architecture options, UX and integration considerations, and rationale.
- Surface risks, assumptions, and follow-up questions.
- Ask for missing context before finalizing if needed.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Treating ideas as decisions without validation.
- Ignoring explicit constraints or scope.

## Checklist
- [ ] Review inputs and constraints
- [ ] Populate `artifacts/brainstorm.md` using the template
- [ ] Note risks and open questions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
