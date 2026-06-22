---
name: qa-planning
description: Provides QA planning methodology including requirements analysis, test strategy, test case design, and SDET scaffolding. Use when creating QA plans or test case specifications.
modeSlugs:
    - qa
---

# QA Planning Methodology

For workflow steps, see `.nayan/rules-test/1_workflow.md`, `.nayan/rules-tester/1_workflow.md`, and `.nayan/rules-sdet/1_workflow.md`. See sdlc_human_gates rule for QA plan sign-off gate.

## When to Use This Skill

- Creating comprehensive QA test plans
- Designing testing strategies and frameworks
- Generating test case specifications from PRDs or development plans
- SDET scaffolding (POM patterns, directory structure)

## QA Plan Methodology (6 Phases)

1. **Requirements Analysis**: Functional/NFR analysis, business rules, acceptance criteria, integration points
2. **Test Strategy**: Test levels (unit, integration, system, UAT), types (performance, security, usability), approach (TDD, BDD, risk-based)
3. **Test Case Design**: Input analysis, test categories (Positive, Negative, Boundary, API-Specific, Security, Edge Cases, Accessibility), output structure
4. **Execution Planning**: Test environment, data management, tool/framework selection
5. **Metrics Framework**: Coverage, defect tracking, quality gates
6. **Test Management**: Traceability, regression suite, gaps & risks

## Test Case Output Structure

- **Input sources**: Jira Story, PRD (refined-prd.md), Development Plan (development-plan.md)
- **Categories (all mandatory)**: Positive, Negative, Boundary, API-Specific, Security, Edge Cases, Accessibility, Performance Flags, Regression
- **Output fields**: Title, Preconditions, Test Steps, Expected Result, Priority, Estimate, Milestone, Automation Type, State, Section
- **Output file**: test-cases.md with Summary, Mermaid Coverage Diagram, Traceability Matrix, Test Cases by Section, Regression Suite, Gaps & Risks, CSV Export

## SDET Subsection

- Page Object Model patterns, scaffolding structure
- POM directory layout, code quality rules
- Playwright/Cypress/Selenium framework setup
