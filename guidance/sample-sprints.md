# Sample Sprints

Two complete sprint examples showing the required format: Acceptance Criteria (sprint + task level), detailed tasks with sub-bullets, HITL Checkpoints, and Verification Criteria.

**Reference:** `.nayan/guidance/development-plan-sprint-format.md` for full format rules.

---

## Sample Sprint 1: Sprint 0 (Groundwork & Scaffolding)

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
- AC: README documents setup, run, and test commands

**Relevant Requirements & User Stories:**

- As a developer, I need to clone the repo and run the app locally with minimal setup.

**HITL Checkpoints:**

- _After Task 1_: Confirm repo URL is correct before cloning.
- _After Task 2_: User provides DB URL, API keys; confirm .env is populated.
- _After Task 8_: "Please verify all components run locally and integration points work." — Wait before Task 9.
- _Sprint completion_: "All sprint functionality verified locally? Tests pass? Coverage reported?" — Wait for "yes" before commit/PR.

**Tasks:**

1. **Repository Synchronization**

    - **Single repo:** [User Input] Repo URL. For new: `git init` at workspace root. For existing: clone. AC: Repo ready; project structure exists.
    - **Multi-repo:** [User Input] Per-repo URLs for REPO_DIRS from architecture (e.g., frontend + backend, or web-app + api). **Do NOT run `git init` at workspace root.** Clone each repo into its dir. AC: All repos cloned; workspace root has no `.git`.

2. **Environment Configuration**

    - [User Input] Ask for each; values go in `.env` (never commit):
      | Input | Example / note |
      |----------|----------------------------------|
      | DB URL | `mongodb://localhost:27017` |
      | API keys | Auth provider, external APIs |
      | Env vars | Per stack; use .env.example |
    - Create `.env.example` with placeholders; user provides values.
    - AC: `.env` populated; `.env.example` documents required vars

3. **Project Structure**

    - Create repo directories per REPO_DIRS from architecture (e.g., frontend/, backend/ or web-app/, api/)
    - **Single repo:** Root `package.json` with workspaces, root `tsconfig.json`, root `.gitignore`
    - **Multi-repo:** No root `.git`; each repo dir has its own `package.json`, `tsconfig.json`, `.gitignore`
    - AC: Directory structure exists; config files present (root for single, per child for multi-repo)

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

    - README: clone, install, env setup (copy .env.example, fill values)
    - Run commands: frontend, backend, both
    - Test and coverage commands
    - AC: README has setup, run, env, test, and coverage sections

8. **Tech Stack Integration & Health Check**

    - Ensure all components connect (e.g. frontend→backend, backend→DB, or per-stack integration points).
    - [User Input] "Please verify all components run locally and integration points work." — Wait for confirmation.
    - AC: User confirmed all integration points work

9. **Sprint Branch, Commit & Deployment**

    - `git checkout -b sprint-0`
    - Run lint, tests, coverage; fix any issues
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

    - Push; create PR; [User Input] Confirm deployment target before PR
    - AC: PR created; branch pushed; user confirmed

**Verification Criteria:** All sprint Acceptance Criteria met; all tech stack components run locally; integration points work; tests pass; coverage reported; user confirmed. All code on `main`. **User must confirm** before proceeding to Sprint 1.
````

---

## Sample Sprint 2: Sprint 1 (User Authentication)

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

    - Connect all components (frontend→API→DB, or per-stack flow).
    - Full flow: UI → API → DB → response → UI (adapt to stack).
    - [User Input] "Please verify: register a user, log in, see dashboard. All integration points work." — Wait for confirmation.
    - AC: User confirmed end-to-end auth flow works

8. **Sprint Branch, Commit & Deployment**

    - `git checkout -b sprint-1`
    - Run lint, tests, coverage; fix any issues
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

    - Push; create PR; [User Input] Confirm deployment works before PR
    - AC: PR created; user confirmed

**Verification Criteria:** All sprint Acceptance Criteria met; end-to-end flow works (register → login → dashboard); tests pass; coverage reported; all tech stack integration points validated by user. **User must confirm** before proceeding to Sprint 2.
````

---

## Key Elements Summary

| Element                        | Sprint 0                      | Sprint 1                      |
| ------------------------------ | ----------------------------- | ----------------------------- |
| **Sprint Acceptance Criteria** | 5 criteria                    | 5 criteria                    |
| **Tasks**                      | 9                             | 8                             |
| **Task-level AC**              | 1–2 per task                  | 1 per task                    |
| **HITL Checkpoints**           | 4                             | 4                             |
| **Verification Criteria**      | All AC met + tests + coverage | All AC met + E2E flow + tests |
