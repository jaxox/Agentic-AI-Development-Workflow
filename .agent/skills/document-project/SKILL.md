---
name: document-project
description: "Document an existing system for shared understanding and safe change."
---

# Skill: document_project

## Purpose
Document an existing system for shared understanding and safe change.

## Inputs
- Repository codebase and existing docs
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Any known constraints or incidents

## Output
- `artifacts/project-documentation-<date>.md` (use `templates/project-documentation.md`)

## Responsibilities
- Summarize tech stack, architecture patterns, business rules, and integrations.
- Capture constraints, risks, and gaps in documentation.
- Ask for missing context before finalizing if needed.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Guessing about system behavior without evidence.
- Omitting known risks or unknowns.

## Checklist
- [ ] Review codebase and existing docs
- [ ] Populate project documentation using the template
- [ ] Note risks and open questions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
