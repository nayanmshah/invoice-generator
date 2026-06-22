# SDLC Mode Prerequisites

**Prerequisite validation happens before a mode loads** — at delegation time, not after the mode has started. The delegator (orchestrator or handing-off mode) validates that the next mode's prerequisites are present before calling `new_task`. If missing, delegate to the mode that produces them instead.

---

## Validation Rule (Before Mode Loads)

1. **Before delegating** to mode X: Check mode X's prerequisites per the table below.
2. **If missing:** Do NOT delegate to mode X. Delegate to the mode that produces the missing artifact instead. Include instruction to hand off to mode X when done.
3. **If present:** Delegate to mode X with all required artifacts in the message.

**Why before mode loads:** Skills and mode logic load when the mode is activated. Prerequisite validation must run before that — so the mode only ever receives tasks when its inputs are ready.

---

## Direct Mode Entry (User Bypasses Workflow)

When a user enters any mode directly (not via orchestrator or handoff — e.g., selects Code or Plan from the mode selector), the mode is responsible for **self-validation**.

1. **Expertise check (on every message, mandatory):** Run expertise check per `.nayan/guidance/expertise-handoff.md`. If the user or Nayan asks something outside this mode's expertise, hand off to the mode that can handle it. Do not proceed to prerequisite check or mode work.
2. **Prerequisite check:** Check this mode's prerequisites per the table below.
3. **If missing:** Do NOT proceed. Use `new_task` to redirect to the mode that produces the missing artifact. Use the redirect message template (see Redirect Instruction Template below).
4. **If present:** Proceed with mode work.

**Entry modes (brainstorm, prd initial, code fix-bug, qa refactor):** Minimal prerequisites; ask user if missing. No redirect needed for entry modes when user provides the request.

**Explicit UI change:** When the user explicitly requests a change in UI (redesign, new look-and-feel, new design system, component/layout changes), do not satisfy with in-mode work alone. Redirect so **prototype (create/update) → plan (create/update)** run first; **include architect** only when there is API or architecture impact. See `.nayan/guidance/pipeline-entry-points.md` (Explicit UI change requests).

---

## Prerequisites by Mode

### brainstorm

| Prerequisite                              | Required | If Missing                                                   |
| ----------------------------------------- | -------- | ------------------------------------------------------------ |
| User idea or draft (greenfield)           | Yes      | Entry mode; ask user for product idea                        |
| Question or exploration goal (brownfield) | Yes      | Entry mode; ask user what they want to explore or understand |
| brainstorm output                         | No       | Can create from user input                                   |

---

### prd

| Prerequisite                                                         | Required         | If Missing                                                                                                                                                                                                                                                                                         |
| -------------------------------------------------------------------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| User idea or draft (initial phase)                                   | Yes              | Entry mode; ask user                                                                                                                                                                                                                                                                               |
| User idea structured (greenfield initial) OR from brainstorm handoff | Yes (greenfield) | If minimal (one-line, vague): delegate to brainstorm first. When user provides JIRA or SOW (instead of full PRD): orchestrator delegates to brainstorm first; do not delegate to prd until brainstorm has handed off. See `.nayan/guidance/expertise-handoff.md` and `context-input-handling.md`. |
| initial-prd.md (refinement phase)                                    | Yes              | From prd initial phase                                                                                                                                                                                                                                                                             |

---

### architect (architecture phase)

| Prerequisite                              | Greenfield | Brownfield A | Brownfield Migrate | Brownfield B (add-feature with PRD) | If Missing                                                                                                                            |
| ----------------------------------------- | ---------- | ------------ | ------------------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| refined-prd.md with Sign-Off Approved     | Yes        | No           | No                 | Yes                                 | Redirect to **prd**; **reject if Sign-Off is Pending or Needs Revision**                                                              |
| condensed scope / migration brief         | No         | Yes          | Yes                | No                                  | Ask user; or redirect to **orchestrator**. When user provided JIRA/SOW: scope from **brainstorm** handoff (aligned scope in message). |
| existing architecture.md / legacy context | No         | Yes          | Yes                | Yes                                 | Ask user for path or legacy system context; cannot extend/impact without it                                                           |
| codebase access                           | No         | Yes          | Yes                | Yes                                 | Ask user for repo path                                                                                                                |

See `.nayan/guidance/plan-input-requirements.md` for full input requirements.

---

### plan (dev-plan phase)

| Prerequisite                                               | Greenfield     | Brownfield A/B/Migrate | If Missing                                                               |
| ---------------------------------------------------------- | -------------- | ---------------------- | ------------------------------------------------------------------------ |
| architecture.md                                            | Yes            | Yes                    | Redirect to **architect**                                                |
| refined-prd.md with Sign-Off Approved                      | Yes            | No                     | Redirect to **prd**; **reject if Sign-Off is Pending or Needs Revision** |
| condensed scope / feature spec / migration brief           | No             | Yes                    | Ask user; or redirect to **orchestrator**                                |
| UX artifacts (when UI involved): one prototype per persona | From prototype | From prototype         | Redirect to **prototype**                                                |
| CONTEXT (greenfield\|brownfield)                           | Yes            | Yes                    | Infer from inputs or ask user                                            |

**Redirect order:** If both architecture.md and refined-prd missing (greenfield) → redirect to **prd** first. If only architecture.md missing → redirect to **architect**. When UI involved and UX artifacts missing → redirect to **prototype**.

**Explicit UI change:** If the user explicitly requests a UI change (redesign, new look-and-feel, new design system), ensure prototype (create/update) → plan (create/update) run first; include architect only when there is API or architecture impact. Redirect to **prototype** or **architect** as needed. See pipeline-entry-points.md (Explicit UI change requests).

---

### prototype

| Prerequisite                                                | Required | If Missing                      |
| ----------------------------------------------------------- | -------- | ------------------------------- |
| architecture.md                                             | Yes      | Redirect to **architect**       |
| refined-prd.md (greenfield) or condensed scope (brownfield) | Yes      | Redirect to **prd** or ask user |
| CONTEXT (greenfield\|brownfield)                            | Yes      | Infer from inputs or ask user   |

**When to use:** Only when the solution involves UI. Architect delegates to prototype when UI is involved; otherwise to plan (dev-plan phase).

---

### code

| Prerequisite        | Required | If Missing                |
| ------------------- | -------- | ------------------------- |
| development-plan.md | Yes      | Redirect to **plan**      |
| architecture.md     | Yes      | Redirect to **architect** |

**Brownfield-fix-bug:** When pipeline is brownfield-fix-bug, bug-fix-scope from code (bug description, root cause, fix approach, files to modify) satisfies the development-plan prerequisite. Use existing architecture.md if available.

**Explicit UI change:** If the user requests a UI change (redesign, new look-and-feel, new components), redirect so prototype → plan (and architect when API/architecture impact) run first; then code implements to the updated plan and prototype. See pipeline-entry-points.md (Explicit UI change requests).

---

### qa

| Prerequisite                                             | Required | If Missing                       |
| -------------------------------------------------------- | -------- | -------------------------------- |
| development-plan.md (or bug-fix-scope or refactor-scope) | Yes      | Redirect to **plan** or **code** |
| Codebase (implemented code)                              | Yes      | Redirect to **code**             |

**Brownfield-fix-bug:** bug-fix-scope from code satisfies the plan prerequisite. For simple fixes, qa may skip plan/execution phases and go directly to quality gate phase.

**Brownfield-refactor:** refactor-scope from qa (refactor plan: what moves, what changes, before/after state, verification strategy) satisfies the plan prerequisite.

**Note:** QA runs phases: code review (first pass), QA plan creation, QA execution, code quality gate, code review (second pass). tester and sdet are methodologies within qa-planning skill.

---

### secure

| Prerequisite                                                  | Required | If Missing                           |
| ------------------------------------------------------------- | -------- | ------------------------------------ |
| development-plan.md (or bug-fix-scope for brownfield-fix-bug) | Yes      | Redirect to **plan** or **code**     |
| Codebase                                                      | Yes      | Redirect to **code**                 |
| Code quality gate passed                                      | Yes      | Redirect to **qa** — **do not skip** |

**Brownfield:** VERACODE_API_ID, VERACODE_API_KEY, Java 11+ required. See `.nayan/guidance/code-quality-security-gates.md`. **This mode cannot be skipped.**

---

### deploy

| Prerequisite                                                  | Required                              | If Missing                                                                                                             |
| ------------------------------------------------------------- | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| architecture.md                                               | Yes (optional for brownfield-fix-bug) | Redirect to **architect**; for brownfield-fix-bug use existing from project or proceed with codebase + security-review |
| Codebase                                                      | Yes                                   | Redirect to **code**                                                                                                   |
| security-review.md                                            | Yes                                   | Redirect to **secure** — **do not skip**                                                                               |
| code-review.md                                                | Yes                                   | Redirect to **qa** — **do not skip**                                                                                   |
| All sprints finished (or fix complete for brownfield-fix-bug) | Yes                                   | Do not proceed; inform user to complete code first                                                                     |
| Deployment target                                             | Yes                                   | Ask user before proceeding                                                                                             |

**Note:** Brownfield-fix-bug: no development-plan/sprints; fix completion from code mode is sufficient.

---

### code (Brownfield C – fix-bug entry)

| Prerequisite             | Required | If Missing             |
| ------------------------ | -------- | ---------------------- |
| Bug report / description | Yes      | Ask user               |
| Codebase access          | Yes      | Ask user for repo path |

**Note:** Brownfield-fix-bug enters at code mode; uses systematic-debugging skill.

---

### qa (Brownfield D – refactor entry)

| Prerequisite               | Required | If Missing             |
| -------------------------- | -------- | ---------------------- |
| Refactor request from user | Yes      | Ask user               |
| Codebase access            | Yes      | Ask user for repo path |

**Note:** QA produces refactor-scope when entry; no development-plan or refactor-scope required as input.

---

## Who Validates (Delegator, Not Receiver)

| Delegator    | Validates Before Delegating To                   | Check                                                                                    |
| ------------ | ------------------------------------------------ | ---------------------------------------------------------------------------------------- |
| Orchestrator | prd, architect, plan, prototype, debug, code, qa | Entry-mode prerequisites                                                                 |
| Orchestrator | deploy (fix-bug, when user confirms deployment)  | secure passed, code-review.md, architecture.md (from project), user confirmed deployment |
| prd          | architect                                        | refined-prd.md ready                                                                     |
| architect    | prototype or plan (dev-plan)                     | architecture.md, PRD/scope in message (prototype when UI; plan dev-plan when API-only)   |
| prototype    | plan                                             | architecture.md, PRD/scope, UX artifacts in message                                      |
| debug        | code                                             | diagnosis + fix instructions in message (debug phase → code implementation phase)        |
| plan         | code                                             | development-plan.md, architecture.md in message                                          |
| code         | qa                                               | development-plan.md, codebase in message                                                 |
| qa           | secure                                           | development-plan.md, codebase, code-review.md in message                                 |
| secure       | deploy                                           | architecture.md, codebase, security-review.md, code-review.md in message                 |
| deploy       | orchestrator                                     | attempt_completion when deployment complete                                              |

---

## Redirect Instruction Template

When redirecting, use `new_task` with a message like:

```
Prerequisites for [current-mode] are missing. Redirecting to [producing-mode] first.

Missing: [list artifacts]

[Producing-mode], please produce [artifact(s)]. When complete and user has approved, hand off to [current-mode] with context: [brief context].

Original request: [user's original request]
```

---

## References

- `.nayan/guidance/expertise-handoff.md` — Expertise handoff; check before loading skills; expertise check on every message (any mode, any point); scope input maturity (greenfield)
- `.nayan/guidance/sdlc-human-gates.md` — HITL gates
- `.nayan/guidance/plan-input-requirements.md` — Plan input readiness
- `.nayan/guidance/handoff-schema.md` — Handoff structure
- `.nayan/rules-orchestrator/3_sdlc_prerequisites.md` — Condensed reference for orchestrator
