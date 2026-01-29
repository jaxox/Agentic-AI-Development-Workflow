# Codex Integration Notes

These notes are a lightweight guide to integrating the workflow with the OpenAI Codex CLI / IDE extension.

## Scope
- Applies to Codex CLI and the Codex IDE extension (they share configuration).

## Install and authenticate
- Install Codex CLI with npm and run `codex` to start a session; first run prompts for sign-in (ChatGPT account or API key).
- Use Codex locally inside the repo root so it can read and modify files.

## Repo setup (this repository)
- This repo includes a Team Config at `.codex/config.toml` with the OpenAI Developer Docs MCP server preconfigured.
- If you prefer CLI setup, use `codex mcp add openaiDeveloperDocs --url https://developers.openai.com/mcp`.

## Skills (official)
- Codex skills are defined by a `SKILL.md` file inside a skill folder.
- Optional folders: `scripts/`, `references/`, `assets/`.
- Skills can be invoked explicitly (`/skills` or `$skill-name`) or implicitly by description match.
- Skills load from `.codex/skills` locations with defined precedence; see mapping doc.

See `docs/integrations/codex-skills.md` for the full summary and repo mapping.

## MCP (Model Context Protocol) setup
- Codex supports MCP servers in both the CLI and IDE extension.
- MCP configuration is stored in `~/.codex/config.toml` by default; a repo-scoped `.codex/config.toml` can be used as a Team Config layer.
- You can configure MCP servers via `codex mcp` CLI commands or by editing `config.toml` directly.

### Recommended: OpenAI Developer Docs MCP
- Server URL: `https://developers.openai.com/mcp`
- Add via CLI:
  - `codex mcp add openaiDeveloperDocs --url https://developers.openai.com/mcp`
- Verify:
  - `codex mcp list`
- Manual config:
  - `~/.codex/config.toml`:
    - `[mcp_servers.openaiDeveloperDocs]`
    - `url = "https://developers.openai.com/mcp"`

Rationale: This MCP server provides read-only access to OpenAI developer documentation and is the fastest way to keep Codex up to date with the latest docs while working in this repo.

## Run the workflow with Codex
- Open the repo root in Codex.
- Start with `context/task.md` and follow `docs/checklists/run-workflow.md`.
- Each skill writes to `artifacts/` using templates in `templates/`.
- Record test logs and metrics per `docs/specs/test-logging.md` and `docs/specs/metrics.md`.

## Workflow alignment
- Use `templates/` for artifact scaffolding and write outputs to `artifacts/`.
- For each skill, ensure the artifact includes a `Status` section and an explicit state.
- For `verify_and_test`, enforce the JUnit XML + raw log format described in `docs/specs/test-logging.md`.

## Safety & approvals
- Use Codex approval modes that require explicit confirmation for file changes or command execution when running destructive operations.
- Prefer running Codex in a dedicated branch or repo clone for experiments.
- See `docs/checklists/codex-safety.md`.

## References
- https://developers.openai.com/codex/cli
- https://developers.openai.com/codex/mcp
- https://developers.openai.com/codex/config-basic
- https://developers.openai.com/resources/docs-mcp
