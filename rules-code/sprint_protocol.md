# Sprint Protocol

## Todo Structure by Pipeline Type

When Code mode creates or updates its todo list, use the structure per pipeline:

- **Sprint-based** (greenfield, brownfield-extend, brownfield-add-feature, brownfield-migrate): S0, S1, S2... (one per sprint); Code quality gate (per sprint); Hand off to QA (new_task). Reference: Deployment Sprint runs after QA and Secure; handled by deploy mode.
- **Fix-bug** (brownfield-fix-bug): Diagnose, Fix, Hand off to QA. Reference: Deploy is conditional — orchestrator asks after Secure.
- **Refactor** (brownfield-refactor): Apply refactor per refactor-scope, Hand off to QA. Reference: Deploy runs after QA and Secure; handled by deploy mode.

**Handoff:** Use new_task per 4_handoff.xml. See handoff-schema.md.

## Launch and Verify (Before Sprint End)

1. **Launch:** Run backend and frontend in background. Derive commands from tech stack (architecture.md or development plan Section 1.2). Example: backend `cd backend && uvicorn app.main:app --reload`; frontend `cd frontend && npm run dev`. Use background execution so both run concurrently. **Multi-repo:** Same — launch from workspace root; use REPO_DIRS from architecture/handoff (e.g., frontend/, backend/ or web-app/, api/) — each repo dir is a subdir.
2. **Expose URLs:** State the exposed URLs (e.g., Frontend: http://localhost:3000, Backend: http://localhost:8000 or /docs). Derive from tech stack defaults.
3. **Update README:** Ensure README has a "Setup and Run Locally" (or "How to Launch Manually") section with backend and frontend commands and typical URLs. User can run later without Nayan.
4. **Nayan validates first:** Before asking the user, Nayan must validate that everything works as defined in the current sprint. **Single repo:** Run tests from workspace root (or per package.json/pytest config). **Multi-repo:** Run tests **in each repo separately** — for each repo in REPO_DIRS: `cd <repo> && npm test` (or pnpm test) or `cd <repo> && pytest` (or equivalent). Hit backend health endpoint; hit frontend; for feature sprints, verify key endpoints per sprint acceptance criteria. Fix any failures before proceeding. **Only when Nayan's validation passes** — proceed to step 5.
5. **Ask user to verify:** "Please verify at [Frontend URL] and [Backend URL]. Confirm the app works as expected per this sprint's deliverables."

## Per-Sprint Verification (Local Environment Only)

1. **Announce**: State what you're about to implement and reference the development plan task
2. **Ask**: If anything is ambiguous, ask BEFORE writing code — never guess. **User inputs required**: repo URL, DB URL, env vars, API keys—ask the user; never assume or hardcode. (Deployment target is confirmed by deploy mode.)
3. **Implement**: Write the code for one sprint at a time. **Ensure tech stack integration** — each feature sprint must have a working end-to-end flow across all integration points (e.g. UI→API, API→DB, API→queue, service→external API). **Multi-repo:** Implement the full vertical slice (frontend + backend) before any commit; do not commit until E2E flow is verified.
4. **Explain**: Briefly describe what was built and how to test it
5. **Wait**: Per Launch and Verify section — launch backend and frontend, **Nayan validates first** (tests, health endpoints, key sprint endpoints), then ask user to verify at exposed URLs. **Wait for explicit user confirmation** ("yes", "confirmed") before proceeding. Do not assume verification passed, including **end-to-end flow** across all integration points. **Multi-repo:** Same — user must confirm full UI→backend flow works before any commit to frontend or backend repos.
6. **Proceed**: Only move to the next sprint after user confirms end-to-end flow works

**NEVER batch multiple sprints and present them all at once.** Each sprint should be individually verifiable on local env.

## Cloud Deployment

- **Per-sprint**: Verify and test on **local environment only**. Do not deploy to cloud during sprints.
- **Cloud deploy**: Only after **all sprints are finished**. Deploy mode handles deployment and confirms deployment target. Code hands off to QA → Secure → Deploy.

## PR Creation

Create PR with accomplishments; **do not merge** — human reviewer approves and merges.

## Branch and Commit Strategy

**Branch naming:** Create one branch per sprint using `{type}/JIRA-ID-sprint-N` (e.g., `story/IRD-123-sprint-1`, `bug/IRD-456-sprint-0`). Type: story, bug, task, feature, etc. When JIRA ID is in handoff or development plan, use it. If not provided, ask the user before creating the branch. Commit **only** to that sprint branch. See `.nayan/guidance/branch-sprint-commit-strategy.md`.

## Repository Strategy (Decoupled Fullstack)

**Single repo:** Launch both from workspace root; git from root; one branch per sprint (`type/JIRA-ID-sprint-N`), one commit, one PR per sprint.

**Multi-repo:** Launch from workspace root (`cd <repo> && ...` for each repo in REPO_DIRS). **Every feature sprint:** Implement full vertical slice (UI + backend), verify end-to-end flow (UI→API→backend) at exposed URLs, **wait for user confirmation**, then create `type/JIRA-ID-sprint-N` in each affected repo, commit and PR each repo. Do NOT commit before E2E verification. If sprint touches only one repo, commit/PR only that repo. Never mix repos in one commit. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md` (Sprint Verification: End-to-End Before Commit).

**Fix-bug and refactor:** Single repo → one commit, one PR. Multi-repo → commit and PR only in repos that have changes. Code detects repo structure from codebase (one `.git` at root vs multiple child dirs with `.git`); use REPO_DIRS from architecture when available.
