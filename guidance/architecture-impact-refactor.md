# Architecture Impact: Refactor (Brownfield D)

Use when **refactoring** or improving code quality. Pre/post architecture diagrams are **optional but recommended** for structural refactors. Flow diagram is **required**.

**Pipeline:** `brownfield-refactor`. See `.nayan/rules-orchestrator/2_workflows_brownfield.xml`.

**Producer:** QA mode (refactor scope) → Code mode (applies refactor). Plan mode is skipped.

**When to use pre/post:** Structural refactor that changes module boundaries, dependencies, or data flow. Recommended for any refactor that moves code across components.

---

## DiagramSpec (from workflow)

| Diagram                         | Requirement  | When to Include                                         |
| ------------------------------- | ------------ | ------------------------------------------------------- |
| Pre-Architecture / Before State | **Optional** | Structural refactor; current module/component structure |
| Post-Architecture / After State | **Optional** | Structural refactor; target module/component structure  |
| Flow Diagrams                   | **Required** | Refactor scope: what moves, what changes, what stays    |

---

## Required Sections

### Create

| Nayan | User Name | Create Date |
| :----- | :-------- | :---------- |
|        |           |             |

### 1. Refactor Scope

- **What** is being refactored
- **Why:** Pain points, tech debt, quality goals

### 2. Pre-Architecture / Before State (optional but recommended)

When refactor changes boundaries, dependencies, or data flow:

- **C4 Container** or **module diagram** showing current structure
- Highlight: pain points, tight coupling, boundaries to change

### 3. Post-Architecture / After State (optional but recommended)

When refactor changes boundaries, dependencies, or data flow:

- **C4 Container** or **module diagram** showing target structure
- Highlight: new boundaries, reduced coupling, improved flow

### 4. Flow Diagram (Required)

- **Refactor scope diagram:** What moves, what changes, what stays
- Before/after data flow or call flow if applicable
- Mermaid format; validate before handoff

### 5. Backward Compatibility & Migration

- **Does refactor break** any APIs, contracts, or external integrations?
- **Migration path:** How to get from before to after
- **Risks:** Rollback approach

### 6. Verification Strategy

- **How to verify** refactor does not break existing functionality
- Tests, manual checks, regression scope

---

## Output Location

- **refactor-scope.md** (or equivalent) — QA mode produces; passed to code for implementation
- Not a separate architecture.md — this is an **architecture impact** subsection within the refactor scope
- **Optional:** Update existing architecture.md if refactor changes documented structure (handoff to architect for architecture update, or document delta in refactor-scope)

---

## References

- `.nayan/guidance/brownfield-use-cases.md` — Brownfield D diagram requirements
- `.nayan/rules-orchestrator/2_workflows_brownfield.xml` — diagramSpec: pre/post optional, flowDiagrams required
