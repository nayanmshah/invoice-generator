# Veracode & OWASP Security Validation

Detailed steps for running Veracode Pipeline Scanner and manual OWASP Top 10 review. See `1_workflow.md` for the high-level workflow. See `code_quality_security_gates` rule for pipeline order and HITL gates.

**Greenfield:** Use `npm audit` / `pnpm audit` / `pip audit` (or project security scan). Veracode optional if credentials configured.

**Brownfield:** Veracode Pipeline Scanner **required** + manual OWASP Top 10 review.

## Mandatory Input Validation

Before starting:

**Multi-repo:** If no `.git` at root and one or more child dirs have `.git`, discover child repos. Run these checks **per repo**: `cd <repo> && git status --porcelain`. Scan each repo that has changes. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.

1. **Check for local modifications** — run `git status --porcelain` and `git diff --name-only origin/develop...HEAD` (or `origin/main...HEAD`). **Multi-repo:** Run inside each child repo directory. If there are no uncommitted changes and no branch commits ahead of the base, inform the user there is nothing new to scan and **STOP**.
2. If changes exist, ask: "Should I scan **recent local changes only** (git diff vs develop), or the **full project**?" — default to recent changes.
3. Read `architecture.md` if it exists — for security architecture context
4. Read `development-plan.md` — to understand what was built and what security was planned
5. Read `security-review.md` if it exists — to build on prior findings rather than duplicate them

---

## Phase 0: Veracode Pipeline Scanner (Brownfield)

Run the Veracode Pipeline Scanner first. Its automated SAST findings form the baseline; the manual review in Phases 1–3 layers on top.

### Step 1: Verify Prerequisites

```bash
# 1. Check Veracode credentials (never echo secret values to chat)
[ -n "${VERACODE_API_ID:-}" ]  && echo "VERACODE_API_ID is set"  || echo "VERACODE_API_ID is NOT SET"
[ -n "${VERACODE_API_KEY:-}" ] && echo "VERACODE_API_KEY is set" || echo "VERACODE_API_KEY is NOT SET"

# 2. Check Java (required to run pipeline-scan.jar)
java -version

# 3. Check if pipeline-scan.jar already exists
ls -la pipeline-scan.jar 2>/dev/null || echo "pipeline-scan.jar not found — will download"
```

**If credentials are missing or empty**: STOP — do not proceed to build or scan. Inform the user:

> "Veracode credentials are not set. Please export VERACODE_API_ID and VERACODE_API_KEY in your shell, then re-run Security Review mode."

**If Java is missing**: STOP. Inform the user:

> "Java is required to run the Veracode Pipeline Scanner. Please install Java 11+ and try again."

### Step 2: Identify Files to Scan

**Multi-repo:** Run `git diff` and `git rev-parse` inside each child repo directory. For each repo with changes, identify files to scan.

```bash
# Get files changed vs develop (or main) branch
# Single repo: run from workspace root. Multi-repo: cd <repo> first, then run.
git diff --name-only origin/develop...HEAD 2>/dev/null \
  || git diff --name-only origin/main...HEAD 2>/dev/null \
  || git diff --name-only HEAD~1

# Also capture the branch and commit context for the report
echo "Branch: $(git rev-parse --abbrev-ref HEAD)"
echo "Latest commit: $(git log -1 --oneline)"
```

If the user chose **full project scan**, skip the diff filter and package the entire build output.

### Step 3: Download Pipeline Scanner (if needed)

```bash
if [ ! -f pipeline-scan.jar ]; then
  curl -sSO https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip
  unzip -o pipeline-scan-LATEST.zip pipeline-scan.jar
  echo "Downloaded pipeline-scan.jar"
fi
```

### Step 4: Build and Package the Artifact

Veracode Pipeline Scanner requires a **compiled artifact** — it does not scan raw TypeScript/source directly.

#### 4a: Build

Detect the build command from project config (`package.json` scripts, `pom.xml`, `build.gradle`). Do not ask the user unless auto-detection fails. Run the build.

#### 4b: Package

The artifact zip must contain **only compiled JS** (`.js`, `.mjs`, `.cjs`) from build output directories (`dist/`, `build/`, `target/`). For monorepos, find all build output dirs across packages/apps.

**Never include**: `node_modules/`, config files, or non-JS assets (`.ts`, `.tsx`, `.css`, `.json`, `.html`, `.map`). Also exclude `.js` files that live outside build output directories (e.g. test mocks, source `.js` files in `src/`) — only `.js` files inside `dist/`, `build/`, or `target/` belong in the artifact.

**Full project scan:**

```bash
# Find all build output dirs (adjust pattern to match project structure)
find . -name "dist" -type d -not -path "*/node_modules/*" -not -path "*/.git/*"

# Zip only compiled JS from those directories
zip -r veracode-scan-artifact.zip <dirs> -i "*.js" "*.mjs" "*.cjs" -x "*/node_modules/*"
```

**Local changes scan** — only the compiled output of changed files and their dependent modules. Do not include the full build output.

```bash
# 1. Get changed source files
CHANGED=$(git diff --name-only origin/develop...HEAD 2>/dev/null \
  || git diff --name-only origin/main...HEAD)

# 2. Map each changed source file to its compiled equivalent
#    Replace /src/ with /dist/ in the path, and .ts/.tsx extension with .js
#    Verify the compiled file actually exists before including it
COMPILED=""
for f in $CHANGED; do
  js=$(echo "$f" | sed 's|/src/|/dist/|' | sed 's/\.tsx\{0,1\}$/.js/')
  [ -f "$js" ] && COMPILED="$COMPILED $js"
done

# 3. Trace direct project imports from each compiled file
#    (relative imports only — skip anything from node_modules)
DEPS=""
for f in $COMPILED; do
  dir=$(dirname "$f")
  grep -oE "(require|from) ['\"]\.\/[^'\"]+" "$f" 2>/dev/null \
    | sed "s/.* ['\"]//" \
    | while read imp; do
        dep="$dir/$imp.js"
        [ -f "$dep" ] && echo "$dep"
      done
done | sort -u > /tmp/veracode-deps.txt
DEPS=$(cat /tmp/veracode-deps.txt)

# 4. Zip changed compiled files + their dependent modules
echo $COMPILED $DEPS | tr ' ' '\n' | sort -u | zip veracode-scan-artifact.zip -@
```

#### 4c: Validate before scanning

```bash
# Check artifact contents — should only show .js/.mjs/.cjs from dist/build dirs
unzip -l veracode-scan-artifact.zip | head -30
ls -lh veracode-scan-artifact.zip
```

If the artifact contains `node_modules/`, `src/` paths, or non-JS files, **STOP** and repackage. Do not upload a bad artifact.

If the build fails, report the error and ask the user to fix it before scanning.

### Step 5: Run the Pipeline Scan

```bash
java -jar pipeline-scan.jar \
  --veracode_api_id "$VERACODE_API_ID" \
  --veracode_api_key "$VERACODE_API_KEY" \
  --file veracode-scan-artifact.zip \
  --fail_on_severity "Very High, High" \
  --json_output_file veracode-results.json \
  --issue_details true \
  2>&1 | tee veracode-scan.log

echo "Exit code: $?"
```

**Secrets:** Do not paste `veracode-scan.log` (or any log that might contain API id/key or request details) to chat. Report only exit code and scan success/failure. Per secrets-chat rule.

**Scan flags:**

- `--fail_on_severity "Very High, High"`: Non-zero exit if Critical/High findings exist
- `--json_output_file veracode-results.json`: Machine-readable results
- `--issue_details true`: Include CWE IDs and remediation info

### Step 6: Parse Veracode Results

Read `veracode-results.json` and map every finding into the standard FINDING-XXX format.

**Veracode → Nayan severity mapping:**

| Veracode Severity | Nayan Severity |
| ----------------- | --------------- |
| 5 — Very High     | Critical        |
| 4 — High          | High            |
| 3 — Medium        | Medium          |
| 2 — Low           | Low             |
| 1 — Informational | Informational   |

**Filter for recent changes:** Cross-reference `files_changed` from Step 2. Flag findings in changed files as **"In-scope (changed file)"** and in unchanged files as **"Context finding (unchanged file)"**. Focus remediation on in-scope findings.

**Key fields to extract:** `issue_id`, `cwe_id`, `issue_type`, `severity`, `files.source_file.file`, `files.source_file.line`

### Step 7: Veracode Scan Summary

Produce a summary in chat:

```
Veracode Pipeline Scan — Summary
=================================
Artifact scanned : veracode-scan-artifact.zip
Branch           : [branch name]
Commit           : [latest commit]
Scan scope       : Recent changes (git diff) | Full project

Findings
--------
Critical (Very High) : X  ← blocks deployment
High                 : X  ← blocks deployment
Medium               : X
Low                  : X
Informational        : X

In-scope (changed files) : X findings
Context (unchanged files): X findings
```

---

## Phase 1: Attack Surface Mapping (Manual)

After the Veracode scan (or for greenfield), map the attack surface:

- **Entry Points**: All API endpoints, user inputs, file uploads, webhooks, scheduled jobs
- **Authentication/Authorization Boundaries**: Who can access what, and how identity is verified
- **Data Flows**: What sensitive data (PII, credentials, financial) enters, is processed, and is stored
- **External Integrations**: Third-party services, APIs, databases, message queues
- **Infrastructure**: Deployment configs, container definitions, CI/CD pipelines

---

## Phase 2: OWASP Top 10 Manual Review

Focus manual review on areas SAST may miss (business logic, config, runtime behavior).

**A01 — Broken Access Control:**

- [ ] Authorization checks on all sensitive endpoints
- [ ] No insecure direct object references (IDOR)
- [ ] RBAC correctly implemented; privilege escalation not possible
- [ ] CORS properly configured

**A02 — Cryptographic Failures:**

- [ ] No hardcoded secrets, passwords, or API keys in source code
- [ ] Sensitive data encrypted at rest and in transit (TLS/HTTPS enforced)
- [ ] Passwords hashed with bcrypt, Argon2, or equivalent (NOT MD5/SHA1)
- [ ] Encryption key management secured

**A03 — Injection:**

- [ ] No SQL injection (parameterized queries or ORM used throughout)
- [ ] No command injection in shell/exec calls
- [ ] User-generated content sanitized to prevent XSS
- [ ] No LDAP, template, or XPath injection

**A04 — Insecure Design:**

- [ ] Rate limiting on sensitive operations (login, password reset, API)
- [ ] Business logic flaws reviewed (e.g., price manipulation, workflow bypass)
- [ ] No race conditions in critical paths

**A05 — Security Misconfiguration:**

- [ ] No default credentials left in place
- [ ] Error messages do not expose stack traces or system internals
- [ ] Security headers configured (HSTS, CSP, X-Frame-Options, X-Content-Type-Options)
- [ ] Unnecessary endpoints, ports, or features disabled

**A06 — Vulnerable and Outdated Components:**

- [ ] Dependencies checked for known CVEs (package.json, pom.xml, requirements.txt)
- [ ] No critically outdated libraries in use

**A07 — Identification and Authentication Failures:**

- [ ] Session tokens expire and are invalidated on logout
- [ ] Brute force protection in place (rate limiting, account lockout)
- [ ] Secure cookie attributes set (HttpOnly, Secure, SameSite)
- [ ] MFA enforced where required by PRD or compliance

**A08 — Software and Data Integrity Failures:**

- [ ] Dependency lockfiles present and committed
- [ ] CI/CD pipeline access controls verified
- [ ] No deserialization of untrusted data

**A09 — Security Logging and Monitoring Failures:**

- [ ] Security events logged (auth failures, access violations, privilege changes)
- [ ] Logs do NOT contain passwords, tokens, or full PII
- [ ] Log integrity and centralization in place
- [ ] Alerting configured for critical security events

**A10 — Server-Side Request Forgery (SSRF):**

- [ ] No user-controlled URLs passed to server-side HTTP requests without validation
- [ ] URL allowlists enforced for external requests
- [ ] Cloud provider metadata endpoints protected

---

## Phase 3: Additional Manual Checks

- **Secrets Management**: No secrets in code or config files; .env and credentials in .gitignore; Secret Manager for production
- **API Security**: Auth on all endpoints; rate limiting; no PII or credentials in responses or logs
- **Input Validation**: Server-side validation on all inputs; file upload validation (type, size, content)
- **Infrastructure Security**: Non-root container user; resource limits; IAM least privilege; network policies

---

## Finding Format

Use this format for **all** findings — both Veracode-detected and manual:

```markdown
### FINDING-001: [Descriptive Title]

**Source**: Veracode Pipeline Scanner | Manual Review
**Severity**: Critical | High | Medium | Low | Informational
**Category**: [OWASP A0X or CWE-XXX]
**Location**: [file:line or component name]
**Description**: [What the vulnerability is and why it is a risk]
**Evidence**: [Specific code snippet, Veracode issue_id, or CWE ID]
**Risk**: [What an attacker could do if this is exploited]
**Remediation**: [Specific steps to fix, with before/after code examples]
**References**: [OWASP link, CWE link, Veracode docs, or CVE]
**In-scope**: Yes (changed file) | No (context finding)
```

**Severity Definitions:**

- **Critical**: Immediate exploitation possible; data breach or system compromise likely — block deployment
- **High**: Significant risk; must be fixed before production deployment
- **Medium**: Security weakness; address in near term
- **Low**: Minor concern; best practice improvement
- **Informational**: Positive finding or non-blocking suggestion

---

## Output: security-review.md

**MANDATORY**: Produce/update `security-review.md` in the workspace root with ALL of the following sections:

```markdown
# Security Review Report

### Create

| Nayan | User Name | Create Date |
| :----- | :-------- | :---------- |
|        |           |             |

**Branch**: [branch name]
**Commit**: [latest commit hash + message]
**Scan scope**: Recent changes (git diff vs develop) | Full project

---

## Executive Summary

[2–3 sentences on overall security posture and key risks]

## Veracode Pipeline Scan Results

| Severity | Veracode Count | In-scope (changed files) |
| -------- | -------------- | ------------------------ |
| Critical | X              | X                        |
| High     | X              | X                        |
| Medium   | X              | X                        |
| Low      | X              | X                        |
| Info     | X              | X                        |

**Artifact scanned**: [filename]
**Veracode scan log**: veracode-scan.log

## Combined Finding Summary (Veracode + Manual)

| Severity | Count |
| -------- | ----- |
| Critical | X     |
| High     | X     |
| Medium   | X     |
| Low      | X     |
| Info     | X     |

## Critical & High Priority Findings

[All Critical and High findings listed here for immediate visibility]

## All Findings

[Every finding in FINDING-XXX format — source tagged as Veracode or Manual]

## Positive Security Findings

[What security measures were correctly implemented]

## Prioritized Remediation Recommendations

[Ordered action list — Critical first, then High, Medium, Low]

## OWASP Top 10 Checklist Results

| OWASP Item                | Result            | Notes |
| ------------------------- | ----------------- | ----- |
| A01 Broken Access Control | Pass / Fail / N-A |       |

...

## Remediation Tracking

| Finding ID  | Source   | Severity | Status | Owner |
| ----------- | -------- | -------- | ------ | ----- |
| FINDING-001 | Veracode | High     | Open   | —     |
```

In chat: Veracode scan summary + manual review summary + top 3 Critical/High findings + confirm `security-review.md` created/updated.

---

## Completion Criteria

Before handoff, ensure:

- Veracode credentials verified and scan completed (or clearly blocked with reason; greenfield: npm/pip audit completed)
- Veracode findings parsed and tagged with in-scope vs context status
- Attack surface mapped (Phase 1)
- OWASP Top 10 checklist completed (Phase 2)
- Additional checks completed (Phase 3)
- All findings (Veracode + manual) in FINDING-XXX format with source, severity, evidence, remediation
- `security-review.md` produced with Veracode scan results section + combined findings
- Critical and High findings highlighted prominently
- Cleanup: remove `veracode-scan-artifact.zip` and `pipeline-scan.jar` after scan if user prefers

**HANDOFF**: If no Critical or High findings remain → hand off to **deploy** (project-specific pipelines may use **GCP Deployment** or similar). If Critical or High findings exist → return to **code** (or **plan** for architectural-level changes) with the findings list for remediation, then re-run this mode after fixes are committed.
