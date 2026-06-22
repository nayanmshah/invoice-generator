---
name: code-implementation
description: Provides implementation guidelines for Developer mode including coding standards, sprint deployment workflow, development plan integration, company tech stack alignment, and technical implementation best practices.
modeSlugs:
    - code
---

# Code Implementation Guidelines

## When to Use This Skill

Use this skill when:

- Implementing features or fixing bugs
- Following sprint-based development workflows
- Making code changes that need to align with a development plan
- Writing production code following best practices

## When NOT to Use This Skill

Do NOT use this skill when:

- Planning architecture (use architect mode)
- Debugging issues (use code mode with systematic-debugging skill)
- Writing tests (use QA mode)

## Step-by-Step Build Protocol

For each sprint:

1. **Announce**: State what you're about to implement and reference the development plan task
2. **User-provided inputs**: Use repo URL(s), DB URL, API keys, env vars from handoff (USER_INPUTS) when present. **Single repo:** REPO_URL. **Multi-repo:** REPO_FRONTEND + REPO_BACKEND (Decoupled) or REPO_DIRS + per-repo URLs (project-specific names). Ask only for values not provided. If anything is ambiguous, ask BEFORE writing code — never guess on technology choices or database configurations
3. **Implement**: Write the code for one sprint at a time
4. **Explain**: Briefly describe what was built and how to test it
5. **Wait (HITL)**: **Launch** backend and frontend (run in background per tech stack). **Update README** with manual launch commands and URLs. **Nayan validates first:** Run tests, hit backend health (e.g., `curl http://localhost:8000/health`), hit frontend, verify key endpoints per sprint acceptance criteria. Fix any failures. **Only when Nayan's validation passes** — ask user to verify at exposed URLs (e.g., Frontend: http://localhost:3000, Backend: http://localhost:8000) — **wait for explicit user confirmation** ("yes", "confirmed") before proceeding. Do not assume verification passed; do not commit without consent.
6. **Proceed**: Only move to the next sprint after user has explicitly confirmed local testing

**NEVER batch multiple sprints and present them all at once.** Each sprint should be individually verifiable on local env. Per-sprint: verify locally only; cloud deploy only after all sprints finished. See sdlc_human_gates rule.

## Real-Stack Enforcement

**NEVER substitute the technology specified in architecture.md with a local-only alternative without explicit user confirmation.** Consult architect-planning skill for company tech stack when making technology choices. Key anti-patterns: never use H2 for Oracle; never skip Keycloak when product family uses it; never introduce frameworks not in company stack without approval.

Acceptable local alternatives (when architect/architecture approves): Docker Compose, Testcontainers, environment-specific profiles (e.g., Spring profiles), mock servers for third-party APIs only.

## Sprint Deployment Workflow

**CRITICAL: Per-sprint: local verification only. Cloud deploy only after all sprints finished.** See sdlc_human_gates rule.

### Per-Sprint (Local Only)

1. Complete all code implementation for the sprint
2. **Tests & Code Coverage (MANDATORY):** Run unit/integration tests, coverage; all must pass. **Multi-repo:** Run tests **in each repo** (`cd <repo> && npm test` or `cd <repo> && pytest` for each repo in REPO_DIRS).
3. **Local Testing & User Consent (MANDATORY):** **Launch** backend and frontend (run in background). **Update README** with "Setup and Run Locally" (manual launch commands and URLs). **Nayan validates first** (tests, health endpoints, key sprint endpoints); fix failures. **Only when Nayan's validation passes** — ask user to verify at exposed URLs; **wait for explicit confirmation** before commit
4. **Code quality gate:** Lint, tests, coverage pass. **Multi-repo:** Run lint, tests, coverage **in each repo** (`cd <repo> && npm run lint && npm test` for each repo in REPO_DIRS). All must pass before commit.
5. **Security scan:** Run `npm audit`/`pnpm audit`/`pip audit`; fix critical/high before PR. **Multi-repo:** Run audit **in each repo** (`cd <repo> && pnpm audit` or `cd <repo> && pip audit` for each repo in REPO_DIRS).
6. **Detailed git commit (MANDATORY):** Minimum 5–8 accomplishment bullets; one-line commits NOT allowed. See `.nayan/guidance/development-plan-sprint-format.md`. Include "Verified local testing: [user-confirmed items]"
7. Push branch; **Create PR per sprint (MANDATORY):** Human reviewer must approve before merge. Do NOT merge — human merges.

**Repository Strategy (Decoupled Fullstack):** When REPO_STRATEGY: single (or only REPO_URL present): one repo; git from workspace root; one branch, one commit, one PR per sprint. When REPO_STRATEGY: multi (or REPO_FRONTEND + REPO_BACKEND or REPO_DIRS present): run git commands in each repo's directory (`cd <repo> && git ...` for each repo in REPO_DIRS). Commit and PR per repo. **Multi-repo E2E rule:** Do NOT commit until the full UI→backend flow is verified and user has confirmed. Every feature sprint delivers a vertical slice; commit only after Tech Stack Integration verification. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`. 8. **Do NOT deploy to cloud** — verify locally only

### Deployment Sprint (Only After All Sprints)

When all sprints complete: delegate to **qa** (quality gate phase) then **secure** (both must pass). Then delegate to **deploy** for cloud deployment with HITL at each step. See code_quality_security_gates rule.

**Handoff:** Code hands off to QA via new_task. Last todo: "Hand off to QA (new_task)" — never "Call attempt_completion back to orchestrator." See handoff-schema.md.

## Deployment Consultation

Before any deployment decision, ask the user:

1. "Where should this be deployed?" — use what is specified in architecture.md
2. "What are the environment connection strings?"
3. "Are there existing CI/CD pipelines to integrate with?"
4. "Should I create Docker configurations for local development?"

## Implementation Guidelines

- **UI design and look-and-feel:** When UX prototype was approved (passed from development-plan), implement UI to **match the approved prototype** for layout, components, and look-and-feel **using the tech stack selected in architect mode** (from architecture.md). The prototype is authoritative for design; the tech stack (Next.js, Angular, React, etc.) is used for implementation. Reference `ux/prototypes/{persona}/` (or path provided in development-plan).
- Follow the technical architecture and technology stack specified in development plans
- Implement features according to sprint priorities and task sequencing
- Update development plan progress as tasks are completed
- **Detailed sprint commits (MANDATORY):** One-line commits NOT allowed. Use commit body with **minimum 5–8 accomplishment bullets** (see `.nayan/guidance/development-plan-sprint-format.md`)
- **Fix-bug and refactor (brownfield):** Single repo → one commit, one PR. Multi-repo → commit and PR only in repos that have changes. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md` and `.nayan/rules-code/sprint_protocol.md`
- Respect task dependencies and completion criteria from development plans
- Align code implementation with sprint goals and milestones
- No hardcoded credentials, URLs, or environment-specific values
- Configuration externalized to environment variables or config files
- README updated with setup steps, **manual launch commands**, and exposed URLs (Setup and Run Locally section)
