# PRD Gap Validation

**Purpose:** Validate initial-prd.md and refined-prd.md against the required template to ensure no gaps before handoff. Run this validation **before** presenting to user and **before** handoff to architect (refined-prd) or refinement phase (initial-prd).

**Reference:** `.nayan/guidance/prd-template-v2.md` (15 mandatory sections) | `.nayan/skills/prd-standards/SKILL.md`

---

## How to Run

1. **Identify document:** initial-prd.md (creation) or refined-prd.md (refinement)
2. **For each row below:** Search the PRD for the section; verify content is present and not blank/placeholder
3. **Do not handoff** until all required items pass
4. **Fix gaps** before presenting to user

---

## All PRDs: 15 Mandatory Sections Checklist

| #   | Section                       | Verification Check                                                                                                                                                                                                                   | Pass/Fail |
| --- | ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------- |
| 1   | Basic Information             | Project Name, Priority, Target Release filled; **Create** table (Nayan, User Name, Create Date) — two create names; Sign-Off table present                                                                                          |           |
| 2   | Problem Statement             | What problem, who has it, how they experience it today — substantive content                                                                                                                                                         |           |
| 3   | KPIs & Business Justification | KPI table or narrative; revenue/business impact; why essential now                                                                                                                                                                   |           |
| 4   | Success Criteria              | How we measure success; what "done" looks like                                                                                                                                                                                       |           |
| 5   | Users & Personas              | User Type table or list; user context                                                                                                                                                                                                |           |
| 6   | Scope                         | In scope (MVP); out of scope — clearly defined                                                                                                                                                                                       |           |
| 7   | Use Cases                     | At least one use case with As a/I want to/So that; Steps; Acceptance Criteria                                                                                                                                                        |           |
| 8   | Data, Entities & Information  | Entities involved; data elements; privacy & sensitivity when applicable                                                                                                                                                              |           |
| 9   | Integrations                  | External systems; internal systems — or "None" if N/A                                                                                                                                                                                |           |
| 10  | Error Handling & Edge Cases   | Expected errors; edge cases — or "See use case validation" if minimal                                                                                                                                                                |           |
| 11  | Non-Functional Expectations   | Performance, availability, security, accessibility, platform — specified                                                                                                                                                             |           |
| 12  | UI/UX Requirements            | Design assets; key UI elements; interaction patterns — or "N/A" if API-only. **When UI in scope (not N/A):** visual depth/surface style, theme, responsive strategy, design system, material types must be filled or marked deferred |           |
| 13  | Constraints & Dependencies    | Constraints; dependencies table — or "None" if N/A                                                                                                                                                                                   |           |
| 14  | Open Questions                | Question table with impact — or "None" if all resolved                                                                                                                                                                               |           |
| 15  | Appendix                      | Domain Glossary (Glossary) with at least key terms; References if applicable                                                                                                                                                         |           |

---

## Create Validation (Section 1)

| Check       | Verification                                                                   | Pass/Fail |
| ----------- | ------------------------------------------------------------------------------ | --------- |
| Nayan      | "Nayan" when AI created the document                                          |           |
| User Name   | Filled with logged-in user who created using Nayan (from environment_details) |           |
| Create Date | Filled (YYYY-MM-DD format)                                                     |           |

## Sign-Off Validation (Section 1) — Required for refined-prd Handoff to Architect

| Check                   | Verification                                                      | Pass/Fail |
| ----------------------- | ----------------------------------------------------------------- | --------- |
| All three roles present | PM, Engineering Lead, Design in Sign-Off table                    |           |
| Status = Approved       | Each role has Status = "Approved" (not Pending or Needs Revision) |           |
| Approver Name filled    | Each Approved role has Approver Name (not blank)                  |           |
| Sign-Off Date filled    | Each Approved role has Sign-Off Date (not blank)                  |           |

**Block handoff** if any role has Pending, Needs Revision, or missing Approver Name/Date.

**Note:** Creator approves for their role only; other roles stay Pending until the people in those roles approve via shared PRD. One user = one role; each role requires a different approver.

---

## Architect-Required Sections (refined-prd.md) — Must Pass Before Handoff to Architect

| Section                 | Verification                                                                      | Pass/Fail |
| ----------------------- | --------------------------------------------------------------------------------- | --------- |
| 7. Use Cases            | Traceable use cases; Steps, Acceptance Criteria; each maps to implementable scope |           |
| 8. Data, Entities       | Entities listed; key fields; relationships; sufficient for data model             |           |
| 11. Non-Functional      | Performance, availability, security, accessibility, platform specified            |           |
| 15. Appendix (Glossary) | Domain Glossary with key domain terms; consistent with entities in §8             |           |

---

## Use Case Quality (Section 7)

| Check                      | Verification                                                                                      | Pass/Fail |
| -------------------------- | ------------------------------------------------------------------------------------------------- | --------- |
| As a / I want to / So that | Each use case has user story format                                                               |           |
| Steps                      | Numbered steps with user action and system response                                               |           |
| Acceptance Criteria        | Clear, testable criteria                                                                          |           |
| Applicable sub-sections    | Business Rules, Validation Rules, Calculation Logic, State Transitions — include where applicable |           |

---

## Concluding Phrase

| Document       | Required Phrase                                                                                 | Pass/Fail                                         |
| -------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| initial-prd.md | —                                                                                               | (No specific phrase; used as input to refinement) |
| refined-prd.md | "PRD Complete - Ready for architect mode (architecture) and prototype (when UI)." or equivalent |                                                   |

---

## Common Gaps to Avoid

| Gap                                    | Required Instead                                                                                                             |
| -------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Blank Sign-Off                         | All three roles Approved with Approver Name and Sign-Off Date (creator approves for their role first; others via shared PRD) |
| Empty Use Cases                        | At least one use case with Steps and Acceptance Criteria                                                                     |
| No Domain Glossary                     | Section 15 Appendix with Glossary table; key terms defined                                                                   |
| Missing NFRs                           | Section 11: Performance, availability, security, platform specified                                                          |
| Vague Scope                            | Clear IN scope (MVP) and OUT of scope                                                                                        |
| Placeholder content                    | Replace [Name], [TBD], etc. with actual content                                                                              |
| Section 12 incomplete when UI in scope | Visual depth, theme, responsive, design system, material types filled or marked deferred                                     |
| Entities not in Glossary               | Entities in §8 must align with terms in §15 Glossary                                                                         |

---

## Validation Output

**Before handoff:** All required items must pass. Document any failures and fix before presenting to user.

| Result   | Action                                      |
| -------- | ------------------------------------------- |
| All Pass | Proceed to user approval and handoff        |
| Any Fail | Fix gaps; re-run validation; do not handoff |

---

## References

- `.nayan/guidance/prd-template-v2.md` — 15 mandatory sections
- `.nayan/guidance/plan-input-requirements.md` — Plan readiness gate
- `.nayan/skills/prd-standards/SKILL.md` — Canonical PRD structure
- `.nayan/skills/prd-creation/SKILL.md` — PRD creation and refinement methodology
