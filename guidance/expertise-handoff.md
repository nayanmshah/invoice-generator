# Expertise Handoff

**Principle:** At any point in any mode, if the user or Nayan asks a question or makes a request that the current mode does not have expertise on, hand off to the appropriate mode. This applies to: (1) before delegating or loading skills (orchestrator), (2) when entering a mode, and (3) on every message/turn throughout the conversation. "Before skill load" is one application; the rule applies throughout the interaction. Do not attempt in-place or create a subtask. Hand off to the mode that has the expertise.

---

## 1. Orchestrator: Before Delegating

**Order of checks:** Out-of-scope → Handoff required → Delegate.

### Out-of-Scope

Before any delegation, check scope per `.nayan/guidance/out-of-scope-handling.md`.

- **Greetings** (Hi, Hello): Handle directly; greet warmly; redirect to /greenfield or /brownfield. Do NOT hand off. Do NOT load skills.
- **General non-product** (e.g. "How to make tea?"): Respond briefly; redirect. Do NOT create new_task.
- **Other out-of-scope** (poems, homework): Politely decline; redirect. Do NOT create new_task.

Only create new_task for in-scope requests (greenfield, brownfield, or software questions).

### Greenfield + Minimal Details

**Greenfield entry routing (avoid loading PRD when brainstorm needed):** If the user provides **minimal details** (one-line idea, vague concept, "I want to build X" without context), delegate to **brainstorm** — do NOT delegate to prd. PRD mode and its skills load only when prd runs; if you delegate to brainstorm first, prd never loads until brainstorm hands off.

**Delegate to prd only when:** The idea is already structured (problem statement, users, key capabilities) or when brainstorm has handed off with a structured concept.

### JIRA or SOW (instead of full PRD)

**Entry is brainstorm first:** When the user provides **JIRA ID or SOW** (and not a full PRD document), delegate to **brainstorm first** for greenfield and for brownfield pipelines: brownfield-extend, brownfield-add-feature, brownfield-migrate. Do NOT delegate directly to prd or architect. Brainstorm fetches context, presents it (Present-First), deeply understands requirements with the user (Q&A/brainstorm), then hands off to prd (greenfield or brownfield add-feature) or architect (brownfield extend, migrate). See `.nayan/guidance/context-input-handling.md` and `.nayan/guidance/pipeline-entry-points.md`.

| Input Type      | Example                                                                                                                                                 | Delegate To |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| Minimal         | "Create [product] for [domain]" (one-line, vague)                                                                                                       | brainstorm  |
| JIRA or SOW     | User shares PROJ-123 or SOW link (greenfield or brownfield extend/add-feature/migrate)                                                                  | brainstorm  |
| Structured      | "We need a marketplace. Buyers: restaurants. Sellers: farms. Problem: fragmented supply chain. Key capabilities: order placement, inventory, shipping." | prd         |
| From brainstorm | Brainstorm handoff with structured concept                                                                                                              |

### Missing Prerequisites

**Artifact validation:** Before delegating to any mode, verify that mode's prerequisites are present per `.nayan/guidance/sdlc-prerequisites.md` and sdlc_prerequisites rule. If missing: delegate to the mode that produces them; include instruction to hand off to intended mode when done.

**Input maturity (greenfield PRD only):** For PRD initial phase, user idea must be structured (problem statement, users, key capabilities) OR from brainstorm handoff. If minimal (one-line, vague): delegate to brainstorm first — do NOT delegate to prd.

---

## 2. Expertise Check (Any Mode, Any Point)

**On every message/turn:** When the user or Nayan (e.g., from a subtask, handoff message, or system context) asks a question or makes a request that the current mode does not have expertise on, hand off to the mode that can handle it. **CRITICAL: Run this check on EVERY message — including the second, third, and all subsequent messages.** Do not skip on follow-up turns. If you ran it once and passed, you must run it again on the next message.

### Rule

1. **On every message (including follow-ups):** Check if the question or request falls within this mode's expertise (per MODE RESTRICTION in customInstructions). Do not assume the check from the previous message still applies — the user may have changed the topic.
2. **If outside mode expertise:** Do NOT attempt in-place. Do NOT create a subtask for another mode's work. Use `new_task` to hand off to the mode that has the expertise (include skillHint per orchestrator Standalone Intent Routing). If unsure, hand off to orchestrator.
3. **Do not proceed** with prerequisite check or mode work until expertise check passes.

### Request Source

The question or request can come from:

- **User** — Direct message in the conversation
- **Nayan** — Subtask handoff message, system prompt, or internal question (e.g., from another mode or workflow step)

### Intent-to-Mode Mapping

Use for standalone intents when the user or Nayan asks something outside current mode expertise:

| User Intent                                   | Hand Off To | Skill Hint                   |
| --------------------------------------------- | ----------- | ---------------------------- |
| Fix GitHub issue                              | code        | issue-resolution-workflow    |
| Address PR feedback / fix PR                  | code        | pr-resolution-workflow       |
| Resolve merge conflicts                       | code        | nayan-conflict-resolution   |
| Create GitHub issue                           | code        | issue-creation-workflow      |
| Investigate GitHub issue                      | code        | issue-investigation-workflow |
| Extract docs from codebase                    | code        | docs-extraction-workflow     |
| Create/update documentation                   | code        | docs-creation-workflow       |
| Create or edit custom mode                    | code        | mode-creation-workflow       |
| Write/maintain tests                          | code        | vitest-testing               |
| Review pull request                           | qa          | pr-review-workflow           |
| Create PRD                                    | prd         | prd-creation                 |
| Create architecture                           | architect   | architect-planning           |
| Implement feature                             | code        | code-implementation          |
| Diagnose bug only (then hand off fix to Code) | debug       | systematic-debugging         |
| Fix bug (diagnose and fix in one flow)        | code        | systematic-debugging         |

**Phase distinction:** **Debug** = debug phase (diagnosis only). **Code** = code implementation phase (implements fix or features).

**Pipeline flow:** When user asks for implementation (e.g., "Implement the login page") while in prd or architect or plan, hand off per pipeline: prd → architect → (prototype when UI) → plan → code. If in prd and user asks for architecture, hand off to architect. If in architect and user asks for implementation (after architecture), hand off to prototype or plan per 4_handoff. If in plan and user asks for implementation, hand off to code.

### Examples by Current Mode

| Current Mode | User Request        | Hand Off To                              | Skill Hint                  |
| ------------ | ------------------- | ---------------------------------------- | --------------------------- |
| PRD          | Fix GitHub issue    | code                                     | issue-resolution-workflow   |
| PRD          | Create architecture | architect                                | architect-planning          |
| PRD          | Implement feature   | architect (pipeline: arch → plan → code) | (pipeline flow)             |
| Brainstorm   | Create PRD now      | prd                                      | prd-creation                |
| Plan         | Implement this      | code                                     | code-implementation         |
| Code         | Create PRD          | prd                                      | prd-creation                |
| Code         | Review architecture | architect                                | (or return to orchestrator) |
| QA           | Fix this bug        | code (or debug if diagnose-only desired) | systematic-debugging        |

---

## 3. Direct Mode Entry (Fallback)

When user enters a mode directly (e.g., selects PRD from mode selector):

- **All modes:** Run expertise check on every message (per step 0 in 1_workflow.md). If the user or Nayan asks something outside this mode's expertise, hand off per Expertise Check above. Do not proceed to prerequisite check or mode work.
- **PRD (when request is within PRD expertise):** Then run input maturity check. If minimal details, do NOT proceed. Switch to brainstorm via new_task. See `.nayan/rules-prd/1_workflow.md` and prd-creation skill "Minimal Input: Switch to Brainstorm Mode."
- **Other modes:** Verify prerequisites per sdlc_prerequisites; redirect if missing.

---

## References

- `.nayan/guidance/out-of-scope-handling.md` — Out-of-scope check
- `.nayan/guidance/sdlc-prerequisites.md` — Prerequisite validation
- `.nayan/rules/sdlc_prerequisites.xml` — Prerequisite rule
- `.nayan/rules/sdlc_human_gates.xml` — prerequisite_validation
- `.nayan/rules-orchestrator/1_workflow.md` — Standalone Intent Routing table
