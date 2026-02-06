---
name: regenerate-project-md-frontend
description: Analyze a frontend repository and (re)generate PROJECT.frontend.md as authoritative working memory for future AI agents.
metadata:
  short-description: Auto-regenerate frontend PROJECT.md
  tags: [frontend, docs, architecture]
  version: "1.0"
---

# regenerate-project-md-frontend

## Purpose
Create or update `PROJECT.frontend.md` so future AI agents understand the frontend without re-analyzing the entire repo.

This is NOT a README.
This IS architectural memory and constraint documentation.

## Non-negotiable rules
- Prefer facts from the repo over assumptions
- If unclear, mark **Unknown / Needs confirmation**
- Avoid framework boilerplate explanations
- Optimize for future code changes and debugging
- Never invent behavior not proven by code

## Inputs
- Frontend repository working tree
- Existing `PROJECT.frontend.md` if present

## Output
- `PROJECT.frontend.md` at repo root

---

## Workflow

### 1) Detect frontend type
Identify:
- Framework (React / Next.js / Remix / Vue / RN / etc.)
- Build tool (Vite, Next, Webpack)
- Routing system
- State management
- Styling approach

Use:
- `package.json`
- build config files
- `src/` layout
- router config

### 2) Identify architectural intent
Extract:
- How UI, state, and services are separated
- Whether this is page-driven, feature-driven, or component-driven
- Where business logic actually lives

### 3) Map folders (ownership rules)
For each top-level folder:
- What belongs here
- What must NOT go here
- Any special conventions

### 4) Identify invariants
Document:
- Routing assumptions
- State ownership rules
- API usage patterns
- Styling constraints
- Performance-sensitive patterns

### 5) Diff-aware update
If `PROJECT.frontend.md` exists:
- Update only stale or incorrect sections
- Preserve valid warnings and constraints
If missing:
- Create new file using template below

---

## `PROJECT.frontend.md` Template (STRICT)

# Frontend Project Overview
- What this frontend app is
- What problem it solves
- Target platform(s)

# Tech Stack
- Framework
- Build tool
- Routing
- State management
- Styling system
- Testing setup

# High-Level Architecture
- How the frontend is structured conceptually
- Where UI vs logic vs services live

# Key User Flows
- Primary user journeys
- Related routes/components (high level)

# Folder & Module Map
For each top-level folder:
- Purpose
- Allowed contents
- Disallowed contents

# State & Data Flow
- Global vs local state
- Data flow from API → state → UI
- Caching or persistence behavior

# API Integration
- How API calls are made
- Where API clients live
- Auth/token handling assumptions
- Mock vs real backend strategy

# Styling & UI Conventions
- Component patterns
- Design system usage
- Styling rules that must be followed

# Configuration & Environments
- Env files
- Runtime config patterns
- Feature flags (if any)

# Non-Obvious Constraints
- Performance assumptions
- Mobile vs desktop considerations
- Intentional shortcuts or hacks

# Do Not Break These Invariants
Explicit frontend rules future changes must respect

# Open Questions / TODOs
Unclear or incomplete areas

---

## Final quality gate
- No fluff
- No onboarding steps
- No invented behavior
- Everything is either factual or explicitly marked unknown
