# Pipeline Entry Points: Greenfield vs Brownfield

This document defines when to use each pipeline and how to enter it.

## Greenfield Pipeline

**Use when:** Starting a new product from scratch. No existing codebase, architecture, or PRD.

**When user provides JIRA ID or SOW (instead of PRD):** **Entry point is brainstorm first** for both greenfield and brownfield, all use cases. Orchestrator delegates to **brainstorm**; brainstorm fetches context per `.nayan/guidance/context-input-handling.md`, presents it to the user (Present-First), then **deeply understands JIRA/SOW requirements with the user** through question-answer and brainstorm. After alignment, brainstorm hands off to the next mode: greenfield → prd; brownfield extend/migrate → architect; brownfield add-feature (substantial or JIRA/SOW) → prd; then prd → architect → prototype/plan as applicable. **When user provides a full PRD:** Entry can be prd (greenfield) or prd/architect/prototype/plan per pipeline (brownfield).

**Entry:** User describes product idea → Orchestrator → brainstorm or prd

**Full flow:**

1. orchestrator
2. brainstorm (optional—structures raw idea)
3. prd
4. architect (architecture phase — produces architecture.md)
5. prototype (when UI involved; skip when API-only)
6. plan (dev-plan phase only — produces development-plan.md)
7. code
8. qa (code review first pass, QA plan, QA execution, quality gate, code review second pass)
9. secure (MANDATORY — no skip; must pass; includes security assessment)
10. deploy

**Tech stack selection:** Architect asks user for tech stack (Bootcamp vs Enterprise vs custom) when creating architecture. Architect includes `TECH_STACK: bootcamp|enterprise|custom` in handoff to prototype/plan/code.

**Architecture format:** Greenfield uses `.nayan/guidance/architecture-greenfield-structure.md`; Brownfield A uses `.nayan/guidance/architecture-brownfield-structure.md`. See `.nayan/guidance/architecture-document-structure.md`.

**Development plan format:** Greenfield uses `.nayan/guidance/development-plan-greenfield-template.md`; brownfield uses `.nayan/guidance/development-plan-brownfield-template.md`. Shared sprint format: `.nayan/guidance/development-plan-sprint-format.md`.

---

## Brownfield Pipelines

### Brownfield A: Extend Existing Product

**Use when:** Adding a significant feature or module to an existing product. Architecture may need review or extension.

**Entry:** orchestrator → architect (skips prd)

**Flow:** architect → prototype (when UI) → plan (dev-plan) → code → qa → secure → deploy

**Input:** Condensed scope document (not full PRD), existing codebase, architecture.md

**Architecture:** Architect extends existing architecture.md per `architecture-brownfield-structure.md`.

**Development plan:** Uses brownfield template (Context & Existing Assets, Changes to Application Anatomy, Sprints).

---

### Brownfield Migrate: Product Migration (Legacy to New)

**Use when:** Migrating from legacy system to new system; replacing entire product or major subsystem.

**Entry:** orchestrator → architect (skips prd). **Architect and prototype (when UI) before plan** — do not skip.

**Flow:** architect → prototype (when UI; migration UX) → plan (migration plan with sprints, cutover, verification) → code → qa → secure → deploy

**Input:** Migration brief or condensed scope, existing (legacy) codebase, architecture.md or legacy system context

**Architecture:** Architect produces pre/post architecture (current state vs target), migration strategy, data migration, cutover. See `.nayan/guidance/brownfield-migration-use-cases.md`.

**Development plan:** Migration plan with dedicated migration sprints, cutover plan, verification. Uses brownfield template.

---

### Brownfield B: Add Feature (Architecture Exists)

**Use when:** Architecture already exists. New feature or enhance existing feature; implementation follows dev plan.

**When to include PRD:** Use PRD when the feature is substantial, an enhancement (new capability), or requires formal requirements or stakeholder sign-off (including when user provides JIRA ID, SOW, or PRD for add/enhance). **When user provides JIRA or SOW (not a full PRD):** Entry is **brainstorm first** — orchestrator → brainstorm (deep understanding with user via Q&A/brainstorm) → prd → architect (architecture impact) → prototype (when UI) or plan. **When user provides a full PRD:** orchestrator → prd → architect → prototype/plan. **Add/enhance with PRD always uses architect.** When the feature is small or spec is clear and no JIRA/SOW, skip prd: orchestrator → prototype (when UI) or plan (when API-only).

**Entry:** orchestrator → prd (optional) | architect (when PRD was used) | prototype (when UI) or plan (when API-only). Architect runs only when PRD was used.

**Flow:** When PRD used: prd → architect → prototype (when UI) or plan → plan (dev-plan) → code → qa → secure → deploy. When PRD skipped: prototype (when UI) or plan → plan (dev-plan) → code → qa → secure → deploy.

**Input:** architecture.md, refined-prd (when PRD was used) or feature spec

**Development plan:** Uses brownfield template. Include CONTEXT: brownfield when delegating.

---

### Brownfield C: Fix Bug

**Use when:** Fixing a reported bug (restore/correct behavior to match existing spec). When the "bug" is actually an enhancement (new capability, requirement change), classify as add-feature or extend and include PRD; do not use fix-bug. Planning phases skipped; quality and security gates never bypassed.

**Phase distinction:** **Debug** = debug phase (diagnosis only; hands off fix instructions to code). **Code** = code implementation phase (implements fix from debug handoff, or diagnoses and fixes in one flow with systematic-debugging).

**Entry:** orchestrator → **debug** (when "diagnose only, then hand off fix to Code" is desired) or **code** (when diagnose and fix in one flow).

**Flow:** debug (optional) → code → qa → secure → (deploy?). When debug used: debug → code → qa → secure. When code entry: code → qa → secure. After secure: orchestrator asks "Does this require deployment?" — if no, end; if yes, deploy.

**Input:** Bug report, codebase

---

### Brownfield D: Refactor / Code Quality

**Use when:** Refactoring or improving code quality.

**Entry:** orchestrator → qa

**Flow:** qa (refactor scope) → code → qa → secure → deploy → orchestrator or user

**Input:** Refactor scope, codebase

---

## Explicit UI change requests

When the user or scope **explicitly requests a change in UI** (redesign, new look-and-feel, new design system, component or layout changes, etc.), **in both greenfield and brownfield** run **prototype (create/update) → plan (create/update) first** before code. Do not implement UI changes in code without going through this sequence.

**Use architect when there is API or architecture impact:** Include **architect (create/update)** before prototype and plan when the UI change has (or may have) impact on: APIs (new or changed endpoints, contracts), backend or data model, new modules or services, integration points, or a new frontend app/service that must be reflected in architecture. In those cases use **architect (create/update) → prototype (create/update) → plan (create/update)** first. **Pure UI-only** (visual/look-and-feel, styling, layout, components within existing structure, no API or backend change): **prototype (create/update) → plan (create/update)** is sufficient; skip architect.

If already in code or plan and the user requests an explicit UI change: redirect so prototype (create/update) and plan (create/update) are done first; include architect in the sequence only when API or architecture impact applies. Then code implements to the updated prototype and plan.

---

## Entry Point Summary

| Scenario                             | Entry Mode                                                                     | Pipeline           | Skips                                                                                                                                          |
| ------------------------------------ | ------------------------------------------------------------------------------ | ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| New product (no JIRA/SOW)            | orchestrator → brainstorm / prd                                                | Greenfield         | —                                                                                                                                              |
| New product (JIRA/SOW)               | orchestrator → **brainstorm first** → prd                                      | Greenfield         | —                                                                                                                                              |
| Extend existing product              | orchestrator → **brainstorm first** (when JIRA/SOW) or architect               | Brownfield A       | prd                                                                                                                                            |
| Add or enhance feature (arch exists) | orchestrator → **brainstorm first** (when JIRA/SOW) or prd or prototype / plan | Brownfield B       | When PRD skipped: no architect. When JIRA/SOW: brainstorm → prd → architect → prototype/plan. When full PRD: prd → architect → prototype/plan. |
| Add/enhance (JIRA/SOW)               | orchestrator → **brainstorm first** → prd → architect → prototype / plan       | Brownfield B       | Architect produces architecture impact; then prototype (UI) or plan.                                                                           |
| Product migration (legacy→new)       | orchestrator → **brainstorm first** (when JIRA/SOW) or architect               | Brownfield Migrate | architect → prototype (when UI) → plan; do not skip architect or prototype before plan                                                         |
| Fix bug                              | orchestrator → debug (diagnose only) or code (diagnose+fix)                    | Brownfield C       | All planning modes; if "bug" is enhancement → use add-feature/extend + PRD                                                                     |
| Refactor                             | orchestrator → qa                                                              | Brownfield D       | prd, architect, plan                                                                                                                           |

---

## Rules Reference

- `.nayan/rules-orchestrator/2_workflows_brownfield.xml` — Brownfield pipeline definitions (extend, add-feature, fix-bug, refactor, migrate)
- `.nayan/rules-orchestrator/1_workflow.md` — Entry mode selection, flow, and delegation
- `.nayan/guidance/use-case-coverage.md` — Use case inventory, edge cases, and classification guidance
- `.nayan/guidance/brownfield-use-cases.md` — Pre/post architecture diagrams, flow diagrams, and detailed explanations per brownfield type
- `.nayan/guidance/brownfield-migration-use-cases.md` — Product/feature migration use cases (data, API version, rollout, deprecation)
- `.nayan/guidance/plan-input-requirements.md` — PRD/scope readiness before architect (greenfield and brownfield A)
- `.nayan/guidance/sdlc-prerequisites.md` — Prerequisite validation and redirect rules for all SDLC modes
