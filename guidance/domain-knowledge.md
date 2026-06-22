# Domain Knowledge in the SDLC

Domain knowledge must be captured early and flow through the pipeline so architecture, development plans, and code align with the business domain.

## Capture Points

| Phase                | Who  | What to Capture                                                 |
| -------------------- | ---- | --------------------------------------------------------------- |
| **PRD**              | prd  | Domain Glossary, core entities, key terminology, business rules |
| **Architecture**     | plan | Domain modules, bounded contexts (from PRD + user input)        |
| **Development Plan** | plan | Module–entity mapping, domain terms in sprint tasks             |
| **Code**             | code | Use domain terminology in naming (entities, APIs, variables)    |

## Domain Glossary (PRD Section 15 Appendix)

**Required.** Ask the user for domain-specific terms and definitions. Include:

| Term          | Definition                      | Example / Notes |
| ------------- | ------------------------------- | --------------- |
| [Domain term] | [What it means in this product] | [How it's used] |

- **Why:** Prevents misinterpretation; ensures plan mode and code mode use consistent language.
- **When:** During PRD creation. If user provides a draft, extract terms; if not, ask: "What key domain terms should we define? (e.g. Order, Shipment, SKU, Campaign)"
- **Flow:** Glossary in PRD → Architect references it → Development plan uses terms in modules/sprints → Code uses terms in naming.

## Core Entities (from PRD)

The PRD already requires "Map out data entities" and "Specify lifecycle operations." Ensure:

- Entity names match domain terminology (use Glossary).
- Relationships between entities reflect business reality.
- Lifecycle states use domain language (e.g. "Draft" vs "Submitted" vs "Shipped").

## Handoff: Domain Context

- **PRD → Architect:** PRD includes Domain Glossary (Section 15 Appendix). Architect reads it before designing modules.
- **Plan → Development Plan:** architecture.md references domain modules; development plan maps modules to entities from PRD.
- **Development Plan → Code:** Sprint tasks use domain entity names; code follows naming from PRD/architecture.

## Checklist: Domain Knowledge Considered

- [ ] Domain Glossary present in PRD (Section 15 Appendix)
- [ ] Entity names in PRD match domain terminology
- [ ] Architect module names align with domain (e.g. OrderModule, not "OrderManagementService" if domain says "Order")
- [ ] Development plan sprint tasks reference domain entities
- [ ] Code uses domain terms in API routes, models, variables (e.g. `/api/orders`, `Order`, not generic names)
