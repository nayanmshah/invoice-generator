# Code Quality Gate & Security Review

**MANDATORY — no skip.** QA (quality gate phase) and secure must run and pass for greenfield and brownfield before deployment. Neither may be skipped. Keeps human in the loop for quality and security.

## Secrets and Chat (All Modes)

**Never echo, log, or paste sensitive values to chat** (e.g. VERACODE_API_KEY, SONAR_TOKEN, passwords, API keys). Only report that a credential is **"set"** or **"NOT SET"** or that an operation **succeeded** or **failed**. Applies in every mode. See `.nayan/rules/secrets_chat.xml`.

**No exceptions:** Applies to **all pipelines where code or files change** — greenfield, brownfield-extend, brownfield-add-feature, brownfield-fix-bug, brownfield-refactor, brownfield-migrate. Quality and security gates must never be bypassed when code changes.

## Strict Handoff (When There Is a Code Change)

**When there is a code change** (i.e. after Code mode has completed implementation in the pipeline) in greenfield or brownfield:

- **Code → QA:** Code must hand off to QA when implementation is complete. Do not skip QA or hand off directly to deploy.
- **QA → Secure:** QA must hand off to Secure when the quality gate passes. Do not skip Secure or hand off directly to deploy.
- **No bypass:** This order (Code → QA → Secure) is strict for every pipeline where code or files change. Applies to greenfield and all brownfield pipelines (extend, add-feature, fix-bug, refactor, migrate). Brownfield-refactor: QA may be entry (Phase 0 → code); after Code completes, Code → QA (full flow) → Secure.

See pipeline definitions in `.nayan/rules-orchestrator/2_workflows_greenfield.xml` and `2_workflows_brownfield.xml`.

## Pipeline Order

| Step | Mode   | When                                                                       |
| ---- | ------ | -------------------------------------------------------------------------- |
| 1    | qa     | After code + tests; QA runs quality gate phase; before PR/deployment       |
| 2    | secure | After qa quality gate passes; before deploy (includes security assessment) |

## Code Quality Gate

**Purpose:** Focused, systematic review of code quality and maintainability. Assess: readability, modularity, adherence to patterns and standards, test coverage, complexity hot spots, refactoring opportunities. **Output must clearly state PASS or FAIL.** If FAIL: specify concrete improvements requiring return to Code before proceeding.

**Tools:** SonarQube (SonarScanner CLI) or SonarCloud + language-specific linting (ESLint, Checkstyle, SpotBugs)

**Multi-repo (Decoupled Fullstack):** Run quality gate **per repo** — `cd frontend && sonar-scanner` (or equivalent); `cd backend && sonar-scanner`. Produce code-review.md covering both repos. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.

**SonarQube credentials** — ask user which setup before proceeding:

**Option A: Global / Remote SonarQube (or SonarCloud):**

- SONAR_TOKEN
- SONAR_PROJECT_KEY
- SONAR_HOST_URL (or https://sonarcloud.io for SonarCloud)
- SONAR_ORGANIZATION (SonarCloud only)

**Option B: Local SonarQube:**

- Host URL (default: `http://localhost:9000/`) + either a token or username/password
- If username/password provided, token is auto-generated via API
- Project key auto-derived (auto-created on first scan)
- Typically Community Edition — omit `sonar.branch.name`

**Fallback when SonarQube not configured:** Lint + tests + coverage (per sprint workflow) must pass. **Do not skip** the qa quality gate phase — run it with fallback (lint + tests + coverage) and produce code-review.md. Document tool used in PR.

**Output:** code-review.md with quality gate status, metrics, issues, remediation. Include **Create** block (Nayan, User Name, Create Date) per document standards.

## Security Review

**Purpose:** Evaluate design and implementation from a security perspective. Identify vulnerabilities, misconfigurations, data protection gaps, compliance issues. Provide actionable recommendations. **Clearly indicate whether security posture is acceptable.** If critical: require return to code (and potentially plan) with explicit guidance.

### Greenfield

- **Required:** `npm audit` / `pnpm audit` / `pip audit` (or project security scan)
- **Optional:** Veracode if credentials are configured

### Brownfield

- **Required:** **Veracode Pipeline Scanner** — VERACODE_API_ID, VERACODE_API_KEY, Java 11+
- **Required:** Manual OWASP Top 10 review
- **Output:** security-review.md with Veracode results + manual findings
- **Multi-repo:** Build and scan **each repo separately**; combine findings in security-review.md. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.

**Veracode setup:**

- Download pipeline-scan: https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip
- Veracode scans **compiled artifacts** — build before scan (e.g., `dist/` for TS, `target/` for Java)
- Artifact: zip of compiled output (e.g., `zip -r veracode-scan-artifact.zip dist/ -i "*.js"`)

**OWASP Top 10 focus:** A01 Injection, A02 Broken Auth, A03 XSS, A05 Misconfiguration, A07 XSS, A09 Logging Failures

## HITL Gates (No Skip)

- **Code quality gate:** **MUST run** — cannot be skipped. User must confirm quality gate PASS before Security Review. FAIL → return to Code.
- **Security review:** **MUST run** — cannot be skipped. User must confirm Critical/High findings resolved before deployment. Unacceptable posture → return to Code/Plan.
- **Deployment:** Do not deploy until both gates **pass**. No bypass.

## Integration with Sprint Workflow

- **Per sprint:** Lint, tests, coverage (already in sprint workflow)
- **Before deployment:** Code quality gate (SonarQube) + Security review (Veracode for brownfield)
- **PR per sprint:** Human review gate

## References

- `.nayan/rules-qa/1_workflow.md` (quality gate phase)
- `.nayan/rules-qa/2_sonarqube_validation.md` — detailed SonarScanner CLI, lint commands, templates, architectural validation
- `.nayan/rules-secure/1_workflow.md`
- `.nayan/rules-secure/2_veracode_validation.md` — detailed Veracode Pipeline Scanner, OWASP Top 10, finding format
- `.nayan/guidance/sdlc-human-gates.md`
