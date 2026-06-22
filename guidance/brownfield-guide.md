# Brownfield Guide

Single reference for brownfield pipelines (extend, add feature, fix bug, refactor, migrate). Use cases A/B/C/D and Migrate, diagram requirements, migration use cases, and condensed scope.

---

## Use Cases A/B/C/D and Migrate

| Type                                       | Pipeline               | Entry Mode                                          | When                                                                                                                                                                                                                |
| ------------------------------------------ | ---------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **A** Extend product                       | brownfield-extend      | architect                                           | Add significant feature; architecture may need extension                                                                                                                                                            |
| **Migrate** Product migration (legacy→new) | brownfield-migrate     | architect                                           | Legacy→new; architect then prototype (when UI) then plan (migration plan). Do not skip architect or prototype before plan.                                                                                          |
| **B** Add or enhance feature               | brownfield-add-feature | brainstorm (when JIRA/SOW) or prd or prototype/plan | When JIRA/SOW: brainstorm first (deep understanding with user) → prd → architect → prototype/plan. When full PRD or substantial: prd → architect → prototype (UI) or plan (API). Else prototype (UI) or plan (API). |
| **C** Fix bug                              | brownfield-fix-bug     | debug or code                                       | True bug = fix to match spec. If "bug" is an enhancement → use add-feature or extend + PRD. Debug = diagnose only; code = diagnose+fix.                                                                             |
| **D** Refactor                             | brownfield-refactor    | qa                                                  | Refactor or improve code quality                                                                                                                                                                                    |

---

## Diagram Requirements

| Brownfield        | Pre-Architecture        | Post-Architecture                      | Flow Diagrams                 |
| ----------------- | ----------------------- | -------------------------------------- | ----------------------------- |
| **A** Extend      | Required                | Required (incl. Impacted Integrations) | Required                      |
| **Migrate**       | Required (legacy state) | Required (target; migration path)      | Required (migration, cutover) |
| **B** Add feature | Reference (Section 1.1) | N/A                                    | Required for new flows        |
| **C** Fix bug     | Optional                | Optional                               | Required if multi-step        |
| **D** Refactor    | Optional                | Optional                               | Required                      |

**Brownfield A Impacted Integrations:** Post-architecture diagram must include Impacted Integrations subsection: which existing integrations are affected; impact chain; downstream consumers.

---

## Detailed Explanation Requirements

| Type  | Required Explanations                                                                                                                                                                                 |
| ----- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **A** | **Analyze existing architecture:** Align to existing when request fits; propose changes when required. Scope of Change; Integration Points; Impacted Integrations; Migration Path; Traceability       |
| **B** | Context & Existing Assets; **Existing Folder Structure (analyze codebase)**; Scope of Change; Integration Points; Impacted Integrations; Folder Structure Changes (derived from existing vs. desired) |
| **C** | Bug Description; Root Cause; Fix Approach; Regression Risk; Verification                                                                                                                              |
| **D** | Refactor Scope; Before/After State; Backward Compatibility; Migration Path; Verification Strategy                                                                                                     |

---

## Migration Use Cases

When extending or changing existing products, document migration in architecture or development plan:

| Use Case                       | When                                       | Where Documented                                     |
| ------------------------------ | ------------------------------------------ | ---------------------------------------------------- |
| **Data Migration**             | Schema changes; existing data must move    | architecture.md Section 4c; development-plan sprints |
| **API Version Migration**      | Deprecating or replacing API versions      | architecture.md API Strategy; development-plan       |
| **Feature Rollout**            | Gradual rollout; A/B testing               | architecture.md or development-plan                  |
| **Feature Deprecation**        | Removing or replacing a feature            | architecture.md; development-plan                    |
| **Product Migration**          | Migrating from legacy to new system        | architecture.md; development-plan                    |
| **Module/Component Migration** | Moving code between modules (Brownfield D) | qa output; development-plan if large                 |

**Brownfield Migrate:** Use pipeline brownfield-migrate. Architect → prototype (when UI) → plan. architecture.md + development-plan (migration sprints, cutover).
**Brownfield A:** Data migration (4c), API version impact, Impacted integrations (11a). Feature rollout/deprecation if scope includes it.
**Brownfield B:** Development-plan — Schema changes & migration (2.2) when applicable. Feature rollout if using flags.
**Brownfield D:** qa — Migration path in refactor plan.

---

## Condensed Scope Template (Brownfield A)

When delegating to architect for Brownfield A, provide condensed scope with:

- Feature/Extension Summary (what, why, scope)
- Key Domain Terms
- Functional Scope
- Integration Points & Impacted Integrations
- Out of Scope

**Full template:** `.nayan/guidance/condensed-scope-template.md`

---

## References

- `.nayan/guidance/architecture-brownfield-structure.md` — Brownfield architecture sections
- `.nayan/guidance/development-plan-brownfield-template.md` — Brownfield development plan
- `.nayan/guidance/brownfield-use-cases.md` — Full diagram and explanation details
- `.nayan/guidance/brownfield-migration-use-cases.md` — Full migration use cases
- `.nayan/rules-orchestrator/2_workflows_brownfield.xml` — Pipeline definitions
