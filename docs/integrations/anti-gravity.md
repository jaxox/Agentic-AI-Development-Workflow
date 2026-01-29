# Anti-Gravity Integration Notes

These notes are best-effort based on public reporting plus the Antigravity skills documentation provided by the user.

## Reported product snapshot (public sources)
- Public reporting refers to a Google “Antigravity” agent-first IDE with agents that can act in the editor, terminal, and browser.
- Reported features include multi-agent workflows, “Artifacts” (task lists, plans, screenshots, browser recordings), and a Manager view for orchestrating agents.
- Reports indicate a public preview for Windows, macOS, and Linux with rate limits that reset periodically.

## Integration approach (safe defaults)
Given limited official docs, treat Anti-Gravity as a generic agentic IDE and enforce strict guardrails:

- **Workspace isolation**: Run in a dedicated repo clone or branch.
- **Explicit approvals**: Require confirmation for file writes and command execution.
- **Artifact discipline**: Direct agents to write outputs only to `artifacts/` using `templates/`.
- **Gate enforcement**: Block progression if `brief.md` has open questions or `verify_and_test` lacks logs.
- **No mocks**: Prohibit UI/service mock data unless explicitly behind an API boundary.

## Suggested workflow mapping
- Agent/role configuration should mirror the skill boundaries in `docs/specs/skill-contract.md`.
- Ensure each agent outputs a single artifact matching its responsibility:
  - Analyst → `artifacts/brief.md`
  - PM → `artifacts/prd.md`
  - Architect → `artifacts/architecture.md`
  - QA → test logs per `docs/specs/test-logging.md`
  - Orchestrator → `artifacts/status.md`

## Skills doc summary (official)
- Workspace skills live at `<workspace-root>/.agent/skills/<skill-folder>/`.
- Global skills live at `~/.gemini/antigravity/global_skills/<skill-folder>/`.
- Each skill requires a `SKILL.md` file with YAML frontmatter.
- `description` is required; `name` is optional and defaults to the folder name.
- Optional subfolders: `scripts/`, `examples/`, `resources/`.

See `docs/integrations/anti-gravity-skills.md` for the full summary and mapping used in this repo.

## Rules & workflows (official)
- Rules are Markdown files limited to 12,000 characters.
- Global rules live at `~/.gemini/GEMINI.md`.
- Workspace rules live at `.agent/rules/` in the repo root.
- Activation modes: Manual (@ mention), Always On, Model Decision, Glob.
- Workflows are Markdown files (title + description + steps) and are invoked via `/workflow-name`.
- Workflows are created in the editor’s Customizations → Workflows panel.

See `docs/integrations/anti-gravity-rules-workflows.md` for full details and repo mapping.

## Setup steps (best-effort)
These steps are derived from public documentation and reporting. Validate in your environment.

1) Install Anti-Gravity from the public site and launch the app.
2) Open this repo as a workspace.
3) Ensure workspace skills exist under `.agent/skills/` (this repo includes them).
4) Create agents/roles that map to the skills in `.agent/skills/`.
5) In each agent prompt, enforce:
   - Inputs: read required files before writing.
   - Outputs: write only to `artifacts/` using `templates/`.
   - Gates: stop on open questions or missing logs.
6) Follow `docs/checklists/run-workflow.md` and `docs/integrations/workflow-wiring.md`.

## Security risk notes (public reporting)
- A reported incident describes an AI action that deleted a developer’s drive after a misunderstood cache-cleaning request, highlighting the risk of running with auto-approval or “turbo” execution modes.
- Separate reporting highlights prompt-injection and data-exfiltration risks when agents can execute terminal commands without sufficient safeguards.

## Open questions to resolve with official docs
- Exact configuration format or CLI entrypoint.
- Supported approval/permission modes.
- How to enforce read/write boundaries.
- Supported integrations (MCP or equivalent).

## References (public reporting)
- https://www.theverge.com/news/822833/google-antigravity-ide-coding-agent-gemini-3-pro
- https://www.techradar.com/ai-platforms-assistants/googles-antigravity-ai-deleted-a-developers-drive-and-then-apologized
- https://www.techradar.com/pro/googles-ai-powered-antigravity-ide-already-has-some-worrying-security-issues
- https://antigravity.im/documentation
- https://antigravity.im
- https://antigravity.google/docs/skills
- https://antigravity.google/docs/rules-workflows
