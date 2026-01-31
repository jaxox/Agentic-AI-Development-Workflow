---
name: repo-explainer
description: "Explain the repository structure, core workflow, and how to run the workflow from a given entry point."
metadata:
  short-description: "Explain the repository structure, core workflow, and how to run the workflow from a given entry point."
---

# Skill: repo_explainer

## Purpose
Explain the repository structure, core workflow, and how to run the workflow from a given entry point.

## Inputs
- `README.md`
- `docs/project/structure.md`
- `docs/checklists/run-workflow.md`
- `docs/specs/skill-contract.md`

## Output
- `docs/repo-overview.md` (must follow the required section layout)

## Responsibilities
- Summarize what the repo does in 3–5 bullets.
- Explain the main workflow steps and key artifacts.
- Provide a Mermaid architecture diagram.
- Document modules as a table (path → responsibility).
- Include how to run locally and how to test.
- Add deployment notes if any are present; otherwise state “None found.”
- Include gotchas and open questions/missing docs.
- Highlight any gating rules (NEEDS INPUT / BLOCKED).

## Forbidden
- Inventing files or steps not present in the repo.
- Recommending actions that bypass required checks.

## Checklist
- [ ] Read the README and structure doc
- [ ] Produce `docs/repo-overview.md` with the required sections
- [ ] Explain the workflow steps and artifacts
- [ ] Link to relevant integration docs
- [ ] Call out gating rules and validation requirements

## Required output structure for `docs/repo-overview.md`

```\n# Repo Overview\n\n## What this repo is\n<1 paragraph>\n\n## Key user flows / runtime flows\n- ...\n\n## Architecture diagram\n```mermaid\nflowchart LR\n  A[Entry] --> B[Step]\n```\n\n## Modules\n| Path | Responsibility |\n| --- | --- |\n| ... | ... |\n\n## How to run locally\n- ...\n\n## How to test\n- ...\n\n## Deployment notes (if present)\n- None found.  // replace if present\n\n## Things that will bite you (gotchas)\n- ...\n\n## Open questions / missing docs\n- ...\n```\n*** End Patch"}]}คิดเห็น to=functions.apply_patch code  ฝ่ายขายรายการy consent ҵо আরোassistant to=functions.apply_patch interplay? code: 彩票招商;?>
