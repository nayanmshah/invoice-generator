# Architecture Impact: Fix Bug (Brownfield C)

Use when **fixing a reported bug** that spans multiple components or changes component interaction. Pre/post architecture diagrams are **optional** per workflow; use this template when the bug warrants them.

**Pipeline:** `brownfield-fix-bug`. See `.nayan/rules-orchestrator/2_workflows_brownfield.xml`.

**Producer:** Code mode (as part of bug diagnosis/fix) or embedded in bug-fix-scope. Plan mode is skipped.

**When to use pre/post:** Bug spans multiple components; fix changes component interaction or data flow. For simple one-line fixes, omit.

---

## DiagramSpec (from workflow)

| Diagram                       | Requirement  | When to Include                                                        |
| ----------------------------- | ------------ | ---------------------------------------------------------------------- |
| Pre-Architecture / Pre-Flow   | **Optional** | Bug spans multiple components; diagram clarifies current (buggy) flow  |
| Post-Architecture / Post-Flow | **Optional** | Fix changes component interaction; diagram shows corrected flow        |
| Flow Diagrams                 | **Optional** | Required when multi-step or cross-component; optional for simple fixes |

---

## Required Sections (when pre/post used)

### Create

| Nayan | User Name | Create Date |
| :----- | :-------- | :---------- |
|        |           |             |

### 1. Bug Description

- **What fails:** Symptom, error, incorrect behavior
- **Where:** Component(s), API(s), data flow
- **Conditions:** When does it occur (inputs, state, timing)

### 2. Pre-Architecture / Pre-Flow Diagram (optional)

When bug spans multiple components:

- **C4 Container** or **sequence diagram** showing current (buggy) flow
- Highlight: where the bug occurs, incorrect data path, missing validation
- Mermaid format; validate before handoff

### 3. Root Cause

- **Why** the bug occurs
- Traceability to code/module

### 4. Fix Approach

- **What changes:** Code, config, data flow
- **Why this approach:** Alternative considered, trade-offs

### 5. Post-Architecture / Post-Flow Diagram (optional)

When fix changes component interaction:

- **C4 Container** or **sequence diagram** showing corrected flow after fix
- Highlight: what changed, new validation, corrected path

### 6. Regression Risk & Verification

- **What other areas** might this fix affect?
- **Verification scope:** Unit, integration, E2E
- **How to confirm** the fix

---

## Output Location

- **bug-fix-scope.md** (or equivalent) — Code mode produces; passed to qa for quality gate
- Not a separate architecture.md — this is an **architecture impact** subsection within the fix scope

---

## References

- `.nayan/guidance/brownfield-use-cases.md` — Brownfield C diagram requirements
- `.nayan/rules-orchestrator/2_workflows_brownfield.xml` — diagramSpec: pre/post optional, flowDiagrams optional
- `.nayan/skills/systematic-debugging/SKILL.md` — Bug diagnosis workflow
