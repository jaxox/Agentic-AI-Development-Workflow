---
name: clear-jira-ticket
description: Turn rough requirements into a production-quality Jira ticket by scanning the repo, asking clarifying questions, and producing a detailed, actionable ticket (acceptance criteria, risks, test plan, rollout). Use when the user says things like "Create a Jira ticket for...", "Turn these requirements into a ticket...", "Write a detailed Jira story/task...", or "We need a Jira for this feature/bug...".
---

# Clear Jira Ticket

## Overview
Convert minimal or rough requirements into a Jira-ready ticket grounded in the current codebase, with explicit scope, approach, acceptance criteria, test plan, rollout, risks, and open questions.

## Workflow (mandatory)

### Phase 0 - Restate and confirm objective
- Restate the requirement in 1-3 sentences.
- State what success looks like in one sentence.
- State what you will inspect in the codebase next.

### Phase 1 - Codebase recon (repo scan)
You must inspect the repository before writing the final ticket.

1) Identify likely entry points
- Search for keywords from the requirement.
- Search related endpoints, configs, consumers/producers, UI pages, feature flags, metrics, or existing tickets/docs.

2) Map relevant components
- Main modules/services involved
- Call paths / data flow (high-level)
- Existing patterns to follow

3) Identify constraints
- Timeouts, retries, caching, idempotency, concurrency
- Existing validation / authz
- Observability hooks (logs/metrics/traces)

4) Capture concrete findings
- File paths, classes, key functions, configs
- Existing tests and where new tests should go

If the repo is huge, do a fast pass first, then zoom in.

### Phase 2 - Question pass (non-negotiable)
Before producing the final ticket, ask a tight set of clarifying questions.

Rules:
- Ask 5-12 questions max in one batch.
- Derive questions from gaps you observed in the repo scan (avoid generic questions).
- For each question, include a short clause on why it matters.
- Group questions by:
  1) Product/UX behavior
  2) Scope boundaries
  3) Data/edge cases
  4) Non-functional requirements (perf, reliability, security)
  5) Rollout/observability

If the user answers partially, proceed with explicit assumptions and list them.

### Phase 3 - Draft ticket (v1)
Produce a Jira ticket with the standard structure in the Output Format section.

### Phase 4 - Tighten
- Remove fluff.
- Ensure each section has concrete, actionable content.
- Ensure acceptance criteria are measurable.
- Ensure the plan follows patterns already used in the repo.

## Inputs to request from the user
Minimal input is fine, but ask for missing essentials before finalizing.

If provided, use:
- Desired ticket type (Bug/Story/Task/Spike)
- Target service/repo/module
- Environment (prod/stg/dev)
- Priority/severity
- Due date / milestone
- Stakeholders

If missing, ask for them.

## Style rules
- Be specific. Prefer file paths and function names over vague statements.
- Do not invent systems not present in the repo.
- Do not claim tests passing or verification without evidence.
- Avoid "should" when "will" is accurate.
- Keep it Jira-ready: readable, scannable, complete.

## Output format
Return:
1) A Jira-ready ticket body (Markdown)
2) A short "Copy/paste summary" (Title + 3 bullet highlights)
3) A checklist of next actions (for the assignee)

If the user asks, also generate:
- Subtasks
- Story points suggestion (with rationale)
- Labels / components suggestion

## Ticket structure

**Title**
- Short, specific, includes component/service and intent

**Background / Problem**
- What's happening and why it matters

**Goal**
- What we want to achieve

**Scope**
- In scope bullets
- Out of scope bullets

**Repo Findings (grounded references)**
- Relevant modules/files/classes discovered
- Existing patterns to reuse
- Related code paths and constraints

**Proposed Approach**
- Step-by-step technical plan
- Exact areas to change (paths/classes)
- Migration/backward compatibility if needed

**Acceptance Criteria (testable)**
- Bullets written as "Given/When/Then" or clear pass/fail checks
- Include failure modes and rollback expectations

**Test Plan**
- Unit tests: where + what
- Integration tests: where + what
- E2E tests: where + what (if relevant)
- Load/perf test notes (if relevant)

**Rollout Plan**
- Feature flag strategy or staged rollout
- Monitoring + alerting checks (metrics/logs dashboards)
- Backout plan

**Risks / Edge Cases**
- Timeouts, retries, partial failures, race conditions
- Data consistency, caching, idempotency
- Security/privacy concerns

**Dependencies**
- Other teams/services
- Infra/config changes
- Schema changes

**Open Questions / Assumptions**
- Anything unresolved, explicitly listed
