# Plan Input Requirements

Before delegating to **architect** (architecture phase) or **plan** (dev-plan phase), ensure the input has all information the receiving mode needs. **Do not proceed until these requirements are satisfied.** Use HITL to confirm readiness.

**Greenfield vs Brownfield:** Greenfield uses full PRD (refined-prd.md) per prd-template-v2 for architect. Brownfield A uses condensed scope (not full PRD) for architect. Brownfield B with PRD: architect receives refined-prd + existing architecture and produces architecture impact per architecture-impact-add-feature.md, then hands off to prototype/plan. Brownfield B without PRD: architect is skipped; plan/prototype receive architecture + feature spec directly.

---

## Greenfield: PRD Readiness (refined-prd.md)

The architect mode creates architecture from `refined-prd.md`. **Before handoff to architect**, verify:

### Mandatory Sections (Must Be Present)

PRD format per `.nayan/guidance/prd-template-v2.md` (15 sections).

| Section                             | Required For Architect | Purpose                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| ----------------------------------- | ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Sign-Off**                     | Yes                    | **One user = one role.** Creator approves for their role first; others approve when they receive the shared PRD. Each role requires a different approver. **All three roles (PM, Engineering Lead, Design) must have Status = "Approved"** — each with **Approver Name** and **Sign-Off Date** filled. **Approver Name:** Per SDLC human gates — use Nayan logged-in user from `environment_details`. Do NOT accept Pending or Needs Revision. **Do not mark Approved until user has given explicit sign-off** — sign-off is the last step before handoff. Block handoff until sign-off is complete. |
| **7. Use Cases**                    | Yes                    | Traceable use cases; Steps, Acceptance Criteria; each use case maps to modules/APIs                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **8. Data, Entities & Information** | Yes                    | Entities, data elements; module/entity naming                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **11. Non-Functional Expectations** | Yes                    | Performance, availability, security, accessibility, platform                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| **15. Appendix (Glossary)**         | Yes                    | Domain Glossary for module/entity naming; consistent terminology                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |

### Traceability

- Each use case in Section 7 is a traceable unit (optional US-###/FR-### identifiers for pipeline compatibility)
- Entities in Section 8 align with Domain Glossary in Section 15
- Use cases and entities provide sufficient detail for architecture design

### PRD Gap Validation (Mandatory)

**Before handoff to architect**, run `.nayan/guidance/prd-gap-validation.md` — verify all 15 sections present, Sign-Off complete, architect-required sections (7, 8, 11, 15) sufficient, no gaps. Do not handoff until validation passes.

### HITL: PRD Readiness Gate

**Before handoff to architect**, prd (or orchestrator) must:

1. **Present** refined-prd.md to user
2. **Confirm:** "Does the PRD contain all required information for architecture? (Use Cases, Entities, Domain Glossary, Non-Functional Expectations, Sprint cadence or week of work for MVP when applicable)"
3. **Wait for explicit approval** — user confirms content is good. Do NOT mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off.
4. **Then verify Sign-Off:** Ask "Which role are you? (PM, Engineering Lead, or Design)" — do NOT assume or default to PM. Fill Approver Name and Sign-Off Date for the role the user identifies. PRD Section 1 Sign-Off table must have PM, Engineering Lead, Design all with Status = "Approved", **Approver Name**, and **Sign-Off Date** filled for each. One user = one role; each role requires a different approver. If any role has Pending, Needs Revision, or missing Name/Date, **do NOT handoff**. If creator's role is Approved but others Pending, direct user to share PRD with Engineering Lead and Design per prd-sharing-sign-off.
5. **Run PRD gap validation** — `.nayan/guidance/prd-gap-validation.md`; fix any failures before handoff
6. If gaps exist: ask user to fill gaps or iterate before proceeding

**Sign-off rule:** Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off. Sign-off is the last step before handoff to architect.

**PRD sharing for sign-off:** When sharing PRD with another for approval, use manual hand-off (share task → direct recipient to PRD approval) or Slack/Gmail integration. See `.nayan/guidance/prd-sharing-sign-off.md`.

**Reference:** `.nayan/guidance/prd-template-v2.md` — 15 mandatory sections

---

## Brownfield A: Condensed Scope Readiness

The architect mode extends existing architecture from condensed scope. **Before delegating to architect**, ensure:

### Scope Must Include

| Element                           | Required | Purpose                                                                                                                                                        |
| --------------------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Feature/extension description** | Yes      | What is being added or extended                                                                                                                                |
| **Key domain terms**              | Yes      | Naming consistency with existing. **If absent, orchestrator (or prd provider) must ask user before delegating to Architect.** Architect uses; does not re-ask. |
| **Functional scope**              | Yes      | What capabilities the extension provides                                                                                                                       |
| **Integration points**            | Yes      | How it connects to existing modules/APIs                                                                                                                       |
| **Existing architecture.md**      | Yes      | Architect must have access                                                                                                                                     |
| **Existing codebase**             | Yes      | Architect must have access (or repo path). Architect will analyze folder structure and align architecture to existing or propose changes.                      |

### Condensed Scope Template

Use `.nayan/guidance/condensed-scope-template.md` when creating or structuring scope for Brownfield A.

### HITL: Scope Readiness Gate

**Before delegating to architect**, orchestrator must:

1. Confirm user has provided: feature description, scope, and access to architecture.md and codebase
2. **If scope is vague:** Ask user to clarify: "What feature/extension are you adding? What are the key capabilities? How does it connect to existing modules?"
3. **Present scope summary** to user; wait for confirmation before delegating to architect
4. Include in delegation: SCOPE (or condensed-scope.md), ARCHITECTURE_FILE, and instruction to extend per architecture-brownfield-structure.md

**Reference:** `.nayan/guidance/condensed-scope-template.md`

---

## Brownfield Migrate: Migration Brief / Scope Readiness

When **brownfield-migrate** (product migration legacy→new), orchestrator delegates to **architect** first. Architect receives migration brief or condensed scope, existing (legacy) architecture or system context, and codebase. **Before delegating to architect**, ensure: migration scope (what is being migrated, legacy vs target), key domain terms, integration points, access to legacy system context or architecture, codebase. Architect produces architecture.md with pre/post diagrams, migration strategy, data migration, cutover, dual-run, verification per `.nayan/guidance/brownfield-migration-use-cases.md`. Plan then receives architecture and produces **migration plan** (sprints, cutover, verification). Do not skip architect or prototype (when UI) before plan.

---

## Brownfield B: Architect When PRD Used

When brownfield-add-feature or **enhance-existing-feature** uses PRD (including when user provides JIRA ID, SOW, or PRD for add/enhance): **when user provides JIRA or SOW (instead of a full PRD), entry is brainstorm first** — orchestrator → brainstorm (deep understanding with user via Q&A/brainstorm) → prd → architect. When user provides full PRD: orchestrator → prd → architect. PRD hands off to **architect**. Architect receives refined-prd.md (Sign-Off Approved) + existing architecture.md + codebase and produces **architecture impact** per `.nayan/guidance/architecture-impact-add-feature.md` (addendum or impact section), then hands off to prototype (when UI) or plan (when API-only). **Add/enhance with PRD always uses architect.** Before handoff to architect, same PRD readiness as Greenfield (Sign-Off Approved, Use Cases, Entities, Domain Glossary, NFRs). When PRD is skipped (feature small, spec clear, no JIRA/SOW/PRD), orchestrator delegates to prototype/plan directly; plan receives architecture.md and feature spec for dev-plan phase.

---

## Summary

| Pipeline                                | Input                                                                                 | Readiness Gate Before Architect                                                                                                                             |
| --------------------------------------- | ------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Greenfield**                          | refined-prd.md                                                                        | PRD has 15 sections; **Sign-Off all three roles Approved with Approver Name and Sign-Off Date**; Use Cases, Entities, Domain Glossary, NFRs; user approved  |
| **Brownfield A**                        | Condensed scope + architecture.md + codebase                                          | Scope has feature description, integration points; user confirmed; architect has access to files                                                            |
| **Brownfield Migrate**                  | Migration brief or condensed scope + legacy architecture or system context + codebase | Architect produces full architecture with pre/post, migration strategy, cutover; then prototype (when UI) → plan (migration plan).                          |
| **Brownfield B (add-feature with PRD)** | refined-prd.md + architecture.md + codebase                                           | Same as Greenfield for PRD; architect has access to existing architecture.md; architect produces architecture impact per architecture-impact-add-feature.md |
