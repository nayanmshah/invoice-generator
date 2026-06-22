# Test Methodology Selection (QA Planning)

Use this guide when qa uses qa-planning skill for test-related workflows.

## QA Planning Methodologies (tester / sdet)

| Methodology | Purpose                                   | Input                             | Output                                                |
| ----------- | ----------------------------------------- | --------------------------------- | ----------------------------------------------------- |
| **tester**  | Generate test case specifications         | PRD, development-plan, Jira story | test-cases.md (traceability, CSV for TestRail/Zephyr) |
| **sdet**    | Playwright + POM automation (Java/Python) | test-cases.md                     | Executable test code, page objects, API helpers       |

## Code Mode: Vitest Tests

| Skill              | Purpose                       | When code uses                       |
| ------------------ | ----------------------------- | ------------------------------------ |
| **vitest-testing** | Vitest unit/integration tests | Need Vitest tests for TS/JS codebase |

## QA Mode Skills (qa uses directly)

| Skill                                     | Purpose                                   | When QA uses                                                               |
| ----------------------------------------- | ----------------------------------------- | -------------------------------------------------------------------------- |
| **qa-execution** (UI subsection)          | UI E2E (Selenium/Playwright/Cypress)      | Plan includes UI automation; prefer framework-agnostic or Selenium/Cypress |
| **qa-execution** (API subsection)         | API test suites (REST, GraphQL, etc.)     | Plan includes API validation, contract testing                             |
| **qa-execution** (Integration subsection) | E2E integration for greenfield/brownfield | Plan includes integration tests across components                          |

## When to Use Each Methodology

- **tester** — Requirements exist; need structured test cases with traceability before automation
- **sdet** — test-cases.md exists; need Playwright + POM automation in Java or Python

## QA Plan Creator: Make Choices, Human Approves Plan

**qa** derives test strategies and test cases from Dev Plan and Code. It **makes choices** for qa-planning methodology (tester/sdet) based on project context and prepares the plan accordingly:

- **Uses:** qa-planning skill (tester or sdet methodology)
- **QA skills:** qa-planning, qa-execution

Include chosen approach and rationale in the plan. **Human reviews and approves the plan** (including the choices). Keep human in the loop.

## Typical Flow

1. **qa** → derives test strategy, maps acceptance criteria to test cases; **makes choices** for qa-planning methodology (tester/sdet) based on project; prepares plan with rationale; human approves
2. **qa** → executes per approved plan using qa-planning and qa-execution skills
3. **tester methodology** → produces test-cases.md from PRD/development-plan (via qa)
4. **sdet methodology** → consumes test-cases.md, produces Playwright automation (via qa)
