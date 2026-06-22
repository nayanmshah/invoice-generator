---
name: vitest-testing
description: Provides Vitest testing best practices including test organization, mocking patterns, and coverage analysis for the Nayan extension codebase.
modeSlugs:
    - code
---

# Vitest Testing Best Practices

For workflow steps, see `.nayan/rules-test/1_workflow.md`.

## When to Use This Skill

Use this skill when:

- Writing new Vitest test suites
- Maintaining existing test files
- Setting up mocks and test utilities
- Analyzing and improving test coverage
- Configuring Vitest for the project

## When NOT to Use This Skill

Do NOT use this skill when:

- Writing integration or E2E tests (use Integration Tester mode)
- Writing UI automation tests (use UI Automation Test Writer mode)
- Writing API tests (use API Test Writer mode)

## Testing Standards

When writing tests:

- Always use describe/it blocks for clear test organization
- Include meaningful test descriptions
- Use beforeEach/afterEach for proper test isolation
- Implement proper error cases
- Add JSDoc comments for complex test scenarios
- Ensure mocks are properly typed
- Verify both positive and negative test cases
- Always use data-testid attributes when testing webview-ui
- The vitest framework is used for testing; the `describe`, `test`, `it`, etc functions are defined by default in `tsconfig.json` and therefore don't need to be imported
- Tests must be run from the same directory as the `package.json` file that specifies `vitest` in `devDependencies`
