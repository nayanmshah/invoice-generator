# Sprint Structure

**Document format**: Use `.nayan/guidance/development-plan-greenfield-template.md` for new products, `.nayan/guidance/development-plan-brownfield-template.md` for extending existing products. **Tech stack is documented in architecture.md** — folder structure, sprint tasks, and commands are based on the tech stack documented in architecture.md. **Folder structure**: Use ```text tree with **deep** structure (3–4 levels), inline comments per directory. **Match tech stack:** Bootcamp → Bootcamp structure; Enterprise → Enterprise structure; Custom → derive from architecture.md. **Match architecture pattern:** Monolith vs Decoupled. **Folder structure must fulfill sprints** — when Sprint 1 includes auth, include auth dirs.

**MANDATORY**: Each sprint must have **granular, in-depth detail**. See Sprint Format in `.nayan/guidance/development-plan-sprint-format.md`.

## Required Sections Per Sprint

| Section                              | Required  | Content                                                                                                                                                                  |
| ------------------------------------ | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Sprint ID                            | Yes       | e.g., S0: Groundwork & Scaffolding                                                                                                                                       |
| Project Context                      | Yes       | 1–2 sentences about the product and this sprint's role                                                                                                                   |
| Previous Sprint's Accomplishments    | Yes (S1+) | Full list of what was delivered                                                                                                                                          |
| Goal                                 | Yes       | One clear outcome sentence                                                                                                                                               |
| **Acceptance Criteria**              | Yes       | 3–6 testable criteria defining "sprint done." User-facing outcomes. Align with requirements.                                                                             |
| Relevant Requirements & User Stories | Yes       | **Greenfield:** Full use case text from PRD Section 7. **Brownfield:** Requirements from condensed scope or feature spec                                                 |
| **HITL Checkpoints**                 | Yes       | Explicit points where user approval/confirmation is required before proceeding                                                                                           |
| Tasks                                | Yes       | **Numbered** (1, 2, 3...) with **3–8 sub-bullets per task** including **1–3 AC per task**. See Task Granularity in `.nayan/guidance/development-plan-sprint-format.md`. |
| Verification Criteria                | Yes       | All sprint AC met; tests pass; coverage reported; **user must confirm** before next sprint                                                                               |

See sdlc_human_gates rule for HITL gates.

## HITL Checkpoints (Required)

Each sprint must list **HITL Checkpoints**: explicit points where the user must confirm before proceeding. Include at least:

- **User-provided inputs**: Repo URL, DB URL, API keys, env vars, deployment target—**ask the user**; never assume or hardcode
- Per-task verification for critical tasks (e.g., "Please verify [X] works locally")
- **Tech stack integration validation** — User confirms end-to-end flow works across all integration points (e.g. UI→API, API→DB, API→queue, service→external API)
- Sprint completion confirmation before commit/PR ("All sprint functionality verified locally? End-to-end flow confirmed?")

## Sprint 0 Structure

Each sprint must have **Acceptance Criteria** (3–6 per sprint). Each task must have **3–8 granular sub-bullets** including **1–3 AC per task**.

1. Repository Synchronization — [User Input] Repo URL (single repo) or per-repo URLs for REPO_DIRS from architecture (multi-repo). **Multi-repo:** Do NOT run `git init` at workspace root; clone each repo into its dir (from REPO_DIRS, e.g., frontend/, backend/ or web-app/, api/). See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
2. Environment Configuration — [User Input] DB URL, API keys, env vars
3. Project Structure — **Create the full folder structure from Section 2.3** (all directories in the tree). Sub-bullets: create all dirs per structure, root config, package.json/tsconfig/pom.xml. AC: Directory tree matches Section 2.3.
4. Backend Setup — Sub-bullets: app entry, health route, DB connection
5. Frontend Setup — Sub-bullets: app shell, layout, health page, routing
6. **Test Framework & Coverage Setup** — Sub-bullets: install runner, coverage config, smoke test, document in README
7. Documentation — Sub-bullets: setup, run, env, test/coverage commands
8. Health Check Verification (USER INPUT: Confirm)
9. Sprint Branch, Commit & Deployment (full detail: branch, commit template, push, deploy, PR)

## Sprint 1+ Structure

Each sprint must have **Acceptance Criteria** (3–6 per sprint). Each task must have **3–8 granular sub-bullets** including **1–3 AC per task**. Avoid single-line tasks.

1. Database Model (if new entities) — Sub-bullets: schema fields, migration, types, seed, verify
2. Backend: [Feature] Logic (per endpoint/flow) — Sub-bullets: route path, request/response, validation, service logic, error handling
3. Backend: Protected Route (if applicable) — Sub-bullets: middleware, JWT validation, protected paths
4. Frontend: UI & State — Sub-bullets: components, pages, state, API calls, loading/error states. **When UX prototype provided:** Reference prototype; implement to match approved layout and look-and-feel using tech stack from architecture.md. Prototypes use in-page feedback (no alert()); include all screens; no placeholder content.
5. **Tests & Code Coverage** — Sub-bullets: unit tests (which files), integration tests (which endpoints), frontend tests, coverage command
6. **Tech Stack Integration / End-to-End Flow** — Sub-bullets: connect UI→API→DB, list integration points, [User Input] user confirms
7. Sprint Branch, Commit & Deployment

**Rule:** Every feature sprint must deliver a working end-to-end flow across all tech stack integration points and the user must validate it. **Every sprint must include tests and code coverage** for new code.

## Sprint Branch, Commit & Deployment (Every Sprint)

The last task of every sprint must include:

- `git checkout -b sprint-N`
- **Code quality gate:** Lint, tests, coverage — all must pass before commit
- **Security scan:** When repo has changes, run `pnpm audit` / `npm audit` / `pip audit`; fix critical/high before PR
- **Detailed commit** (MANDATORY — one-line commits NOT allowed):
    - Title: `feat(sprint-N): summary` (≤72 chars)
    - Body: **Minimum 5–8 accomplishment bullets**; list all features, components, endpoints with specifics (file paths, endpoint paths); last bullet: "Verified local testing: ..."
    - See `.nayan/guidance/development-plan-sprint-format.md` for format and examples
- Push
- **Create PR per sprint (MANDATORY — HITL):** Create PR with accomplishments, testing instructions. **Human reviewer must approve** before merge. Do NOT merge — human merges.
- [User Input] for deployment verification (S0 or when applicable)

## Concluding Phrase

"Development Plan Complete - Ready for implementation."
