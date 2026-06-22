# Decoupled Fullstack: Repository Strategies

When the architectural pattern is **Decoupled Fullstack** (frontend and backend as separate runtimes, e.g., Next.js + FastAPI, Angular + Spring Boot), Nayan supports two repository layouts. This guidance applies across the SDLC — plan, code, qa, secure, deploy.

## Both Layouts Supported

| Layout                     | Structure                                                                                                                                 | Commit/PR                                                       | When to Use                                            |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- | ------------------------------------------------------ |
| **Single repo (monorepo)** | One repo with `/frontend` and `/backend` directories                                                                                      | One branch, one commit, one PR per sprint (or per fix/refactor) | Simpler setup; single team; shared history             |
| **Multi-repo workspace**   | Workspace with separate git repos (child dirs with `.git`; names are project-specific, e.g., `frontend/`, `backend/`, `web-app/`, `api/`) | Per-repo branch, commit, PR                                     | Separate teams; independent release cycles; org policy |

## How Repo Strategy Is Determined

| Pipeline                   | How Determined                                                                                                               |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| **Greenfield**             | **ASK** user at architecture time: "Monorepo (single repo with frontend/ and backend/ dirs) or multi-repo (separate repos)?" |
| **Brownfield-extend**      | **DETECT** from existing architecture + codebase (Section 1.4). If **introducing new** Decoupled layout → **ASK**            |
| **Brownfield-add-feature** | **DETECT** from existing architecture + codebase (Section 1.4)                                                               |
| **Brownfield-fix-bug**     | **DETECT** from existing codebase (one `.git` vs multiple)                                                                   |
| **Brownfield-refactor**    | **DETECT** from existing codebase                                                                                            |

**Detection rules:** Check architecture.md for Repository Strategy; if absent, check folder structure: one `.git` at workspace root → single; no `.git` at root and one or more immediate child dirs have `.git` → multi. **Multi-repo:** Parent has no `.git`; only child dirs have `.git`. Child names are project-specific (e.g., frontend, backend, web-app, api, client, server, portal). Decoupled Fullstack often uses frontend/backend, but projects may use different names. **How to discover child repos:** List immediate children of workspace root; for each dir `D`, check if `D/.git` exists.

**architecture.md format (when Decoupled Fullstack):** In Section 2 (Architectural Pattern) or equivalent, include: `**Repository Strategy:** single` or `**Repository Strategy:** multi`. When multi-repo, add `**Repo dirs:** [list]` (e.g., `[frontend, backend]` or `[web-app, api]`). Downstream modes use this list for per-repo operations.

## Single Repo (Monorepo)

- **Structure:** One Repo URL; `/frontend` and `/backend` as directories in one git repo.
- **User-provided inputs:** Repo URL (single).
- **Git operations:** All git commands from workspace root. One branch per sprint (`type/JIRA-ID-sprint-N`, e.g., `story/IRD-123-sprint-1`); one commit per sprint; one PR per sprint. See `.nayan/guidance/branch-sprint-commit-strategy.md`.
- **Launch:** `cd frontend && npm run dev`; `cd backend && uvicorn ...` — both from workspace root.

## Multi-Repo Workspace

- **Structure:** Workspace root contains child dirs as separate git repos (each has `.git`). **Workspace root (parent) is NOT a git repo** — no `.git` at root. Child dir names are project-specific (e.g., frontend, backend, web-app, api).
- **No git init at parent:** When multi-repo, **never** run `git init` at workspace root. The parent is a container only. Child repos each have their own `.git` from clone or `git init` **inside that child directory** (never at root).
- **User-provided inputs:** When Decoupled with frontend/backend: Frontend repo URL, Backend repo URL. When project-specific names: REPO_DIRS (list of dir names) + per-repo URL (e.g., REPO_WEB_APP_URL, REPO_API_URL).
- **Git operations:** All git commands run **inside** each repo's directory. Never mix. Per-repo branch (`type/JIRA-ID-sprint-N`), commit, PR. If sprint touches only one repo, commit/PR only that repo. See `.nayan/guidance/branch-sprint-commit-strategy.md`.
- **Launch:** Same as single repo — launch each from workspace root (`cd <repo> && ...`).

## Sprint Verification: End-to-End Before Commit (CRITICAL for Multi-Repo)

**Every feature sprint** that has UI must deliver a **complete vertical slice** (UI → API → backend) before any commit. This applies to both single and multi-repo.

**Multi-repo — mandatory sequence:**

1. **Implement** all sprint work (frontend + backend) for the feature.
2. **Launch** both frontend and backend from workspace root.
3. **Verify** full end-to-end flow: user action in UI → API call → backend logic → response → UI update. All integration points (UI→API, API→DB, API→external) must work.
4. **User confirms** at exposed URLs: "Please verify at [Frontend URL] and [Backend URL]. Confirm [sprint feature] works end-to-end."
5. **Only after** user confirms — then commit frontend, commit backend, create PRs.

**Never** commit frontend or backend in isolation for a feature sprint until the full UI→backend flow is verified. Per-repo commit/PR is a **mechanical** step that happens **after** E2E verification.

## Per-Repo Operations (Multi-Repo Only)

- For each child repo `D`: `cd D && git status` — never mix. Use REPO_DIRS from architecture/handoff or discover child dirs with `.git`.
- `cd <repo> && git add . && git commit ...` — commit only that repo's changes.
- **No cross-repo commits:** Never `git add` files from multiple repos in one commit.

## Brownfield Detection

- **Architect** (when extending) or **Plan** (when creating dev plan) reads architecture.md and development plan Section 1.4 (Existing Folder Structure).
- **Detect:** One `.git` at root → single. No `.git` at root and one or more child dirs have `.git` → multi. Discover child repos: list immediate child dirs; for each `D`, check `D/.git`. Document actual dir names (e.g., web-app, api) as REPO_DIRS.
- **Architect** documents repo strategy in architecture.md so downstream modes (Plan, Code, QA, Secure, Deploy) use it. **Plan** documents in dev plan and collects REPO\_\* URLs at sign-off.
- **Brownfield new Decoupled:** When brownfield-extend **introduces** a new Decoupled layout (e.g., splitting monolith into frontend + backend), **ask** user: "Monorepo or multi-repo?"

## Handoff to Code

Plan handoff passes:

- **Single repo:** `REPO_URL`, `REPO_STRATEGY: single`
- **Multi-repo (Decoupled with frontend/backend):** `REPO_FRONTEND`, `REPO_BACKEND`, `REPO_STRATEGY: multi` (backward compatible)
- **Multi-repo (project-specific names):** `REPO_DIRS: [dir1, dir2, ...]`, `REPO_<DIR>_URL` per dir (e.g., REPO_WEB_APP_URL, REPO_API_URL), `REPO_STRATEGY: multi`

Code, QA, Secure, and Deploy read `REPO_STRATEGY` and `REPO_DIRS` (when multi) to determine workflow.

## Fallback Detection (When REPO_STRATEGY Not in Handoff)

When QA, Secure, or Deploy receives a handoff without REPO_STRATEGY (e.g., brownfield-fix-bug where debug or code was entry point), **detect from codebase**:

1. Check architecture.md or development-plan.md for "Repository Strategy: single|multi", "REPO_STRATEGY", or "Repo dirs".
2. If absent, check folder structure: one `.git` at workspace root → single; no `.git` at root and one or more child dirs have `.git` → multi. Discover child repos to get REPO_DIRS.
3. Use detected value for per-repo operations (quality gate, security scan, deployment).

## Separation of Concerns (Multi-Repo)

| Mode          | Responsibility                                                                                                                          | Per-Repo Operations                        |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| **Architect** | Determine strategy (ask/detect when extending), document in architecture.md                                                             | N/A                                        |
| **Plan**      | Document in dev plan, collect REPO_FRONTEND/REPO_BACKEND or REPO_DIRS + per-repo URLs at sign-off, pass in handoff to Code              | N/A                                        |
| **Code**      | Receive or detect REPO_STRATEGY and REPO_DIRS; run git, tests, lint, audit **in each repo's directory**; commit/PR per repo; pass to QA | `cd <repo> && git/test/lint` for each repo |
| **QA**        | Receive or detect REPO_STRATEGY; run quality gate (SonarQube, lint, tests) **per repo**; produce code-review covering all               | Run in each repo dir                       |
| **Secure**    | Receive or detect REPO_STRATEGY; run security scan (npm/pip audit, Veracode) **per repo**; produce security-review covering all         | Build and scan each repo separately        |
| **Deploy**    | Receive or detect REPO_STRATEGY; deploy **each repo from its directory**; may target different platforms                                | Deploy from each repo dir                  |

**Rule:** Never mix repos. All git, test, lint, audit, scan, and deploy commands run **inside** the relevant repo's directory for multi-repo.

## Commands and Rules (Single vs Multi-Repo)

| Command / Rule                                              | Single Repo                              | Multi-Repo                                                                                                                                      |
| ----------------------------------------------------------- | ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| **/init**                                                   | Analyze root; extract commands from root | Discover child repos (any names); document per-repo build/test/lint; AGENTS.md at workspace root explains multi-repo layout and lists repo dirs |
| **/commit**                                                 | `git status/add/commit/push` from root   | Discover child repos; run per repo; only repos with changes                                                                                     |
| **/nayan-resolve-conflicts**                               | Resolve in one repo                      | PR belongs to one child repo; run git commands in that repo's directory                                                                         |
| **release, cli-release**                                    | Run from workspace root                  | If multi-repo, run from repo containing release artifacts (usually not applicable for Nayan extension)                                         |
| **rules-pr-fixer, rules-merge-resolver, rules-issue-fixer** | Git from root                            | Discover child repos; run git in repo containing modified files                                                                                 |
| **rules-secure (Veracode)**                                 | Git from root                            | Run `git status`/`git diff` per repo; scan each repo with changes                                                                               |

## References

- `.nayan/guidance/development-plan-sprint-format.md` — Sprint Branch, Commit & Deployment; commit message format
- `.nayan/rules-code/sprint_protocol.md` — Launch and Verify; per-sprint workflow
- `.nayan/skills/code-implementation/SKILL.md` — Code mode repo strategy handling
