---
name: nayan-conflict-resolution
description: Provides comprehensive guidelines for resolving merge conflicts intelligently using git history and commit context. Use when tasks involve merge conflicts, rebasing, PR conflicts, or git conflict resolution. This skill analyzes commit messages, git blame, and code intent to make intelligent resolution decisions.
modeSlugs:
    - code
---

# Nayan Conflict Resolution Skill

For workflow steps, see `.nayan/rules-merge-resolver/1_workflow.xml`. This skill provides methodology for intelligent conflict resolution.

## When to Use This Skill

Use this skill when the task involves:

- Resolving merge conflicts for a specific pull request
- Rebasing a branch that has conflicts with the target branch
- Understanding and analyzing conflicting code changes
- Making intelligent decisions about which changes to keep, merge, or discard
- Using git history to inform conflict resolution decisions

## When NOT to Use This Skill

Do NOT use this skill when:

- There are no merge conflicts to resolve
- The task is about general code review without conflicts
- You're working on fresh code without any merge scenarios

## Resolution Methodology

When resolving conflicts: analyze git blame, commit messages, and code intent. Prioritize bugfix over feature over refactor. Combine non-conflicting changes when appropriate. Categorize changes by intent (bugfix, feature, refactor); evaluate recency and relevance; check for structural overlap vs formatting differences; identify if changes can be combined or if one should override; consider test updates and related changes.

## Git Commands Reference

| Command                                                          | Purpose                                           |
| ---------------------------------------------------------------- | ------------------------------------------------- |
| `gh pr checkout [PR_NUMBER] --force`                             | Force checkout the PR branch                      |
| `git fetch origin main`                                          | Get the latest main branch                        |
| `GIT_EDITOR=true git rebase origin/main`                         | Rebase current branch onto main (non-interactive) |
| `git blame -L [start],[end] [commit] -- [file]`                  | Get commit information for specific lines         |
| `git show --format="%H%n%an%n%ae%n%ad%n%s%n%b" --no-patch [sha]` | Get commit metadata                               |
| `git show [sha] -- [file]`                                       | Get the actual changes made in a commit           |
| `git ls-files -u`                                                | List unmerged files with stage information        |
| `GIT_EDITOR=true git rebase --continue`                          | Continue rebase after resolving conflicts         |

## Best Practices

### Intent-Based Resolution (High Priority)

Always prioritize understanding the intent behind changes rather than just looking at the code differences. Commit messages, PR descriptions, and issue references provide crucial context.

**Example:** When there's a conflict between a bugfix and a refactor, apply the bugfix logic within the refactored structure rather than simply choosing one side.

### Preserve All Valuable Changes (High Priority)

When possible, combine non-conflicting changes from both sides rather than discarding one side entirely. Both sides of a conflict often contain valuable changes that can coexist if properly integrated.

### Escape Conflict Markers (High Priority)

When using `apply_diff`, always escape merge conflict markers with backslashes to prevent parsing errors:

- Correct: `\<<<<<<< HEAD`
- Wrong: `<<<<<<< HEAD`

### Consider Related Changes (Medium Priority)

Look beyond the immediate conflict to understand related changes in tests, documentation, or dependent code. A change might seem isolated but could be part of a larger feature or fix.

## Resolution Heuristics

| Category            | Rule                                               | Exception                               |
| ------------------- | -------------------------------------------------- | --------------------------------------- |
| Bugfix vs Feature   | Bugfixes generally take precedence                 | When features include the fix           |
| Recent vs Old       | More recent changes are often more relevant        | When older changes are security patches |
| Test Updates        | Changes with test updates are likely more complete | -                                       |
| Formatting vs Logic | Logic changes take precedence over formatting      | -                                       |

## Common Pitfalls

### Blindly Choosing One Side

**Problem:** You might lose important changes or introduce regressions.
**Solution:** Always analyze both sides using git blame and commit history.

### Ignoring PR Context

**Problem:** The PR description often explains the why behind changes.
**Solution:** Always fetch and read the PR information before resolving.

### Not Validating Resolved Code

**Problem:** Merged code might be syntactically incorrect or introduce logical errors.
**Solution:** Always check for syntax errors and review the final diff.

### Unescaped Conflict Markers in Diffs

**Problem:** Unescaped conflict markers (`<<<<<<`, `=======`, `>>>>>>`) will be interpreted as diff syntax.
**Solution:** Always escape with backslash (`\`) when they appear in content.

## Apply Diff Example

When resolving conflicts with `apply_diff`, use this pattern:

```
<<<<<<< SEARCH
:start_line:45
-------
\<<<<<<< HEAD
function oldImplementation() {
  return "old";
}
\=======
function newImplementation() {
  return "new";
}
\>>>>>>> feature-branch
=======
function mergedImplementation() {
  // Combining both approaches
  return "merged";
}
>>>>>>> REPLACE
```

## Quality Checklist

### Before Resolution

- [ ] Fetch PR title and description for context
- [ ] Identify all files with conflicts
- [ ] Understand the overall change being merged

### During Resolution

- [ ] Run git blame on conflicting sections
- [ ] Read commit messages for intent
- [ ] Consider if changes can be combined
- [ ] Escape conflict markers in diffs

### After Resolution

- [ ] Verify no conflict markers remain
- [ ] Check for syntax/compilation errors
- [ ] Review the complete diff
- [ ] Document resolution decisions

## Completion Criteria

- All merge conflicts have been resolved
- Resolved files have been staged
- No syntax errors in resolved code
- Resolution decisions are documented

## Communication Guidelines

When reporting resolution progress:

- Be direct and technical when explaining resolution decisions
- Focus on the rationale behind each conflict resolution
- Provide clear summaries of what was merged and why

### Progress Update Format

```
Conflict in [file]:
- HEAD: [brief description of changes]
- Incoming: [brief description of changes]
- Resolution: [what was decided and why]
```

### Completion Message Format

```
Successfully resolved merge conflicts for PR #[number] "[title]".

Resolution Summary:
- [file1]: [brief description of resolution]
- [file2]: [brief description of resolution]

[Key decision explanation if applicable]

All conflicts have been resolved and files have been staged for commit.
```
