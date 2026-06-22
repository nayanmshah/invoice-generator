# Architecture Gap Validation

**Purpose:** Validate architecture.md against the required template to ensure no gaps before handoff. Run this validation **before** presenting to user and **before** handoff to prototype or development plan.

**Reference:** Greenfield → `.nayan/guidance/architecture-greenfield-structure.md` | Brownfield A → `.nayan/guidance/architecture-brownfield-structure.md`

---

## How to Run

1. **Identify template:** Greenfield or Brownfield A (extend)
2. **For each row below:** Search architecture.md for the section/pattern; mark Pass/Fail
3. **Do not handoff** until all required items pass
4. **Fix gaps** before presenting to user

---

## Greenfield: Section Gap Checklist

| #   | Required Section                | Verification Check                                                                         | Pass/Fail |
| --- | ------------------------------- | ------------------------------------------------------------------------------------------ | --------- |
| 0   | Create                          | Document contains Create table with Nayan, User Name, Create Date (two create names)      |           |
| 1   | Technology Stack                | Document contains tech stack (Frontend, Backend, Database, Deployment); versions specified |           |
| 2   | Architectural Pattern           | Document contains "Modular Monolith" or "Decoupled" with justification                     |           |
| 3   | Module Design                   | Document contains module list with responsibilities (Domain, Infrastructure, Shared)       |           |
| 4   | Domain Model                    | Conceptual entities and relationships; distinct from ERD; aligns with PRD §8               |           |
| 5   | Data Model Diagram (ERD)        | Mermaid erDiagram with entities, attributes, PK/FK, relationships                          |           |
| 6   | Database Schema                 | Per-table purpose; per-column purpose, type, constraints                                   |           |
| 7   | API Strategy                    | API style, key endpoints, versioning strategy (e.g., /api/v1/)                             |           |
| 8   | Deployment                      | Targets, environments (dev/staging/prod), secrets management                               |           |
| 9   | NFRs & Architecture             | Performance, scalability, availability, monitoring; maps to PRD §11                        |           |
| 10  | Security Architecture           | Auth, authorization, encryption, audit, compliance                                         |           |
| 11  | Error Handling & Resilience     | Retries, circuit breakers, fallbacks, graceful degradation                                 |           |
| 12  | Cross-Cutting Concerns          | Logging, monitoring, observability, health checks                                          |           |
| 13  | External Integrations           | Per-integration table when integrations exist; or "No external integrations"               |           |
| 14  | Testing Strategy                | Test boundaries, mock strategy, E2E scope                                                  |           |
| 15  | ADRs                            | At least one ADR for key decisions (tech stack, pattern, integrations)                     |           |
| 16  | Architecture Risks & Trade-offs | Technical risks, limitations, trade-offs with mitigation                                   |           |
| 17  | Data Flow / Sequence            | 2–4 critical flows; each with sequence diagram                                             |           |
| 18  | E2E & Deployment Diagram        | Combined components + deployment topology; Integration Map & Impact subsection             |           |
| 19  | Module & PRD Use Case Mapping   | Table: Use Case ↔ Module ↔ API                                                           |           |
| 20  | C4 Diagrams                     | C4Context, C4Container, C4Component (at least one)                                         |           |
| 21  | Scope Boundaries                | Table: Capability \| In MVP? \| Module/API \| Deferred Rationale                           |           |
| 22  | Open Questions Resolution       | Table: PRD §14 questions → Resolved/Deferred/Escalated                                     |           |
| 23  | Constraints Mapping             | Table: PRD §13 constraints → Architectural Response                                        |           |

### Greenfield: Diagram Requirements

| Diagram Type         | Required | Verification                                          |
| -------------------- | -------- | ----------------------------------------------------- |
| C4Context            | Yes      | Contains `C4Context` or `C4Context` block             |
| C4Container          | Yes      | Contains `C4Container` block                          |
| C4Component          | Yes      | Contains `C4Component` for at least one key container |
| ERD (erDiagram)      | Yes      | Contains `erDiagram` block                            |
| Sequence (2–4 flows) | Yes      | 2–4 `sequenceDiagram` blocks                          |

### Greenfield: PRD Traceability

| PRD Section         | Architecture Coverage                                  |
| ------------------- | ------------------------------------------------------ | --- |
| §7 Use Cases        | Every use case in Module & PRD Mapping table           |     |
| §8 Entities         | Domain Model + ERD align with entities                 |     |
| §10 Error Scenarios | Section 11 maps each to retry/fallback/circuit breaker |     |
| §13 Constraints     | Section 23 Constraints Mapping                         |     |
| §14 Open Questions  | Section 22 Open Questions Resolution                   |     |

---

## Brownfield A: Section Gap Checklist

| #   | Required Section                | Verification Check                                                     | Pass/Fail |
| --- | ------------------------------- | ---------------------------------------------------------------------- | --------- |
| 1   | Existing Architecture Summary   | Tech stack, current modules, key patterns                              |           |
| 2   | Scope of Change                 | What is being added or extended                                        |           |
| 3   | New or Modified Modules         | Modules with responsibilities                                          |           |
| 4   | Schema Changes                  | New entities, migrations; or "No schema changes"                       |           |
| 4a  | Data Model Diagram (ERD)        | When schema changes: updated erDiagram                                 |           |
| 4b  | Schema Details                  | When schema changes: per-table, per-column                             |           |
| 4c  | Data Migration Strategy         | When schema changes: approach, rollback; or "No migration"             |           |
| 4d  | Product/Feature Migration       | When applicable; or "No product/feature migration"                     |           |
| 5   | API Additions/Changes           | New endpoints; versioning impact                                       |           |
| 6   | Deployment Impact               | Changes or "No deployment impact"                                      |           |
| 7   | NFRs & Architecture Impact      | How extension affects performance, availability                        |           |
| 8   | Security Architecture Impact    | Auth/encryption/audit impact; or "No change" stated                    |           |
| 9   | Error Handling & Resilience     | Retries, fallbacks for new/changed flows                               |           |
| 10  | Cross-Cutting Concerns          | Logging, monitoring for new components                                 |           |
| 11  | External Integrations           | New/changed integrations; or "N/A"                                     |           |
| 12  | ADRs                            | ADRs for extension choices                                             |           |
| 13  | Architecture Risks & Trade-offs | Risks, limitations from extension                                      |           |
| 14  | Data Flow / Sequence            | Sequence diagrams for new/changed flows                                |           |
| 15  | E2E & Deployment Diagram        | Pre-architecture + Post-architecture; Impacted Integrations subsection |           |
| 16  | Module & Scope Mapping          | Table: scope ↔ modules ↔ APIs                                        |           |

### Brownfield A: Diagram Requirements

| Diagram Type          | Required | Verification                  |
| --------------------- | -------- | ----------------------------- | --- |
| Pre-architecture      | Yes      | C4 diagram of current state   |     |
| Post-architecture     | Yes      | C4 diagram of extended state  |     |
| Impacted Integrations | Yes      | Subsection after post diagram |     |
| Flow (new/changed)    | Yes      | Sequence for each new flow    |     |

---

## Validation Output

**Before handoff:** All required items must pass. Document any failures and fix before presenting to user.

| Result   | Action                                      |
| -------- | ------------------------------------------- |
| All Pass | Proceed to user approval and handoff        |
| Any Fail | Fix gaps; re-run validation; do not handoff |

---

## References

- `.nayan/rules-architect/3_architecture_validation.md` — Full validation checklist (Mermaid + PRD coverage + HITL)
- `.nayan/guidance/architecture-greenfield-structure.md` — Greenfield template
- `.nayan/guidance/architecture-brownfield-structure.md` — Brownfield A template
