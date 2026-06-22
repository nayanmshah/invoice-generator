# Architecture: Brownfield Structure

Use when **extending** architecture for an existing product (Brownfield A). Architect extends existing architecture.md.

**Input:** Condensed scope or feature spec (per `.nayan/guidance/condensed-scope-template.md`), existing architecture.md, existing codebase. Brownfield pipelines skip PRD phase; see `.nayan/rules-orchestrator/2_workflows_brownfield.xml` — brownfield-extend enters at architect.

**Architecture alignment mandate:** Analyze the existing architecture and codebase. **Align to existing architecture** when the user request fits within the current design (no significant structural changes needed). **Propose architecture changes** when the user request requires modifications to the existing architecture to solve it — document what changes, why, and the impact. Do not invent a new architecture from scratch; extend or adapt the existing one.

**Note:** Other brownfield flows use lighter architecture-impact templates:

- **Brownfield B (add-feature):** [architecture-impact-add-feature.md](./architecture-impact-add-feature.md) — Architecture unchanged; flow diagrams in dev plan
- **Brownfield C (fix-bug):** [architecture-impact-fix-bug.md](./architecture-impact-fix-bug.md) — Pre/post optional; code produces bug-fix-scope
- **Brownfield D (refactor):** [architecture-impact-refactor.md](./architecture-impact-refactor.md) — Pre/post optional; qa produces refactor-scope

**Pipeline context:** Orchestrator delegates to architect directly (no prd phase). Architect input readiness per `.nayan/guidance/plan-input-requirements.md` (Brownfield A). Workflow diagramSpec: preArchitecture required, postArchitecture required, flowDiagrams required.

## Architect's Mandate: Scope-to-Architecture Traceability

As technical/solution architect, you must document architectural decisions that **directly address the extension scope**. When scope references PRD-like elements, ensure coverage.

| Scope Element                     | Architect Must Document                                                                                                                                                 |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | -------------------------------------------------------------------- |
| **Feature/extension description** | Scope of Change (Section 2); New or Modified Modules (Section 3).                                                                                                       |
| **Functional scope**              | Module & Scope Mapping (Section 16). **Plus:** For calculation logic, business rules: where does logic live?                                                            |
| **Integration points**            | Impacted Integrations (Section 15 subsection); External Integrations (Section 11) when new external systems. **Plus:** Per-integration contract when new external APIs. |
| **Constraints** (if in scope)     | Architecture Risks & Trade-offs (Section 13). **Plus:** Constraints mapping: Constraint → Architectural Response.                                                       |
| **Error scenarios** (if in scope) | Error Handling & Resilience (Section 9). Map scope error scenarios to retry, fallback, circuit breaker.                                                                 |
| **Open questions** (if in scope)  | Open Questions Resolution: Resolved                                                                                                                                     | Deferred | Escalated. Do not leave architecture-affecting questions unresolved. |

### Product-Need Conditional Sections (Brownfield)

Include when the extension requires them:

| Product Need                                   | Section to Add                  | When                                                                    |
| ---------------------------------------------- | ------------------------------- | ----------------------------------------------------------------------- | -------- | ---- | ------- | ----- | --------- |
| **New scoring, pricing, or calculation logic** | Algorithm / Core Business Logic | Extension adds calculation. Document: module, parameterization, config. |
| **New external API**                           | Per-Integration Contract Table  | Extension adds external system. Format: System                          | Contract | Auth | Timeout | Retry | Fallback. |
| **Schema changes with retention**              | Data Retention Impact           | New tables have retention requirements. Document retention, archival.   |
| **Constraints from scope**                     | Constraints Mapping             | Scope lists constraints. Map to architectural decisions.                |

## Document Header (Required)

- **Title:** `# Architecture Design Document — [Extension Name]` or extend existing `# Architecture Design Document`
- **Create:** Table with Nayan, User Name, Create Date. Two create names: Nayan (AI) and User Name (logged-in user who created using Nayan, from `environment_details`). Format: `| Nayan | User Name | Create Date |`
- **Introduction:** 2–3 sentences: scope of change, what is being added/extended, key new modules. Enables stakeholders to orient quickly.

## Common Gaps to Avoid

Implementations often miss these. Ensure each is addressed:

| Gap                                       | Required Instead                                                                                                                                                          |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Skipping Pre/Post diagrams                | Section 15: **Pre-architecture** diagram (current state) + **Post-architecture** diagram (extended state). Both required.                                                 |
| Schema changes without ERD                | Section 4a: When schema changes, **Data Model Diagram (ERD)** showing new/modified entities, attributes, relationships, PK/FK.                                            |
| Schema changes without migration strategy | Section 4c: Zero-downtime approach, phased migration, rollback plan. When no schema changes: state "No schema changes; no migration required."                            |
| No Impacted Integrations subsection       | Section 15: **Impacted Integrations** subsection—which existing integrations are affected; impact chain (change → affected modules → APIs → flows); downstream consumers. |
| API additions without versioning impact   | Section 5: New endpoints **and** versioning/compatibility impact (e.g., new `/api/v2/` vs extending `/api/v1/`).                                                          |
| No data flow for new flows                | Section 14: Sequence diagrams for **each** new or significantly changed user flow; how extension integrates with existing components.                                     |
| Skipping Product/Feature Migration        | Section 4d: When applicable (API deprecation, feature flags, rollout): document. If none: state "No product/feature migration."                                           |
| Deployment impact omitted                 | Section 6: If extension changes deployment (new services, config, scaling): document. If none: state "No deployment impact."                                              |
| Security impact omitted                   | Section 8: Auth changes, new authorization, encryption, audit, compliance impact—even when "no change" (state explicitly).                                                |
| No ADRs for extension choices             | Section 12: ADRs for key extension decisions (e.g., why new module vs extending existing).                                                                                |
| Scope open questions ignored              | Section 18: When scope has open questions, resolve, defer, or escalate.                                                                                                   |
| Scope constraints not mapped              | Section 19: When scope has constraints, map to architectural decisions.                                                                                                   |
| New external API without contract         | Section 11: Per-integration table when extension adds external system.                                                                                                    |
| Calculation logic undocumented            | Product-Need: Algorithm section when extension adds scoring, pricing, or formula logic.                                                                                   |

## Required Sections in architecture.md (Extended)

| Section                                              | Purpose                                                                                                                                                                                                                                                        | Used By                          |
| ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- | -------------------------------------------------------------------- | ------------ |
| **1. Existing Architecture Summary**                 | Tech stack (use as-is), current modules, key patterns                                                                                                                                                                                                          | Development plan Section 1.1     |
| **2. Scope of Change**                               | What is being added or extended                                                                                                                                                                                                                                | Development plan Section 1.2     |
| **3. New or Modified Modules**                       | Modules being added or extended; responsibilities                                                                                                                                                                                                              | Development plan Section 2.1     |
| **4. Schema Changes**                                | New entities, migrations, or schema extensions                                                                                                                                                                                                                 | Development plan sprints         |
| **4a. Data Model Diagram (ERD)**                     | **Required when schema changes:** Updated ER diagram showing new/modified entities, attributes, relationships, PK/FK. Extend existing or add new entities. Use Mermaid erDiagram or equivalent.                                                                | Development plan, code, QA       |
| **4b. Schema Details (Table/Column Purpose)**        | **Required when schema changes:** For each new/modified table: purpose (what it stores, domain concept). For each column: purpose (business meaning), type, constraints (nullable, unique, FK). Traceable to scope and Domain Glossary.                        | Development plan, code, QA       |
| **4c. Data Migration Strategy**                      | How migration runs (zero-downtime, phased, rollback); migration scripts approach                                                                                                                                                                               | Development plan sprints         |
| **4d. Product/Feature Migration** (when applicable)  | API version migration, feature rollout/deprecation, product migration (legacy→new). See `.nayan/guidance/brownfield-migration-use-cases.md`                                                                                                                   | Development plan, stakeholders   |
| **5. API Additions/Changes**                         | New endpoints or modifications; versioning and compatibility impact                                                                                                                                                                                            | Development plan sprints         |
| **6. Deployment Impact**                             | Any deployment changes (if applicable)                                                                                                                                                                                                                         | Development plan Section 1.5     |
| **7. NFRs & Architecture Impact**                    | How extension affects performance, scalability, availability, monitoring                                                                                                                                                                                       | Development plan, QA             |
| **8. Security Architecture Impact**                  | Auth changes, new authorization, encryption, audit, compliance impact                                                                                                                                                                                          | Development plan, security-plan  |
| **9. Error Handling & Resilience**                   | Retries, circuit breakers, fallbacks for new/changed flows                                                                                                                                                                                                     | Development plan, code           |
| **10. Cross-Cutting Concerns**                       | Logging, monitoring, observability for new/changed components                                                                                                                                                                                                  | Development plan, deploy         |
| **11. External Integrations**                        | New or changed third-party integrations; contracts, failure handling                                                                                                                                                                                           | Development plan, code           |
| **12. ADRs**                                         | Architecture Decision Records for extension choices                                                                                                                                                                                                            | Traceability                     |
| **13. Architecture Risks & Trade-offs**              | Technical risks, limitations, technical debt from extension                                                                                                                                                                                                    | Development plan, stakeholders   |
| **14. Data Flow / Core End-to-End Sequence**         | Sequence diagrams for new/changed flows; how extension integrates with existing components                                                                                                                                                                     | Development plan, QA             |
| **15. End-to-End Architecture & Deployment Diagram** | Pre-architecture diagram (current state), Post-architecture diagram (extended state). **Include subsection: Impacted Integrations** — which existing integrations are affected; impact chain (change → affected modules → APIs → flows); downstream consumers. | Development plan, deploy         |
| **16. Module & Scope Mapping**                       | Traceability: scope items ↔ new/modified modules ↔ APIs                                                                                                                                                                                                      | Development plan, QA, validation |
| **17. Diagrams**                                     | **Pre** (current state) + **Post** (extended state) C4 diagrams; flow diagrams for new/changed flows                                                                                                                                                           | Validation                       |
| **18. Open Questions Resolution** (when scope has)   | For each open question in scope: Resolved                                                                                                                                                                                                                      | Deferred                         | Escalated. Do not leave architecture-affecting questions unresolved. | Stakeholders |
| **19. Constraints Mapping** (when scope has)         | Scope constraints → architectural decisions. Table: Constraint                                                                                                                                                                                                 | Architectural Response.          | Development plan                                                     |

**Section notes (Brownfield A):**

- **4a. Data Model Diagram (ERD):** Required when schema changes. Updated ER diagram: new/modified entities, attributes, relationships, PK/FK. When no schema changes: state "No schema changes; existing data model unchanged."
- **4b. Schema Details (Table/Column Purpose):** Required when schema changes. For each new/modified table: purpose. For each column: purpose (business meaning), type, constraints. Example: `OrderItem.quantity` — "Number of units of this product in the order". When no schema changes: omit.
- **4c. Data Migration Strategy:** When schema changes: zero-downtime approach, phased migration, rollback plan. When no schema changes: state "No schema changes; no migration required."
- **4d. Product/Feature Migration:** When applicable: API version migration (deprecation, consumer migration), feature rollout (flags, phased), feature deprecation (timeline, user migration), product migration (legacy→new, cutover). If none: state "No product/feature migration."
- **7. NFRs & Architecture Impact:** How extension affects performance, scalability, availability, monitoring.
- **8. Security Architecture Impact:** Auth changes, new authorization, encryption, audit, compliance impact.
- **9. Error Handling & Resilience:** Retries, circuit breakers, fallbacks for new/changed flows.
- **10. Cross-Cutting Concerns:** Logging, monitoring, observability for new/changed components.
- **11. External Integrations:** New or changed third-party integrations. **When new external APIs:** Per-integration table (System | Contract | Auth | Timeout | Retry | Fallback). If none: "N/A".
- **13. Architecture Risks & Trade-offs:** Technical risks, limitations, technical debt from extension.

**Section 15 structure (End-to-End Architecture & Deployment Diagram):**

- **Pre-architecture diagram:** C4 Context or Container showing system _before_ extension (existing modules, integrations)
- **Post-architecture diagram:** C4 Context or Container showing system _after_ extension (new/modified modules, new integrations)
- **Impacted Integrations (subsection):** Which existing integrations are affected by the change? Impact chain: Change X → affects modules A, B → affects APIs Y, Z → affects flows F1, F2. Document downstream consumers (internal and external). Place immediately after post diagram—impact is a direct consequence of the change shown.

**Flow diagrams:** Sequence or flowchart for each new or significantly changed user flow, with detailed explanation

## Section Templates (Minimum Content)

### Section 4b. Schema Details (when schema changes) — Per-Table, Per-Column Format

```
**NEW_TABLE_NAME:** [Purpose: what it stores, domain concept]

| Column | Type | Constraints | Purpose (business meaning) |
|--------|------|--------------|----------------------------|
| id | BIGINT | PK, NOT NULL | Surrogate key |
| parent_id | BIGINT | FK, NOT NULL | References PARENT_TABLE |
```

### Section 4c. Data Migration Strategy — Required Subsections

- **Approach:** Zero-downtime, phased, or maintenance window
- **Migration scripts:** Tool (Flyway, Liquibase, custom) and execution order
- **Rollback plan:** How to revert if migration fails
- **When no schema changes:** State "No schema changes; no migration required."

### Section 15. Impacted Integrations — Table Format

| Change                    | Affected Modules | Affected APIs     | Affected Flows      | Downstream Consumers |
| ------------------------- | ---------------- | ----------------- | ------------------- | -------------------- |
| New RECOVERY_SCORES table | Scoring Engine   | GET /scores/daily | Score display flow  | Angular dashboard    |
| New User Service endpoint | API Gateway      | POST /api/v1/logs | Log submission flow | Angular log form     |

### Section 12. ADRs — Format for Extensions

For each key extension decision: **Title | Context | Decision | Rationale**

Example: `ADR-EXT-001: New Scoring Module vs Extend User Service | Need scoring logic isolated | Create new Scoring Engine service | Enables independent scaling; User Service stays focused on identity and logs`

### Section 11. External Integrations — Per-Integration Contract (when new external APIs)

| System    | Contract/Format | Auth      | Timeout | Retry               | Fallback                    |
| --------- | --------------- | --------- | ------- | ------------------- | --------------------------- |
| [New API] | REST; endpoints | OAuth 2.0 | 30s     | Exponential backoff | [Graceful degrade behavior] |

### Section 18. Open Questions Resolution (when scope has open questions)

| Open Question | Status    | Resolution / Next Step      |
| ------------- | --------- | --------------------------- |
| [From scope]  | Resolved  | [Decision documented]       |
| [From scope]  | Deferred  | [Timeline]                  |
| [From scope]  | Escalated | [Requires product decision] |

### Section 19. Constraints Mapping (when scope has constraints)

| Constraint   | Architectural Response          |
| ------------ | ------------------------------- |
| [From scope] | [How architecture addresses it] |

## Brownfield-Specific

- **Tech stack:** Use existing—do not re-ask; document as-is from existing architecture
- **Repository Strategy (Decoupled Fullstack only):** **DETECT** from existing architecture and codebase (Section 1.4 Existing Folder Structure). One `.git` at root → single. No `.git` at root and one or more child dirs have `.git` → multi. Discover child repos: list immediate child dirs; for each `D`, check `D/.git`. Document actual dir names as **Repo dirs:** [list]. **When introducing new Decoupled layout** (e.g., splitting monolith into frontend + backend): **ASK** user "Monorepo or multi-repo?" See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
- **Extend, don't replace:** Add new modules, schema changes, API additions; preserve existing design
- **Integration points:** Document how new work connects to existing modules, APIs, data
- **Traceability:** Map condensed scope / feature spec to new/modified modules and APIs

### Architecture Alignment vs. Proposed Changes

1. **Analyze existing architecture:** Read existing architecture.md and codebase. Understand current modules, folder structure, API patterns, data model.
2. **Align when possible:** If the user request fits within the existing architecture (e.g., add feature to existing module, extend API, add table to existing schema), **align** — extend architecture.md without changing structural patterns. Document additions only.
3. **Propose changes when required:** If the user request cannot be solved within the existing architecture (e.g., new module needed, new service, schema restructuring, new integration pattern), **propose changes** — document in architecture.md: what changes, why, impact on existing modules, migration path. Use Pre/Post diagrams to show before vs. after.

**Reference:** `.nayan/guidance/brownfield-use-cases.md` — Full diagram requirements and explanations for all brownfield types

## Architecture Completeness Checklist (HITL)

Before presenting to user and handoff, verify architecture.md has **all** of:

| Check                                                                                            | Required    |
| ------------------------------------------------------------------------------------------------ | ----------- |
| Existing architecture summary (tech stack, modules, patterns)                                    | Yes         |
| Scope of change clearly documented                                                               | Yes         |
| New or modified modules with responsibilities                                                    | Yes         |
| Schema changes (entities, migrations)                                                            | Yes         |
| Data model diagram (ERD) when schema changes (or "No schema changes" when N/A)                   | Yes         |
| Schema details (table/column purpose) when schema changes                                        | Yes         |
| Data migration strategy (or "No schema changes" when N/A)                                        | Yes         |
| Product/feature migration (when applicable: API version, rollout, deprecation, legacy migration) | Yes         |
| API additions/changes (versioning impact)                                                        | Yes         |
| Deployment impact (if any)                                                                       | Yes         |
| NFRs & architecture impact                                                                       | Yes         |
| Security architecture impact                                                                     | Yes         |
| Error handling & resilience for new/changed flows                                                | Yes         |
| Cross-cutting concerns (logging, monitoring)                                                     | Yes         |
| External integrations (or "N/A" if none)                                                         | Yes         |
| Impacted integrations (change → affected modules/APIs/flows)                                     | Yes         |
| ADRs for extension choices                                                                       | Yes         |
| Architecture risks & trade-offs                                                                  | Yes         |
| Pre-architecture diagram (current state)                                                         | Yes         |
| Post-architecture diagram (extended state)                                                       | Yes         |
| Data flow / sequence for new/changed flows                                                       | Yes         |
| End-to-end architecture & deployment diagram (post-extension)                                    | Yes         |
| Module & scope mapping (scope ↔ modules ↔ APIs)                                                | Yes         |
| Integration points documented                                                                    | Yes         |
| Open questions resolution (when scope has; Resolved/Deferred/Escalated)                          | Conditional |
| Constraints mapping (when scope has constraints)                                                 | Conditional |
| Per-integration contract (when new external integrations)                                        | Conditional |
| Product-need sections (Algorithm, Data Retention when applicable)                                | Conditional |

**HITL:** Present full architecture; confirm with user: "Does this architecture fully address the extension scope?" Wait for explicit approval before handoff.

**Input readiness:** Ensure condensed scope has sufficient detail before starting. See `.nayan/guidance/plan-input-requirements.md` and `.nayan/guidance/condensed-scope-template.md`.

**Gap validation:** Before presenting to user, run `.nayan/guidance/architecture-gap-validation.md` — verify all required sections present, no gaps. Do not handoff until validation passes.

---

## References (Canonical Sources)

| Artifact                                 | Path                                                    | Purpose                                                                            |
| ---------------------------------------- | ------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| Condensed Scope Template                 | `.nayan/guidance/condensed-scope-template.md`          | Scope structure for brownfield; feature description, integration points            |
| Plan Input Requirements                  | `.nayan/guidance/plan-input-requirements.md`           | Brownfield A readiness; scope, architecture.md, codebase                           |
| Brownfield Workflow                      | `.nayan/rules-orchestrator/2_workflows_brownfield.xml` | brownfield-extend pipeline; diagramSpec (pre/post, flowDiagrams)                   |
| SDLC Prerequisites                       | `.nayan/rules-orchestrator/3_sdlc_prerequisites.md`    | Architect prerequisites (Brownfield A): condensed scope, architecture.md, codebase |
| PRD Template (when scope references PRD) | `.nayan/guidance/prd-template-v2.md`                   | If scope was derived from PRD; section mapping for traceability                    |
