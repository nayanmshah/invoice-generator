# Tester Workflow

Generate comprehensive test case specifications from Jira stories, PRDs, or development plans. Produces `test-cases.md` with full traceability — importable into TestRail, Zephyr, qTest, or Xray.

## Prerequisites

- Jira story, PRD (refined-prd.md), or development-plan.md
- Codebase access (for context, Test Notes, validation rules)

## Workflow

1. **Verify prerequisites** (normally validated by delegator): development-plan.md or PRD or Jira story. If not passed: redirect per sdlc_prerequisites rule.
2. **Explore context** — Search `/docs/`, `/UserContext/`, codebase for testing standards, validation rules, business logic. If development-plan.md exists: read Test Notes, Touched Files, WP acceptance criteria.
3. **Extract & decompose** — Use cases, acceptance criteria, data entities, API endpoints, UI components, business rules, security controls. Map to atomic testable units; risk-classify (Critical/High/Medium/Low).
4. **HITL:** Present analysis summary (source type, testable units count, risk distribution, proposed sections, assumptions). Ask: "Do you approve this scope, or would you like adjustments?" **Wait for approval** before generating.
5. **Generate test cases** — All categories: Positive, Negative, Boundary, API-Specific, Security, Edge Cases, Accessibility, Performance Flags, Regression Candidates. Every test case: Title, Preconditions, Test Steps, Expected Result, Priority, Estimate, Milestone, Automation Type, State, Section. Negative:Positive ratio ≥ 3:1.
6. **Produce test-cases.md** — Summary, Mermaid coverage diagram, traceability matrix, test cases by section, regression suite, gaps & risks, CSV export.
7. **Summarize in chat** — 5–10 bullet summary only; do NOT paste full content.

## Output

- `test-cases.md` — Structured test cases with traceability (FR/US/WP), CSV export for TestRail/Zephyr/qTest/Xray

## Key Rules

- Never assume — ask. Flag ambiguities as assumptions.
- Be specific — concrete data in every step.
- Trace everything — every test → FR/US/WP or Implied — Best Practice.
- Consume Dev Test Notes — if development-plan.md has Test Notes under WPs, use as primary input.
- No fluff — every expected result must be testable.

## Handoff

- **To sdet:** When test-cases.md is approved and automation is needed — hand off to **sdet** with test-cases.md path.
- **To qa:** When generic UI automation (Selenium/Cypress) is preferred over Playwright+POM; QA uses qa-execution skill (UI subsection).
- **To qa:** When QA plan/strategy is needed before test cases. QA mode consolidates qa-plan-creator; use qa with qa-planning skill.

See `.nayan/skills/qa-planning/SKILL.md` for full methodology (input analysis, test categories, output structure).
