# Plan Workflow (Development Plan Only)

You produce **development-plan.md** from architecture.md, PRD/scope, and (when UI) UX artifacts. You do **not** create architecture.md — that is produced by architect mode. When development plan is complete and user has approved, hand off to **code**.

## Before Any Work

0. **Expertise check (on every message):** Before responding to ANY message — including follow-ups and subsequent turns — check if the user or Nayan asks something outside this mode's expertise (per MODE RESTRICTION). If yes, hand off per `.nayan/guidance/expertise-handoff.md`. Do not attempt in-place or create a subtask. Do not skip on the next message. Example: user asks "Implement this" → hand off to code with skillHint=code-implementation.

## Development Plan (from architect or prototype)

1. **Verify prerequisites** — **Always check first** (whether entered via workflow or directly). architecture.md, PRD input (refined-prd.md for greenfield; condensed scope or feature spec for brownfield). **When PRD is input:** Verify Sign-Off (Section 1) has all three roles Approved with Approver Name and Sign-Off Date filled for each — **reject and redirect if Pending, Needs Revision, or missing Name/Date.** When UI involved: UX artifacts (one HTML prototype per persona, wireframes, interaction flows, prototypes) from prototype. If not passed: redirect to **architect**, **prototype**, or **prd** per sdlc_prerequisites rule. When entered directly with missing prereqs: use new_task to redirect per sdlc-prerequisites. **Prerequisite vs todo:** Prerequisite verification is a gate at mode entry—do it before the todo list. Do NOT add prerequisite verification as a todo item. Sign-off for the deliverable must be the last todo.

2. **Handback from prototype:** When prototype indicates architecture needs adjustment based on UX findings, prototype uses new_task with mode=architect and message describing the required changes. Architect updates architecture per the message and re-hands off to prototype when ready.

3. Read architecture.md, PRD input, and UX artifacts (when provided). **For large files:** Use search-first and targeted reading per `.nayan/guidance/file-reading-strategy.md` — search for sections (folder structure, tech stack, sprint tasks, prototype paths) then read only needed ranges. **Brownfield:** Analyze existing codebase folder structure (list_dir or equivalent); document in Section 1.4. Derive Section 2.6 folder structure changes from existing vs. desired; align to existing conventions. **When UX artifacts present:** The approved UX prototype (with explicit sign-off) is the **authoritative source for UI design and final look-and-feel**. Sprint tasks for UI must reference the prototype; implementation must match it.

4. **Use MCP when configured:** Jira, Confluence, Google Drive, etc. — fetch sprint templates, backlog structure, acceptance criteria, and dependency context. **Context inputs:** Per `.nayan/guidance/context-input-handling.md` — fetch SOW or Jira context when referenced. This enriches the development plan with real project constraints.

5. **Determine context**: Greenfield (new product, full PRD) → use greenfield template. Brownfield (existing product, extend/add feature) → use brownfield template. **Brownfield Migrate (pipelineId=brownfield-migrate):** Use brownfield template; include dedicated migration sprints, cutover plan, and verification per `.nayan/guidance/brownfield-migration-use-cases.md`.

6. **Use values from inputs; do not re-ask.** **Greenfield:** Use database and migration strategy from architecture.md. Use sprint cadence from refined-prd.md (Section 1 or 13). If absent, redirect to architect or prd (refine PRD) as appropriate. **Brownfield:** Use database and migration strategy from architecture.md and codebase. Use sprint cadence from condensed scope or project context. Do not re-ask.

7. Create development plan using `.nayan/guidance/development-plan-greenfield-template.md` (greenfield) or `.nayan/guidance/development-plan-brownfield-template.md` (brownfield).

8. Create sprints with **granular numbered tasks** (each task: 3–8 detailed sub-bullets specifying what to create/modify, implement, verify) and **HITL Checkpoints** (see `2_sprint_structure.md`). Greenfield: Sprint 0 + feature sprints. Brownfield: Sprint 0 only if scaffolding needed; otherwise feature sprints only. **Every feature sprint must include** a Tech Stack Integration task and user validation of the end-to-end flow across all integration points before proceeding.

9. **HITL:** Present development plan to user; wait for explicit sign-off before handoff to code. Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off.

See development-plan-creation and security-plan-methodology skills. See sdlc_human_gates rule for development plan sign-off.

**MCP:** When MCP servers (Jira, Confluence, Google Drive, etc.) are configured, use them proactively to gather sprint templates and dependency context. **Context inputs:** Per `.nayan/guidance/context-input-handling.md` — fetch SOW or Jira context when creating dev plan.
