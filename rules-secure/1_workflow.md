# Secure Workflow

**MANDATORY — no skip.** For greenfield and brownfield before deployment. Must run and pass; cannot be bypassed. **Brownfield:** Veracode scan is **required** security.

Evaluate the design and implementation from a security perspective. Identify potential vulnerabilities, misconfigurations, data protection gaps, and compliance issues. Provide actionable recommendations. **Clearly indicate whether security posture is acceptable.** If issues are critical, require a return to Code (and potentially Plan) with explicit guidance.

## Before Any Work

0. **Expertise check (on every message):** Before responding to ANY message — including follow-ups and subsequent turns — check if the user or Nayan asks something outside this mode's expertise (per MODE RESTRICTION). If yes, hand off per `.nayan/guidance/expertise-handoff.md`. Do not attempt in-place or create a subtask. Do not skip on the next message.

## Prerequisites

- Code quality gate passed (MANDATORY — do not skip; use lint + tests + coverage fallback if SonarQube not configured)
- Code committed
- **Greenfield:** npm audit / pnpm audit / pip audit (or project security scan)
- **Brownfield:** **Veracode Pipeline Scanner** — VERACODE_API_ID, VERACODE_API_KEY, Java 11+

## Workflow

1. **Verify prerequisites** — **Always check first** (whether entered via workflow or directly). **Normal pipeline:** development-plan.md, codebase, tests passing. **Brownfield-fix-bug:** bug-fix-scope (or fix context from QA handoff), codebase, code quality gate passed — no development-plan required. If not passed: redirect per sdlc_prerequisites rule. When entered directly with missing prereqs: use new_task to redirect per sdlc-prerequisites.
2. **Multi-repo (Decoupled Fullstack):** When REPO_STRATEGY: multi, run security scan on **both** frontend and backend (each repo separately). Produce security-review.md covering both repos. Read REPO_STRATEGY from handoff; if absent, read from architecture.md; if still absent, **detect from codebase** (one `.git` at root → single; `frontend/.git` and `backend/.git` → multi). See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
3. **Detect local modifications** — Check for uncommitted/staged changes and branch commits vs base. If nothing has changed, STOP and inform the user. If changes are detected, ask the user: scan **local changes only** (faster, focused) or **full branch** (all compiled output)?
4. **Read context** — architecture.md (security architecture; optional for brownfield-fix-bug), development-plan.md (or BUG_FIX_SCOPE/fix context when brownfield-fix-bug), security-review.md (if exists)
5. **Greenfield:** Run `npm audit` / `pnpm audit` / `pip audit` (or project tool). Fix critical/high vulnerabilities. (Per repo when multi-repo.)
6. **Brownfield (Veracode required):**
    - Verify VERACODE_API_ID, VERACODE_API_KEY, Java
    - Build project (compiled output only — never raw source or node_modules)
    - **Multi-repo:** Build and scan **each repo separately** — `cd frontend && build` then package and scan; `cd backend && build` then package and scan. Produce combined security-review.md covering both.
    - Package artifact: **local scan** → compiled files for changed sources + their dependent modules only; **full scan** → entire compiled output directory
    - Run Veracode Pipeline Scanner on artifact
    - Parse results; map to severity
7. **Security evaluation** — Identify: **vulnerabilities**, **misconfigurations**, **data protection gaps**, **compliance issues**. Manual OWASP Top 10 review (auth, injection, XSS, config, etc.)
8. **Produce security-review.md** — All findings, severity, **actionable recommendations**, security posture (acceptable / not acceptable)
9. **HITL:** Present security summary. **Clearly indicate whether security posture is acceptable.** User confirms before handoff to deploy

## Output

- `security-review.md` — Findings, actionable recommendations, security posture assessment
- In chat: Security posture ✅/❌, top 3 Critical/High findings, explicit guidance if return required

## Handoff

- **Security posture acceptable:** When pipeline is **brownfield-fix-bug**, use attempt_completion to return to orchestrator (do not hand off to deploy). Orchestrator will ask user "Does this fix require deployment?" and delegate to deploy only if yes. For **normal pipeline**, hand off to deploy per `4_handoff.xml`.
- **Critical issues:** Require return to **code** (and potentially **plan**) with **explicit guidance**. Do not proceed until resolved and re-run.

See `4_handoff.xml` for conditional handoff logic. See `2_veracode_validation.md` for detailed Veracode Pipeline Scanner steps, OWASP Top 10 checklist, finding format, and security-review.md template. See `code_quality_security_gates` rule for pipeline order and HITL gates.
