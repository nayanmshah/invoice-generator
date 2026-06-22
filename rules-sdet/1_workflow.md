# SDET Workflow

Generate executable automated test code (Playwright + POM) in Java or Python from test case specifications. Uses Page Object Model with App Actions (API-first setup/teardown).

## Prerequisites

- `test-cases.md` (from Tester mode) or manual test case specifications
- User choice: Java (JUnit 5/TestNG) or Python (pytest)

## Workflow

1. **Pre-flight (MANDATORY)** — Ask user: (a) "Do you have an existing Playwright test project? If yes, provide path. If no, I will generate full scaffolding." (b) "Which language: `java` or `python`?" **Do NOT write code until both answered.**
2. **Context** — Read test-cases.md. If existing project: read patterns (page objects, fixtures, config). Search `/docs/`, `/UserContext/`.
3. **Plan** — Map test cases to automation structure. Identify page objects, API helpers, DB utilities. Present plan to user.
4. **HITL:** Summarize: N test classes, N page objects, N API helpers, N DB utilities. **Wait for user approval** before generating.
5. **Scaffold (if new project)** — Generate project structure, dependencies, BaseTest/conftest.py, sample tests, CI stub, README. Java: Maven + JUnit 5. Python: pytest + pytest-playwright.
6. **Generate** — Page objects → API helpers → DB utilities → test classes. Locator priority: `data-testid` → `role` → `text` → CSS → XPath. **App Actions:** Use API/DB for setup/teardown, NOT UI.
7. **Validate** — All `Automated` test cases from test-cases.md have corresponding test methods. List skipped (Manual) items.
8. **Commit** — Conventional format: `test(<scope>): <description>`. Update development-plan.md Touched Files if exists.

## Output

- Test automation project (Java or Python)
- Page objects, API helpers, DB utilities, test classes
- README with setup and run instructions

## Key Rules

- No hardcoded selectors in tests — all in Page Objects
- No hardcoded test data — use factories, fixtures, JSON
- No `Thread.sleep` / `time.sleep` — Playwright auto-waits
- No assertions in Page Objects or API helpers — assertions in test methods only
- Tracing enabled by default (trace on failure)
- App Actions: API/DB for setup/teardown, not UI

## Handoff

- **From tester:** Receives test-cases.md
- **To code:** When application changes affect tests

See `.nayan/skills/qa-planning/SKILL.md` (SDET subsection) for scaffolding structure, POM patterns, and code quality rules.
