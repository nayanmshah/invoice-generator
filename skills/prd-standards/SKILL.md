---
name: prd-standards
description: Canonical PRD structure with 15 mandatory sections per prd-template-v2. All PRDs must be generated in this format only.
modeSlugs:
    - prd
---

# PRD Standards (Template v2)

**All PRDs must follow the structure in `.nayan/guidance/prd-template-v2.md`.** This is the only acceptable format.

## 15 Mandatory Sections (Exact Order)

1. **Basic Information** — Project name, priority, target release; **Create table** (Nayan, User Name, Create Date — two create names: Nayan AI and logged-in user who created using Nayan); **Sign-Off table** (PM, Engineering Lead, Design) with Status: Pending / Approved / Needs Revision. **One user = one role.** Creator approves for their role only; others approve when they receive the shared PRD. **Handoff to architect requires all three roles = Approved** (each by a different approver).
2. **Problem Statement** — What problem, who has it, how they experience it today
3. **KPIs & Business Justification** — Key Performance Indicators table, revenue/business impact, why essential now
4. **Success Criteria** — How we measure success, what "done" looks like
5. **Users & Personas** — User Type table, user context
6. **Scope** — In scope (MVP), out of scope
7. **Use Cases** — Each use case: As a/I want to/So that, Steps, Acceptance Criteria, Business Rules, Validation Rules, Calculation Logic, State Transitions (include only applicable sub-sections)
8. **Data, Entities & Information** — Entities involved, data elements, what is created/stored, privacy & sensitivity
9. **Integrations** — External systems, internal systems
10. **Error Handling & Edge Cases** — Expected errors, edge cases
11. **Non-Functional Expectations** — Performance, availability, security, accessibility, platform support
12. **UI/UX Requirements** — Design assets, key UI elements, interaction patterns
13. **Constraints & Dependencies** — Constraints, dependencies table
14. **Open Questions** — Question table with impact if unresolved
15. **Appendix** — Glossary (Domain Glossary), References

## Traceability for Nayan Pipeline

- **Domain Glossary:** Section 15 (Appendix). Plan uses for module/entity naming. See `.nayan/guidance/domain-knowledge.md`
- **Use Cases:** Section 7. Each use case is a traceable unit. Optional US-###/FR-### identifiers for plan traceability
- **Entities:** Section 8. Plan uses for data model and schema
- **NFRs & Security:** Section 11 (Non-Functional Expectations)

## Concluding Phrase

"PRD Complete - Ready for architect (and prototype when UI)."

## Gap Validation

**Before handoff:** Run `.nayan/guidance/prd-gap-validation.md` for initial-prd.md and refined-prd.md. Verify all 15 sections present, no gaps. For refined-prd handoff to architect: Sign-Off complete, architect-required sections (7, 8, 11, 15) sufficient.
