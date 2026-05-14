---
name: java-spring-boot-review-fix
description: Review and fix Java/Spring Boot changes with a root-cause workflow. Use when users ask to review uncommitted Java or Spring Boot code, staged and unstaged diffs, PR-sized local changes, or to fix review findings properly instead of applying band-aid patches.
---

# Java Spring Boot Review Fix

## Overview

Run a focused Java/Spring Boot review over the current local change set, then fix substantive issues through a root-cause workflow. The default scope is all uncommitted code: staged, unstaged, and relevant untracked Java, test, configuration, migration, and contract files.

## Reuse

- Use `root-cause-fix-enforcer` for P0/P1/P2 issues involving correctness, regressions, API contracts, persistence, security, transactions, shared state, concurrency, or repeated failures.
- Use the repository `AGENTS.md` and local coding standards as higher-priority rules.
- Use existing project test conventions and build tooling; do not invent a new validation stack.

## Operating Rules

1. Read applicable repo instructions before editing.
2. Review staged and unstaged changes together.
3. Include relevant untracked files when they are part of the same local change.
4. Do not commit, stage, or push unless the user explicitly asks.
5. Review changed lines first, but read existing files to verify contracts, call sites, tests, and framework behavior before reporting an issue.
6. Prefer the smallest authoritative fix that closes the defect for all callers.
7. Do not suggest or implement local-only, controller-only, or test-only patches when the root cause is in service logic, persistence, configuration, authorization, or API contract.
8. If the user asked for review only, stop after findings and validation suggestions. If the user asked to fix, build a findings ledger and close each finding with code and tests.

## Evidence Collection

Start with:

```bash
git status --short
git diff --staged
git diff
git ls-files --others --exclude-standard
```

Then inspect only the files needed to prove or disprove issues: touched production code, direct tests, interfaces, DTOs, controllers, services, repositories, migrations, generated-contract sources, build files, and relevant configuration.

## Review Checklist

Check Java/Spring Boot concerns that commonly create production defects:

- Controller and API boundary: request validation, response status, error shape, DTO compatibility, content negotiation, path/query parameter handling, and stable error codes.
- Service layer: authoritative business rule location, transaction boundaries, idempotency, retry behavior, async execution, timeouts, and exception propagation.
- Persistence: repository query correctness, tenant/org scoping, locking, pagination, N+1 queries, lazy-loading outside transactions, migrations, and read-after-write behavior.
- Security: authentication, authorization, method security, injection, SSRF, unsafe deserialization, secrets, sensitive logging, CORS/CSRF when applicable, and cross-tenant data leakage.
- Framework behavior: bean lifecycle, conditional configuration, profiles, property binding, validation groups, scheduled jobs, listeners, caches, and thread pools.
- Contract stability: OpenAPI/protobuf/schema changes, backwards compatibility, enum/default handling, generated code expectations, and client compatibility.
- Observability: actionable logs, metrics/traces for failure paths, meaningful exception context, and no noisy or misleading logging.
- Tests: missing regression coverage, brittle mocks, absent integration/slice tests, missing negative cases, and tests that verify only implementation details.

## Review-To-Fix Workflow

1. Summarize the changed scope and likely risk.
2. Produce findings first, ordered by severity (`P0`, `P1`, `P2`), with stable IDs such as `P1-1`.
3. For each finding, include file/line, problem, root cause, impact, and the authoritative fix.
4. Group findings that share one root cause before editing.
5. For each substantive finding, define closure notes:

```text
Invariant:
Entrypoints in scope:
Authoritative owner layer:
Expected post-condition:
Validation proving closure:
Finding IDs covered:
```

6. Implement by finding ID, not by narrative.
7. Add or update tests that would fail before the fix and pass after it.
8. Re-run targeted tests, then any repo-required checks for the touched scope.
9. Re-review the remaining diff and mark each finding `closed` or `open` only with validation evidence.

## Validation Guidance

Choose commands from the repo, not from memory. Common examples:

- Gradle: `./gradlew test`, targeted `./gradlew test --tests 'com.example.SomeTest'`, or module-specific tasks.
- Maven: `./mvnw test`, targeted `./mvnw -Dtest=SomeTest test`, or module-specific invocations.
- Spring slices: controller tests with MockMvc/WebTestClient, repository tests, service tests, or full `@SpringBootTest` only when the behavior crosses framework boundaries.

Run the narrowest tests that prove the changed behavior first. Broaden only when the touched surface is shared, framework-level, persistence-heavy, security-sensitive, or required by repo instructions.

## Required Output

Always report:

- Changed scope.
- Findings ledger with IDs and `open`/`closed` status.
- Root-cause fixes applied, if edits were made.
- Tests/checks run and what each proved.
- Any intentionally deferred broad verification.
- Final state: `REVIEW ONLY`, `LOCAL GREEN`, or `BLOCKED`.

If no issues are found, say so clearly and still list residual test or verification gaps.
