# Systematic Debugging Workflow

**Debug = debug phase.** This mode diagnoses only; it does not implement fixes. **Code = code implementation phase** (implements fix from debug handoff or from development plan).

## When Debug mode is used

1. **Verify prerequisites** — Bug report or description and codebase access. If not: ask user. **When user provides a JIRA ticket:** If it is a **bug** (fix-bug pipeline), use it as the bug report; fetch Jira context per `.nayan/guidance/context-input-handling.md` (Present-First: show full summary to user, then proceed). If the ticket describes an **enhancement or new feature** (not a defect), hand off to **orchestrator** so the request can be classified as add-feature or extend — JIRA/SOW for requirements uses brainstorm first per pipeline.
2. **Diagnose** — Use systematic-debugging skill: multi-source analysis, hypothesis distillation, log-based validation. See `.nayan/skills/systematic-debugging/SKILL.md`.
3. **HITL:** Present full diagnosis to user (user must SEE the full content first). Ask: "Do you confirm this diagnosis?"
4. **If code change is required:** Write clear fix instructions (steps, files, changes) and hand off to **Code mode** via `new_task`. Do NOT apply code fixes yourself. Message must include: diagnosis summary + step-by-step fix instructions so Code can implement without re-diagnosing.
5. **If no code change** (e.g. config-only, user will fix manually): Complete and summarize.

**Output:** Diagnosis summary; when fix needed, handoff to Code with instructions (see `4_handoff.md`).

---

## When code mode is invoked for brownfield-fix-bug (Code Implementation Phase)

When **code mode** is invoked for **brownfield-fix-bug** pipeline: **code = code implementation phase.** Either (1) implement the fix from debug handoff (diagnosis + fix instructions), or (2) diagnose and fix in one flow using systematic-debugging skill. Code mode handles both diagnosis and fix when entry.

## Prerequisites

- Bug report or description
- Codebase access

(Orchestrator validates before delegating; if missing, ask user.)

**Direct mode entry:** When code mode is entered directly for fix-bug, if bug report or codebase missing: ask user. No redirect (fix-bug entry).

## Workflow

1. **Verify prerequisites** — Bug report and codebase present. If not: ask user.
2. **Diagnose** — Use systematic-debugging skill: multi-source analysis, hypothesis distillation, log-based validation.
3. **HITL:** Present diagnosis to user. Ask: "Confirm diagnosis before applying fix." **Wait for explicit approval** before proceeding. See sdlc_human_gates rule.
4. **Fix:**
    - **Simple fix:** Apply fix; verify; hand off to qa.
    - **Complex fix:** Apply fix (may span multiple files); hand off to qa.
5. **When pipeline includes diagramSpec** (from orchestrator new_task): If bug spans multiple components or fix is multi-step, produce flow diagram (bug path + fix path) per brownfield-fix-bug diagramSpec.

## Output

- Diagnosis summary
- Fix (if simple) or handoff context for code (if complex)
- Flow diagram (when multi-step, per diagramSpec)

## Handoff

Code mode (when doing fix-bug) hands off to qa per `2_workflows_brownfield.xml`. Quality gates (qa, secure) are mandatory.

See `.nayan/skills/systematic-debugging/SKILL.md` for full methodology.
