# Handoff Schema for Pipeline Modes

Each pipeline mode must include `4_handoff.xml` or `4_handoff.md` in `.nayan/rules-{mode}/` with the following structure.

## XML Format (4_handoff.xml)

```xml
<handoff>
  <output_file>architecture.md</output_file>
  <next_mode>plan</next_mode>
  <handoff_instruction>
    When architecture is complete and user has approved, use new_task with mode=plan and message including:
    - PRD_FILE: refined-prd.md
    - ARCHITECTURE_FILE: architecture.md
    - Instruction to synthesize both into development-plan.md
  </handoff_instruction>
</handoff>
```

## Markdown Format (4_handoff.md)

```markdown
## Handoff

- **Output file:** architecture.md
- **Next mode:** plan
- **Instruction:** When architecture is complete and user has approved, use new_task with mode=plan and message including PRD_FILE, ARCHITECTURE_FILE, and instruction to synthesize both into development-plan.md.
```

## Required Fields

| Field                 | Description                                                                                          |
| --------------------- | ---------------------------------------------------------------------------------------------------- |
| `output_file`         | Primary deliverable this mode produces (e.g., refined-prd.md, architecture.md, development-plan.md)  |
| `next_mode`           | Slug of the mode to hand off to (e.g., plan, prototype, code, qa, secure, deploy)                    |
| `handoff_instruction` | What to include in the new_task/switch_mode message: file paths, context, instructions for next mode |

## Mode Switching: new_task vs attempt_completion

**Rule:** To hand off to the next mode, use **new_task**. To return to the orchestrator at pipeline end, use **attempt_completion**.

| When                                                               | Use                |
| ------------------------------------------------------------------ | ------------------ |
| Hand off to next mode (code→qa, qa→secure, secure→deploy)          | new_task           |
| Return to orchestrator (deploy done; secure in brownfield-fix-bug) | attempt_completion |

**Do not use attempt_completion for mode switching** — it ends the task and blocks auto-transition. Only Deploy and Secure (brownfield-fix-bug) use attempt_completion.

**Strict handoff (code change):** When the pipeline includes a code change (greenfield or brownfield), the sequence Code → QA → Secure is mandatory. Do not skip QA or hand off from Code directly to deploy. Do not skip Secure or hand off from QA directly to deploy. See `.nayan/guidance/code-quality-security-gates.md`.

**Examples:** new_task: brainstorm→prd, prd→architect, architect→prototype or plan, plan→code, debug→code (fix-bug), code→qa, qa→secure, secure→deploy. attempt_completion: deploy→orchestrator; secure→orchestrator (brownfield-fix-bug only).

**Explicit UI change:** When the user explicitly requests a change in UI (redesign, look-and-feel, design system, components), prototype → plan must run (create/update) first before code; include architect (create/update) only when there is API or architecture impact. Do not hand off to code for UI implementation until prototype and plan (and architect when applicable) are ready. See `.nayan/guidance/pipeline-entry-points.md` (Explicit UI change requests).

**Exception:** End-interaction-satisfaction-check uses new_task for handoff. See `.nayan/guidance/end-interaction-satisfaction-check.md`.

## HITL Requirement

Handoff rules must state: **Wait for user approval before calling new_task.** Do not hand off until the user has signed off on the deliverable.

**Sign-off applies to both:** Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off. For greenfield/brownfield, most steps use **new_task** (handoff); only pipeline-end steps (e.g., deploy) use attempt_completion.

## Manual Hand-Off: PRD Sharing for Sign-Off

When one user shares a refined PRD with another for approval (e.g., PM → Engineering Lead, Design):

- **Manual hand-off:** Share the task; direct the recipient to open the shared link and navigate to the PRD approval process. The shared view should offer "Approve PRD" / "Complete Sign-Off" to guide the recipient.
- **Slack/Gmail integration:** When configured, send refined PRD via Slack or email for approval. See `.nayan/guidance/prd-sharing-sign-off.md`.

## JIRA/SOW entry: orchestrator → brainstorm

When the user provides **JIRA ID or SOW** (instead of a full PRD), orchestrator delegates to **brainstorm first** for greenfield and for brownfield (extend, add-feature, migrate). The **new_task to brainstorm** must include **pipelineId** (greenfield | brownfield-extend | brownfield-add-feature | brownfield-migrate) and context/scope so brainstorm can (1) fetch and present JIRA/SOW context, (2) deeply understand requirements with the user (Q&A/brainstorm), and (3) hand off to the correct next mode (prd or architect) with the right pipelineId and aligned scope. See `.nayan/guidance/context-input-handling.md` and `.nayan/guidance/pipeline-entry-points.md`.

---

## Prerequisite Validation (Before Delegating)

**Before calling `new_task`** to hand off to the next mode, the delegating mode must validate that the next mode's prerequisites are present per sdlc_prerequisites rule. Validation happens **before the next mode loads** — at delegation time.

1. Check the next mode's prerequisites
2. If missing: Do NOT delegate to the next mode. Delegate to the mode that produces the missing artifact instead
3. If present: Include all required artifacts in the new_task message

Example: Architect handing off to prototype or plan (dev-plan), Plan handing off to code, or **Debug (debug phase) handing off to Code (code implementation phase)** — verify required artifacts (architecture.md and PRD/scope, or diagnosis + fix instructions) are ready and included in the message. If not, do not hand off.

## Pipeline Modes Requiring 4_handoff

- orchestrator
- brainstorm
- prd
- architect
- plan
- prototype
- debug (debug phase; hands off to code for fix-bug)
- code
- qa
- secure
- deploy

## Example: rules-architect/4_handoff.xml (architect → prototype or plan); rules-plan/4_handoff.xml (plan → code)

```xml
<handoff>
  <output_file>architecture.md</output_file>
  <next_mode>prototype</next_mode>
  <handoff_instruction>
    When architecture is complete and user has approved (when UI), use new_task with mode=prototype. When API-only, hand off to plan (dev-plan phase) or code.
  </handoff_instruction>
</handoff>
```
