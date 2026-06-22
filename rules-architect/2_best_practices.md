# Architect Best Practices

**Scope:** Architecture (architecture.md) only. You do not create development-plan.md.

## Deliverable

- architecture.md with structure per `architecture-greenfield-structure.md` (greenfield) or `architecture-brownfield-structure.md` (brownfield A)
- Tech stack, architectural pattern, module design, database schema, API strategy (with versioning), deployment, ADRs
- **NFRs & architecture**: How design supports performance, scalability, availability, monitoring
- **Security architecture**: Auth, authorization, encryption, audit, compliance
- **Error handling & resilience**: Retries, circuit breakers, fallbacks
- **Cross-cutting concerns**: Logging, monitoring, observability
- **External integrations**: When applicable (third-party APIs, contracts, failure handling)
- **Architecture risks & trade-offs**: Technical risks, limitations, known debt
- **Domain model** (greenfield): Conceptual entities, relationships
- **Data model diagram (ERD)** (greenfield: always; brownfield: when schema changes): Entities, attributes, relationships, PK/FK
- **Database schema with table/column purpose** (greenfield: always; brownfield: when schema changes): For each table—purpose; for each column—purpose (business meaning), type, constraints
- **Testing strategy**: Testability, test boundaries, mock strategy
- **Data migration strategy** (brownfield): Zero-downtime, rollback approach; or "No schema changes" when N/A
- **Product/feature migration** (brownfield, when applicable): API version, rollout, deprecation, legacy migration
- **Integration map & impact** (greenfield): Subsection within E2E & Deployment Diagram; all integrations; impact propagation
- **Impacted integrations** (brownfield): Subsection within End-to-End Architecture & Deployment Diagram, after post diagram; change → affected modules/APIs/flows
- **Data flow / core end-to-end sequence**: 2–4 critical flows with sequence diagrams
- **End-to-end architecture & deployment diagram**: Components + deployment topology
- **Module & PRD use case mapping**: Traceability table (Use Case ↔ Module ↔ API)
- Mermaid diagrams (system context, container, component, data flow, deployment, sequence)
- Technical architecture and design decisions

## Validation Checklist

**Mandatory before handoff:** Review architecture.md and run through `3_architecture_validation.md`. Do not handoff until this review is complete:

- **Mermaid diagrams**: System context (C4Context), container (C4Container), component (C4Component), data flow or sequence, deployment if needed; **self-review after adding each diagram** — validate the doc for Mermaid syntax errors and fix any issues **before user approval and before handoff**
- **Use case coverage**: Every use case from PRD Section 7 mapped to modules/APIs; no use case missed
- Technology stack aligned with company standards (see architect-planning skill, Company Technology Stack section)
- Architecture Decision Records documented for key choices
- Clarifying questions asked before finalizing architecture

## HITL: Architecture Decisions (Human-in-the-Loop)

**Decision points**—confirm with user before proceeding:

1. **Input readiness** — Before starting: Greenfield—confirm refined-prd has all required sections. Brownfield A—confirm condensed scope has feature description, integration points. See plan_input_requirements rule
2. **Tech stack** — Confirm Bootcamp/Enterprise/Custom choice before documenting
3. **Architectural pattern** — Present Modular Monolith vs Decoupled; wait for user choice
4. **Key modules** — Present module list; confirm before detailed design
5. **Final sign-off** — Present full architecture; confirm "Does this fully address all requirements?"; wait for explicit approval before new_task

See sdlc_human_gates rule for Architecture sign-off gate.
