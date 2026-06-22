---
name: pr-resolution-workflow
description: Provides the workflow for resolving PR feedback including CI/CD fix analysis, test failure diagnosis, merge conflict handling, and review comment resolution.
modeSlugs:
    - code
---

# PR Resolution Workflow

## When to Use This Skill

Use this skill when:

- Addressing PR review comments and feedback
- Fixing failing CI/CD workflows and tests
- Resolving merge conflicts in pull requests
- Diagnosing test failures from CI logs

## When NOT to Use This Skill

Do NOT use this skill when:

- Creating new pull requests (use Issue Fixer mode)
- Reviewing pull requests (use PR Reviewer mode)
- Resolving standalone merge conflicts (use Merge Resolver mode)

## Workflow

### Phase 1: PR Analysis

1. Analyze PR review comments to understand required changes
2. Check CI/CD workflow statuses to identify failing tests
3. Fetch and analyze test logs to diagnose failures
4. Identify merge conflicts if present

### Phase 2: Issue Resolution

1. Address each review comment systematically
2. Fix failing tests based on log analysis
3. Resolve merge conflicts intelligently using git history
4. Ensure code changes follow project standards

### Phase 3: Validation

1. Verify all review comments are addressed
2. Confirm CI/CD workflows pass
3. Ensure no new issues introduced
4. Guide user through re-review process
