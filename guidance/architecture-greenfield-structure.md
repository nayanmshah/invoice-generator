# Architecture: Greenfield Structure

Use when creating architecture for a **new product** from scratch. Full structure required. **Pre-architecture:** N/A (new product; no existing system). **Post-architecture:** The full `architecture.md` deliverable.

**Input:** `refined-prd.md` — the canonical PRD produced by PRD mode. PRD must follow `.nayan/guidance/prd-template-v2.md` (15 sections). See `.nayan/skills/prd-standards/SKILL.md` for traceability (Domain Glossary §15, Use Cases §7, Entities §8, NFRs §11).

**Pipeline context:** Orchestrator delegates prd → architect. PRD handoff (`.nayan/rules-prd/4_handoff.xml`) passes `PRD_FILE: refined-prd.md` and instruction to create architecture.md. Architect input readiness per `.nayan/guidance/plan-input-requirements.md`. Workflow: `.nayan/rules-orchestrator/2_workflows_greenfield.xml` — diagramSpec: postArchitecture required, flowDiagrams required.

## Architect's Mandate: PRD-to-Architecture Traceability

As technical/solution architect, you must document architectural decisions that **directly address product needs**. For each PRD section below, ensure the architecture has a corresponding section or explicit mapping.

| PRD Section                        | Architect Must Document                                                                                                                                                                                 |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- | -------------------------------------------------------------- | ------- | ----- | --------- |
| **2. Problem Statement**           | Introduction: 1 sentence linking architecture to the problem (e.g., "This architecture supports unified recovery insights by...").                                                                      |
| **4. Success Criteria**            | NFRs & Architecture (Section 9): Map each success metric to an architectural decision (e.g., "Score in < 1s" → caching, indexing, async boundaries).                                                    |
| **6. Scope**                       | **Scope Boundaries (new):** What is in MVP scope architecturally vs deferred. Explicit "In Scope" / "Deferred" table. Prevents scope creep.                                                             |
| **7. Use Cases**                   | Module & PRD Mapping (Section 19). **Plus:** For use cases with calculation logic, business rules, or state transitions: document where that logic lives (module, config, algorithm).                   |
| **8. Data, Entities**              | Domain Model, ERD, Schema (Sections 4–6). **Plus:** Data retention strategy (how long, archival, deletion) when PRD specifies retention.                                                                |
| **9. Integrations**                | External Integrations (Section 13). **Plus:** Per-integration table: System                                                                                                                             | Contract/Format | Auth                                                           | Timeout | Retry | Fallback. |
| **10. Error Handling**             | Error Handling & Resilience (Section 11). **Plus:** Map PRD error scenarios to architectural responses (e.g., "Sync fails" → retry policy, circuit breaker, user notification).                         |
| **11. Non-Functional**             | NFRs (Section 9), Security (Section 10). **Plus:** Platform Support (web/mobile/native) → client architecture, offline capability, API design for mobile.                                               |
| **12. UI/UX**                      | When UI affects architecture: client rendering (SSR vs CSR), offline-first, PWA vs native. Document in Module Design or Deployment.                                                                     |
| **13. Constraints & Dependencies** | Architecture Risks & Trade-offs (Section 16). **Plus:** Explicit "Constraints" subsection mapping PRD constraints to architectural decisions (e.g., "Health API rate limits" → rate limiting, caching). |
| **14. Open Questions**             | **Open Questions Resolution (Section 22):** For each PRD §14 question: Resolved                                                                                                                         | Deferred        | Escalated. Do not leave unresolved if it affects architecture. |

**Section numbers** refer to `prd-template-v2.md` (15 mandatory sections). PRD creation per `.nayan/skills/prd-creation/SKILL.md`; output `refined-prd.md` concludes "PRD Complete - Ready for architect mode (architecture) and prototype (when UI)."

### Product-Need Conditional Sections

Include these **when the product requires them**:

| Product Need                               | Section to Add                  | When                                                                                                                                                     |
| ------------------------------------------ | ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ---- | ------- | ----- | --------- |
| **Scoring, pricing, or calculation logic** | Algorithm / Core Business Logic | PRD has calculation logic, formulas, or algorithm (e.g., Readiness Score). Document: where logic lives, parameterization, configurability, MVP defaults. |
| **Multi-platform (web + mobile)**          | Platform & Client Strategy      | PRD Section 11 specifies iOS, Android, web. Document: native vs hybrid vs PWA, offline support, API design for mobile.                                   |
| **Sensitive data (PII, PHI, financial)**   | Data Retention & Lifecycle      | PRD Section 8 has retention. Document: retention periods, archival, deletion, compliance (GDPR right-to-erasure).                                        |
| **External API integrations**              | Per-Integration Contract Table  | PRD Section 9 lists external systems. Required format: System                                                                                            | Contract | Auth | Timeout | Retry | Fallback. |

## Document Header (Required)

- **Title:** `# Architecture Design Document`
- **Create:** Table with Nayan, User Name, Create Date. Two create names: Nayan (AI) and User Name (logged-in user who created using Nayan, from `environment_details`). Format: `| Nayan | User Name | Create Date |`
- **Introduction:** 2–3 sentences: product name, tech stack summary, architectural pattern. Enables stakeholders to orient quickly.

## Common Gaps to Avoid

Implementations often miss these. Ensure each is addressed:

| Gap                               | Required Instead                                                                                                                                 |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ---- | ------- | ----- | ---------------------------------- |
| Skipping conceptual Domain Model  | Section 4: Conceptual entities and relationships (distinct from ERD). Align with PRD Section 8 & Domain Glossary.                                |
| Single combined sequence diagram  | Section 17: **2–4** critical flows (e.g., auth, core feature, sync). Each with brief description + Mermaid sequence diagram.                     |
| C4Context + C4Container only      | Section 20: Add **C4Component** for at least one key container (e.g., Scoring Engine, User Service).                                             |
| Brief "Integrations" paragraph    | Section 18: **Integration Map & Impact** subsection—table or diagram of all integrations; impact chain (change X → affects Y, Z → flows F1, F2). |
| No API versioning                 | Section 7: API style, key endpoints, **versioning strategy** (e.g., `/api/v1/`), backward-compatibility approach.                                |
| Deployment = "GKE" only           | Section 8: Environments (dev/staging/prod), **secrets management**, infrastructure approach.                                                     |
| NFRs + Security merged            | Sections 9 & 10: **Separate** NFRs (performance, scalability, availability) from Security (auth flows, RBAC, encryption, audit, compliance).     |
| No Error Handling section         | Section 11: Retries, circuit breakers, fallbacks, timeout handling, graceful degradation.                                                        |
| No Cross-Cutting Concerns         | Section 12: Logging, monitoring, observability, tracing, health/readiness endpoints.                                                             |
| No ADRs                           | Section 15: Architecture Decision Records for key choices (tech stack, pattern, external integrations).                                          |
| Schema = table purpose only       | Section 6: **Per-column** purpose (business meaning), type, constraints (nullable, unique, FK).                                                  |
| No E2E + Deployment diagram       | Section 18: Combined diagram showing components **and** deployment topology (where each runs, environments, networking).                         |
| PRD Open Questions ignored        | Section 22: Resolve, defer, or escalate each PRD Section 14 question. Unresolved questions that affect architecture block handoff.               |
| PRD Constraints not mapped        | Section 23: Map each PRD Section 13 constraint to an architectural decision.                                                                     |
| No scope boundaries               | Section 21: Explicit MVP vs deferred table. Align with PRD Section 6.                                                                            |
| Calculation logic undocumented    | Product-Need: Algorithm section when PRD has scoring, pricing, or formula logic. Document where it lives, parameterization.                      |
| External APIs without contract    | Section 13: Per-integration table (Contract                                                                                                      | Auth | Timeout | Retry | Fallback) when integrations exist. |
| PRD error scenarios not addressed | Section 11: Map PRD Section 10 error scenarios to retry, fallback, circuit breaker, user notification.                                           |

## Required Sections in architecture.md

| Section                                              | Purpose                                                                                                                                                                                                                                                                | Used By                                                                                                                     |
| ---------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ | ----------------------------------------- | ------------------------------ |
| **1. Technology Stack**                              | Frontend, Backend, Database, Deployment (full details per `2_tech_stacks.md`)                                                                                                                                                                                  | Development plan Section 1.2                                                                                                |
| **2. Architectural Pattern**                         | Modular Monolith vs Decoupled Fullstack; justification. **When Decoupled Fullstack:** Include **Repository Strategy** (single repo vs multi-repo). See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.                                                      | Development plan Section 1.1                                                                                                |
| **3. Module Design**                                 | Domain Modules, Infrastructure Modules, Shared Module; responsibilities and interfaces                                                                                                                                                                                 | Development plan Section 2.1, 2.2                                                                                           |
| **4. Domain Model**                                  | Conceptual entities, relationships, aggregates (align with PRD Section 8 & Domain Glossary in Section 15); distinct from physical schema                                                                                                                               | Development plan, code                                                                                                      |
| **5. Data Model Diagram (ERD)**                      | **Required diagram:** Entities, attributes (with types), relationships, cardinality, PK/FK. Mermaid ER diagram or equivalent. Align with Domain Model and PRD Domain Glossary.                                                                                         | Development plan, code, QA                                                                                                  |
| **6. Database Schema**                               | Physical schema: tables, columns, relationships. **For each table:** purpose (what it stores, domain concept). **For each column:** purpose (business meaning), type, constraints (nullable, unique, FK). Implements Data Model; traceable to PRD Domain Glossary.     | Development plan sprints                                                                                                    |
| **7. API Strategy**                                  | API style (REST/GraphQL), key endpoints, versioning and backward-compatibility approach                                                                                                                                                                                | Development plan Section 1.4, sprints                                                                                       |
| **8. Deployment**                                    | Deployment targets, infrastructure approach; environment config (dev/staging/prod), secrets management                                                                                                                                                                 | Development plan Section 1.5                                                                                                |
| **9. NFRs & Architecture**                           | How design supports PRD Section 11 (Non-Functional Expectations): performance, scalability, availability, data retention, monitoring                                                                                                                                   | Development plan, QA                                                                                                        |
| **10. Security Architecture**                        | Auth flows, authorization model, encryption, audit logging, compliance (per PRD Section 11 Security)                                                                                                                                                                   | Development plan, security-plan                                                                                             |
| **11. Error Handling & Resilience**                  | Retries, circuit breakers, fallbacks, failure modes, graceful degradation                                                                                                                                                                                              | Development plan, code                                                                                                      |
| **12. Cross-Cutting Concerns**                       | Logging, monitoring, observability, tracing, health checks                                                                                                                                                                                                             | Development plan, devops                                                                                                    |
| **13. External Integrations**                        | Third-party APIs, contracts, failure handling (include when system integrates with external services)                                                                                                                                                                  | Development plan, code                                                                                                      |
| **14. Testing Strategy**                             | Testability: unit boundaries, integration test points, mock strategy, E2E scope                                                                                                                                                                                        | Development plan, QA                                                                                                        |
| **15. ADRs**                                         | Architecture Decision Records for key choices                                                                                                                                                                                                                          | Traceability                                                                                                                |
| **16. Architecture Risks & Trade-offs**              | Technical risks, known limitations, technical debt, trade-off decisions                                                                                                                                                                                                | Development plan, stakeholders                                                                                              |
| **17. Data Flow / Core End-to-End Sequence**         | Critical user flows with sequence diagrams (e.g., auth flow, core feature flow); step-by-step interaction across components                                                                                                                                            | Development plan, QA, code                                                                                                  |
| **18. End-to-End Architecture & Deployment Diagram** | Combined diagram: system components + deployment topology (where each component runs, environments, networking). **Include subsection: Integration Map & Impact** — all integrations (internal + external); impact chain (change in X → affects Y, Z → affects flows). | Development plan Section 1.5, devops                                                                                        |
| **19. Module & PRD Use Case Mapping**                | Traceability matrix: Use Case ↔ Module ↔ API; which modules/APIs implement which use cases                                                                                                                                                                           | Development plan, QA, validation                                                                                            |
| **20. Diagrams**                                     | C4Context, C4Container, C4Component; **Data Model (ERD)**; data flow or sequence; deployment if needed                                                                                                                                                                 | Validation                                                                                                                  |
| **21. Scope Boundaries**                             | MVP vs deferred (align with PRD Section 6). Table: Capability                                                                                                                                                                                                          | In MVP?                                                                                                                     | Module/API                                                                     | Deferred Rationale. Prevents scope creep. | Development plan, stakeholders |
| **22. Open Questions Resolution**                    | For each PRD Section 14 open question: Resolved (decision)                                                                                                                                                                                                             | Deferred (timeline)                                                                                                         | Escalated (blocker). Do not leave architecture-affecting questions unresolved. | Stakeholders, development plan            |
| **23. Constraints Mapping**                          | PRD Section 13 constraints → architectural decisions. Table: Constraint                                                                                                                                                                                                | Architectural Response. E.g., "Health API rate limits" → "Daily sync schedule; cache in Ingestion DB; exponential backoff." | Development plan, stakeholders                                                 |

**Section notes:**

- **4. Domain Model:** Conceptual entities and relationships (align with PRD Section 8 & Domain Glossary in Section 15); distinct from physical schema.
- **5. Data Model Diagram (ERD):** Required ER diagram: entities with attributes (id, types), relationships with cardinality, PK/FK. Use Mermaid erDiagram or equivalent. Example: User, Product, Order, OrderItem, Shipment with sells/places/contains/has/delivers relationships. SDLC-critical for development plan and QA.
- **6. Database Schema:** For each table: purpose (what it stores, domain concept). For each column: purpose (business meaning), type, constraints (nullable, unique, FK). Example: `Order.status` — "Order lifecycle: Pending, Processing, Shipped, Delivered, Cancelled". Align with Domain Glossary. Enables correct implementation and QA test design.
- **8. Deployment:** Include environment config (dev/staging/prod), secrets management approach.
- **9. NFRs & Architecture:** Map each NFR from PRD Section 11 to architectural decisions (e.g., "Performance: caching strategy, DB indexing").
- **10. Security Architecture:** Auth (JWT/session), RBAC/ABAC, encryption at rest/transit, audit logging, compliance (GDPR, HIPAA, etc.).
- **11. Error Handling & Resilience:** Document retry policies, circuit breakers, fallbacks, timeout handling.
- **12. Cross-Cutting Concerns:** Structured logging, metrics (latency, errors), distributed tracing, health/readiness endpoints.
- **13. External Integrations:** Include when system calls external APIs. **Required when integrations exist:** Per-integration table (System | Contract/Format | Auth | Timeout | Retry | Fallback). If none: state "No external integrations."
- **14. Testing Strategy:** Test boundaries, integration points, mock strategy, E2E scope.
- **16. Architecture Risks & Trade-offs:** Known limitations, technical debt, risks with mitigation.
- **17. Data Flow:** 2–4 critical flows; each with brief description + Mermaid sequence diagram. **Minimum:** auth flow (if applicable) + at least one core feature flow. Example flows: Login/Register, Submit Log, Sync Biometrics, Get Score.
- **18. E2E & Deployment Diagram:** Components + deployment topology (where each component runs, environments, networking). **Subsection — Integration Map & Impact (mandatory):** Table or diagram of all integrations (UI↔API, API↔DB, API↔external, module↔module). For each: what breaks if it changes? Impact chain: Change in X → affects Y, Z → affects flows F1, F2.
- **19. Module & PRD Mapping:** Mandatory table. Example: `| Use Case 1: Register | Auth Module | POST /api/auth/register |`
- **21. Scope Boundaries:** Align with PRD Section 6. Table: Capability | In MVP? (Yes/No) | Module/API | Deferred Rationale (if No). Ensures architecture matches product scope.
- **22. Open Questions Resolution:** For each PRD Section 14 question: Resolved (document decision in architecture) | Deferred (state when it will be addressed) | Escalated (blocks architecture; requires product decision). Architecture-affecting questions must not remain unresolved.
- **23. Constraints Mapping:** PRD Section 13 lists constraints. Map each to an architectural decision. Example: "Health API rate limits" → "Strict daily sync; cache in Ingestion DB; exponential backoff on 429."

## Section Templates (Minimum Content)

### Section 6. Database Schema — Per-Table, Per-Column Format

**Migration strategy (required):** Document how schema changes are applied (e.g., auto-migrate on startup, Alembic, Flyway, manual migrations). Must be in architecture.md before handoff to development plan.

```
**TABLE_NAME:** [Purpose: what it stores, domain concept]

| Column | Type | Constraints | Purpose (business meaning) |
|--------|------|--------------|----------------------------|
| id | BIGINT | PK, NOT NULL | Surrogate key |
| user_id | BIGINT | FK, NOT NULL | References USERS; owner of this record |
| status | VARCHAR(20) | NOT NULL | Order lifecycle: Pending, Processing, Shipped |
```

### Section 8. Deployment — Required Subsections

- **Targets:** e.g., GKE (GCP), EKS, on-prem
- **Environments:** dev, staging, prod (or equivalent)
- **Secrets management:** e.g., GCP Secret Manager, Vault, env vars (and what must NOT be in env)
- **Infrastructure approach:** e.g., Helm charts, Terraform, K8s manifests

### Section 15. ADRs — Format

For each key decision: **Title | Context | Decision | Rationale**

Example: `ADR-001: Decoupled Microservices | Need to scale scoring independently | Use separate User, Ingestion, Scoring services | Enables independent scaling per PRD Section 11 (Performance)`

### Section 18. Integration Map & Impact — Table Format

| Integration    | From           | To           | Protocol   | Impact if change        |
| -------------- | -------------- | ------------ | ---------- | ----------------------- |
| UI → API       | Angular App    | API Gateway  | HTTPS/REST | All UI flows break      |
| Scoring → User | Scoring Engine | User Service | REST       | Score calculation fails |

### Section 13. External Integrations — Per-Integration Contract (when integrations exist)

| System          | Contract/Format            | Auth      | Timeout | Retry                      | Fallback                                   |
| --------------- | -------------------------- | --------- | ------- | -------------------------- | ------------------------------------------ |
| Apple HealthKit | REST; sleep, HRV endpoints | OAuth 2.0 | 30s     | Exponential backoff, max 3 | Graceful degrade; use subjective logs only |
| Google Fit      | REST; same metrics         | OAuth 2.0 | 30s     | Same                       | Same                                       |

### Section 21. Scope Boundaries — Table Format

| Capability            | In MVP? | Module/API                      | Deferred Rationale                               |
| --------------------- | ------- | ------------------------------- | ------------------------------------------------ |
| Manual logging        | Yes     | User Service, POST /api/v1/logs | —                                                |
| Automated sync        | Yes     | Data Ingestion Service          | —                                                |
| Advanced sleep stages | No      | —                               | Focus MVP on essential metrics per PRD Section 6 |

### Section 22. Open Questions Resolution — Table Format

| PRD Open Question                                  | Status   | Resolution / Next Step                                                 |
| -------------------------------------------------- | -------- | ---------------------------------------------------------------------- |
| How will algorithm weight subjective vs automated? | Resolved | Configurable weights; MVP default 50/50; stored in config              |
| Require daily log to see score?                    | Resolved | No; score from biometrics only when log missing; recommend user to log |

### Section 23. Constraints Mapping — Table Format

| PRD Constraint                 | Architectural Response                                                 |
| ------------------------------ | ---------------------------------------------------------------------- |
| Health API rate limits         | Daily sync schedule; cache in Ingestion DB; exponential backoff on 429 |
| Scoring requires baseline data | First 7 days: subjective-only score; full algorithm after calibration  |

### Product-Need: Algorithm / Core Business Logic (when applicable)

When PRD has calculation logic (scoring, pricing, etc.):

- **Location:** Which module owns the logic (e.g., Scoring Engine)
- **Parameterization:** Config-driven vs hardcoded; what is configurable (weights, thresholds)
- **MVP defaults:** Initial values for launch
- **Edge cases:** Missing inputs, partial data (e.g., subjective-only when biometrics unavailable)

### Product-Need: Data Retention & Lifecycle (when PRD Section 8 specifies retention)

- **Retention periods:** Per entity (e.g., logs: 2 years; scores: 1 year)
- **Archival:** When and how data moves to cold storage
- **Deletion:** Process for GDPR right-to-erasure, account deletion

## Greenfield-Specific

- **Tech stack:** Ask user (Bootcamp vs Enterprise vs Custom); document full stack
- **Repository Strategy (Decoupled Fullstack only):** Ask user: "Monorepo (single repo with frontend/ and backend/ dirs) or multi-repo (separate repos)?" Document choice. Single repo: one Repo URL; one commit/PR per sprint. Multi-repo: When using frontend/backend: REPO*FRONTEND, REPO_BACKEND. When project-specific names: document **Repo dirs:** [list] (e.g., [web-app, api]) and collect per-repo URL (REPO*<DIR>\_URL). Per-repo commit/PR. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
- **All sections:** Create from scratch; no existing architecture to extend
- **Traceability:** Map every use case from PRD Section 7 to modules/APIs

## Architecture Completeness Checklist (HITL)

Before presenting to user and handoff, verify architecture.md has **all** of:

| Check                                                                                | Required    |
| ------------------------------------------------------------------------------------ | ----------- |
| Technology stack (full details)                                                      | Yes         |
| Architectural pattern with justification                                             | Yes         |
| Module design (domain, infrastructure, shared)                                       | Yes         |
| Domain model (conceptual entities, relationships)                                    | Yes         |
| Data model diagram (ERD: entities, attributes, relationships, PK/FK)                 | Yes         |
| Database schema (tables, columns, relationships; table/column purpose for each)      | Yes         |
| API strategy (style, key endpoints, versioning)                                      | Yes         |
| Deployment (targets, infrastructure, env config, secrets)                            | Yes         |
| Testing strategy (testability, boundaries, mocks)                                    | Yes         |
| NFRs & architecture (performance, scalability, availability, monitoring)             | Yes         |
| Security architecture (auth, authorization, encryption, audit, compliance)           | Yes         |
| Error handling & resilience                                                          | Yes         |
| Cross-cutting concerns (logging, monitoring, observability)                          | Yes         |
| External integrations (or "N/A" if none)                                             | Yes         |
| Integration map & impact (internal + external; impact propagation)                   | Yes         |
| ADRs for key decisions                                                               | Yes         |
| Architecture risks & trade-offs                                                      | Yes         |
| C4 diagrams (Context, Container, Component)                                          | Yes         |
| Data flow / core end-to-end sequence (2–4 critical flows)                            | Yes         |
| End-to-end architecture & deployment diagram                                         | Yes         |
| Module & PRD use case mapping (Use Case ↔ Module ↔ API)                            | Yes         |
| Scope boundaries (MVP vs deferred; align with PRD Section 6)                         | Yes         |
| Open questions resolution (PRD Section 14; Resolved/Deferred/Escalated)              | Yes         |
| Constraints mapping (PRD Section 13 → architectural decisions)                       | Yes         |
| Per-integration contract table (when external integrations exist)                    | Yes         |
| Domain Glossary terms used consistently                                              | Yes         |
| Product-need sections (Algorithm, Data Retention, Platform Strategy when applicable) | Conditional |

**HITL:** Present full architecture; confirm with user: "Does this architecture fully address all requirements?" Wait for explicit approval before handoff.

**Input readiness:** Ensure refined-prd.md has all required sections (per prd-template-v2) before starting. See `.nayan/guidance/plan-input-requirements.md`.

**Gap validation:** Before presenting to user, run `.nayan/guidance/architecture-gap-validation.md` — verify all 23 sections present, no gaps. Do not handoff until validation passes.

---

## References (Canonical Sources)

| Artifact                | Path                                                    | Purpose                                                               |
| ----------------------- | ------------------------------------------------------- | --------------------------------------------------------------------- |
| PRD Template            | `.nayan/guidance/prd-template-v2.md`                   | 15 mandatory sections; section numbers for traceability               |
| PRD Standards           | `.nayan/skills/prd-standards/SKILL.md`                 | Canonical PRD structure; Domain Glossary, Use Cases, Entities, NFRs   |
| PRD Creation            | `.nayan/skills/prd-creation/SKILL.md`                  | PRD methodology; output refined-prd.md                                |
| Plan Input Requirements | `.nayan/guidance/plan-input-requirements.md`           | PRD readiness gate; Sign-Off, Use Cases, Entities, Glossary, NFRs     |
| PRD Handoff             | `.nayan/rules-prd/4_handoff.xml`                       | PRD → architect handoff; PRD_FILE, instruction to create architecture |
| Greenfield Workflow     | `.nayan/rules-orchestrator/2_workflows_greenfield.xml` | Pipeline steps; diagramSpec (postArchitecture, flowDiagrams)          |
| SDLC Prerequisites      | `.nayan/rules-orchestrator/3_sdlc_prerequisites.md`    | Plan prerequisites: refined-prd.md with Sign-Off Approved             |
