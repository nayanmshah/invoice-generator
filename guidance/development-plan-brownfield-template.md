# Development Plan: Brownfield Template

Use when extending an existing product (Brownfield A or B) or **product migration legacy→new (Brownfield Migrate)**. Architecture and codebase already exist. **When pipeline is brownfield-migrate:** Include dedicated migration sprints, cutover plan, and verification per `.nayan/guidance/brownfield-migration-use-cases.md` (Section 5. Product Migration).

**Sprint Format:** Use `.nayan/guidance/development-plan-sprint-format.md` for HITL, tasks, verification, and sample sprints.

**Tech stack:** Use the tech stack from architecture.md. Do not re-define or override. See `.nayan/rules-architect/2_tech_stacks.md` (architect documents tech stack; plan consumes from architecture.md).

**Brownfield differences:**

- **Sprint 0**: Omit when the existing codebase is already runnable; include only if new packages, env config, or migrations are required.
- **Task content**: Extend existing modules and APIs rather than create from scratch (e.g. "Add endpoint to existing /api/products" vs "Create /api/products").

---

## Top-Level Structure

1. **# Development Plan: [Feature/Extension Name] — [Product Name]**
2. **## Create** — Table with Nayan, User Name, Create Date. Two create names: Nayan (AI) and User Name (logged-in user who created using Nayan, from `environment_details`). Format: `| Nayan | User Name | Create Date |`
3. **## 1. Context & Existing Assets**
4. **## 2. Changes to Application Anatomy**
5. **## 3. Incremental Delivery Plan**

## Section 1: Context & Existing Assets

- **### 1.1. Existing Architecture Summary** — Tech stack (from architecture.md—use as-is), modules, key patterns from architecture.md
- **### 1.2. Scope of Change** — What is being added or extended (condensed scope or feature spec)
- **### 1.3. Integration Points** — How the new work connects to existing modules, APIs, data
- **### 1.4. Existing Folder Structure** — **MANDATORY**: Analyze the current codebase. Use `list_dir` or equivalent to discover the actual folder structure. Document the existing tree (```text block) with inline comments. **When Decoupled Fullstack:** Document **Repository Strategy** — single `.git`at root (single repo) or no`.git`at root and one or more child dirs have`.git`(multi-repo). For multi-repo: discover child repos (list immediate child dirs; for each`D`, check `D/.git`); document actual dir names (e.g., web-app, api) as REPO_DIRS. Plan derives REPO_STRATEGY from this. This is the baseline for Section 2.6 — folder structure changes are derived from existing vs. desired.

**Brownfield B diagram requirements:** Include **flow diagrams** for each new user flow or feature path (sequence or flowchart). No pre/post architecture diagrams—architecture is unchanged. When PRD was used, architect produced architecture impact (use architecture.md + impact). When PRD was skipped, plan derives from architecture.md and feature spec. See `.nayan/guidance/brownfield-use-cases.md`.

## Section 2: Changes to Application Anatomy

- **### 2.1. New or Modified Modules** — Modules being added or extended
- **### 2.2. Schema Changes & Migration** (when applicable) — New entities, migrations; if schema changes: document migration approach (zero-downtime, rollback). If no schema changes: state "No schema changes."
- **### 2.3. Impacted Integrations** — Which existing integrations are affected by this change? Impact chain: change → affected modules → affected APIs → affected flows. **Brownfield A:** Reference architecture Section 15 (subsection). **Brownfield B:** Document here.
- **### 2.4. Product/Feature Migration** (when applicable) — API version migration, feature rollout (flags), feature deprecation, product migration (legacy→new). See `.nayan/guidance/brownfield-migration-use-cases.md`. If none: state "No product/feature migration."
- **### 2.5. NFRs & Security Impact** (when applicable) — If feature touches performance, scalability, auth, or compliance: document impact. If none: state "No NFR/Security impact."
- **### 2.6. Folder Structure Changes** — **MANDATORY**: Derive from **Section 1.4 (Existing Folder Structure)**. Compare existing vs. desired. Show only **new** or **changed** directories. Align to existing conventions (naming, depth, layout). Use ```text block with inline comments.

```text
# New or changed directories only (existing structure from Section 1.4)
# Add within existing layout; follow existing conventions
src/
├── app/
│   ├── api/
│   │   └── new-feature/         # NEW: API routes for [feature]
│   │       ├── routes.ts
│   │       └── handlers/
│   └── (new-role)/              # NEW: Pages for [role]
│       ├── page.tsx
│       └── components/
└── ...
```

**Rule:** Analyze existing structure first (Section 1.4). Folder structure changes must align to existing architecture and conventions. Sprint tasks create only the new/changed directories.

## Section 3: Incremental Delivery Plan

- **### HITL Overview** — Brief summary: "User approval required at: (1) development plan sign-off, (2) **user-provided inputs** (repo URL or REPO_FRONTEND + REPO_BACKEND when Decoupled with frontend/backend, or REPO_DIRS + per-repo URLs when generic multi-repo, DB URL, env vars, API keys, deployment target—ask, never assume), (3) after each critical task (local verification), (4) tests pass and coverage reported per sprint, (5) code quality gate and security scan before PR, (6) sprint completion before commit/PR, (7) **PR per sprint** — human reviewer approves before merge, (8) deployment sprint — user approval at each step. **Decoupled Fullstack + multi-repo:** per-repo commit and PR. See sdlc_human_gates rule."
- **### THE SPRINT PLAN**
- **#### Sprint 0** — Omit if no scaffolding needed. Include only if new packages, env config, or migrations required. Include HITL Checkpoints (see `.nayan/guidance/development-plan-sprint-format.md`).
- **#### Sprint 1: [Feature]** — First feature sprint with granular tasks
- **#### Sprint 2+: [Feature]** — Continue for each sprint
- **#### Deployment Sprint** — After all feature sprints: code quality, security scan, [User Input] deployment target, pre-deploy approval, deploy, post-deploy verification. See `.nayan/guidance/development-plan-sprint-format.md`. Aligns brownfield-extend and brownfield-add-feature with greenfield.
- **---** and **Development Plan Complete - Ready for implementation.**

---

## Sample: Brownfield Sprint (Add Feature to Existing)

````markdown
#### Sprint 1: Add Product Search

**Project Context:** E-commerce app already has auth and catalog. This sprint adds search to the existing product API and UI.

**Previous Sprint's Accomplishments:** N/A (or list prior brownfield sprints)

**Goal:** Users can search products; existing catalog and auth unchanged.

**Relevant Requirements & User Stories:**

- As a [user type], I need to search [items] by [criteria].

**HITL Checkpoints:**

- _After Task 2_: "Please verify search API works with existing product data." — Wait before Task 3.
- _After Task 4_: "Please verify tests pass and coverage is reported." — Wait before Task 5.
- _After Task 5_: "Please verify end-to-end flow: search input → API → results. All integration points work." — Wait before Task 6.
- _Sprint completion_: "All sprint functionality verified locally? Tests pass? Coverage reported? End-to-end flow confirmed?" — Wait for "yes" before commit/PR.

**Tasks:**

1. **Database** — Add search index or use existing; no new model if full-text search on Product.

2. **Backend: Extend Product API** — Add `?q=` param to GET /api/products; wire to DB/search.

3. **Frontend: Extend Catalog UI** — Add search input to existing catalog page.

4. **Tests & Code Coverage** — Unit tests for ProductService.search(); integration tests for GET /api/products?q=; frontend tests for search input. Run coverage; ensure new search code is covered.

5. **Tech Stack Integration: End-to-End Search Flow**

    - Connect search input → extended API → DB.
    - [User Input] "Please verify: type in search, results update. All integration points work." — Wait for confirmation.

6. **Sprint Branch, Commit & Deployment**

    - `git checkout -b sprint-1`
    - Commit (detailed):

        ```
        feat(sprint-1): add product search - API param, UI, integration

        Sprint 1 Accomplishments:
        - GET /api/products?q= query param for search
        - ProductService.search() with DB filter
        - Search input in catalog UI; debounced API call
        - Unit and integration tests for search; coverage reported
        - Verified local testing: search returns filtered results end-to-end
        ```

    - [User Input] Confirm deployment before PR.

**Verification Criteria:** Search works end-to-end; tests pass; coverage reported; all tech stack integration points validated by user. **User must confirm** before proceeding.
````
