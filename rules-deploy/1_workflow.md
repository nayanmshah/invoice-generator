# Deploy Workflow

Deploy mode uses the `standard-deploy` workflow skill. General policies (user consent, expertise check, present-first) apply.

## Before Any Work

0. **Expertise check (on every message):** Before responding to ANY message — including follow-ups and subsequent turns — check if the user or Nayan asks something outside this mode's expertise (per MODE RESTRICTION). If yes, hand off per `.nayan/guidance/expertise-handoff.md`. Do not attempt in-place or create a subtask. Do not skip on the next message.

## Workflow

Load the **standard-deploy** skill — full deployment plan (infrastructure, CI/CD, environments, observability) to the user's chosen platform (Vercel, Render, Railway, AWS, Azure, GCP, etc.).

Provider-specific methodology skills (`deployment-aws`, `deployment-azure`, `deployment-gcp`, `deployment-vercel`, `deployment-render`, `deployment-railway`, `terraform-deployment`) are loaded **within** standard-deploy based on the chosen platform.

### Execute

Load standard-deploy and any applicable provider methodology skill.

1. **Verify prerequisites** — **Always check first** (whether entered via workflow or directly). architecture.md (optional for brownfield-fix-bug), codebase, security-review.md, code-review.md. If not passed: redirect per sdlc_prerequisites rule. When entered directly with missing prereqs: use new_task to redirect per sdlc-prerequisites. If all sprints not finished (or fix not complete for brownfield-fix-bug): do not proceed; inform user.
2. **Read context** — architecture.md (if present), codebase, security-review.md (security decisions), code-review.md (quality decisions). **Brownfield-fix-bug:** If architecture.md missing, use codebase and security-review for deployment context.
3. **Align with security and quality** — Plan must align with security-review.md and code-review.md (quality gate) decisions. Compatible with greenfield and brownfield.
4. HITL (MANDATORY):\*\*
    - Present deployment plan to user. **Wait for explicit approval**
    - **Pre-deploy code quality:** Lint, tests, coverage must pass. User confirms or CI reports green.
    - **Pre-deploy security scan:** Run security scan. Fix critical/high before deploy. User confirms scan passed.

Follow the loaded deployment skill workflow.
After completion, follow `4_handoff.xml` to return to orchestrator.
