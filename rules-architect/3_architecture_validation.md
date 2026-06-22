# Architecture Validation Checklist

**Mandatory before handoff to prototype or plan.** Review architecture.md (or architecture impact for Brownfield B) and verify the following. **Greenfield:** see `architecture-greenfield-structure.md`. **Brownfield A:** see `architecture-brownfield-structure.md`. **Brownfield Migrate:** see `architecture-brownfield-structure.md` and `.nayan/guidance/brownfield-migration-use-cases.md` — validate pre/post architecture, migration strategy, data migration, cutover, dual-run, verification. **Brownfield B (add-feature with PRD):** see `architecture-impact-add-feature.md` — validate impact addendum/section (modules touched, new flows, impacted integrations). Do not handoff until this review is complete.

## Validation Steps (Run in Order)

1. **Input Readiness** — Verify PRD/scope is ready before starting
2. **Mermaid Diagram Validation** — Validate all diagrams for syntax errors
3. **Architecture Gap Validation** — Run `.nayan/guidance/architecture-gap-validation.md` checklist; fix any gaps
4. **PRD / Use Case Coverage** — Verify traceability and no use case missed
5. **HITL** — Confirm decisions with user before handoff

---

## Input Readiness (Before Starting)

**Do not begin architecture until input is ready.** See plan_input_requirements rule:

- **Greenfield:** refined-prd.md must have Sign-Off (Section 1) with all three roles (PM, Engineering Lead, Design) Approved, Approver Name, and Sign-Off Date filled for each; Use Cases (Section 7), Entities (Section 8), Domain Glossary (Section 15 Appendix), Non-Functional Expectations (Section 11); user must have approved PRD. **Reject PRD if Sign-Off is Pending, Needs Revision, or missing Name/Date.**
- **Brownfield A:** Condensed scope must have feature description, integration points, key domain terms; architect must have access to existing architecture.md and codebase
- **Brownfield Migrate:** Migration brief or condensed scope; existing (legacy) architecture or system context; codebase. Architect produces full architecture with pre/post, migration strategy, data migration, cutover per `brownfield-migration-use-cases.md`.
- **Brownfield B (add-feature with PRD):** refined-prd.md with Sign-Off Approved; existing architecture.md; codebase. Architect produces architecture impact per `architecture-impact-add-feature.md`, not full new architecture.

## Mermaid Diagram Validation

**Mandatory: Self-review and validate every diagram.** Detect and fix all Mermaid syntax errors **before** user approval and **before** handoff to prototype or plan.

### When to Validate

- **Immediately** after adding any new diagram (including when user requests a new diagram)
- **Immediately** after modifying any existing diagram
- **Before** presenting architecture to user for approval
- **Before** handoff to prototype or plan

Mermaid syntax errors must be avoided or rectified before user approval and before handoff.

### Validation Steps (Required)

1. **Self-review only** — Do not run any script or command for Mermaid validation. Validate each Mermaid block in architecture.md by reading the doc, checking each diagram for syntax errors (see common errors table below), and fixing any issues before presenting or handoff.
2. If any syntax error is found: fix it in architecture.md and re-check until all diagrams pass.
3. Do not present to user or handoff with unresolved syntax errors.

### Common Syntax Errors and Fixes

| Error cause                   | Fix                                                              |
| ----------------------------- | ---------------------------------------------------------------- |
| Double quotes `"` inside `[]` | Use single quotes `'` or remove quotes                           |
| Parentheses `()` inside `[]`  | Use hyphens or underscores instead                               |
| Reserved word `end` as label  | Use `["end"]` or rename to `finish`/`complete`                   |
| Reserved `subgraph`/`graph`   | Use `["subgraph"]` or different label (e.g. `phase`, `group`)    |
| Unclosed brackets or quotes   | Match all `[]`, `()`, `""`, `''` pairs                           |
| Colons `:` in node text/label | Use " - " or wrap label in brackets: `["Label: value"]`          |
| Angle brackets `<>` in labels | Use words (e.g. "optional") or escape; avoid raw `<` `>`         |
| Stray or malformed arrows     | Use `-->`, `---`, `--text-->`; no lone `-` or `>`                |
| Subgraph ID/label syntax      | Use `subgraph id [Label]`; no spaces in id; close with `end`     |
| Duplicate node IDs            | Ensure each node ID is unique or reuse same ID with same meaning |
| Sequence: missing participant | Declare `participant`/`actor` before use; correct arrow syntax   |
| C4 wrong directive            | Use `C4Context`, `C4Container`, `C4Component` (not flowchart)    |
| Invalid C4/flowchart keyword  | Check [Mermaid docs](https://mermaid.js.org/) for correct syntax |

### Diagram Requirements

- **Required types** (include all that apply): C4Context, C4Container, C4Component, data flow or sequence, end-to-end architecture & deployment diagram
- **Data flow / core end-to-end sequence**: 2–4 critical flows with sequence diagrams (e.g., auth, core feature)
- **End-to-end architecture & deployment**: Combined view of components + deployment topology
- **Labels**: Every diagram has a descriptive title; connections labeled with protocol (HTTPS, REST, etc.)

## Architecture Gap Validation

**Mandatory:** Run through `.nayan/guidance/architecture-gap-validation.md` before user approval and handoff.

- **Greenfield:** Verify all 23 required sections present; all diagram types (C4Context, C4Container, C4Component, ERD, 2–4 sequence); PRD traceability (use cases, constraints, open questions)
- **Brownfield A:** Verify all 16 required sections present; Pre + Post diagrams; Impacted Integrations subsection
- **Do not handoff** until gap validation passes. Fix any missing sections or diagrams.

## PRD / Use Case Coverage

- **Traceability**: Every use case from refined-prd.md Section 7 (or scope) is addressed in the architecture
- **Use cases**: Every use case has a corresponding module, API, or component in the design
- **No gaps**: If the PRD has N use cases, the architecture covers all N—no use case missed
- **Module & PRD use case mapping**: Mandatory section with table: Use Case ↔ Module ↔ API (greenfield) or scope ↔ modules ↔ APIs (brownfield)
- **NFRs & architecture**: How design supports performance, scalability, availability, monitoring
- **Security architecture**: Auth, authorization, encryption, audit, compliance
- **Error handling & resilience**: Retries, circuit breakers, fallbacks
- **Cross-cutting concerns**: Logging, monitoring, observability
- **External integrations**: When applicable (third-party APIs, contracts, failure handling)
- **Architecture risks & trade-offs**: Technical risks, limitations, known debt
- **Data migration strategy** (brownfield): Zero-downtime, rollback approach; or "No schema changes" when N/A
- **Product/feature migration** (brownfield, when applicable): API version migration, feature rollout/deprecation, product migration
- **Integration map & impact** (greenfield): Subsection within E2E & Deployment Diagram (Section 17); all integrations; impact propagation
- **Impacted integrations** (brownfield): Subsection within End-to-End Architecture & Deployment Diagram (Section 15), immediately after post diagram; change → affected modules/APIs/flows; downstream consumers
- **Domain model** (greenfield): Conceptual entities, relationships (align with PRD Domain Glossary)
- **Data model diagram (ERD)** (greenfield: always; brownfield: when schema changes): Entities, attributes, relationships, PK/FK; Mermaid erDiagram or equivalent
- **Database schema with table/column purpose** (greenfield: always; brownfield: when schema changes): For each table—purpose; for each column—purpose (business meaning), type, constraints
- **Testing strategy**: Testability, test boundaries, mock strategy
- **API versioning**: Versioning and compatibility strategy
- **Scope boundaries** (greenfield): MVP vs deferred; align with PRD Section 6
- **Open questions resolution** (greenfield): PRD Section 14; each Resolved, Deferred, or Escalated
- **Constraints mapping** (greenfield): PRD Section 13 constraints → architectural decisions
- **Per-integration contract** (when external integrations): System | Contract | Auth | Timeout | Retry | Fallback
- **Product-need sections** (when applicable): Algorithm (calculation logic), Data Retention, Platform Strategy

## Human-in-the-Loop (Architecture Decisions)

**HITL at decision points**—do not finalize without user confirmation:

| Decision              | When                                   | Action                                                                   |
| --------------------- | -------------------------------------- | ------------------------------------------------------------------------ |
| Tech stack            | After user selects Bootcamp/Enterprise/Custom | Confirm selection before documenting in architecture.md                  |
| Architectural pattern | Before module design                   | Present Modular Monolith vs Decoupled; wait for user choice              |
| Key modules           | Before detailed design                 | Present module list and responsibilities; confirm with user              |
| Final architecture    | Before handoff                         | Present full architecture.md; wait for explicit approval before new_task |

See sdlc_human_gates rule for Architecture sign-off gate.
