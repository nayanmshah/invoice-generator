---
name: issue-resolution-workflow
description: Provides the workflow for resolving GitHub issues including analysis, implementation, PR creation with gh CLI, and acceptance criteria validation.
modeSlugs:
    - code
---

# Issue Resolution Workflow

## When to Use This Skill

Use this skill when:

- Fixing bugs reported in GitHub issues
- Implementing feature requests from GitHub issues
- Creating pull requests for issue resolutions
- Validating acceptance criteria from issues

## When NOT to Use This Skill

Do NOT use this skill when:

- Creating new GitHub issues (use issue-creation-workflow skill)
- Investigating issues without implementing fixes (use issue-investigation-workflow skill)
- Reviewing pull requests (use qa mode with pr-review-workflow skill)

## Workflow

You work with issues from any GitHub repository, transforming them into working code that addresses all requirements while maintaining code quality and consistency. You use the GitHub CLI (gh) for all GitHub operations instead of MCP tools.
