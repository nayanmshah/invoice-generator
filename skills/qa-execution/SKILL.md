---
name: qa-execution
description: Provides QA execution methodology for UI automation, API testing, and integration testing. Use when writing or executing UI E2E, API test suites, or E2E integration tests.
modeSlugs:
    - qa
---

# QA Execution Methodology

See `.nayan/guidance/test-mode-selection.md` for skill selection. QA mode uses these subsections based on plan: UI automation (Selenium/Cypress/Playwright), API validation, or E2E integration.

## UI Automation (ui-automation-testing)

Use when: Building UI E2E test frameworks, Page Object Model patterns, cross-browser testing.

- **Framework**: Selenium, Playwright, or Cypress per plan
- **Patterns**: Page Object Model, explicit waits, data-testid for selectors
- **Coverage**: Positive/negative scenarios, responsive (320/768/1920px), accessibility (WCAG)
- **Do NOT use for**: API tests (use api-testing); unit tests

## API Testing (api-testing)

Use when: Creating API test suites, contract validation, auth testing.

- **Patterns**: Request/response validation, schema validation, status codes
- **Coverage**: Auth (OAuth, JWT, API keys), authorization, contract/schema, security, performance
- **Do NOT use for**: UI tests (use ui-automation-testing); unit tests

## Integration Testing (integration-testing)

Use when: E2E integration across components, greenfield/brownfield flows.

- **Scope**: Multi-step flows spanning frontend, backend, external systems
- **Framework**: Project's test framework (Vitest, Jest, pytest) per development-plan
- **Location**: tests/integration/, e2e/, \*.integration.(ts|js|py)
- **Greenfield**: Base on architecture.md and development-plan
- **Brownfield**: Extend existing; add coverage for new/changed flows; ensure backward compatibility
- **Do NOT use for**: UI-only automation (use ui-automation-testing); API-only suites (use api-testing)
