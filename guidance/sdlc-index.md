# SDLC Guidance Index

Quick reference for SDLC pipelines, prerequisites, and human gates.

---

## Pipelines

| Command       | Pipeline                                                                                               | Config                       |
| ------------- | ------------------------------------------------------------------------------------------------------ | ---------------------------- |
| `/greenfield` | greenfield                                                                                             | `2_workflows_greenfield.xml` |
| `/brownfield` | brownfield-extend, brownfield-add-feature, brownfield-fix-bug, brownfield-refactor, brownfield-migrate | `2_workflows_brownfield.xml` |

**Entry points:** See `.nayan/guidance/pipeline-entry-points.md` for full flow details.

**Use case coverage:** See `.nayan/guidance/use-case-coverage.md` for use case inventory, edge cases, and classification.

---

## Prerequisites

**Validate before delegating.** Do not delegate until prerequisites are ready.

- **Condensed (in rules-orchestrator):** `3_sdlc_prerequisites.md` — validation table for orchestrator
- **Full reference:** `.nayan/guidance/sdlc-prerequisites.md` — complete prerequisite tables per mode

---

## Human-in-the-Loop (HITL) Gates

| Phase              | Gates                                                                                 |
| ------------------ | ------------------------------------------------------------------------------------- |
| **Planning**       | PRD sign-off, Architecture sign-off, UX prototype sign-off, Development plan sign-off |
| **Implementation** | Sprint task verification, Local testing consent                                       |
| **Quality**        | Code quality gate (MANDATORY), Security review (MANDATORY), PR per sprint             |
| **Deployment**     | Deployment plan sign-off, Pre-deploy approval, Cloud deploy                           |

**Full reference:** `.nayan/guidance/sdlc-human-gates.md`

**PRD sharing for sign-off:** When sharing PRD with another for approval — manual hand-off (share task, direct recipient to PRD approval) or Slack/Gmail integration. See `.nayan/guidance/prd-sharing-sign-off.md`.

**Approver Name:** When any sign-off requires Approver Name, use Nayan logged-in user from `environment_details` (section "Nayan Logged-in User"). See sdlc-human-gates.

**End interaction satisfaction check:** Before `attempt_completion`, call `ask_followup_question` with "Yes, satisfied" / "Not yet, I want more updates". See `.nayan/guidance/end-interaction-satisfaction-check.md`.

---

## Architecture & Development Plan

| Path           | Architecture                         | Development Plan                        |
| -------------- | ------------------------------------ | --------------------------------------- |
| **Greenfield** | architecture-greenfield-structure.md | development-plan-greenfield-template.md |
| **Brownfield** | architecture-brownfield-structure.md | development-plan-brownfield-template.md |

**Shared:** development-plan-sprint-format.md

---

## References

- `.nayan/guidance/pipeline-entry-points.md` — Entry points, full flows, tech stack
- `.nayan/guidance/sdlc-prerequisites.md` — Prerequisite validation
- `.nayan/guidance/sdlc-human-gates.md` — HITL gates
- `.nayan/guidance/brownfield-guide.md` — Brownfield use cases A/B/C/D
- `.nayan/guidance/architecture-document-structure.md` — Architecture format
- `.nayan/guidance/handoff-schema.md` — Handoff structure
