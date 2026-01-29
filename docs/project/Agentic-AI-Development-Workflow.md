# Project: Agentic AI Development Workflow (BMAD → IDE Skills)

## 1. Problem Statement

Current AI-assisted development is inefficient:
- AI works task-by-task instead of end-to-end
- Loses context, lies about test status, skips work
- Reinvents UI / architecture instead of following existing patterns
- Requires constant re-prompting and babysitting

Goal:  
Create a **repeatable, testable, agent-based AI workflow** that can:
- Take a Jira ticket (or problem statement)
- Plan → research → design → implement → validate
- Run inside IDE tools (Coax / Gemini / Anti-Gravity) as **Skills / Workflows**
- Be measurable, debuggable, and improvable over time

---

## 2. Strategy (Tell It Like It Is)

❌ Do NOT “just use BMAD as-is”  
BMAD is a **conceptual framework**, not an IDE-native system.

✅ Correct approach:
- **Extract BMAD principles**
- **Translate roles into IDE Skills**
- **Enforce artifacts, gates, and rules**
- **Instrument for truth (tests, diffs, metrics)**

BMAD becomes the **source philosophy**, not the runtime.

---

## 3. Core Design Principles

### 3.1 Artifact-First (Non-Negotiable)
AI output is only valid if it produces artifacts:
- `.md` specs
- `.json` configs
- real code
- test results (logs, diffs)

No “looks good to me”.

---

### 3.2 Role → Skill Mapping

| BMAD Role | IDE Skill | Output Artifact |
|----------|----------|----------------|
| Analyst | `analyze_task` | `brief.md` |
| PM | `define_requirements` | `prd.md` |
| Architect | `design_system` | `architecture.md` |
| Developer | `implement_code` | code + commits |
| QA | `verify_and_test` | test logs + diff |
| Orchestrator | `run_workflow` | checklist + status |

Each **Skill = one responsibility**.  
No skill is allowed to “do everything”.

---

## 4. Skill Contracts (Critical)

Every Skill must obey:

### Input
- Explicit inputs only (files, links, ticket text)
- No assumptions
- Ask questions *before* generating output

### Output
- Deterministic structure
- Named files
- Clear “DONE / BLOCKED / NEEDS INPUT” status

### Forbidden
- Claiming tests passed without logs
- Creating mock data in UI/services
- Changing architecture without approval
- Inventing new styles/themes

---

## 5. Workflow (End-to-End)

### Step 0 – Entry Point
Input:
- Jira ticket OR problem statement

Output:
- `/context/task.md`

---

### Step 1 – Analyst Skill
**Skill:** `analyze_task`

Produces:
- `brief.md`

Contents:
- Goals
- Non-goals
- Constraints
- Risks
- Open questions
- Acceptance definition

⛔ Block workflow if questions unanswered

---

### Step 2 – PM Skill
**Skill:** `define_requirements`

Produces:
- `prd.md`

Contents:
- Functional requirements (FR-01…)
- Non-functional requirements (NFRs)
- User stories (Given / When / Then)
- MVP scope
- Explicit exclusions

---

### Step 3 – Architect Skill
**Skill:** `design_system`

Produces:
- `architecture.md`
- diagrams (PlantUML / Mermaid)

Contents:
- Component boundaries
- Data flow
- Tech stack decisions (with reasons)
- No-code zones (what must NOT change)

---

### Step 4 – Developer Skill
**Skill:** `implement_code`

Rules:
- Code must map to PRD IDs
- No mocks in UI/services
- Fake backend allowed ONLY behind API boundary

Produces:
- Real code
- Tests
- Git diff

---

### Step 5 – QA Skill
**Skill:** `verify_and_test`

Produces:
- Test execution logs
- Failed tests list
- Coverage / gaps
- Rollback readiness

⛔ If tests are flaky or skipped → FAIL

---

### Step 6 – Orchestrator Skill
**Skill:** `run_workflow`

Produces:
- `status.md`

Contents:
- Completed steps
- Blockers
- Confidence level
- What to run next

---

## 6. Integration into Coax / Gemini / Anti-Gravity

### How Skills Are Implemented

Each Skill =:
- One prompt
- One responsibility
- One output directory

Example:

