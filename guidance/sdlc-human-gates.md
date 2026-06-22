# SDLC Human Gates (Human-in-the-Loop)

All modes must enforce these checkpoints. Rules and skills reference this document for consistency.

## Approver Name (All Sign-Off Activities)

**When any sign-off requires Approver Name** (PRD, architecture, development plan, QA plan, QA execution, deployment plan, security plan, etc.): Use the Nayan logged-in user's name from `environment_details` (section "Nayan Logged-in User"). If the user approves for a role or gate, use that name for the Approver Name field.

---

## Present-Before-Consent (CRITICAL)

**Never ask for consent, satisfaction, or approval before the user has seen the full content.** Users cannot meaningfully approve something they have not seen.

- **Jira/SOW context:** Present the full synthesized summary to the user immediately. Only after they have seen it, ask "Are you satisfied? Should I proceed?"
- **Satisfaction check:** Present the complete deliverable first. Only then ask "Are you satisfied with this result?"
- **Wrong:** "Are you satisfied with me presenting this summary now?" (user has not seen it)
- **Correct:** Present full content → then "Are you satisfied with this?"

See `.nayan/guidance/context-input-handling.md` and `.nayan/guidance/end-interaction-satisfaction-check.md`.

---

## Universal: USER CONSENT (Every Mode)

Before taking any action:

1. Ask clarifying questions to fully understand the user's requirements and intent.
2. **Present** your understanding and proposed plan to the user (user must see the full content).
3. Wait for explicit user approval before proceeding with any changes or actions.

## Prerequisite Validation (Before Mode Loads)

**Before delegating** to any mode, the delegator (orchestrator or handing-off mode) must validate that the next mode's prerequisites are present per `.nayan/guidance/sdlc-prerequisites.md`. Validation happens at delegation time — before the next mode loads and before its skills load. If missing, delegate to the mode that produces the missing artifact instead.

---

## Planning Gates

| Gate                          | Who Approves         | Where Enforced                                | Action                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ----------------------------- | -------------------- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **PRD sign-off**              | Product owner / user | prd                                           | **MANDATORY: Ask** "Which role are you? (PM, Engineering Lead, or Design)" **before** filling any Sign-Off. Do NOT assume or default to PM. **One user = one role.** Creator approves for their role only; other roles stay Pending. Share PRD with Engineering Lead and Design for their approvals. Each role requires a different approver. Present PRD; wait for "PRD approved" before handoff to architect. **PRD Sign-Off table (Section 1) must have all three roles (PM, Engineering Lead, Design) with Status = "Approved", Approver Name, and Sign-Off Date filled for each.** Handoff only when all three Approved. **When sharing PRD with another for sign-off:** Use manual hand-off (share task → direct recipient to PRD approval) or Slack/Gmail integration to send refined PRD. See `.nayan/guidance/prd-sharing-sign-off.md`. Do NOT handoff if Sign-Off is Pending, Needs Revision, or missing Name/Date. |
| **Architect input readiness** | User / orchestrator  | prd (greenfield), orchestrator (brownfield A) | **Greenfield:** Confirm refined-prd has (1) Sign-Off with all three roles Approved, Approver Name, and Sign-Off Date filled for each, (2) Use Cases, Entities, Domain Glossary (Appendix), Non-Functional Expectations before delegating to architect. **Brownfield A:** Confirm condensed scope has feature description, integration points; architect has architecture.md and codebase. See `.nayan/guidance/plan-input-requirements.md`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| **Architecture sign-off**     | Tech lead / user     | architect                                     | HITL at decision points: tech stack, architectural pattern, key modules; present full architecture; confirm "Does this fully address all requirements?"; wait for approval before handoff                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **UX prototype sign-off**     | User / design        | prototype                                     | Present prototypes; wait for explicit approval before handoff to plan (dev-plan phase). **Once approved, the prototype is the authoritative source for UI design and final look-and-feel.** Code mode implements to match the prototype using the tech stack selected in architect mode.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **Development plan sign-off** | User / team          | plan                                          | Present plan; wait for approval before handoff to code                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Code review (first pass)**  | User / reviewer      | qa                                            | After code: present review; wait for approval before handoff to QA plan phase. **For brownfield-fix-bug (simple):** skip to quality gate phase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| **QA plan sign-off**          | User / QA            | qa                                            | Present QA plan; wait for approval before handoff to QA execution phase                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| **QA execution sign-off**     | User / QA            | qa                                            | Present QA results; wait for approval before handoff to quality gate phase                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| **Code review (second pass)** | User / reviewer      | qa                                            | After quality gate: present final review; wait for approval before handoff to secure                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| **Deployment plan sign-off**  | User / ops           | deploy                                        | Present deployment plan; wait for approval before handoff to deployment execution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| **User-provided inputs**      | User                 | plan, code                                    | Repo URL (single repo) or REPO_FRONTEND + REPO_BACKEND (Decoupled with frontend/backend) or REPO_DIRS + per-repo URLs (generic multi-repo with project-specific names), DB URL, env vars, API keys, deployment target—**ask**; never assume or hardcode. Plan collects at development plan sign-off; passes to Code in handoff. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |

---

## Implementation Gates

| Gate                                     | Who Approves     | Where Enforced | Action                                                                                                                                                                                                                                                    |
| ---------------------------------------- | ---------------- | -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sprint task verification**             | Developer / user | code           | After each task: verify on **local env**; "Please verify [X] works locally"; **wait for explicit user confirmation** before next task                                                                                                                     |
| **Tests & code coverage**                | Developer / user | code           | Each sprint: unit tests, integration tests for new code; run coverage; ensure new code covered. "Please verify tests pass and coverage is reported." — **wait for user consent** before commit                                                            |
| **Tech stack integration**               | User             | code           | "Please verify end-to-end flow: [describe flow]. All integration points work." — **wait for explicit user confirmation** before commit. **Multi-repo:** Same — verify full UI→backend flow at exposed URLs before any per-repo commit.                    |
| **Local testing verification & consent** | User             | code           | User must run app locally and verify features. Ask: "All sprint functionality verified locally? Tests pass? Coverage reported? End-to-end flow confirmed?" — **Wait for user to say "yes" or "confirmed"** before commit. Do not proceed without consent. |
| **Sprint completion**                    | User             | code           | Final gate before commit/PR: user must explicitly confirm all verification items above. No commit without user consent.                                                                                                                                   |

**Per-sprint environment:** During each sprint, verify and test on **local environment only**. Do not deploy to cloud until all sprints are complete.

---

## Code Quality Gates

**Strict handoff when there is a code change (greenfield or brownfield):** Code → QA → Secure. No bypass. Code must hand off to QA; QA must hand off to Secure before deploy. See `.nayan/guidance/code-quality-security-gates.md`.

| Gate                               | Who Approves     | Where Enforced | Action                                                                                                                                                                                                                                                                                                        |
| ---------------------------------- | ---------------- | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Code quality gate (SonarQube)**  | Developer / user | qa             | **MANDATORY — no skip** greenfield & brownfield. QA runs quality gate phase. Run SonarQube (or SonarCloud) + lint; fallback: lint + tests + coverage if SonarQube not configured. Produce code-review.md. PASS → secure; FAIL → code for remediation. See `.nayan/guidance/code-quality-security-gates.md`.  |
| **Code quality gate (per-sprint)** | Developer / CI   | code           | Lint, tests, coverage must pass before commit. Fix failures before PR.                                                                                                                                                                                                                                        |
| **Security review**                | Developer / user | secure         | **MANDATORY — no skip** greenfield & brownfield. Must run and pass. Greenfield: npm/pip audit. Brownfield: **Veracode Pipeline Scanner required** + OWASP Top 10 review. Produce security-review.md. Critical/High must be resolved before deployment. See `.nayan/guidance/code-quality-security-gates.md`. |
| **Security scan (per-sprint)**     | Developer / CI   | code           | When repo has changes: run `npm audit` / `pnpm audit` / `pip audit` (or project tool). Fix critical/high vulnerabilities before PR.                                                                                                                                                                           |
| **PR per sprint**                  | User / reviewer  | code           | **Create PR after each sprint.** Human reviewer must approve before merge. Enables code review gate before next sprint.                                                                                                                                                                                       |
| **PR creation**                    | User             | code           | Create PR with accomplishments, testing instructions, coverage summary; **PR requires reviewer approval** (external to Nayan)                                                                                                                                                                                |
| **PR merge approval**              | Reviewer (human) | —              | Human merges PR in GitHub/GitLab; Nayan does **not** auto-merge                                                                                                                                                                                                                                              |

---

## Deployment Gates

| Gate                                   | Who Approves | Where Enforced              | Action                                                                                                                                                                                 |
| -------------------------------------- | ------------ | --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Deployment needed (fix-bug)**        | User         | orchestrator (after secure) | "Does this fix require deployment?" If no, end pipeline. If yes, delegate to deploy.                                                                                                   |
| **Per-sprint env**                     | —            | code                        | **Local only** during sprints: run and verify on local dev environment                                                                                                                 |
| **Deployment plan sign-off**           | User / ops   | deploy                      | Present deployment plan; wait for approval before handoff to deployment execution                                                                                                      |
| **Deployment sprint**                  | User         | deploy                      | Dedicated phase after all sprints. HITL at each step: pre-deploy (code quality, security scan), deployment target confirmation, pre-deploy approval, deploy, post-deploy verification. |
| **Cloud deploy timing**                | User         | deploy                      | **Cloud deploy only after all sprints finished**; never deploy to cloud mid-pipeline                                                                                                   |
| **Pre-deploy code quality & security** | User / ops   | deploy                      | Code quality gate (SonarQube) and security review (Veracode for brownfield) must pass before deploy. Lint, tests, coverage. User confirms or CI reports green.                         |
| **Deployment target confirmation**     | User         | code, deploy                | "Where should this be deployed?" — never assume                                                                                                                                        |
| **Pre-deploy approval**                | User / ops   | deploy                      | "Confirm deployment target and credentials"; **wait for explicit approval** before deploy                                                                                              |
| **Post-deploy verification**           | User         | code, deploy                | "Please confirm the deployed version works on [URLs]" — **wait for user confirmation**                                                                                                 |

---

## Issue / Debug Gates

| Gate                         | Who Approves | Where Enforced                                           | Action                                                                                                                                                                                   |
| ---------------------------- | ------------ | -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Issue scope confirmation** | User         | code (issue-resolution-workflow, pr-resolution-workflow) | Present issue details to user first; then confirm before implementing. Never ask for confirmation before user has seen the issue.                                                        |
| **Diagnosis confirmation**   | User         | code                                                     | Present diagnosis to user first; then "Confirm diagnosis before applying fix" (brownfield-fix-bug; systematic-debugging). Never ask for confirmation before user has seen the diagnosis. |

**Fix-bug path (brownfield-fix-bug):**

- **Diagnosis confirmation** (code, brownfield-fix-bug): "Confirm diagnosis before applying fix" — already present
- **Fix verification** (code, when fix applied): "Please verify the fix works locally" — wait for user confirmation before handoff to qa
- **Code quality gate** (qa): MANDATORY — user confirms PASS before secure
- **Security review** (secure): MANDATORY — user confirms Critical/High resolved before deployment or pipeline end
- **Deployment needed** (orchestrator): Ask user after secure; if no, end pipeline with summary

---

## End Interaction Satisfaction Check

Before ending any interaction with `attempt_completion`, run a satisfaction confirmation step:

1. **PRESENT-FIRST:** Present the complete deliverable to the user (full summary, details, artifact) before asking.
2. **After** the user has seen it, call `ask_followup_question` to ask whether they are satisfied.
3. Include at least two options: "Yes, satisfied" and "Not yet, I want more updates".
4. If not satisfied → continue working; do not call `attempt_completion`; present updates, then run the check again.
5. If satisfied → provide final summary via `attempt_completion`.
6. If user explicitly says to skip satisfaction checks for the current conversation, follow that instruction.

**Never ask "Are you satisfied with me presenting this?" before the user has seen the content.**

**Exceptions:** Greetings (no `attempt_completion`); delegation subtasks apply at leaf level.

**Full reference:** `.nayan/guidance/end-interaction-satisfaction-check.md`

---

## Explicit Non-Auto Behavior

- **PR merge:** Nayan creates the PR. A **human reviewer** approves and merges in GitHub/GitLab. Rules must state: "Do not merge the PR yourself; the user or team reviewer will merge after approval."
- **Per-sprint verification:** During each sprint, verify and test on **local environment only**. Run locally; **user must confirm** functionality locally. Do not commit without user consent. Do not deploy to cloud until all sprints are complete.
- **Cloud deployment:** Only after **all sprints are finished**, deploy to cloud. Nayan prepares deployment. **Human approves** the actual deploy. Rules must state: "Deploy to cloud only after all sprints complete. Confirm deployment target and get explicit approval before deploying."
