# Brownfield: Product & Feature Migration Use Cases

This document defines migration use cases for brownfield projects. When extending or changing an existing product, consider which migration scenario applies and document it in architecture or development plan.

---

## Migration Use Case Types

| Use Case                       | When                                    | Where Documented                                     | Key Considerations                                  |
| ------------------------------ | --------------------------------------- | ---------------------------------------------------- | --------------------------------------------------- |
| **Data Migration**             | Schema changes; existing data must move | architecture.md Section 4c; development-plan sprints | Zero-downtime, rollback, phased rollout             |
| **API Version Migration**      | Deprecating or replacing API versions   | architecture.md API Strategy; development-plan       | Backward compatibility, consumer migration timeline |
| **Feature Rollout**            | Gradual rollout of new feature          | architecture.md or development-plan                  | Feature flags, percentage rollout, A/B              |
| **Feature Deprecation**        | Removing or replacing a feature         | architecture.md; development-plan                    | User migration path, sunset timeline                |
| **Product Migration**          | Migrating from legacy to new system     | architecture.md; development-plan                    | Dual-run, cutover, data sync                        |
| **Module/Component Migration** | Moving code between modules (refactor)  | Brownfield D; qa output                              | Backward compatibility, verification                |

---

## 1. Data Migration

**When:** Schema changes (new entities, column changes, table splits).

**Document in:** architecture.md Section 4c (Data Migration Strategy); development-plan sprints.

**Include:**

- Zero-downtime approach (e.g., expand-contract, blue-green)
- Phased migration (if large dataset)
- Rollback plan
- Migration script strategy (idempotent, resumable)
- Verification: data integrity checks post-migration

**Reference:** `.nayan/guidance/architecture-brownfield-structure.md` Section 4c.

---

## 2. API Version Migration

**When:** Introducing API v2, deprecating v1; or changing API contracts.

**Document in:** architecture.md (API Additions/Changes); development-plan.

**Include:**

- Versioning strategy (URL path, header, query param)
- Backward compatibility: how long will v1 be supported?
- Consumer migration path: who consumes the API? Migration timeline?
- Deprecation timeline: sunset date for old version
- Impacted integrations: which consumers must migrate?

**Impacted Integrations:** Document in architecture Section 11a (Impacted Integrations).

---

## 3. Feature Rollout (Feature Flags)

**When:** Gradual rollout of new feature; A/B testing; percentage-based release.

**Document in:** architecture.md (if architectural) or development-plan.

**Include:**

- Feature flag strategy (tool, storage, evaluation)
- Rollout phases: % of users, criteria (e.g., by region, cohort)
- Rollback: how to disable feature if issues arise
- Cleanup: when to remove flag and make feature default

---

## 4. Feature Deprecation

**When:** Removing a feature; replacing with new implementation.

**Document in:** architecture.md (Scope of Change, ADRs); development-plan.

**Include:**

- Deprecation timeline: when will old feature be removed?
- User migration path: how do users move to new feature?
- Communication: how will users be notified?
- Fallback: what happens if users don't migrate by sunset?

---

## 5. Product Migration (Legacy to New)

**When:** Migrating from legacy system to new system; replacing entire product or major subsystem.

**Document in:** architecture.md (new section or Scope of Change); development-plan (dedicated migration sprints).

**Include:**

- Migration strategy: big-bang vs phased vs parallel run
- Data migration: schema mapping, ETL, validation
- Cutover plan: when does traffic switch? Rollback criteria?
- Dual-run period: running old and new in parallel
- Verification: how to confirm migration success

**This is a significant brownfield scenario** — use **brownfield-migrate**. Flow: **architect** (assess current state, plan migration architecture, pre/post diagrams) → **prototype** (when UI; migration UX) → **plan** (migration plan with sprints, cutover, verification). Do not skip architect or prototype (when UI) before planning. Do not classify as brownfield-add-feature or brownfield-extend. See `.nayan/rules-orchestrator/1_workflow.md` and `.nayan/rules-orchestrator/2_workflows_brownfield.xml` (pipeline id=brownfield-migrate).

---

## 6. Module/Component Migration (Refactor)

**When:** Moving code between modules; restructuring components (Brownfield D).

**Document in:** qa output; development-plan if scope is large.

**Include:**

- What moves, what stays
- Backward compatibility: do APIs/contracts change?
- Migration path: incremental steps
- Verification strategy: tests, manual checks

**Reference:** `.nayan/guidance/brownfield-use-cases.md` Brownfield D.

---

## When to Include Migration in Architecture

| Brownfield Type                            | Migration in Architecture?                                                                                                                                   |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Migrate** Product migration (legacy→new) | Yes — Pre/post architecture, migration strategy, data migration, cutover, dual-run. Architect → prototype (when UI) → plan. Use pipeline brownfield-migrate. |
| **A** Extend product                       | Yes — Data migration (4c), API version impact (5), Impacted integrations (11a). Feature rollout/deprecation if scope includes it.                            |
| **B** Add feature                          | Development-plan — Schema changes & migration (2.2) when applicable. Feature rollout if using flags.                                                         |
| **C** Fix bug                              | No — Unless fix requires data migration.                                                                                                                     |
| **D** Refactor                             | Code-reviewer — Migration path in refactor plan.                                                                                                             |

---

## Checklist: Migration Coverage

Before handoff, verify:

- [ ] **Data migration:** Documented when schema changes (zero-downtime, rollback)
- [ ] **API versioning:** Documented when API contract changes (compatibility, deprecation)
- [ ] **Impacted integrations:** Documented which integrations are affected by the change
- [ ] **Feature rollout/deprecation:** Documented when applicable (flags, timeline)
- [ ] **Product migration:** Documented when migrating from legacy (cutover, dual-run)

---

## References

- `.nayan/guidance/architecture-brownfield-structure.md` — Architecture sections for migration
- `.nayan/guidance/development-plan-brownfield-template.md` — Section 2.2 Schema Changes & Migration
- `.nayan/guidance/brownfield-use-cases.md` — Diagram and explanation requirements
