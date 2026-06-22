# Architecture Document Structure

Architecture uses **separate structures per use case** (SRP), like development plans. Architecture is produced by **architect mode** and consumes **PRD** (greenfield) or **condensed scope** (brownfield) as input.

**PRD source:** Greenfield uses `refined-prd.md` produced by PRD mode per `.nayan/skills/prd-creation/SKILL.md` and `.nayan/skills/prd-standards/SKILL.md`. PRD follows `.nayan/guidance/prd-template-v2.md` (15 sections). Handoff: `.nayan/rules-prd/4_handoff.xml` → architect with PRD_FILE.

**Orchestrator flows:** `.nayan/rules-orchestrator/2_workflows_greenfield.xml` (greenfield) | `.nayan/rules-orchestrator/2_workflows_brownfield.xml` (brownfield-extend | add-feature | fix-bug | refactor | migrate).

## Structure Selection

| Use Case                       | Structure                                                                      | Pre/Post                | Producer             | When                                                           |
| ------------------------------ | ------------------------------------------------------------------------------ | ----------------------- | -------------------- | -------------------------------------------------------------- |
| **Greenfield**                 | [architecture-greenfield-structure.md](./architecture-greenfield-structure.md) | Pre N/A; post required  | architect            | New product from scratch                                       |
| **Brownfield A (extend)**      | [architecture-brownfield-structure.md](./architecture-brownfield-structure.md) | Pre + Post required     | architect            | Extend existing product; new modules, schema, APIs             |
| **Brownfield B (add-feature)** | [architecture-impact-add-feature.md](./architecture-impact-add-feature.md)     | Pre=reference; Post=N/A | plan (dev-plan)      | Add feature; architecture unchanged; flow diagrams in dev plan |
| **Brownfield C (fix-bug)**     | [architecture-impact-fix-bug.md](./architecture-impact-fix-bug.md)             | Pre + Post optional     | code (bug-fix-scope) | Fix bug; pre/post when multi-component or flow change          |
| **Brownfield D (refactor)**    | [architecture-impact-refactor.md](./architecture-impact-refactor.md)           | Pre + Post optional     | qa (refactor-scope)  | Refactor; pre/post recommended for structural changes          |

**Reclassify:** When add-feature changes system boundaries or requires new modules/schema → use brownfield-extend and architecture-brownfield-structure.md.

## Shared (Both Paths)

- **Document Header:** Title + **Create** (Nayan, User Name, Create Date — two create names) + Introduction (2–3 sentences) for stakeholder orientation
- **PRD/Scope Traceability:** Architect must map product needs to architectural decisions. Greenfield: PRD-to-Architecture table. Brownfield: Scope-to-Architecture table.
- **Product-Need Sections:** Conditional sections: Algorithm (when calculation logic), Data Retention (when PRD specifies), Per-Integration Contract (when external APIs), Open Questions Resolution, Constraints Mapping.
- **Domain Glossary:** Use PRD Section 15 (Appendix) for module/entity naming
- **NFRs/Security:** Consider PRD Section 11 (Non-Functional Expectations) when designing
- **HITL:** Tech stack (greenfield only), pattern, modules, final sign-off
- **Validation:** Mermaid validated; **architecture gap validation** (`.nayan/guidance/architecture-gap-validation.md`) run before handoff; use case/scope coverage verified
- **Diagrams:** C4Context, C4Container, C4Component; data flow or sequence
- **Common Gaps:** Each structure includes a "Common Gaps to Avoid" section—review before handoff

## Quick Reference

- **Greenfield:** Full architecture—tech stack, pattern, modules, domain model, **data model diagram (ERD)**, **schema with table/column purpose** (for each table and column), API (with versioning), deployment (env config, secrets), NFRs & architecture, Security architecture, Error handling & resilience, Cross-cutting concerns, External integrations, Testing strategy, ADRs, Architecture risks & trade-offs, data flow/sequence (2–4 flows), E2E & deployment diagram (with Integration map & impact subsection), module & PRD mapping. See **Common Gaps & Section Templates** in greenfield structure.
- **Brownfield A (extend):** Existing summary + changes—new/modified modules, schema changes, **data model diagram (ERD) when schema changes**, **schema details (table/column purpose) when schema changes**, data migration strategy (or "No schema changes"), product/feature migration (when applicable), API additions, impacted integrations (subsection in E2E diagram), NFRs & security impact, error handling, cross-cutting concerns, external integrations, ADRs, risks & trade-offs, data flow for new flows, Pre + Post E2E & deployment diagram, scope mapping. See **Common Gaps & Section Templates** in brownfield structure.
- **Brownfield B (add-feature):** Architecture unchanged. Dev plan Section 1.1 summarizes existing; flow diagrams for each new user flow. When feature changes boundaries → reclassify as extend. See [architecture-impact-add-feature.md](./architecture-impact-add-feature.md).
- **Brownfield C (fix-bug):** Pre/post optional when bug spans components or fix changes flow. Code produces bug-fix-scope with optional pre/post diagrams. See [architecture-impact-fix-bug.md](./architecture-impact-fix-bug.md).
- **Brownfield D (refactor):** Pre/post optional but recommended for structural refactors. Flow diagram required. QA produces refactor-scope. See [architecture-impact-refactor.md](./architecture-impact-refactor.md).

## Input Readiness (Before Architect)

- **Greenfield:** refined-prd.md must have Use Cases, Entities, Domain Glossary (Appendix), Non-Functional Expectations. See `.nayan/guidance/plan-input-requirements.md`
- **Brownfield A:** Condensed scope must have feature description, integration points; architect needs architecture.md and codebase. See `.nayan/guidance/condensed-scope-template.md`
