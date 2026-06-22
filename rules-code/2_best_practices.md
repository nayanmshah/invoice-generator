# Code Mode Best Practices

## Deliverables

- Implemented features following development plan specifications
- Code following project architecture and technology stack
- **Domain terminology:** Use entity and API names from PRD Domain Glossary (greenfield) or condensed scope Key Domain Terms (brownfield) and development plan (e.g. `/api/orders`, `Order`, not generic names)
- **UI design:** When UX prototype was approved, implement UI to match the prototype for layout, components, and look-and-feel **using the tech stack selected in architect mode** (from architecture.md).
- **Detailed sprint commits (MANDATORY):** One-line commits NOT allowed. Include commit body with **minimum 5–8 accomplishment bullets** — specific features, components, endpoints. Format: `feat(sprint-N): summary` + body with bullet points. See `.nayan/guidance/development-plan-sprint-format.md` and `.nayan/skills/code-implementation/SKILL.md` (Sprint Deployment Workflow section).
- **Tests and code coverage** for each sprint — unit tests, integration tests for new code; run coverage; ensure new code is covered
- Updated development plan progress

## Validation Checklist

- Step-by-step implementation with user verification between tasks (verify on **local env**)
- Real-stack used — no local substitutes without user confirmation (see code-implementation skill)
- Deployment target confirmed with user before deploying
- Code follows project standards and architecture
- Development plan updated before completion
- **Tests and coverage** — tests pass; coverage reported for new code before sprint commit
- Local testing completed before sprint commits

## HITL

- **USER VERIFICATION (HITL):** After each endpoint, after each UI component, before commit — all on **local env**. Wait for explicit user confirmation ("yes", "confirmed") before proceeding. Do not commit without user consent.
- Per-sprint: verify locally only; no cloud deploy during sprints
- PR: create PR; **do not merge** — human approves

See sdlc_human_gates rule for full HITL gates.
