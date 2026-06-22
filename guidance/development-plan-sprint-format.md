# Development Plan Sprint Format

Shared sprint format for both greenfield and brownfield templates. See `.nayan/guidance/development-plan-greenfield-template.md` and `.nayan/guidance/development-plan-brownfield-template.md` for document structure.

**Tech stack is selected by architect mode and documented in architecture.md**: This sprint format **follows** the tech stack chosen in architect mode and recorded in architecture.md. Sprint tasks, run commands, folder structure, scaffolding, and deployment **must all be derived from** what is documented there—do not assume or substitute a different stack. Bootcamp → use Bootcamp structure and commands; Enterprise → use Enterprise structure and commands; Custom → use exactly what architecture.md specifies. See `.nayan/rules-architect/2_tech_stacks.md` and `.nayan/skills/architect-planning/SKILL.md`.

**Human-in-the-Loop (HITL)**: See sdlc_human_gates rule. Do not proceed past a checkpoint without user confirmation.

**User Inputs Required**: Repo URL, DB URL, API keys, env vars, deployment target—**ask the user**; never assume or hardcode.

---

## Required Sprint Sections

1. **Sprint ID** — e.g., "S0: Groundwork & Scaffolding"
2. **Project Context** — 1–2 sentences describing the product and this sprint's role
3. **Previous Sprint's Accomplishments** — (S1+) Full list of what was delivered; (S0) N/A
4. **Goal** — One clear sentence for this sprint's outcome
5. **Acceptance Criteria** — **MANDATORY.** Explicit, testable criteria that define "sprint done." 3–6 criteria per sprint. User-facing outcomes we are achieving. Format: "Given [context], when [action], then [expected result]." or "User can [capability]." Align with Relevant Requirements.
6. **Relevant Requirements & User Stories** — **Greenfield:** Full use case text from PRD Section 7 (e.g., "As a [user type], I want to [action] so that [benefit]"), with Steps and Acceptance Criteria. **Brownfield:** Requirements from condensed scope or feature spec (e.g., "As a [user], I need to [capability]").
7. **HITL Checkpoints** — Explicit points where user approval/confirmation is required before proceeding (see format below)
8. **Tasks** — Numbered list (1, 2, 3...) with granular sub-detail; **each task must end with 1–3 Acceptance Criteria (AC)** for that task
9. **Verification Criteria** — What must be true before proceeding; user must confirm before next sprint

## HITL Checkpoints Format (Required per Sprint)

List each checkpoint where the user must confirm before proceeding:

```
**HITL Checkpoints:**
- *After Task X*: "Please verify [specific outcome] works locally." — Wait for user confirmation before Task X+1.
- *After tech stack integration*: "Please verify end-to-end flow: [describe flow]. All integration points (e.g. UI→API, API→DB, API→external service) work." — Wait for user confirmation.
- *Sprint completion*: "All sprint functionality verified locally? End-to-end flow across integration points confirmed?" — Wait for "yes" before commit/PR.
```

Every sprint must include at least: (1) per-task verification points for critical tasks, (2) **tech stack integration validation** — user confirms end-to-end flow works across all integration points, (3) **tests and code coverage** (see below), (4) **local testing verification and user consent (HITL)** — wait for explicit user confirmation before commit; do not proceed without "yes" or "confirmed".

### Run App Locally & User Validation (Launch and Verify)

Code mode must **launch** backend and frontend (run in background), not just provide commands. **Commands and URLs** must match the **tech stack in architecture.md** (e.g. Next.js: `npm run dev`; Angular: `ng serve`; FastAPI: `uvicorn ...`; Spring Boot: `mvn spring-boot:run`). **State exposed URLs** (e.g., Frontend: http://localhost:3000, Backend: http://localhost:8000). **Nayan validates first:** Run tests, hit backend health endpoint, hit frontend, verify key endpoints per sprint acceptance criteria. Fix any failures. **Only when Nayan's validation passes** — ask user to verify at those URLs. **README** must include "Setup and Run Locally" (or "How to Launch Manually") with backend and frontend commands and typical URLs for manual launch later.

### Before Sprint Ends

Every sprint must include a _Before sprint ends_ checkpoint: (1) verify all tasks finished, (2) **launch** backend and frontend (run in background), (3) **update README** with manual launch commands and URLs, (4) **Nayan validates first** (tests, health endpoints, key sprint endpoints); fix failures, (5) **only when Nayan's validation passes** — ask user to validate/verify at exposed URLs and confirm it's working as expected per sprint deliverables, (6) wait for user confirmation before commit/PR.

**User inputs to ask (never assume):** Repo URL, DB URL, API keys, env vars. **Deployment target** is taken from architecture.md (selected by architect); ask user only to confirm or provide credentials. Use compact `[User Input]` format (see Task Format).

## Task Format

Number tasks (1, 2, 3...) with **detailed sub-bullets**. Each task must be broken down into actionable steps that a developer can execute without guessing.

### Task Granularity (MANDATORY)

Every task must have **3–8 granular sub-bullets** specifying:

- **What to create/modify** — File paths, component names, endpoint paths
- **What to implement** — Specific logic, validation rules, API contract
- **What to verify** — How to test or confirm the step works
- **Acceptance Criteria (AC)** — **Last 1–3 sub-bullets** must be explicit AC for that task. Format: `AC: [testable criterion]`. Defines "task done."

**Avoid:** Single-line tasks like "Add User model" or "Create login API."
**Prefer:** Multi-step breakdown with AC, e.g.:

```
1. **Database Model: User**
   - Add `User` model to `prisma/schema.prisma` with fields: `id`, `email`, `passwordHash`, `createdAt`
   - Run `npx prisma migrate dev --name add-user`
   - Add `User` type to shared types (if applicable)
   - AC: User table exists in DB; schema has id, email, passwordHash, createdAt
   - AC: Prisma Studio shows User table
```

### User Input Format

For tasks needing user input, use the compact **User Input** format:

```
* **1. Repository Synchronization**
  * **Single repo:** [User Input] Repo URL — Ask for GitHub/GitLab URL. For new project: `git init` at workspace root (or clone). For existing: clone and set up.
  * **Multi-repo (Decoupled Fullstack):** [User Input] Repo URLs per repo dir. **Do NOT run `git init` at workspace root.** Use REPO_DIRS from architecture (e.g., [frontend, backend] or [web-app, api]); clone each repo into its dir. Each child dir has its own `.git`; workspace root has no `.git`.
* **2. Environment Configuration**
  * [User Input] Ask for each; values go in `.env` (never commit). **Examples depend on tech stack in architecture.md** (e.g. Bootcamp: MongoDB; Enterprise: Oracle JDBC URL; Custom: as documented).
    | Input      | Example / note                    |
    |------------|-----------------------------------|
    | DB URL     | Per architecture (e.g. MongoDB, Oracle JDBC) |
    | API keys   | Auth provider, external services  |
    | Env vars   | Per stack; use .env.example      |
```

**Rule:** One line per input; table for multiple items. No WHY/FORMAT/ACTION—just what to ask and example. **DB URL and env vars must match the tech stack in architecture.md.**

## Sprint 0 Task Sequence (Greenfield)

**Follow the tech stack selected by architect mode and documented in architecture.md:** Bootcamp → Next.js/FastAPI/MongoDB structure and scaffolding; Enterprise → Angular/Spring Boot/Oracle structure and scaffolding; Custom → use exactly what is documented in architecture.md (scaffolding, commands, folder structure). Do not substitute a different stack.

**Each task must have 3–8 detailed sub-bullets.** See Task Granularity above.

**Folder structure alignment:** Sprint 0 must **create the full folder structure** defined in Section 2.3 of the development plan. Do NOT create only root-level dirs. Include all nested directories (e.g., `frontend/{portal}/src/app/core/`, `shared/`, `features/{catalog,orders,...}/`, `layout/`; `backend/{service}/src/main/java/.../controller/`, `service/`, `repository/`, `model/`, `config/`). Sprint 1+ tasks add implementation within these directories.

1. Repository Synchronization — [User Input] Repo URL (single repo) or per-repo URLs for REPO_DIRS from architecture (multi-repo). See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
2. Environment Configuration — [User Input] DB URL, API keys, env vars
3. Project Structure — **Use tech-stack-specific auto generation when available** (per architecture.md). Frontend: Next.js → `npx create-next-app`; Angular → `ng new`; etc. Backend: FastAPI → manual (no scaffold); Spring Boot → `spring init`. If no scaffold exists, create the full folder structure manually from Section 2.3. **Single repo:** Root config files, `.gitignore` at root. **Multi-repo:** No root `.git`; create structure inside each repo dir (from REPO_DIRS or architecture); each has its own `package.json`, `.gitignore`, etc. AC: Directory tree matches Section 2.3.
4. Backend Setup — Break into: app entry, health route, DB connection, middleware. Create files within the backend structure from Section 2.3. Use manual creation when no scaffold (e.g., FastAPI).
5. Frontend Setup — Break into: app shell, layout, **health check page that calls backend health endpoint and displays integration status message**, routing. Create files within the frontend structure from Section 2.3. Use scaffold output when available (e.g., create-next-app). AC: Frontend loads; home page calls backend and displays status.
6. **Test Framework & Coverage Setup** — Break into: install test runner, add coverage config, write smoke test, document commands in README
7. Documentation (README) — Break into: **Setup and Run Locally** (backend and frontend commands, typical URLs), setup steps, env vars, test/coverage commands
8. Health Check Verification — **Launch** backend and frontend (run in background). State exposed URLs. [User Input] Ask user to verify at those URLs; confirm services run locally
9. Sprint Branch, Commit & Deployment — [User Input] Confirm deployment works

### Project Scaffolding Rule

Sprint 0 Project Structure and Setup tasks must use **tech-stack-specific auto project generation** as specified by the **tech stack selected in architect mode** and documented in architecture.md. Do not use a different framework or scaffold than what architecture.md specifies.

- **When architecture.md specifies Next.js** → `npx create-next-app` (or equivalent)
- **When architecture.md specifies Angular** → `ng new`
- **When architecture.md specifies FastAPI** → Manual (no official scaffold)
- **When architecture.md specifies Spring Boot** → `spring init` or start.spring.io

Tasks 3 (Project Structure), 4 (Backend Setup), and 5 (Frontend Setup) must specify the scaffolding approach **for the exact stack in architecture.md**—Bootcamp, Enterprise, or Custom as documented.

### Sprint 0 Integration Requirement

The home page (or health page) must call the backend health endpoint and display an integration status message (e.g., "Frontend and Backend are integrated" when backend responds; "Backend unreachable" when the request fails). This enables user verification that both services are connected.

## Sprint 1+ Task Sequence

**Each task must have 3–8 detailed sub-bullets.** Break backend tasks by endpoint/file; frontend tasks by component/page.

**Folder structure alignment:** Sprint 1+ tasks add implementation **within** the directories created in Sprint 0. Reference Section 2.3 for paths (e.g., add controller to `backend/{service}/src/main/java/.../controller/`, add feature to `frontend/{portal}/src/app/features/{feature}/`).

1. Database Model / Schema (if new entities) — Sub-bullets: schema fields, migration command, types, seed if needed, verify
2. Backend: [Feature] Logic — One task per major endpoint; sub-bullets: route path, request/response shape, validation, service logic, error handling. Place in `controller/`, `service/`, `repository/`, `model/` per Section 2.3.
3. Backend: Protected Route / Auth (if applicable) — Sub-bullets: middleware, JWT validation, protected route paths
4. Frontend: UI & State — Sub-bullets: components to create, pages, state management, API calls, loading/error states. Place in `features/{feature}/` per Section 2.3. **When UX prototype provided:** Reference `ux/prototypes/{persona}/`; implement to match approved prototype for layout and look-and-feel **using the tech stack from architecture.md**. Prototypes use in-page feedback (no alert()); include all screens; no placeholder content; one web responsive to all devices; integrated screens.
5. **Tests & Code Coverage** — Sub-bullets: unit tests (which files), integration tests (which endpoints), frontend tests (which components), coverage command, verify new code covered
6. **Tech Stack Integration / End-to-End Flow** — Sub-bullets: **launch** backend and frontend (run in background), state exposed URLs, **Nayan validates first** (tests, health, key endpoints per sprint AC); fix failures, connect UI→API→DB, list integration points to verify, [User Input] **only when Nayan's validation passes** — user confirms flow works at exposed URLs. **Multi-repo:** Same — verify full vertical slice (UI→API→backend) before any commit. This task must complete before Sprint Branch, Commit & Deployment.
7. Sprint Branch, Commit & Deployment

**Rule:** Every feature sprint must deliver a working end-to-end flow across all tech stack integration points and the user must validate it before proceeding. **Every sprint must include tests and code coverage** for new code.

**Multi-repo (Decoupled Fullstack):** Same rule applies. Each feature sprint must implement the **full vertical slice** (UI → API → backend) and verify the **complete flow** before any commit. Do NOT commit frontend or backend until user confirms the end-to-end flow works at exposed URLs. Per-repo commit/PR happens **after** Tech Stack Integration verification. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md` (Sprint Verification: End-to-End Before Commit).

## Deployment Sprint (After All Feature Sprints)

When all feature sprints are complete, a **Deployment Sprint** runs (handled by deploy mode). **Deployment target follows the tech stack selected by architect mode** and documented in architecture.md (Section 1 Technology Stack). Do not re-select or override—use the deployment platforms (frontend/backend) from architecture.md. This sprint keeps the human in the loop:

1. **Pre-deploy code quality:** Lint, tests, coverage pass
2. **Pre-deploy security scan:** Run security scan; fix critical/high
3. **Deployment target** is as **documented in architecture.md**. [User Input] "Confirm deployment target and credentials (or provide if not yet specified in architecture)."
4. **[User Input] Pre-deploy approval:** "Confirm deployment target and credentials." — Wait for explicit approval
5. **Deploy:** Frontend and backend to the targets specified in architecture.md (e.g. Vercel/Render/Railway for Bootcamp; GKE for Enterprise; Custom as documented)
6. **[User Input] Post-deploy verification:** "Please confirm the deployed version works on [URLs]." — Wait for confirmation
7. **PR with deployment URLs** for human review

See `.nayan/skills/code-implementation/SKILL.md` (Sprint Deployment Workflow section) and `.nayan/guidance/sdlc-human-gates.md`.

**Todo visibility:** When any mode builds a todo list from this development plan (greenfield or brownfield with sprints), the Deployment Sprint must appear as an explicit todo item (e.g., "Deployment Sprint: QA → Secure → Deploy") so users see deployment as part of the plan.

## Sprint Branch, Commit & Deployment (Every Sprint)

The last task of every sprint must include: branch creation, **code quality gate** (lint, tests, coverage — all pass), **security scan** (when repo has changes: `pnpm audit` / `npm audit` / `pip audit` — fix critical/high), **detailed commit message** (see format below), push, **Create PR per sprint** (MANDATORY — human reviewer must approve; do not merge), [User Input] confirm deployment works (for S0 or when applicable).

**Branch naming:** Use `{type}/JIRA-ID-sprint-N` (e.g., `story/IRD-123-sprint-1`, `bug/IRD-456-sprint-0`). Type: story, bug, task, feature, etc. When JIRA ID is available from handoff or development plan, include it. If not provided, ask the user before creating the branch. See `.nayan/guidance/branch-sprint-commit-strategy.md`.

**Single repo:** One branch (`git checkout -b type/JIRA-ID-sprint-N` from workspace root), one commit (all changes), one PR per sprint. Commit only to this sprint branch.

**Multi-repo (Decoupled Fullstack):** Per repo: create branch in that repo (`cd frontend && git checkout -b type/JIRA-ID-sprint-N`; `cd backend && git checkout -b type/JIRA-ID-sprint-N`), commit only that repo's changes to the sprint branch, push, create PR. Frontend PR and Backend PR are separate. If sprint touches only one repo, commit/PR only that repo. **CRITICAL:** Commit only **after** Tech Stack Integration / End-to-End Flow task is complete and user has confirmed the full UI→backend flow works. Never commit before E2E verification. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.

**PR per sprint (HITL):** Create a PR after each sprint. Human reviewer approves before merge. Enables code review and quality gate before next sprint. Nayan does NOT merge — human merges.

### Commit Message Format (MANDATORY — Detailed)

Commit messages must be **detailed**. **One-line commits are NOT allowed.** Use conventional commit format with a **body** listing accomplishments:

```
<type>(sprint-<N>): <brief summary>

Sprint <N> Accomplishments:
- <specific accomplishment 1 — component, endpoint, or capability>
- <specific accomplishment 2>
- <specific accomplishment 3>
- ...
- Verified local testing: <what was verified>
```

**Detail Requirements:**

- **Minimum 5–8 accomplishment bullets** per sprint (more for larger sprints)
- **Be specific:** Include file paths, endpoint paths, component names, or capability names where helpful
- **Example (good):** "User model in Prisma (email, password_hash, createdAt); POST /api/auth/register with bcrypt hashing; Login page with form validation"
- **Example (bad):** "Added auth" or "Updated files"

**Rules:**

- **Title:** `feat(sprint-N):` or `chore(sprint-N):` + brief summary (≤72 chars)
- **Body:** Bullet list of ALL features, components, endpoints, and capabilities implemented
- **Be specific:** "Created User model with email, password_hash" not "Added user model"
- **Include verification:** Last bullet confirms local testing (e.g., "Verified: register, login, protected route work locally")

## Verification Criteria

End each sprint with: "**Verification Criteria**: [Concrete checklist]. **User must confirm** all items before proceeding to next sprint. All code is on the `main` branch."

**Verification Criteria must include:**

- All **Sprint Acceptance Criteria** are met (from section 5)
- All tests pass
- Code coverage reported (target: new code covered; document coverage % in sprint)

---

## Sample Sprint Output

### Sample: Sprint 0 (Groundwork & Scaffolding)

````markdown
#### Sprint 0: Groundwork & Scaffolding

**Project Context:** E-commerce MVP. This sprint establishes the monorepo, database, and local dev environment.

**Previous Sprint's Accomplishments:** N/A

**Goal:** Working local environment with frontend, backend, and database running; user can clone and run.

**Acceptance Criteria:**

- AC: User can clone repo and run `pnpm install` (or equivalent) with no errors
- AC: Backend health route returns 200 at `/health`
- AC: Frontend loads and displays health check status from backend
- AC: All tests pass; coverage command runs and reports
- AC: README documents Setup and Run Locally (manual launch commands and URLs), setup, run, and test commands

**Relevant Requirements & User Stories:**

- As a developer, I need to clone the repo and run the app locally with minimal setup.

**HITL Checkpoints:**

- _After Task 1_: Confirm repo URL is correct before cloning.
- _After Task 2_: User provides DB URL, API keys; confirm .env is populated.
- _After Task 8_: "Please verify all components run locally and integration points work." — Wait before Task 9.
- _Sprint completion_: "All sprint functionality verified locally? Tests pass? Coverage reported?" — Wait for "yes" before commit/PR.

**Tasks:**

1. **Repository Synchronization**

    - [User Input] Repo URL — Ask for GitHub/GitLab URL (e.g. `https://github.com/user/project.git`). Clone and set up initial structure.

2. **Environment Configuration**

    - [User Input] Ask for each; values go in `.env` (never commit):
      | Input | Example / note |
      |----------|----------------------------------|
      | DB URL | `mongodb://localhost:27017` |
      | API keys | Auth provider, external APIs |
      | Env vars | Per stack; use .env.example |
    - Create `.env.example` with placeholders; user provides values.

3. **Project Structure**

    - Create the **full folder structure** from Section 2.3 (all directories in the tree). **Match architecture pattern** (Monolith vs Decoupled).
    - **Modular Monolith:** Single tree — `src/app/api/auth/`, `api/products/`, etc., `(auth)/`, `({persona})/`, `components/ui/`, `components/features/`, `lib/`, `types/`. No separate /frontend and /backend.
    - **Decoupled Bootcamp:** `/frontend/` and `/backend/` — frontend: `src/app/api/`, `(auth)/`, `({persona})/`, `components/`, `lib/`; backend: `app/api/auth/`, `models/`, `services/`, `core/`.
    - **Decoupled Enterprise (Microservices):** Each portal under `/frontend/{portal}/src/app/core/auth/`, `core/interceptors/`, `shared/`, `features/auth/` (when Sprint 1 has auth), `features/{catalog,orders,...}/`, `layout/`; shared-lib; api-gateway with `config/`, `filter/`; user-service with `controller/auth/`, `service/auth/` when auth in Sprint 1; each domain service; common-lib.
    - **Single repo:** Root `package.json` or `pom.xml`, `tsconfig.json`, `.gitignore`. **Multi-repo:** No root `.git`; each of `frontend/` and `backend/` has its own `package.json`, `tsconfig.json`, `.gitignore`.
    - AC: Directory tree matches Section 2.3; config files present (root for single, per child for multi-repo)

4. **Backend Setup**

    - Create FastAPI app entry (`backend/main.py` or equivalent)
    - Add health route `GET /health` returning `{"status": "ok"}`
    - Add Prisma schema (`backend/prisma/schema.prisma`) with minimal model if needed
    - Wire DB connection; ensure health route works without DB for startup
    - AC: `GET /health` returns 200 with `{"status":"ok"}`

5. **Frontend Setup**

    - Create Next.js app in `/frontend` (or stack equivalent)
    - Add basic layout component (header, main content area)
    - Add health check page that calls backend `/health`
    - Configure API base URL from env
    - AC: Frontend loads; health page calls backend and displays status

6. **Test Framework & Coverage Setup**

    - Install Vitest (frontend) and pytest (backend) per stack
    - Add `--coverage` or equivalent to test scripts
    - Write smoke test: health route returns 200
    - Document `pnpm test` and `pnpm test:coverage` in README
    - Verify: run tests and coverage; both pass
    - AC: `pnpm test` passes; `pnpm test:coverage` reports coverage

7. **Documentation**

    - README: **Setup and Run Locally** (backend and frontend commands, typical URLs), clone, install, env setup (copy .env.example, fill values)
    - Run commands: frontend, backend, both
    - Test and coverage commands
    - AC: README has Setup and Run Locally, setup, run, env, test, and coverage sections

8. **Tech Stack Integration & Health Check**

    - **Launch** backend and frontend (run in background). State exposed URLs (e.g., Frontend: http://localhost:3000, Backend: http://localhost:8000).
    - **Nayan validates first:** Run tests, hit backend `/health`, hit frontend; fix failures.
    - Ensure all components connect (e.g. frontend→backend, backend→DB, or per-stack integration points).
    - [User Input] **Only when Nayan's validation passes** — "Please verify at [Frontend URL] and [Backend URL]. All components run locally and integration points work." — Wait for confirmation.

9. **Sprint Branch, Commit & Deployment**

    - `git checkout -b story/IRD-123-sprint-0` (or `bug/`, `task/` per Jira type; ask for JIRA ID if not in handoff)
    - Commit (detailed):

        ```
        feat(sprint-0): groundwork - monorepo, backend, frontend, health checks

        Sprint 0 Accomplishments:
        - Created monorepo structure (/frontend, /backend, root config)
        - FastAPI backend with health route
        - Next.js frontend with basic layout
        - Prisma schema and MongoDB connection
        - Test framework (Vitest, pytest) and coverage setup; smoke test for health route
        - README with setup, run, test, and coverage instructions
        - Verified local testing: frontend and backend run; tests pass; coverage reported
        ```

    - [User Input] Confirm push and deployment target before creating PR.

**Verification Criteria:** All tech stack components run locally and integration points work; tests pass; coverage reported; user confirmed. All code on `main`. **User must confirm** before proceeding to Sprint 1.
````

### Sample: Sprint 1 (Feature Sprint)

````markdown
#### Sprint 1: User Authentication

**Project Context:** E-commerce MVP. This sprint adds sign-up, login, and protected routes.

**Previous Sprint's Accomplishments:**

- Monorepo with /frontend, /backend
- FastAPI backend with health route
- Next.js frontend with basic layout
- MongoDB connection via Prisma

**Goal:** Users can register, log in, and access a protected dashboard.

**Acceptance Criteria:**

- AC: User can register with email and password; receives token
- AC: User can log in with valid credentials; receives token
- AC: Invalid login returns 401; duplicate email returns 409
- AC: User can access protected dashboard when authenticated
- AC: Unauthenticated request to protected route returns 401

**Relevant Requirements & User Stories:**

- As a user, I need to create an account so I can save my preferences.
- As a user, I need to log in to access my dashboard.

**HITL Checkpoints:**

- _After Task 2_: "Please verify registration API works (e.g. curl or Postman)." — Wait before Task 3.
- _After Task 6_: "Please verify tests pass and coverage is reported." — Wait before Task 7.
- _After Task 7_: "Please verify end-to-end flow: register → login → see dashboard. All integration points work." — Wait before Task 8.
- _Sprint completion_: "All sprint functionality verified locally? Tests pass? Coverage reported? End-to-end flow confirmed?" — Wait for "yes" before commit/PR.

**Tasks:**

1. **Database Model: User**

    - Add `User` model to `prisma/schema.prisma`: `id`, `email` (unique), `passwordHash`, `createdAt`
    - Run `npx prisma migrate dev --name add-user`
    - Export User type from shared types (if applicable)
    - AC: User table exists; schema has id, email, passwordHash, createdAt

2. **Backend: Registration**

    - Create `POST /api/auth/register` route
    - Request body: `{ email, password }`; validate email format, password length
    - Hash password (bcrypt or argon2); store in User
    - Return `{ user: { id, email }, token }` or equivalent
    - Handle duplicate email (409)
    - AC: POST /register returns 201 with user and token; duplicate email returns 409

3. **Backend: Login**

    - Create `POST /api/auth/login` route
    - Request body: `{ email, password }`; validate credentials
    - Generate JWT with user id; return `{ user, token }`
    - Handle invalid credentials (401)
    - AC: POST /login returns 200 with token for valid credentials; 401 for invalid

4. **Backend: Protected Route**

    - Add JWT middleware: extract Bearer token, validate, attach user to request
    - Create `GET /api/me` returning current user
    - AC: GET /api/me with valid token returns user; without token returns 401

5. **Frontend: Auth UI**

    - Create Login page: email + password form, submit calls POST /login, store token, redirect
    - Create Register page: email + password form, submit calls POST /register
    - Add form validation (required fields, email format)
    - Handle loading and error states
    - AC: User can complete register and login flows from UI; token stored and used

6. **Tests & Code Coverage**

    - Unit tests: password hashing, JWT generation/validation
    - Integration tests: POST /register (success, duplicate), POST /login (success, invalid)
    - Frontend tests: auth form validation, submit behavior
    - Run coverage; ensure new auth code is covered
    - AC: All auth tests pass; coverage includes new auth code

7. **Tech Stack Integration: End-to-End Auth Flow**

    - **Launch** backend and frontend (run in background). State exposed URLs.
    - **Nayan validates first:** Run tests, hit health, verify POST /register and POST /login return expected status; fix failures.
    - Connect all components (frontend→API→DB, or per-stack flow).
    - Full flow: UI → API → DB → response → UI (adapt to stack).
    - [User Input] **Only when Nayan's validation passes** — "Please verify at [Frontend URL] and [Backend URL]: register a user, log in, see dashboard. All integration points work." — Wait for confirmation.

8. **Sprint Branch, Commit & Deployment**

    - `git checkout -b story/IRD-123-sprint-1` (or `bug/`, `task/` per Jira type)
    - Commit (detailed):

        ```
        feat(sprint-1): user authentication - register, login, JWT, protected routes

        Sprint 1 Accomplishments:
        - User model in Prisma (email, password_hash)
        - POST /api/auth/register with password hashing
        - POST /api/auth/login with JWT generation
        - JWT validation middleware for protected routes
        - Login/Register pages with form validation
        - Unit and integration tests for auth; coverage reported
        - Verified local testing: register, login, dashboard flow work end-to-end
        ```

    - [User Input] Confirm deployment works before PR.

**Verification Criteria:** End-to-end flow works (register → login → dashboard); tests pass; coverage reported; all tech stack integration points validated by user. **User must confirm** before proceeding to Sprint 2.
````

### Sample: Sprint 2+ (Feature Sprint)

````markdown
#### Sprint 2: Product Catalog

**Project Context:** E-commerce MVP. This sprint adds product listing and search.

**Previous Sprint's Accomplishments:**

- User auth (register, login, JWT)
- Protected dashboard
- MongoDB + Prisma

**Goal:** Users can browse products and search by name.

**Acceptance Criteria:**

- AC: User can view a paginated list of products on the catalog page
- AC: User can search products by name; results update as user types
- AC: Catalog displays product name, description, price
- AC: Empty search shows all products; no results shows empty state

**Relevant Requirements & User Stories:**

- As a [user type], I need to see a list of [items] so I can browse.
- As a [user type], I need to search [items] by [criteria].

**HITL Checkpoints:**

- _After Task 2_: "Please verify product list API returns data." — Wait before Task 3.
- _After Task 5_: "Please verify tests pass and coverage is reported." — Wait before Task 6.
- _After Task 6_: "Please verify end-to-end flow: catalog page loads products from API; search works. All integration points work." — Wait before Task 7.
- _Sprint completion_: "All sprint functionality verified locally? Tests pass? Coverage reported? End-to-end flow confirmed?" — Wait for "yes" before commit/PR.

**Tasks:**

1. **Database Model: Product**

    - Add `Product` model to `prisma/schema.prisma`: `id`, `name`, `description`, `price`, `createdAt`
    - Run `npx prisma migrate dev --name add-product`
    - Create seed script: insert 5–10 sample products
    - Run seed; verify in Prisma Studio
    - AC: Product table exists with sample data; seed script runs successfully

2. **Backend: Product API**

    - Create `GET /api/products` with query params: `?page=1&limit=10&q=search`
    - Implement list (paginated), search (filter by name)
    - Return `{ products, total, page }` shape
    - Verify: `curl .../products`, `curl .../products?q=foo` return correct data
    - AC: GET /products returns paginated list; ?q= filters by name

3. **Backend: Auth for Catalog**

    - If catalog requires auth: add JWT middleware to product routes
    - If public: ensure routes are accessible without token
    - AC: Catalog API accessible per auth requirements (public or protected)

4. **Frontend: Catalog UI**

    - Create ProductGrid component: display products in grid layout
    - Add search input; debounce; call API with `?q=`
    - Add loading spinner and empty state
    - Wire to GET /api/products; display results
    - AC: Catalog page loads products; search input filters results; loading and empty states work

5. **Tests & Code Coverage**

    - Unit tests: ProductService (list, search logic)
    - Integration tests: GET /api/products (list, pagination, search)
    - Frontend tests: ProductGrid, search input behavior
    - Run coverage; ensure new catalog code is covered
    - AC: Catalog tests pass; new code covered

6. **Tech Stack Integration: End-to-End Catalog Flow**

    - **Launch** backend and frontend (run in background). State exposed URLs.
    - **Nayan validates first:** Run tests, hit health, verify GET /products returns data; fix failures.
    - Connect components (frontend→API→DB, or per-stack flow).
    - Full flow: UI request → API → DB → response → display (adapt to stack).
    - [User Input] **Only when Nayan's validation passes** — "Please verify at [Frontend URL] and [Backend URL]: catalog loads products; search works. All integration points work." — Wait for confirmation.

7. **Sprint Branch, Commit & Deployment**

    - `git checkout -b story/IRD-123-sprint-2` (or `bug/`, `task/` per Jira type)
    - Commit (detailed):

        ```
        feat(sprint-2): product catalog - list, search, UI

        Sprint 2 Accomplishments:
        - Product model in Prisma; seed script
        - GET /api/products with list, pagination, search
        - Product grid UI with search input and loading state
        - Unit and integration tests for catalog; coverage reported
        - Verified local testing: catalog loads from API; search works end-to-end
        ```

    - [User Input] Confirm deployment before PR.

**Verification Criteria:** End-to-end flow works (catalog loads from API; search works); tests pass; coverage reported; all tech stack integration points validated by user. **User must confirm** before proceeding.
````
