# regenerate-project-md-backend

## Purpose
Create or update `PROJECT.backend.md` so future AI agents understand backend architecture, domain boundaries, and constraints without re-reading the codebase.

This is NOT API documentation.
This IS system-level memory.

## Non-negotiable rules
- Prefer code reality over comments
- Explicitly mark **Unknown / Needs confirmation**
- Avoid generic backend theory
- Focus on domain, data, and invariants
- Never guess API behavior

## Inputs
- Backend repository working tree
- Existing `PROJECT.backend.md` if present

## Output
- `PROJECT.backend.md` at repo root

---

## Workflow

### 1) Detect backend stack
Identify:
- Language & framework (Spring Boot, Node, etc.)
- Build system
- Persistence layer(s)
- Messaging / async systems
- Auth strategy
- Deployment assumptions (if visible)

Use:
- build files
- config files
- `src/` layout
- migration folders
- infra configs (if present)

### 2) Identify domain structure
Extract:
- Core domain concepts
- Service boundaries
- Where business logic lives vs controllers
- DTO vs domain vs persistence separation

### 3) Map data & persistence
Document:
- Databases used
- Migration strategy
- ORM or query style
- Transaction boundaries (if visible)

### 4) Identify system invariants
Document:
- API contracts that must not change casually
- Data integrity assumptions
- Ordering / idempotency rules
- Performance-sensitive paths
- Security constraints

### 5) Diff-aware update
If `PROJECT.backend.md` exists:
- Update only incorrect or outdated sections
- Preserve valid warnings and constraints
If missing:
- Create new file using template below

---

## `PROJECT.backend.md` Template (STRICT)

# Backend Project Overview
- What this backend does
- What problem it solves
- Who/what consumes it

# Tech Stack
- Language & framework
- Build system
- Persistence
- Messaging / async
- Auth & security
- Observability (if any)

# High-Level Architecture
- How the backend is structured
- Service / module boundaries
- Control flow from request to persistence

# Core Domain Model
- Key domain concepts
- Relationships
- Where domain logic lives

# API Surface
- How APIs are exposed (REST, GraphQL, etc.)
- Versioning assumptions
- Contract stability expectations

# Data & Persistence
- Databases used
- Schema/migration strategy
- ORM or query approach

# Async / Background Processing
- Jobs, queues, or event processing
- Ordering and retry assumptions

# Configuration & Environments
- Env files
- Runtime configuration
- Secrets handling (if visible)

# Non-Obvious Constraints
- Performance bottlenecks
- Scaling assumptions
- Intentional shortcuts or hacks

# Do Not Break These Invariants
Rules future backend changes must respect

# Open Questions / TODOs
Unknowns or incomplete areas

---

## Final quality gate
- No API reference dumps
- No speculative behavior
- Focus on architecture and constraints
- Mark uncertainty explicitly
