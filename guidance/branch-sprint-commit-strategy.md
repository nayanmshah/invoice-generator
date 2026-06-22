# Branch and Commit Strategy: Sprint + JIRA ID

Nayan must create **one branch per sprint** and commit **only** to that JIRA ID / feature-specific sprint branch. This ensures traceability and keeps work scoped to the sprint and JIRA ticket.

## Branch Naming Convention

**Format:** `{type}/JIRA-ID-sprint-N` (e.g., `story/IRD-123-sprint-1`, `bug/IRD-456-sprint-0`)

- **type:** Jira issue type — `story`, `bug`, `task`, `feature`, etc. Use the type from the Jira issue or handoff; default to `story` for greenfield sprints.
- **JIRA-ID:** The Jira issue key (e.g., IRD-123, PROJ-456). Use the key from the handoff or development plan context.
- **sprint-N:** Sprint number (sprint-0, sprint-1, sprint-2, …).

**Examples:**

- `story/IRD-123-sprint-0` — Sprint 0 groundwork for story IRD-123
- `story/IRD-123-sprint-1` — Sprint 1 feature work for story IRD-123
- `bug/IRD-456-sprint-0` — Bug fix for IRD-456
- `task/IRD-789-sprint-1` — Task IRD-789 in sprint 1

## Rules

1. **One branch per sprint:** Create exactly one branch per sprint. Do not reuse branches across sprints.
2. **JIRA ID required:** When JIRA ID is available (from handoff, development plan, or user context), include it in the branch name. If no JIRA ID is provided, ask the user before creating the branch. Fall back to `type/sprint-N` only if the user confirms no JIRA ID applies.
3. **Commit only to sprint branch:** All commits for a sprint must go to that sprint's branch. Never commit sprint work to `main` or another feature branch.
4. **Single repo:** One branch per sprint from workspace root.
5. **Multi-repo:** Create the same branch name in each affected repo (e.g., `story/IRD-123-sprint-1` in both frontend and backend repos).

## Workflow

1. **Before creating branch:** Confirm JIRA ID is known. If not, ask the user.
2. **Create branch:** `git checkout -b type/JIRA-ID-sprint-N` (e.g., `story/IRD-123-sprint-1`; or `cd <repo> && git checkout -b ...` for multi-repo).
3. **Implement:** Do all sprint work on this branch.
4. **Commit:** Use detailed commit message per `.nayan/guidance/development-plan-sprint-format.md` (include JIRA ID in body when applicable).
5. **PR:** Create PR from `type/JIRA-ID-sprint-N` to `main` (or target branch). Human reviewer merges.

## Commit Message (Include JIRA ID)

When JIRA ID is known, reference it in the commit body:

```
feat(sprint-1): user authentication - register, login, JWT

JIRA: IRD-123

Sprint 1 Accomplishments:
- User model in Prisma (email, password_hash)
- POST /api/auth/register with password hashing
...
```

## References

- `.nayan/guidance/development-plan-sprint-format.md` — Sprint Branch, Commit & Deployment; commit format
- `.nayan/guidance/decoupled-fullstack-repo-strategies.md` — Multi-repo branch/commit rules
- `.nayan/rules-code/sprint_protocol.md` — Per-sprint workflow
