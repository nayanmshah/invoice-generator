# Architecture Impact: Add Feature (Brownfield B)

Use when **adding a feature** or **enhancing an existing feature** on an existing product. Architecture does **not** change by design; existing architecture.md is consumed and **architecture impact** (addendum or impact section) is produced by architect when PRD is used.

**Pipeline:** `brownfield-add-feature`. See `.nayan/rules-orchestrator/2_workflows_brownfield.xml`.

**When to use:** New feature or enhance existing feature within existing architecture. When PRD is used (including when user provides **JIRA ID**, **SOW**, or **PRD** for add/enhance): **architect** runs with refined-prd + existing architecture and produces architecture impact per this doc (addendum to architecture.md or impact section); then hands off to prototype/plan. **Add/enhance with PRD always uses architect.** Dev plan Section 1.1 summarizes existing; plan/prototype use architecture.md + architecture impact when PRD was used.

**When to reclassify:** If the feature changes system boundaries, adds new modules, or requires schema/API extension → use **brownfield-extend** and `architecture-brownfield-structure.md` instead.

---

## DiagramSpec (from workflow)

| Diagram           | Requirement                            | Location                                         |
| ----------------- | -------------------------------------- | ------------------------------------------------ |
| Pre-Architecture  | **Reference** existing architecture.md | Dev plan Section 1.1 summarizes; do not recreate |
| Post-Architecture | **N/A** — architecture unchanged       | —                                                |
| Flow Diagrams     | **Required** for each new user flow    | Dev plan; sequence or flowchart                  |

---

## Required: Development Plan Section 1.1 (Context & Existing Assets)

The development plan must include:

- **Tech stack:** Copy from existing architecture.md
- **Current modules:** Summary of existing modules and patterns
- **Integration points:** How the new feature connects to existing modules, APIs, data
- **Existing folder structure (Section 1.4):** **MANDATORY** — Analyze the current codebase (list_dir or equivalent). Document the existing folder structure. Section 2.6 folder structure changes must be derived from this analysis — show only new/changed dirs, aligned to existing conventions.

---

## Required: Flow Diagrams for New Flows

For each **new** user flow or feature path:

- **Sequence diagram** or **flowchart** showing the new feature end-to-end
- Include: actors, existing modules, new code paths, decision points
- Purpose: Show how the new feature fits into the existing system

---

## Optional: Impacted Integrations (when feature touches existing integrations)

When the new feature modifies or extends existing APIs or data flows:

| Integration    | Change         | Affected Consumers |
| -------------- | -------------- | ------------------ |
| [Existing API] | [What changes] | [Who is affected]  |

---

## References

- `.nayan/guidance/development-plan-brownfield-template.md` — Dev plan structure
- `.nayan/guidance/brownfield-use-cases.md` — Brownfield B diagram requirements
- `.nayan/rules-orchestrator/2_workflows_brownfield.xml` — diagramSpec: preArchitecture=reference, postArchitecture=null
