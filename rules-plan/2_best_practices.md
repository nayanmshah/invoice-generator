# Plan Best Practices (Development Plan Only)

**Scope:** Development plan (development-plan.md) only. You consume architecture.md; you do not create it. Architecture is produced by architect mode.

## Deliverable

- development-plan.md with sprints per `development-plan-greenfield-template.md` or `development-plan-brownfield-template.md`
- Folder structure (from tech stack in architecture.md), sprint tasks, run commands, deployment section
- **Tech stack:** Use exactly what is documented in architecture.md. Do not re-define or override. See `.nayan/rules-architect/2_tech_stacks.md` for reference (architect documents; you consume).
- Plans are specific, actionable, and in logical order
- Each sprint: granular numbered tasks (3–8 sub-bullets per task), HITL checkpoints, verification criteria

## Validation

- Folder structure matches tech stack and pattern from architecture.md (Monolith vs Decoupled)
- Every feature sprint includes Tech Stack Integration task and user validation of end-to-end flow
- User-provided inputs (repo URL(s), DB URL, API keys, env vars) collected at sign-off and passed to Code

## HITL: Development Plan Sign-Off

**Before handoff to code:** Present development plan to user; wait for explicit sign-off. Collect user-provided inputs (repo URL(s), DB URL, API keys, env vars) at sign-off. Do not mark Approved or hand off (new_task) until user has given explicit sign-off.

See sdlc_human_gates rule for Development plan sign-off gate.
