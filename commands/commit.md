---
description: "Commit and push changes with a descriptive message"
argument-hint: "[optional-context]"
---

**Step 0 — Detect repo layout:** Check for `.git` at workspace root. If multi-repo (no `.git` at root; one or more child dirs have `.git`): discover child repos, proceed with per-repo workflow below. Else: single-repo workflow (steps 1–5).

## Single-Repo Workflow

1. Analyze the current changes to understand what needs to be committed:

    ```bash
    # Check for staged and unstaged changes
    git status --short

    # View the diff of all changes (staged and unstaged)
    git diff HEAD
    ```

2. Based on the diff output, formulate a **detailed** commit message following conventional commit format:

    - **feat**: New feature or functionality
    - **fix**: Bug fix
    - **refactor**: Code restructuring without behavior change
    - **docs**: Documentation changes
    - **test**: Adding or updating tests
    - **chore**: Maintenance tasks, dependencies, configs
    - **style**: Formatting, whitespace, no logic changes

    **Format (detailed — preferred):**

    ```
    type(scope): brief description

    - <specific change 1>
    - <specific change 2>
    - <specific change 3>
    ```

    **Sprint commits (MANDATORY detailed):** One-line commits NOT allowed. Include body with **minimum 5–8 accomplishment bullets** — specific features, components, endpoints. See `.nayan/guidance/development-plan-sprint-format.md` and `.nayan/skills/code-implementation/SKILL.md` (Sprint Deployment Workflow section).

    Examples (detailed):

    - `feat(api): add user authentication endpoint` + body: Created User model; POST /register with hashing; POST /login with JWT; middleware for protected routes
    - `fix(ui): resolve button alignment on mobile` + body: Adjusted flex layout; fixed breakpoint for small screens
    - `refactor(core): simplify error handling logic` + body: Extracted error mapper; consolidated retry logic

3. Stage all unstaged changes:

    ```bash
    git add -A
    ```

4. Commit with the generated message:

    **For detailed commits (sprint or multi-change):**

    ```bash
    git commit -m "type(scope): brief description" -m "- specific change 1
    - specific change 2
    - specific change 3"
    ```

    Or use `git commit` (no -m) to open editor for multi-line message.

    **For simple single-change commits:**

    ```bash
    git commit -m "type(scope): brief description"
    ```

    **If pre-commit hooks fail:**

    - Review the error output (linter errors, type checking errors, etc.)
    - Fix the identified issues in the affected files
    - Re-stage the fixes: `git add -A`
    - Retry the commit

5. Push to the remote repository:

    ```bash
    git push
    ```

    **If pre-push hooks fail:**

    - Review the error output (test failures, linter errors, etc.)
    - Fix the identified issues in the affected files
    - Stage and commit the fixes using steps 3-4
    - Retry the push: `git push`

## Multi-Repo Workflow

1. **Discover child repos** — List immediate child dirs; for each `D`, check `D/.git`. All such `D` are repo roots.
2. **Check each repo for changes** — For each repo: `cd <repo> && git status --short`. Identify repos with changes.
3. **For each repo with changes:** Formulate commit message (scope = repo name). Stage and commit: `cd <repo> && git add -A && git commit -m "..."`. Push: `cd <repo> && git push`.
4. **Never** `git add -A` from workspace root in multi-repo — root has no `.git`. Never mix files from multiple repos in one commit.

**Common hook failures (multi-repo):** Run linter/tests **in the repo** where the commit is made: `cd <repo> && <lint/test command>`.

---

**Tips for good commit messages:**

- **Be detailed:** Prefer a body with bullet points over a one-line message when multiple changes exist
- Keep the first line (title) under 72 characters
- Use imperative mood ("add", "fix", "update", not "added", "fixes", "updated")
- **Be specific:** List components, endpoints, or files changed — e.g., "Created User model; POST /register; JWT middleware" not "Added auth"
- If multiple unrelated changes exist, consider splitting into separate commits

**Common hook failures and fixes:**

- **Linter errors**: Run the project's linter (e.g., `npm run lint` or `pnpm lint`) to see all issues, then fix them
- **Type checking errors**: Run type checker (e.g., `npx tsc --noEmit`) to identify type issues
- **Test failures**: Run tests (e.g., `npm test` or `pnpm test`) to identify failing tests and fix them
- **Format issues**: Run formatter (e.g., `npm run format` or `pnpm format`) to auto-fix formatting
