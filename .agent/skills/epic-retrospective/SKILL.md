---
name: epic-retrospective
description: "Summarize outcomes and lessons learned after completing an epic."
---

# Skill: epic_retrospective

## Purpose
Summarize outcomes and lessons learned after completing an epic.

## Inputs
- Completed stories and delivery metrics
- Incident reports or postmortems if any
- Stakeholder feedback if available

## Output
- `artifacts/epic-retrospective.md` (use `templates/epic-retrospective.md`)

## Responsibilities
- Capture outcomes, wins, and misses objectively.
- Identify follow-up actions and owners.
- Note open questions and risks.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Attributing outcomes without evidence.
- Omitting follow-up actions when gaps exist.

## Checklist
- [ ] Review delivery metrics and feedback
- [ ] Populate `artifacts/epic-retrospective.md` using the template
- [ ] Capture follow-ups and open questions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
