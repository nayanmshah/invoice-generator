---
name: standard-deploy
description: Standard deployment workflow with Phase 1 (deployment plan creation with HITL approval) and Phase 2 (deployment execution). Covers multi-provider deployments (GCP, Render, Vercel, Railway, AWS, Azure) with security and quality alignment.
modeSlugs:
    - deploy
---

# Standard Deployment Workflow

Deploy mode covers deployment plan creation and deployment execution. **Human reviews plan** before execution; **human approves** actual deploy.

**This is the primary workflow.** Even when the user names a specific platform (e.g. "deploy to Vercel"), follow this workflow's phases in order. Provider-specific skills (deployment-vercel, deployment-render, deployment-railway, deployment-aws, deployment-azure, deployment-gcp) are methodology supplements referenced during Phase 2 execution — they do NOT replace this workflow.

## Phase 1: Deployment Plan Creation

1. **Verify prerequisites** — **Always check first** (whether entered via workflow or directly). architecture.md (optional for brownfield-fix-bug), codebase, security-review.md, code-review.md. If not passed: redirect per sdlc_prerequisites rule. When entered directly with missing prereqs: use new_task to redirect per sdlc-prerequisites. If all sprints not finished (or fix not complete for brownfield-fix-bug): do not proceed; inform user.
2. **Read context** — architecture.md (if present), codebase, security-review.md (security decisions), code-review.md (quality decisions). **Brownfield-fix-bug:** If architecture.md missing, use codebase and security-review for deployment context. **REPO_STRATEGY and REPO_DIRS:** Read from handoff; if absent, from architecture.md; if still absent, **detect from codebase** (one `.git` at root → single; no `.git` at root and one or more child dirs have `.git` → multi; discover child repos for REPO_DIRS). See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
3. **Create deployment plan** (per devops-plan-methodology):
    - Infrastructure design (GCP, Render, Vercel, Railway, AWS, etc.)
    - Environment strategy (dev, test, staging, production)
    - CI/CD pipelines
    - Configuration management
    - Observability and logging
    - **Multi-repo (Decoupled Fullstack):** When REPO_STRATEGY: multi, each repo in REPO_DIRS may deploy to different targets (e.g., Vercel for frontend, Render for backend). Handle per-repo deployment from each repo dir. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
4. **Align with security and quality** — Plan must align with security-review.md and code-review.md (quality gate) decisions. Compatible with greenfield and brownfield.
5. **HITL:** Present deployment plan to user. **Wait for explicit approval** before Phase 2.

**Provider skill (MANDATORY):** Once the deployment target is known (from user input, architecture.md, or handoff context), **read and follow** the matching `deployment-{provider}` skill for platform-specific configuration, commands, and verification:

| Target Platform   | Load Skill         |
| ----------------- | ------------------ |
| Vercel            | deployment-vercel  |
| Render            | deployment-render  |
| Railway           | deployment-railway |
| AWS               | deployment-aws     |
| Azure             | deployment-azure   |
| GCP (GKE/Jenkins) | deployment-gcp     |

Use the provider skill's methodology for infrastructure details in Phase 1 and execution steps in Phase 2. The provider skill supplements this workflow — follow both this workflow's phases AND the provider skill's platform-specific instructions.

## Phase 2: Deployment Execution

1. **Verify prerequisites** — **Always check first** (whether entered via workflow or directly). deployment plan (user approved), architecture.md (optional for brownfield-fix-bug), codebase. If not passed: redirect per sdlc_prerequisites rule (e.g. to architect if architecture.md missing). When entered directly with missing prereqs: use new_task to redirect per sdlc-prerequisites. If all sprints not finished (or fix not complete for brownfield-fix-bug): do not deploy; inform user.
2. **Read deployment plan** — Infrastructure, environment strategy, CI/CD, config, observability
3. **Deployment Sprint — HITL (MANDATORY):**
    - **Pre-deploy code quality:** Lint, tests, coverage must pass. User confirms or CI reports green.
    - **Pre-deploy security scan:** Run security scan. Fix critical/high before deploy. User confirms scan passed.
    - **[User Input] Deployment target:** "Where should this be deployed?" — User provides (GCP, AWS, Azure, Render, Vercel, Railway, etc.). Never assume. See `.nayan/guidance/deployment-platforms.md`.
    - **[User Input] Pre-deploy approval:** "Confirm deployment target and credentials." — **Wait for explicit user approval** before deploying.
    - **Deploy:** Follow the `deployment-{provider}` skill's instructions for the confirmed target platform. Frontend and backend to user-specified targets. **Multi-repo:** Deploy each repo in REPO_DIRS from its directory; may target different platforms (e.g., Vercel + Render) — load the corresponding provider skill for each.
    - **[User Input] Post-deploy verification:** "Please confirm the deployed version works on [URLs]." — **Wait for user confirmation** before marking complete.
4. When deployment complete, call `attempt_completion` back to orchestrator

See devops-plan-methodology, ops-plan-methodology, dockerization-methodology, jenkins-cicd (when CI/CD is Jenkins), terraform-deployment (when infra is Terraform), deployment-gcp, deployment-vercel, deployment-render, deployment-railway, deployment-aws, deployment-azure skills. See sdlc_human_gates rule for deployment plan sign-off and deployment gates.

---

## Sprint Deployment Workflow

When deploy mode is called after local testing and commit (Vercel/Render/Railway or similar).

### Sprint Deployment Workflow (When Delegated from Developer Mode)

When called by Developer mode after local testing and commit:

1. Verify pre-deployment steps completed (implementation, testing, commit, push)
2. Deploy Frontend to Vercel (or as per architecture) from sprint branch
3. Deploy Backend to Render or Railway (or as per architecture) from sprint branch
4. Request user testing on deployed URLs
5. Create Pull Request with deployment URLs
6. Update development plan with sprint status

### Deliverables

- Deployment strategy with MCP-based platform selection
- Environment variable templates (.env.example)
- Deployment documentation with step-by-step instructions
- Executed deployments using MCP tools (Vercel, Render, Railway)
- Deployment results for user review

### Validation Checklist

- Codebase analyzed for tech stack
- Optimal platform selected per component
- Environment variables configured
- Deployments executed and verified
- Health checks validated
- Frontend-backend integration confirmed
- Deployment documentation complete
