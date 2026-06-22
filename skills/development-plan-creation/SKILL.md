---
name: development-plan-creation
description: Provides the methodology for creating sprint-based development plans from PRDs including technology stack selection, architecture decisions, sprint structure, and deployment strategy.
modeSlugs:
    - plan
---

# Development Plan Creation Methodology

For workflow steps, see `.nayan/rules-plan/1_workflow.md` and `.nayan/rules-plan/2_sprint_structure.md`. This skill provides Bootcamp stack methodology. See sdlc_human_gates rule for development plan sign-off gate.

## When to Use This Skill

Use this skill when:

- Creating a development plan from a finalized PRD
- Designing sprint-based implementation roadmaps
- Selecting technology stacks and architecture patterns
- Planning deployment strategies and user input protocols

## When NOT to Use This Skill

Do NOT use this skill when:

- Implementing code (use Code mode)
- Creating PRDs (use PRD Architect or PRD Refiner modes)
- Debugging or testing

## Critical File Creation Requirement

**MANDATORY**: After completing your analysis, you MUST use the `write` tool to create a file named `development-plan.md` with the complete plan content. Do NOT just describe what you would create - actually create the file. The output MUST follow the **Output Template** structure defined in this skill (see Output Template section below).

## Critical Anti-Premature Completion Rule

**ABSOLUTELY FORBIDDEN**: You MUST NOT claim completion until you have:

1. Completed ALL steps in the workflow (see rules-plan/1_workflow.md and rules-plan/2_sprint_structure.md)
2. Created the actual `development-plan.md` file using the `write` tool
3. Verified the file exists and contains the complete plan

## Input Synthesis

The development plan synthesizes requirements and the architecture document into one cohesive roadmap:

- **From architecture.md**: **Technology stack (use as-is—do not re-define or override)**, including **deploy tech stack** (frontend/backend deployment platforms, cloud). Deploy tech stack is **selected and documented in architecture.md by the architect** (see architect-planning skill); the development plan **consumes** it—do not re-select or override deployment targets. Also from architecture: database schema, API endpoints, technical decisions, deployment strategy, module/component design, etc.
- **Greenfield (refined-prd.md)**: Feature scope, use cases (Section 7), acceptance criteria, **Domain Glossary (Section 15 Appendix)** for consistent terminology. PRD format per `.nayan/guidance/prd-template-v2.md`.
- **Brownfield (condensed scope or feature spec)**: Key domain terms (Section 2), functional scope, integration points. Use `.nayan/guidance/condensed-scope-template.md` structure when scope is provided.
- **From UX artifacts (when UI involved):** The **approved UX prototype** (with explicit sign-off) is the **authoritative source for UI design and final look-and-feel**. Sprint tasks for frontend/UI must reference the prototype path and instruct implementation to match it **using the tech stack from architecture.md** (documented in architecture.md by architect). Do not deviate from the prototype's layout, components, or interaction patterns.

**Tech stack is documented in architecture.md**: The development plan (folder structure, sprint tasks, commands, deployment) is **based on the tech stack documented in architecture.md**. Bootcamp → use Bootcamp structure; Enterprise → use Enterprise structure; Custom → derive from what is documented in architecture.md. Do not re-define or override.

## Methodology Overview

1. Analyze refined PRD and architecture requirements
2. Identify technology stack — use architecture.md as-is; default Bootcamp or Enterprise per orchestrator choice
3. Synthesize PRD requirements to architecture's technical design
4. Design domain-driven module structure
5. Define application anatomy (modules, responsibilities, interfaces, folder structure)
6. Draft detailed sprint-by-sprint roadmap with PRD traceability
7. Plan deployment strategy **(from architecture.md—do not re-select deploy tech stack)** and user input requirements
8. Write development-plan.md with finalized plan

## Architecture Decision Framework

**Modular Monolith**: When frontend and backend share a single runtime (e.g., full-stack Next.js with API routes). Single codebase — no separate `/frontend` and `/backend`. Folder structure: `src/app/api/`, `(auth)/`, `({persona})/`, `components/`, `lib/`. See greenfield template "Modular Monolith" example.

**Decoupled Fullstack (Monorepo)**: When the frontend and backend use different runtimes or languages (e.g., Next.js + Python/FastAPI, Angular + Spring Boot). Organize as monorepo with distinct `/frontend` and `/backend` directories. Folder structure: separate trees for frontend and backend. See greenfield template "Decoupled Fullstack" examples.

**Microservices**: Decoupled + multiple backend services (e.g., api-gateway, user-service, catalog-service). Use when: Polyglot Runtimes, Disparate Scaling Needs, Data Siloing Mandates. Folder structure: `/backend/{service}/` per service. See greenfield template "Decoupled + Microservices" (Enterprise) example.

**Folder structure selection:** Use the structure that **matches the architecture pattern** in Section 1.1. Monolith → single-tree; Decoupled → /frontend + /backend; Microservices → /frontend + /backend with multiple services.

**Repository Strategy (Decoupled Fullstack only):** When architecture pattern is Decoupled Fullstack:

- **Greenfield:** Ask user: "Monorepo (single repo with frontend/ and backend/ dirs) or multi-repo (separate repos)?" Document choice in architecture.md. If multi-repo: when frontend/backend, use REPO_FRONTEND and REPO_BACKEND; when project-specific names, document REPO_DIRS and collect per-repo URLs.
- **Brownfield:** Detect from existing architecture and codebase (Section 1.4 Existing Folder Structure). One `.git` at root → single. No `.git` at root and one or more child dirs have `.git` → multi. Discover child repos; document REPO_DIRS. **When introducing new Decoupled layout** (e.g., splitting monolith into frontend + backend): Ask user "Monorepo or multi-repo?" See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.

## Document Structure

**Greenfield** (new product): Use `.nayan/guidance/development-plan-greenfield-template.md`. Required sections: 1. Foundational Strategy & Technology Choices (1.1–1.5), 2. Application Anatomy & Design (2.1–2.4), 3. Incremental Delivery Plan.

**Brownfield** (extend existing product): Use `.nayan/guidance/development-plan-brownfield-template.md`. Required sections: 1. Context & Existing Assets (1.1–1.4), 2. Changes to Application Anatomy (2.1–2.6), 3. Incremental Delivery Plan. **MANDATORY:** Section 1.4 — Analyze existing codebase folder structure (list_dir or equivalent); document the tree. Section 2.6 — Derive folder structure changes from existing (1.4) vs. desired; align to existing conventions.

**Sprint format** (both): Use `.nayan/guidance/development-plan-sprint-format.md`.

## Application Anatomy (Required Section)

Include an **Application Anatomy** or **Module Design** section that deconstructs the application into logical, domain-driven modules. This section must contain:

### 2.1. Module Identification

- **Domain Modules**: Identify 2–5 modules derived from requirements. **Greenfield:** Use Domain Glossary (PRD Section 15 Appendix). **Brownfield:** Use Key Domain Terms from condensed scope (Section 2). Match domain terms—e.g., AuthModule, OrderModule, ShipmentModule.
- **Infrastructure Modules**: DatabaseModule, external service modules (e.g., AIModelModule, AuthProviderModule).
- **Shared Module**: Common UI components, hooks, utilities, and type definitions.

### 2.2. Module Responsibilities and Interfaces

- **Responsibilities**: For each domain module, state what it owns (data, endpoints, business logic).
- **Interfaces**: Define how modules interact (e.g., "FeatureModule uses AIModelModule to generate content").

### 2.3. Folder Structure

**MANDATORY FORMAT**: Use a ```text code block with **deep** tree structure (3–4 levels minimum). Each directory must have an inline comment. **Based on tech stack documented in architecture.md:** Bootcamp → Bootcamp structure; Enterprise → Enterprise structure; Custom → derive from framework conventions in architecture.md. Match architecture pattern (Monolith vs Decoupled). Use `.nayan/guidance/development-plan-greenfield-template.md` — select the example that matches the documented tech stack; adapt domain names and personas from PRD.

**Depth requirement:**

- **Modular Monolith:** Single tree (e.g., `src/app/api/auth/`, `api/products/`, `(auth)/`, `({persona})/`, `components/ui/`, `components/features/`, `lib/`). At least 3–4 levels. Include auth when Sprint 1 has auth.
- **Decoupled/Microservices — Frontend:** Show `src/app/` (or equivalent), then `core/`, `shared/`, `features/` with feature subdirs, `layout/`. For Angular: each persona portal with full `src/app/` structure; `shared-lib` with `components/`, `services/`, `models/`, `pipes/`. **When Sprint 1 includes auth:** MUST include `core/auth/`, `core/interceptors/`, `features/auth/` in each portal.
- **Decoupled/Microservices — Backend:** Each service with `src/main/java/.../` then `controller/`, `service/`, `repository/`, `model/`, `config/`. For Spring Boot: api-gateway with `config/`, `filter/`; each domain service with full package structure; common-lib with `dto/`, `exception/`, `security/`. **When Sprint 1 includes auth:** MUST include user-service with `controller/auth/`, `service/auth/`; api-gateway `filter/` for JWT; common-lib `security/`.

**Sprint alignment:** Sprint 0 tasks must **create the full folder structure** as outlined in Section 2.3. Sprint 1+ tasks must add implementation **within** those directories. Sprints fulfill the folder structure — every directory in the tree should be created by Sprint 0 or populated by subsequent sprints.

See `.nayan/guidance/development-plan-greenfield-template.md` — use the example that matches the **tech stack documented in architecture.md** (Bootcamp, Enterprise, or Custom). For Custom, derive from architecture.md framework conventions.

### 2.4. Key Patterns

- **Data Access**: Repository pattern or equivalent for data access logic.
- **Business Logic**: Service layer for orchestration and business rules.

## Technology Stack

**Tech stack (including deploy tech stack) is documented in architecture.md.** The architect selects and documents the full stack—frontend, backend, database, **and deployment** (frontend/backend platforms, cloud)—in architecture.md. All development plan content—folder structure, sprint tasks, run commands, **deployment targets**—is **based on** the tech stack documented in architecture.md. Do not add, change, or re-select the tech stack—copy it from architecture.md. When Bootcamp: use Bootcamp structure (and deployment per architecture). When Enterprise: use Enterprise structure (and deployment per architecture). When Custom: use exactly what is documented in architecture.md—derive folder structure and deployment from what is documented.

### Enterprise Stack (Conditional)

When TECH_STACK is Enterprise (Angular/Spring Boot/Oracle from architecture.md):

- **Database**: Use real Oracle—never substitute H2. User provides JDBC URL, username, password via env vars (`SPRING_DATASOURCE_URL`, etc.)
- **Folder structure**: Use **deep** structure. Frontend: one portal per persona with `src/app/core/auth/`, `core/interceptors/`, `shared/`, `features/auth/` (when Sprint 1 has auth), `features/{catalog,orders,...}/`, `layout/`; shared-lib with `components/`, `services/`, `models/`, `pipes/`. Backend: api-gateway with `config/`, `filter/` (JWT validation); user-service with `controller/auth/`, `service/auth/` when auth in Sprint 1; one service per domain with `controller/`, `service/`, `repository/`, `model/`, `config/`; common-lib with `dto/`, `exception/`, `security/`. **Folder structure must fulfill sprints** — include auth dirs when Sprint 1 covers authentication. See greenfield template for full example.
- **Deployment**: GCP/GKE—Vercel/Render forbidden for Enterprise. Deployment Sprint uses GKE for Angular (Nginx) and Spring Boot
- **Sprint 0**: Include Oracle Database setup, Oracle Schema/Connection Configuration. **Sprint 0 must create the full folder structure** from Section 2.3.
- **User Input**: Oracle connection details (JDBC URL, username, password) in addition to repo URL, API keys

## Sprint Structure (Granular Detail Required)

**CRITICAL**: Each sprint must have **granular, in-depth detail**—not high-level bullet summaries. See `.nayan/guidance/development-plan-sprint-format.md`.

- **Sprint 0**: Project initialization and scaffolding
- **Sprint 1+**: Complete, vertically-sliced, testable features

Each sprint must deliver a complete feature including all frontend, backend, and data layer modifications. **Every sprint must include tests to ensure code coverage**—run coverage commands, report coverage, and ensure new sprint code is covered.

**Multi-repo (Decoupled Fullstack):** Same rule — each feature sprint must deliver a **vertical slice** (UI through API to backend). The Tech Stack Integration task must verify the full end-to-end flow before Sprint Branch, Commit & Deployment. Never structure a sprint to commit frontend or backend in isolation before E2E verification. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.

## Sprint Structure Requirements

### HITL (Human-in-the-Loop) — Required

Every sprint must include **HITL Checkpoints**: explicit points where the user must confirm before proceeding. See sdlc_human_gates rule. Include at least:

- **User-provided inputs**: At development plan sign-off, **collect** repo URL(s), DB URL, API keys, env vars from the user. **Single repo:** Repo URL. **Multi-repo (Decoupled with frontend/backend):** Frontend repo URL, Backend repo URL. **Multi-repo (project-specific names):** REPO_DIRS + per-repo URLs. Include in handoff to Code (USER_INPUTS) so Code uses them; Code asks only for missing values. Use compact `[User Input]` format in sprint tasks (see development-plan-sprint-format.md).
- Per-task verification for critical tasks ("Please verify [X] works locally")
- **Tech stack integration validation** — User confirms end-to-end flow works across all integration points (e.g. UI→API, API→DB, API→queue, service→external API)
- Sprint completion confirmation before commit/PR ("All sprint functionality verified locally? End-to-end flow confirmed?")
- Section 3 must include an **HITL Overview** summarizing approval points

### Granularity Rules

- **Numbered tasks** (1, 2, 3...) with **3–8 detailed sub-bullets per task**—specify what to create/modify, what to implement, what to verify. **Each task must end with 1–3 Acceptance Criteria (AC)** defining "task done." Avoid single-line tasks.
- **Full use case text** in Relevant Requirements (e.g., "As a [user type], I want to [action] so that [benefit]")—with Steps and Acceptance Criteria
- **User Input** blocks: use compact `[User Input]` format—what to ask + example; no verbose WHY/FORMAT/ACTION
- **Sprint Branch, Commit & Deployment** as the last task with: branch creation, **detailed commit message template** (minimum 5–8 accomplishment bullets, sprint-specific; one-line commits NOT allowed), push, deploy steps, USER INPUT for deployment verification, PR creation with description structure

### Sprint 0: Groundwork and Scaffolding

**Project Scaffolding:** Use tech-stack-specific auto generation when available (Next.js → `npx create-next-app`, Angular → `ng new`, Spring Boot → `spring init`). If unavailable (e.g., FastAPI), document manual creation. Derive scaffolding approach from architecture.md.

**Integration Requirement:** The home page (or health page) must call the backend health endpoint and display an integration status message (e.g., "Frontend and Backend are integrated" when backend responds; "Backend unreachable" when the request fails). This enables user verification that both services are connected.

Tasks: Repository Synchronization (single: git init or clone at root; multi-repo: clone into repo dirs from REPO_DIRS/architecture — **no git init at workspace root**), Environment Configuration, Project Structure (use auto scaffold when available per architecture.md; .gitignore per repo), Backend Setup, Frontend Setup (including health check page that displays integration status), Documentation, Health Check Verification, Sprint Branch/Commit/Deployment (with full commit format example, deploy steps, PR structure)

### Sprint 1: Core User Identity and Authentication

Numbered tasks: 1. Database Model, 2. Backend Registration Logic, 3. Backend Login Logic, 4. Backend Protected Route, 5. Frontend UI & State, 6. Frontend End-to-End Flow, 7. Sprint Branch/Commit/Deployment

### Sprint 2+ Template

Each sprint must include:

1. Sprint ID, Context, and Goal
2. Previous Sprint's Accomplishments
3. Relevant Requirements & User Stories
4. **PRD Fulfilled (end of sprint):** Explicit list of PRD requirements/user stories fully implemented and verified upon sprint completion
5. Detailed Tasks with Database, Backend, Frontend, and E2E steps. **Sprint 1+ must include a Tests & Code Coverage task** that runs coverage, reports coverage, and ensures new sprint code is covered.
6. **Before sprint ends** (required for ALL sprints): **Launch** backend and frontend (run in background), **state exposed URLs**, **update README** with manual launch commands and URLs, **Nayan validates first** (tests, health, key endpoints per sprint AC); fix failures, **only when Nayan's validation passes** — ask user to validate/verify **at exposed URLs** — user must confirm working as expected per sprint deliverables before commit/PR
7. USER INPUT REQUIRED sections with compact `[User Input]` format (what to ask + example)
8. Sprint Branch, Commit & Deployment (with commit template, deploy steps, PR)
9. **Handover Verification** checklist (all tasks finished, app run locally and user asked to validate/verify it, tests executed, code coverage on use cases and acceptance criteria, user confirmed) — required for ALL sprints before proceeding to next sprint
10. Verification Criteria (must include: all sprint AC met)

## User Input Protocol

During execution (not planning), specific information must be requested:

- GitHub Repository URL, MongoDB Atlas Connection String
- Manual Testing Confirmation at each sprint
- Deployment Testing Confirmation

### Protocol Rules

1. What to ask (one line or table)
2. Example format
3. Examples Provided
4. Wait for Response
5. Document Information

## Deployment Infrastructure

**Deploy tech stack comes from architecture.md.** The architect selects and documents deployment (frontend platform, backend platform, cloud) in architecture.md Section 1 (Technology Stack). The development plan **copies** that into Section 1.2 and 1.5—do not hardcode or re-select. Examples: Bootcamp → Vercel (frontend), Render or Railway (backend); Enterprise → GKE (Angular on Nginx, Spring Boot); Custom → use exactly what is documented in architecture.md. Per-sprint: verify locally only. Cloud deploy only after all sprints finished. See sdlc_human_gates rule.

## Output Template

Generate the complete plan following this exact structure and save to `development-plan.md`:

### Document Structure

```markdown
# Development Plan: [App Name]

## 1. Foundational Strategy & Technology Choices

### 1.1. Architectural Pattern Decision

[Justify Decoupled Fullstack (Monorepo), Modular Monolith, or Microservices per Architecture Decision Framework]

### 1.2. Technology Stack Selection

**Copy from architecture.md (including Deployment—do not re-select).** Architect documents full tech stack; development plan uses as-is.

- **Frontend**: [Stack from architecture.md]
- **Backend**: [Stack from architecture.md]
- **Database**: [Stack from architecture.md]
- **Deployment**: [Frontend platform], [Backend platform] — **from architecture.md**
- **External APIs**: [If applicable]

### 1.3. Core Infrastructure & Services (Local Development Focus)

- **Local Development**: Monorepo setup, package managers, sprint cadence.
- **Commands to Run Locally** (derive from tech stack in 1.2; do not hardcode):
    - **Backend**: [e.g., `cd backend && uvicorn app.main:app --reload` for FastAPI; `cd backend && mvn spring-boot:run` for Spring Boot]
    - **Frontend**: [e.g., `cd frontend && npm run dev` for Next.js; `cd frontend && ng serve` for Angular]
- **Database**: MongoDB Atlas usage, migration/startup logic.
- **Authentication**: JWT/session approach, storage, frontend auth.
- **External Services**: Test mode/API keys for local dev.

### 1.4. Integration and API Strategy

- **API Style**: RESTful JSON, FastAPI routers.
- **Standard Formats**: Pydantic models, webhook schemas if applicable.

### 1.5. Deployment Infrastructure

Use deployment **documented in architecture.md**. Do not re-select—copy frontend and backend deployment targets from architecture.md Section 1 (Technology Stack). Examples: Bootcamp → Vercel (frontend), Render or Railway (backend); Enterprise → GKE; Custom → as documented.

- **Frontend Deployment**: [From architecture.md—e.g. Vercel, GKE/Nginx, or as documented]
- **Backend Deployment**: [From architecture.md—e.g. Render, Railway, GKE, or as documented]
- **Deployment Testing**: Dedicated Deployment Sprint for validation.

---

## 2. Application Anatomy & Design

### 2.1. Module Identification

- **Domain Modules**: [List 2–5 modules with brief descriptions]
- **Infrastructure Modules**: DatabaseModule, external service modules.
- **Shared Module**: UI components, shared types, API client utilities.

### 2.2. Module Responsibilities and Interfaces

- [Module]: Owns [data]. Provides [capabilities]. Interfaces with [other modules].

### 2.3. Folder Structure

Use **deep** tree (3–4 levels). Derive from architecture.md. See greenfield template for Bootcamp and Enterprise examples.

\`\`\`text
/
├── frontend/ # Adapt to stack: Next.js or Angular
│ ├── src/app/ # Or per-portal for Angular
│ │ ├── core/
│ │ ├── shared/
│ │ ├── features/ # Feature subdirs: catalog/, orders/, ...
│ │ └── layout/
│ └── ...
├── backend/ # Adapt to stack: FastAPI or Spring Boot
│ ├── app/ or {service}/ # Per-service for Spring Boot
│ │ ├── controller/ or api/
│ │ ├── service/
│ │ ├── repository/ or models/
│ │ └── config/
│ └── ...
└── docs/
\`\`\`

### 2.4. Key Patterns

- **Data Access**: Pydantic + Motor/Beanie, index creation on startup.
- **Business Logic**: Service layer; routers delegate to services.

---

## 3. Incremental Delivery Plan

### HITL Overview

User approval required at: (1) development plan sign-off, (2) **user-provided inputs** (repo URL, DB URL, env vars, API keys), (3) after each critical task (local verification), (4) tests pass and coverage reported per sprint, (5) code quality gate and security scan before PR, (6) **before sprint ends** (ALL sprints): verify all tasks finished, **launch** backend and frontend (run in background), **state exposed URLs**, **update README** with manual launch commands and URLs, **Nayan validates first** (tests, health, key endpoints per sprint AC); fix failures, **only when Nayan's validation passes** — ask user to validate/verify **at exposed URLs**, execute tests, ensure code coverage on use cases and acceptance criteria — wait for user confirmation before commit/PR, (6a) **before handover to next sprint**: confirm handover verification checklist complete, (7) **PR per sprint** — human reviewer approves before merge, (8) deployment sprint — user approval at each step. See sdlc_human_gates rule.

### THE SPRINT PLAN

#### S0: Groundwork & Scaffolding

**Project Context:** [App name and purpose]. This sprint establishes the monorepo, frontend, backend, and database connection.
**Previous Sprint's Accomplishments:** N/A
**Goal:** Working local environment with frontend, backend, and database running; user can clone and run.
**Acceptance Criteria:**

- [Bullet list of measurable criteria]

**Relevant Requirements & User Stories:**
[Quote or paraphrase from PRD]

**PRD Fulfilled (end of sprint):**

- [e.g., NFR-1 (Developer Setup), FR-0.1] — Developer can clone and run app locally with minimal setup.

**HITL Checkpoints:**

- _After Task [N]_: [Specific user verification prompt] — Wait before next task.
- _Before sprint ends_ (required for ALL sprints): Verify all tasks finished. **Code mode must launch** backend and frontend (run in background), **state exposed URLs** (e.g., Frontend: http://localhost:3000, Backend: http://localhost:8000), **update README** with manual launch commands and URLs. **Nayan validates first** (tests, health endpoints, key sprint endpoints); fix failures. **Only when Nayan's validation passes** — ask user to validate/verify **at those URLs** — "All tasks are complete. Please verify at [Frontend URL] and [Backend URL]. Confirm it's working as expected as per this sprint's deliverables." — Wait for user confirmation before commit/PR.

**Tasks:**

1. **Repository Synchronization**
    - **Single repo:** For new projects: run `git init` at workspace root. For existing: [User Input] Repo URL — clone and set up.
    - **Multi-repo:** **Do NOT run `git init` at workspace root.** [User Input] Per-repo URLs for REPO_DIRS from architecture (e.g., frontend + backend, or web-app + api). Clone each repo into its dir. Workspace root has no `.git`; only child dirs have `.git`.
2. **Environment Configuration**
    - [User Input] Ask for each; values go in `.env` (never commit):
      | Input | Example / note |
      |---|---|
      | DB URL | `mongodb+srv://...` |
      | API keys | [As needed] |
      | Env vars | [As needed] |
    - Create `.env.example` with placeholders; user provides values.
3. **Project Structure**
    - **Single repo:** Create root `.gitignore` (node_modules, .env, build outputs, etc.).
    - **Multi-repo:** Create `.gitignore` in each repo dir (from REPO_DIRS); no root `.git`.
    - [Tasks with AC: where applicable]
4. **Backend Setup**
    - [Tasks with AC:]
5. **Frontend Setup**
    - [Tasks with AC:]
6. **Test Framework & Coverage Setup**
    - Install Vitest (frontend) and pytest/pytest-asyncio (backend). Add `--coverage` to test scripts.
    - Write smoke test: backend health returns 200; frontend layout renders.
    - AC: `npm run test` and `pytest` pass; coverage reports generate. Document coverage commands in README.
7. **Documentation**
    - [Tasks with AC:]
8. **Tech Stack Integration & Health Check**
    - **Launch** backend and frontend (run in background). State exposed URLs (e.g., Frontend: http://localhost:3000, Backend: http://localhost:8000). **Update README** with manual launch commands and URLs.
    - **Nayan validates first:** Run tests, hit backend `/health`, hit frontend; fix failures.
    - [User Input] **Only when Nayan's validation passes** — "Please verify at [Frontend URL] and [Backend URL]. Confirm it's working as expected as per this sprint's deliverables." — Wait for user confirmation.
9. **Sprint Branch, Commit & Deployment**
    - **Single repo:** `git checkout -b sprint-0` at root; one commit, one PR.
    - **Multi-repo:** For each repo in REPO_DIRS: `cd <repo> && git checkout -b sprint-0`; commit and PR per repo (no git at root).
    - Run code quality gate (lint, tests pass, coverage reported) per repo for multi-repo.
    - Detailed commit, create PR for human review.

**Handover Verification** (must complete before proceeding to Sprint 1):

- [ ] All tasks finished
- [ ] App launched; Nayan validated (tests, health, key endpoints)
- [ ] User asked to validate/verify at exposed URLs
- [ ] Tests executed and passing
- [ ] Code coverage ensured on use cases and acceptance criteria defined for this sprint
- [ ] User confirmed working as expected per sprint deliverables

**Verification Criteria**: [Summary]. **User must confirm** before proceeding to Sprint 1.

#### S1: Core User Identity & Authentication

**Project Context:** [App name]. This sprint adds sign-up, login, and RBAC.
**Previous Sprint's Accomplishments:** [List from S0]
**Goal:** [One sentence]
**Acceptance Criteria:**

- [Bullet list]

**Relevant Requirements & User Stories:**
[From PRD]

**PRD Fulfilled (end of sprint):**

- UC-1 (User Authentication), FR-1, FR-2, US-1, US-2 — registration, login, RBAC

**HITL Checkpoints:**

- _After Task [N]_: [Verification prompt] — Wait before next task.
- _Before sprint ends_ (required for ALL sprints): Verify all tasks finished. **Code mode must launch** backend and frontend (run in background), **state exposed URLs**, **update README** with manual launch commands and URLs. **Nayan validates first** (tests, health endpoints, key sprint endpoints); fix failures. **Only when Nayan's validation passes** — ask user to validate/verify **at those URLs** — "All tasks are complete. Please verify at [Frontend URL] and [Backend URL]. Confirm it's working as expected as per this sprint's deliverables." — Wait for user confirmation before commit/PR.

**Tasks:**

1. **Database Model: User**
    - [Tasks with AC:]
2. **Backend: Registration**
    - [Tasks with AC:]
3. **Backend: Login & RBAC Middleware**
    - [Tasks with AC:]
4. **Frontend: Auth UI**
    - [Tasks with AC:]
5. **Tests & Code Coverage**
    - Backend unit tests for hashing, JWT; integration tests for registration and login routes.
    - Frontend tests for form validation and auth flow.
    - Run coverage (`npm run test -- --coverage`, `pytest --cov`); ensure new auth code is covered. Report coverage.
    - AC: All auth tests pass; coverage includes new auth code; coverage report generated.
6. **Tech Stack Integration: End-to-End Auth Flow**
    - **Launch** backend and frontend (run in background). State exposed URLs. **Update README** with manual launch commands and URLs.
    - **Nayan validates first:** Run tests, hit health, verify POST /register and POST /login; fix failures.
    - [User Input] **Only when Nayan's validation passes** — "Please verify at [Frontend URL] and [Backend URL]: register → login → role verification flow. Confirm it's working as expected as per this sprint's deliverables." — Wait for user confirmation.
7. **Sprint Branch, Commit & Deployment**
    - Run code quality gate (lint, tests pass, coverage reported).
    - [Branch, quality gate, commit, PR]

**Handover Verification** (must complete before proceeding to Sprint 2):

- [ ] All tasks finished
- [ ] App launched; Nayan validated (tests, health, key endpoints)
- [ ] User asked to validate/verify at exposed URLs
- [ ] Tests executed and passing
- [ ] Code coverage ensured on use cases and acceptance criteria defined for this sprint
- [ ] User confirmed working as expected per sprint deliverables

**Verification Criteria**: [Summary]. **User must confirm** before proceeding to Sprint 2.

#### S2+: [Feature Name]

[Repeat structure for each sprint: Project Context, Previous Sprint's Accomplishments, Goal, Acceptance Criteria, Relevant Requirements & User Stories, **PRD Fulfilled (end of sprint)**, HITL Checkpoints (include *Before sprint ends* for ALL sprints: verify all tasks finished, **launch** backend and frontend in background, **state exposed URLs**, **update README** with manual launch commands and URLs, **Nayan validates first** (tests, health, key endpoints per sprint AC); fix failures, **only when Nayan's validation passes** — ask user to validate/verify **at exposed URLs**, execute tests, ensure code coverage on use cases and acceptance criteria), Tasks (including **Tests & Code Coverage**), **Handover Verification** checklist (all tasks finished, app launched, Nayan validated, user asked to validate/verify at URLs, tests executed, code coverage, user confirmed), Verification Criteria]

#### Deployment Sprint

**Project Context:** Final deployment to cloud infrastructure.
**Goal:** Application is live and usable on public URLs.

**PRD Fulfilled (end of sprint):**

- NFR-2 (Deployment), NFR-3 — application live on production URLs

1. **Pre-deploy code quality:** Lint, tests, coverage pass.
2. **Pre-deploy security scan:** Run security scan; fix critical/high.
3. **Deployment target** is as **documented in architecture.md**. [User Input] "Confirm deployment target and credentials (or provide if not yet specified in architecture)."
4. **[User Input] Pre-deploy approval:** "Confirm deployment target and credentials."
5. **Deploy:** Deploy frontend and backend. Provision production DB.
6. **[User Input] Post-deploy verification:** "Please confirm the deployed version works on the live URLs. Test one full end-to-end critical path transaction." — Wait for confirmation.
7. **PR with deployment URLs** for human review.

---

Development Plan Complete - Ready for implementation.
```

### Template Rules

- **PRD Traceability**: Every sprint must include **PRD Fulfilled (end of sprint):** listing which PRD items are fully implemented and verified upon sprint completion. **Reference PRD using standard identifiers** from refined-prd.md, e.g.:
    - **UC-1** (Use Case 1), **UC-2** (Use Case 2)
    - **FR-1** (Functional Requirement 1), **FR-2**
    - **NFR-1** (Non-Functional Requirement 1)
    - **US-1** (User Story 1), **US-2**
    - Or equivalent IDs as defined in the PRD (e.g., `FR-3.1`, `UC-Auth`, `US-101`)
- **Sprint Tasks**: Each task may include `AC:` (Acceptance Criteria) inline. Use `[User Input]` markers where user must provide data or confirm.
- **User Input Tables**: When requesting multiple env vars/keys, use a table: `| Input | Example / note |`.
- **Code Coverage per Sprint**: Every sprint must include a **Tests & Code Coverage** task that runs coverage commands, ensures new sprint code is covered, and reports coverage. Sprint 0 sets up the coverage framework; Sprint 1+ adds tests for new code and runs coverage before sprint completion.
- **Run App Locally & User Validation (ALL sprints)**: Every sprint must include: (1) **Code mode launches** backend and frontend (runs commands in background), (2) state exposed URLs (e.g., Frontend: http://localhost:3000, Backend: http://localhost:8000), (3) **README** must include "Setup and Run Locally" with manual launch commands and URLs, (4) **Nayan validates first** (tests, health endpoints, key sprint endpoints); fix failures, (5) **only when Nayan's validation passes** — ask user to validate/verify **at exposed URLs**, (6) wait for user confirmation before proceeding. This applies to ALL sprints (S0, S1, S2+, ...).
    - **Commands to run** (Code mode runs these in background; README documents for manual use): **Derive from the tech stack** in Section 1.2 (e.g., FastAPI: `cd backend && uvicorn app.main:app --reload`; Next.js: `cd frontend && npm run dev`; Spring Boot: `cd backend && mvn spring-boot:run`; Angular: `cd frontend && ng serve`).
- **Handover Verification**: Before handing over to the next sprint, verify: (1) all tasks finished, (2) app run locally and user asked to validate/verify it, (3) tests executed and passing, (4) code coverage ensured on use cases and acceptance criteria, (5) user confirmed. Include a **Handover Verification** checklist in each sprint.
- **Before Sprint Ends**: Every sprint must include a _Before sprint ends_ checkpoint: (1) verify all tasks finished, (2) **launch** backend and frontend (run in background), (3) **update README** with manual launch commands and URLs, (4) **Nayan validates first** (tests, health endpoints, key sprint endpoints); fix failures, (5) **only when Nayan's validation passes** — ask user to validate/verify **at exposed URLs** and confirm it's working as expected per sprint deliverables, (6) execute tests and ensure code coverage on use cases and acceptance criteria, (7) wait for user confirmation before commit/PR.
- **HITL Checkpoints**: Every sprint must list specific checkpoints with _After Task N_ and a clear prompt; always "Wait for confirmation" before proceeding.
- **Verification Criteria**: End each sprint with a summary and "**User must confirm** before proceeding to [next sprint]."
- **Deployment Sprint**: Always include as the final sprint with the 7-step structure above.
- **Todo/Task Breakdown Visibility**: When generating todo lists or task breakdowns for the orchestrator/platform, include "Deployment Sprint (QA → Secure → Deploy)" as a visible step so users see deployment as part of the full pipeline. The Deployment Sprint must be a first-class section in the development plan (greenfield already has it; brownfield extend/add-feature must include it).
