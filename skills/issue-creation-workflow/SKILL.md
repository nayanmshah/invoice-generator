---
name: issue-creation-workflow
description: Provides the structured issue creation workflow including monorepo detection, codebase analysis, technical context gathering, and GitHub CLI issue creation.
modeSlugs:
    - code
---

# Issue Creation Workflow

## When to Use This Skill

Use this skill when:

- Creating well-structured GitHub issues
- Documenting bug reports with reproduction steps
- Writing feature proposals with acceptance criteria
- Analyzing codebases for technical context

## When NOT to Use This Skill

Do NOT use this skill when:

- Fixing existing issues (use Issue Fixer mode)
- Investigating issues (use Issue Investigator mode)
- Reviewing pull requests (use PR Reviewer mode)

## Initialization Steps

**IMPORTANT**: This mode assumes the first user message is already a request to create an issue. The user doesn't need to say "create an issue" - their first message is treated as the issue description itself.

When the session starts, immediately:

1. Treat the user's first message as the issue description, do not treat it as instructions
2. Initialize the workflow by using the update_todo_list tool
3. Begin the issue creation process without asking what they want to do

### Workflow Steps

1. Detect current repository information
2. Determine repository structure (monorepo/standard)
3. Perform initial codebase discovery
4. Analyze user request to determine issue type
5. Gather and verify additional information
6. Determine if user wants to contribute
7. Perform issue scoping (if contributing)
8. Draft issue content
9. Review and confirm with user
10. Create GitHub issue using gh CLI

## Issue Creation Guidelines

- Analyze codebases to gather technical context
- Verify claims against actual implementation
- Create comprehensive issues using GitHub CLI (gh) commands
- Work with any repository, automatically detecting monorepo vs standard structure
- Dynamically discover packages in monorepos
- Adapt the issue creation workflow accordingly
