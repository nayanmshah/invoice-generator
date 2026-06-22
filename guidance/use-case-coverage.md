# Use Case Coverage: SDLC Pipelines

This document provides a comprehensive inventory of use cases, edge cases, and classification guidance for greenfield and brownfield pipelines. Use it to verify coverage and classify ambiguous requests.

---

## Primary Use Cases (Covered)

### Cross-cutting: Explicit UI change request

When the user or scope **explicitly requests a change in UI** (redesign, new look-and-feel, new design system, component or layout changes), **in both greenfield and brownfield** use **prototype (create/update) → plan (create/update) first** before code. **Use architect when there is API or architecture impact** (new/changed APIs, backend, data model, new modules or integration points, new frontend app/service); then use architect (create/update) → prototype → plan. Pure UI-only (no API/backend impact): prototype → plan is sufficient. See `.nayan/guidance/pipeline-entry-points.md` (Explicit UI change requests).

### Greenfield

| Use Case                                | Entry                     | Flow                                                                                                                                                    | Notes                                                                                                            |
| --------------------------------------- | ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **New product (raw idea)**              | orchestrator → brainstorm | brainstorm → prd → architect → prototype (when UI) → plan (dev-plan) → code → qa → secure → deploy                                                      | Brainstorm structures the idea first                                                                             |
| **New product (structured idea)**       | orchestrator → prd        | prd → architect → prototype (when UI) → plan (dev-plan) → code → qa → secure → deploy                                                                   | Skip brainstorm                                                                                                  |
| **New product (JIRA / SOW as input)**   | orchestrator → brainstorm | Fetch context → **brainstorm first** (deep understanding with user via Q&A/brainstorm) → prd → architect → prototype/plan → code → qa → secure → deploy | **When JIRA/SOW (not full PRD): entry = brainstorm first.** Then prd → architect. See context-input-handling.md. |
| **New product (PRD as input)**          | Same as above             | prd → architect → prototype/plan → code → qa → secure → deploy                                                                                          | Full PRD: prd first.                                                                                             |
| **API-only product**                    | Same as above             | architect → plan (dev-plan, skip prototype) → code → qa → secure → deploy                                                                               | No UI; architect delegates directly to dev-plan phase                                                            |
| **UI product**                          | Same as above             | architect → prototype → plan (dev-plan) → code → qa → secure → deploy                                                                                   | UX prototype required                                                                                            |
| **Tech stack: Bootcamp / Enterprise / custom** | Same as above             | Architect asks user; includes TECH_STACK in handoff                                                                                                     | Per plan-input-requirements                                                                                      |

### Brownfield A: Extend Product

| Use Case                              | Entry                    | Flow                                                                                  | Notes                                                                                                                   |
| ------------------------------------- | ------------------------ | ------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Add significant feature or module** | orchestrator → architect | architect → prototype (when UI) → plan (dev-plan) → code → qa → secure → deploy       | Architecture may need extension                                                                                         |
| **Product migration (legacy → new)**  | orchestrator → architect | architect → prototype (when UI) → plan (migration plan) → code → qa → secure → deploy | **Classify as brownfield-migrate.** Architect then prototype (when UI) then plan. See brownfield-migration-use-cases.md |
| **Architecture extension**            | orchestrator → architect | Pre/post C4 diagrams required                                                         | Per brownfield-use-cases.md                                                                                             |

### Brownfield B: Add Feature (Architecture Exists)

| Use Case                                     | Entry                                        | Flow                                                                                                                                                 | Notes                                                                                         |
| -------------------------------------------- | -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| **Add feature (UI)**                         | orchestrator → prototype                     | prototype → plan (dev-plan) → code → qa → secure → deploy                                                                                            | Orchestrator delegates to prototype when UI involved; skip prd when feature is small or clear |
| **Add feature (API-only)**                   | orchestrator → plan                          | plan (dev-plan) → code → qa → secure → deploy                                                                                                        | Orchestrator delegates directly to plan                                                       |
| **Add/enhance feature (JIRA/SOW as input)**  | orchestrator → brainstorm                    | brainstorm (deep understanding with user) → prd → architect (architecture impact) → prototype (when UI) or plan → plan → code → qa → secure → deploy | **When JIRA/SOW (not full PRD): entry = brainstorm first.** Then prd → architect.             |
| **Add/enhance feature (substantial or PRD)** | orchestrator → prd                           | prd → architect (architecture impact) → prototype (when UI) or plan → plan (dev-plan) → code → qa → secure → deploy                                  | Use PRD when substantial or when full PRD; architect always used when PRD used.               |
| **New feature within existing arch**         | prototype or plan (or prd → architect first) | Dev plan Section 1.1 summarizes existing; when PRD used, architect produces architecture impact                                                      | Per 2_workflows_brownfield.xml                                                                |

### Brownfield C: Fix Bug

| Use Case                        | Entry                | Flow                                                                                      | Notes                                                          |
| ------------------------------- | -------------------- | ----------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| **Diagnose only then hand off** | orchestrator → debug | debug → code → qa → secure → (deploy?)                                                    | Debug = debug phase; code = code implementation phase          |
| **Simple fix** (one flow)       | orchestrator → code  | code (diagnoses, HITL confirm, applies fix) → qa (quality gate only) → secure → (deploy?) | Code uses systematic-debugging; qa skips plan/execution phases |
| **Complex fix** (one flow)      | orchestrator → code  | code (diagnoses, HITL confirm, applies fix) → qa → secure → (deploy?)                     | Code handles both diagnosis and fix in same session            |
| **Deployment optional**         | —                    | After secure: orchestrator asks "Does this require deployment?"                           | If no: end pipeline. If yes: deploy                            |

**Bug vs enhancement:** If the reported "bug" is actually an enhancement (new capability, requirement change, or behavior beyond original spec), do NOT use fix-bug. Classify as **brownfield-add-feature** or **brownfield-extend** and include PRD so requirements are documented first.

### Brownfield D: Refactor

| Use Case                     | Entry             | Flow                                              | Notes                                     |
| ---------------------------- | ----------------- | ------------------------------------------------- | ----------------------------------------- |
| **Structural refactor**      | orchestrator → qa | qa (refactor-scope) → code → qa → secure → deploy | refactor-scope satisfies qa prerequisites |
| **Tech debt / code quality** | Same              | Same                                              | No new features; quality gates required   |

---

## Migration Use Cases (Covered)

See `.nayan/guidance/brownfield-migration-use-cases.md` for full detail.

| Use Case                       | Brownfield Type                  | Where Documented                                                          |
| ------------------------------ | -------------------------------- | ------------------------------------------------------------------------- |
| Data migration                 | A or B                           | architecture.md 4c; development-plan sprints                              |
| API version migration          | A or B                           | architecture.md API Strategy; development-plan                            |
| Feature rollout (flags)        | A or B                           | architecture.md or development-plan                                       |
| Feature deprecation            | A or B                           | architecture.md; development-plan                                         |
| Product migration (legacy→new) | **Migrate** (brownfield-migrate) | architect → prototype (when UI) → plan; architecture.md; development-plan |
| Module/component migration     | D (refactor)                     | qa output (refactor-scope); development-plan if large                     |

---

## Edge Cases & Classification

| Scenario                                               | Classification                                          | Notes                                                                                                                     |
| ------------------------------------------------------ | ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **Hotfix**                                             | brownfield-fix-bug                                      | Same as fix-bug; quality gates never bypassed                                                                             |
| **Security vulnerability patch**                       | brownfield-fix-bug                                      | Patching known vuln; same flow as fix-bug                                                                                 |
| **Tech stack upgrade** (e.g., React 17→18, Node 16→20) | brownfield-extend or brownfield-refactor                | If architect assesses impact → extend. If qa assesses → refactor                                                          |
| **Dependency upgrade**                                 | brownfield-fix-bug (if security) or brownfield-refactor | Security patch → fix-bug. Non-security → refactor                                                                         |
| **Bug is actually an enhancement**                     | brownfield-add-feature or brownfield-extend             | New capability, requirement change, or behavior beyond spec → use add-feature or extend; include PRD. Do not use fix-bug. |
| **Config-only change** (.env, config files)            | brownfield-fix-bug or brownfield-add-feature            | Files change; quality gates apply per code-quality-security-gates.md                                                      |
| **Test-only addition**                                 | brownfield-add-feature or brownfield-refactor           | Files change; quality gates apply                                                                                         |
| **Documentation-only**                                 | **Out of SDLC pipeline**                                | Use code mode with docs-creation-workflow; not part of greenfield/brownfield                                              |
| **Dockerization**                                      | brownfield-extend                                       | deploy delegates to dockerization when containers needed                                                                  |
| **Replacing legacy system / full product migration**   | brownfield-migrate                                      | Use architect → prototype (when UI) → plan. See brownfield-migration-use-cases.md                                         |
| **Greetings, general non-product**                     | **Out of scope**                                        | Greet warmly; redirect to /greenfield or /brownfield. See out-of-scope-handling.md                                        |
| **Other out-of-scope** (poems, homework, etc.)         | **Reject**                                              | Politely decline; redirect to product development. See out-of-scope-handling.md                                           |

---

## Quality & Security Gates (Never Bypassed)

Per `.nayan/guidance/code-quality-security-gates.md`:

- **Applies to:** All pipelines where **code or files change** — greenfield, brownfield-extend, brownfield-add-feature, brownfield-fix-bug, brownfield-refactor, brownfield-migrate
- **Order:** qa (quality gate) → secure (before deploy)
- **No exceptions:** Config changes, test additions, dependency upgrades — all require quality gates when files change

---

## Handoff Validation Summary

| Pipeline                     | First Pass Code Review | Quality Gate | Second Pass               | Security Review | Deployment                    |
| ---------------------------- | ---------------------- | ------------ | ------------------------- | --------------- | ----------------------------- |
| Greenfield, A, Migrate, B, D | qa (Phase 1)           | qa (Phase 4) | qa (Phase 5) → secure     | secure          | deploy                        |
| Fix-bug                      | **Skip** (simple fix)  | qa (Phase 4) | **Skip** (no second pass) | secure          | User decides; if yes → deploy |

---

## References

- `.nayan/guidance/pipeline-entry-points.md` — Entry points and full flows
- `.nayan/guidance/brownfield-use-cases.md` — Diagram requirements per brownfield type
- `.nayan/guidance/brownfield-migration-use-cases.md` — Migration scenarios
- `.nayan/guidance/sdlc-prerequisites.md` — Prerequisite validation
- `.nayan/guidance/code-quality-security-gates.md` — Quality and security gates
- `.nayan/guidance/out-of-scope-handling.md` — Greet vs reject for non-product questions
- `.nayan/rules-orchestrator/2_workflows_brownfield.xml` — Pipeline definitions
