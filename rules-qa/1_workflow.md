# QA Workflow

QA mode consolidates code review (first pass), QA plan creation, QA execution, code quality gate, and code review (second pass). Run phases in sequence. **Human reviews at each phase** before proceeding.

**When pipeline is brownfield-refactor and QA is entry mode:** Run **Phase 0 only** (Refactor Scope Identification). Produce refactor-scope.md and hand off to code. Do not run Phases 1–5.

## Before Any Work

0. **Expertise check (on every message):** Before responding to ANY message — including follow-ups and subsequent turns — check if the user or Nayan asks something outside this mode's expertise (per MODE RESTRICTION). If yes, hand off per `.nayan/guidance/expertise-handoff.md`. Do not attempt in-place or create a subtask. Do not skip on the next message. Example: user asks "Fix this bug" → hand off to code with skillHint=issue-resolution-workflow.

## Prerequisites

- development-plan.md (or bug-fix-scope for brownfield-fix-bug or refactor-scope for brownfield-refactor when QA is downstream)
- Codebase (implemented code)

**Brownfield-refactor entry:** Refactor request from user, codebase access. QA produces refactor-scope; no development-plan required.

## Phase Responsibility (Single Outcome per Phase)

| Phase | Responsibility                                                 | Outcome                                          |
| ----- | -------------------------------------------------------------- | ------------------------------------------------ |
| 0     | Refactor scope identification (brownfield-refactor entry only) | refactor-scope.md                                |
| 1     | Code review (first pass)                                       | Code review report                               |
| 2     | QA plan creation                                               | QA plan (test strategy, test cases, methodology) |
| 3     | QA execution                                                   | QA execution results                             |
| 4     | Code quality gate                                              | code-review.md (PASS/FAIL)                       |
| 5     | Code review (second pass)                                      | Final code review report                         |

## Phase 0: Refactor Scope Identification (Brownfield-Refactor Entry Only)

**When:** Pipeline is brownfield-refactor and QA is entry mode (orchestrator delegated to QA).

1. **Verify prerequisites** — **Always check first.** Refactor request from user, codebase access. If not passed: ask user. When entered directly (brownfield-refactor entry): no redirect needed; ask user for refactor request if missing.
2. **Read** codebase and user's refactor request. If diagramSpec passed in new_task, include pre/post/flow per spec.
3. **Produce refactor-scope.md** per [architecture-impact-refactor.md](.nayan/guidance/architecture-impact-refactor.md):
    - Refactor scope (what, why)
    - Pre-Architecture / Before State (optional for structural refactors)
    - Post-Architecture / After State (optional for structural refactors)
    - **Flow diagram (required):** What moves, what changes, what stays
    - Backward compatibility & migration
    - Verification strategy
4. **HITL:** Present refactor-scope to user; wait for explicit approval.
5. **Hand off to code** with refactor-scope.md. Do not run Phases 1–5.

## Phase 1: Code Review (First Pass)

1. **Verify prerequisites** — **Always check first** (whether entered via workflow or directly). development-plan.md (or bug-fix-scope), codebase. If not passed: redirect to **plan** or **code** per sdlc_prerequisites rule. When entered directly with missing prereqs: use new_task to redirect per sdlc-prerequisites.
2. Read codebase and development-plan.md (or bug-fix-scope). **Multi-repo (Decoupled Fullstack):** When REPO_STRATEGY: multi, code-review covers both frontend and backend (or per-repo if preferred). Read REPO_STRATEGY from handoff; if absent, read from architecture.md or development-plan.md; if still absent, **detect from codebase** (one `.git` at root → single; `frontend/.git` and `backend/.git` → multi). See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
3. Create code review report per code-review-methodology skill
4. **HITL:** Present review report to user; wait for approval before Phase 2

**Skip for brownfield-fix-bug:** Go directly to Phase 4 (code quality gate).

## Phase 2: QA Plan Creation

1. **Verify prerequisites** — **Always check first** (whether entered via workflow or directly). development-plan.md, codebase. If not passed: redirect per sdlc_prerequisites rule. When entered directly with missing prereqs: use new_task to redirect per sdlc-prerequisites.
2. **Read inputs** — development-plan.md (acceptance criteria, WP scope), codebase (implemented features), architecture.md (tech stack, greenfield/brownfield)
3. **Derive test strategy** — Functional, non-functional, regression, edge-case testing. Map each acceptance criterion to specific test cases. Identify risks and gaps.
4. **Make choices** — Based on project context, decide which QA methodology to use. Include rationale in the plan:
    - **tester** — Test case specs from PRD/dev-plan; produces test-cases.md
    - **sdet** — Playwright + POM automation (Java/Python) when test-cases.md exists
    - **qa-execution** — UI E2E, API validation, E2E integration
5. **Produce QA plan** — Test strategy, concrete test cases, traceability matrix, **chosen approach with rationale**
6. **HITL** — Present plan to user. **Wait for explicit approval** before Phase 3

See `.nayan/guidance/test-mode-selection.md` for methodology selection.

## Phase 3: QA Execution

1. **Read QA plan** — Test strategy, test cases, traceability, skill/methodology choice
2. **Execute QA per plan** — Use qa-planning (tester/sdet) or qa-execution (UI E2E, API suites, E2E integration) as specified
3. **HITL:** Present QA execution results to user. **Wait for explicit approval** before Phase 4

## Phase 4: Code Quality Gate

1. **Verify prerequisites** — **Always check first** (whether entered via workflow or directly). development-plan.md, codebase, tests passing. If not passed: redirect per sdlc_prerequisites rule. When entered directly with missing prereqs: use new_task to redirect per sdlc-prerequisites.
2. **Multi-repo (Decoupled Fullstack):** When REPO_STRATEGY: multi, run quality gate on both frontend and backend. Produce code-review.md covering both repos (or per-repo if preferred). See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
3. **SonarQube credentials** — ask user which setup before proceeding (see 2_sonarqube_validation.md):
    - **A) Global / Remote** — SONAR_TOKEN, SONAR_PROJECT_KEY, SONAR_HOST_URL (SonarCloud: add SONAR_ORGANIZATION)
    - **B) Local** — Host URL + either a token or username/password (token auto-generated; project key auto-derived)
4. **Detect project type** — Read package.json, pom.xml, build.gradle, angular.json (per repo when multi-repo)
5. **Run SonarQube** (via SonarScanner CLI) — New code only. Retrieve quality gate status. (Per repo when multi-repo.)
6. **Run language-specific linting** — ESLint (TS/JS), Checkstyle/SpotBugs (Java), or stack-equivalent
7. **Systematic quality review** — Assess: readability, modularity, adherence to patterns, test coverage, complexity, refactoring opportunities
8. **Produce code-review.md** — Quality gate status (PASS/FAIL), metrics table, Blocker/Critical issues, concrete improvements (if FAIL)
9. **HITL:** Present quality gate status. **Clearly state PASS or FAIL.** If **FAILED** → return to **code** for remediation; re-run after fixes. If **PASSED** → proceed to Phase 5

See `2_sonarqube_validation.md` for SonarScanner CLI steps.

## Phase 5: Code Review (Second Pass)

1. **Read** codebase, development-plan.md, code-review.md (from quality gate)
2. Create final code review report per code-review-methodology skill
3. **HITL:** Present review report to user; wait for approval before handoff to secure

## QA Methodologies (from rules-tester, rules-sdet)

- **tester** — Generate test-cases.md from PRD/dev-plan; traceability to TestRail/Zephyr
- **sdet** — Playwright + POM automation (Java/Python) from test-cases.md

## Output

- Code review reports (first and second pass)
- QA plan (test strategy, test cases, methodology choice)
- QA execution results
- code-review.md (quality gate PASS/FAIL)

## Handoff

- **To secure:** When all phases complete and user has approved. Validate secure prerequisites (architecture.md, codebase, code-review.md, quality gate passed).
