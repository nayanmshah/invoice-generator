# SonarQube & Linting Validation

Detailed steps for running SonarQube (SonarScanner CLI) and language-specific linting. See `1_workflow.md` for the high-level workflow. See `code_quality_security_gates` rule for pipeline order and HITL gates.

## SonarScanner CLI vs SonarCloud

This mode uses the **SonarScanner CLI** (`sonar-scanner`) as the execution engine.

- **Self-hosted SonarQube**: set `SONAR_HOST_URL` to your server (e.g. `http://sonarqube.company.com:9000`)
- **SonarCloud**: set `SONAR_HOST_URL=https://sonarcloud.io` and add `SONAR_ORGANIZATION`
- Same CLI, same command — only the target URL and optional organization differ.

The `sonar.newCode.referenceBranch=develop` property restricts findings to **new code only** (changes since the reference branch).

## Phase 0: Prerequisites Check

### Step 1: Detect Project Type

```bash
ls package.json pom.xml build.gradle angular.json pyproject.toml 2>/dev/null
cat package.json 2>/dev/null | grep -E '"name"|"scripts"' | head -5
```

### Step 2: Determine SonarQube Setup

**MANDATORY**: Ask the user which setup before proceeding:

> **A) Global / Remote** — Token and project already exist on a hosted instance.
> Provide: `SONAR_TOKEN`, `SONAR_PROJECT_KEY`, `SONAR_HOST_URL` (+ `SONAR_ORGANIZATION` for SonarCloud)
>
> **B) Local SonarQube** — Running locally (e.g. Docker). Provide either:
>
> - A **token** you already have, OR
> - **Username + Password** (token will be auto-generated)

#### Option A: Global / Remote

```bash
[ -n "$SONAR_TOKEN" ]       && echo "SONAR_TOKEN        : set" || echo "SONAR_TOKEN        : NOT SET ← required"
[ -n "$SONAR_HOST_URL" ]    && echo "SONAR_HOST_URL     : set" || echo "SONAR_HOST_URL     : NOT SET ← required"
[ -n "$SONAR_PROJECT_KEY" ] && echo "SONAR_PROJECT_KEY  : set" || echo "SONAR_PROJECT_KEY  : NOT SET ← required"
[ -n "$SONAR_ORGANIZATION" ] && echo "SONAR_ORGANIZATION : set" || echo "SONAR_ORGANIZATION : NOT SET (SonarCloud only)"
```

If any required value is missing, ask the user to provide it.

#### Option B: Local SonarQube

Ask user for **Host URL** (default `http://localhost:9000`) and then **which credential type**:

- **Token** — if they already have one, skip straight to verify below
- **Username + Password** — auto-generate a token via API

Run each step below **as a separate command**. If any step fails, STOP and report the error.

**B1 — If user provided username/password, generate a token:**

```bash
export SONAR_HOST_URL="<host>"
SONAR_USER="<username>"
SONAR_PASS="<password>"
curl -s -u "$SONAR_USER:$SONAR_PASS" "$SONAR_HOST_URL/api/system/status"
```

Response must contain `"status":"UP"`. If not, STOP — credentials wrong or SonarQube not running.

```bash
curl -s -u "$SONAR_USER:$SONAR_PASS" -X POST "$SONAR_HOST_URL/api/user_tokens/revoke?name=nayan-scanner" || true
TOKEN_RESPONSE=$(curl -s -u "$SONAR_USER:$SONAR_PASS" -X POST "$SONAR_HOST_URL/api/user_tokens/generate?name=nayan-scanner")
export SONAR_TOKEN=$(echo "$TOKEN_RESPONSE" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
[ -n "$SONAR_TOKEN" ] && echo "SONAR_TOKEN: set" || echo "ERROR: Token generation failed"
```

If `SONAR_TOKEN` is empty, STOP — report that token generation failed (do not echo or show `TOKEN_RESPONSE`; it may contain the token). Suggest user check SONAR_USER/SONAR_PASS and API access. Per secrets-chat rule: never echo, log, or paste sensitive values.

**B2 — If user provided a token directly, verify it:**

```bash
export SONAR_HOST_URL="<host>"
export SONAR_TOKEN="<token>"
curl -s -u "$SONAR_TOKEN:" "$SONAR_HOST_URL/api/system/status"
```

Response must contain `"status":"UP"`. If not, token is invalid.

**B3 — Derive project key and detect edition:**

```bash
export SONAR_PROJECT_KEY=$(node -p "require('./package.json').name" 2>/dev/null || basename "$(pwd)")
[ -n "$SONAR_PROJECT_KEY" ] && echo "SONAR_PROJECT_KEY: set" || echo "SONAR_PROJECT_KEY: NOT SET"
curl -s -u "$SONAR_TOKEN:" "$SONAR_HOST_URL/api/navigation/global" | grep -o '"edition":"[^"]*"'
```

**Community Edition:** `sonar.branch.name` not supported — omit branch params. Most local installs are Community.

### Step 3: Verify sonar-scanner is installed

```bash
sonar-scanner --version 2>/dev/null || echo "sonar-scanner NOT FOUND"
```

If missing: macOS `brew install sonar-scanner`; or download from https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/sonarscanner/; or for JS/TS: `npm install -D sonarqube-scanner` then `npx sonar-scanner`

### Step 4: Identify Changed Files

```bash
CHANGED_FILES=$(git diff --name-only origin/develop...HEAD 2>/dev/null \
  || git diff --name-only origin/main...HEAD 2>/dev/null \
  || git diff --name-only HEAD~1)
echo "Branch  : $(git rev-parse --abbrev-ref HEAD)"
echo "Commit  : $(git log -1 --oneline)"
echo "Changed files:"
echo "$CHANGED_FILES"
```

### Mandatory Input Validation

Before starting:

1. Ask the user: "Scan **new code only** (since develop branch) or the **full project**?" — default is new code only
2. Detect project type: read `package.json`, `pom.xml`, `build.gradle`, `angular.json`
3. Read `development-plan.md` if present — to understand what work packages were just implemented
4. Read `code-review.md` if present — to track history and avoid duplicating prior findings

## Phase 1: SonarQube Scan

### Step 1: Generate sonar-project.properties (if missing)

Check if `sonar-project.properties` exists. If missing, create it from the appropriate template and ask for user confirmation before proceeding.

**Template — TypeScript / JavaScript / Angular:**

```properties
# sonar-project.properties
sonar.projectKey=REPLACE_WITH_PROJECT_KEY
sonar.projectName=REPLACE_WITH_PROJECT_NAME
sonar.sources=src
sonar.exclusions=**/node_modules/**,**/__tests__/**,**/*.spec.ts,**/*.test.ts,**/dist/**,**/coverage/**
sonar.tests=src
sonar.test.inclusions=**/*.spec.ts,**/*.test.ts,**/__tests__/**
sonar.javascript.lcov.reportPaths=coverage/lcov.info
sonar.typescript.tsconfigPath=tsconfig.json
sonar.newCode.referenceBranch=develop
```

**Template — Java / Spring Boot:**

```properties
# sonar-project.properties
sonar.projectKey=REPLACE_WITH_PROJECT_KEY
sonar.projectName=REPLACE_WITH_PROJECT_NAME
sonar.sources=src/main/java
sonar.tests=src/test/java
sonar.java.binaries=target/classes
sonar.java.test.binaries=target/test-classes
sonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
sonar.newCode.referenceBranch=develop
```

### Step 2: Build (if required by project type)

**Java / Spring Boot** — must compile before scanning:

```bash
mvn package -DskipTests -q 2>&1 | tail -5 || ./gradlew build -x test -q 2>&1 | tail -5
```

**TypeScript / Angular** — build if sonar needs compiled output:

```bash
pnpm build 2>/dev/null || npm run build 2>/dev/null
```

### Step 3: Run SonarScanner

Use the command matching the setup chosen in Phase 0, Step 2.

> **Branch analysis note:** `sonar.branch.name` is only supported on **Developer Edition and above**. If using **Community Edition** (common for local installs), **omit** the `-Dsonar.branch.name` parameter entirely — the scan will analyze the default main branch. Community Edition logs will show an error like `"Branch feature is not supported"` if this parameter is included.

**Option A — Self-hosted SonarQube (Developer Edition+, token auth):**

```bash
sonar-scanner \
  -Dsonar.token="$SONAR_TOKEN" \
  -Dsonar.host.url="$SONAR_HOST_URL" \
  -Dsonar.projectKey="$SONAR_PROJECT_KEY" \
  -Dsonar.newCode.referenceBranch=develop \
  -Dsonar.branch.name="$(git rev-parse --abbrev-ref HEAD)" \
  2>&1 | tee sonar-scan.log
echo "Sonar exit code: $?"
```

**Option A — SonarCloud (token auth):**

```bash
sonar-scanner \
  -Dsonar.token="$SONAR_TOKEN" \
  -Dsonar.host.url="https://sonarcloud.io" \
  -Dsonar.projectKey="$SONAR_PROJECT_KEY" \
  -Dsonar.organization="$SONAR_ORGANIZATION" \
  -Dsonar.newCode.referenceBranch=develop \
  -Dsonar.branch.name="$(git rev-parse --abbrev-ref HEAD)" \
  2>&1 | tee sonar-scan.log
echo "Sonar exit code: $?"
```

**Option B — Local SonarQube (token auth, typically Community Edition):**

```bash
sonar-scanner \
  -Dsonar.token="$SONAR_TOKEN" \
  -Dsonar.host.url="$SONAR_HOST_URL" \
  -Dsonar.projectKey="$SONAR_PROJECT_KEY" \
  2>&1 | tee sonar-scan.log
echo "Sonar exit code: $?"
```

**Secrets:** Do not paste `sonar-scan.log` to chat (it may contain auth or token references). Report only exit code and quality gate PASS/FAIL. Per secrets-chat rule.

Note: `sonar.branch.name` and `sonar.newCode.referenceBranch` are omitted for Community Edition. If the user confirms they have Developer Edition or above locally, use the Option A self-hosted command instead.

### Step 4: Retrieve Results via SonarQube API

Both Option A and Option B use token-based auth: `-u "$SONAR_TOKEN:"`

> **Community Edition note:** Omit the `&branch=` query parameter from API calls — Community Edition only has a single main branch and the parameter will cause errors.

**Developer Edition+ / SonarCloud (branch-aware):**

```bash
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Quality Gate status
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/qualitygates/project_status?projectKey=$SONAR_PROJECT_KEY&branch=$BRANCH" \
  -o sonar-quality-gate.json

# New code issues
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/issues/search?componentKeys=$SONAR_PROJECT_KEY&sinceLeakPeriod=true&resolved=false&ps=100&s=SEVERITY&asc=false" \
  -o sonar-issues.json

# New code metrics
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/measures/component?component=$SONAR_PROJECT_KEY&branch=$BRANCH&metricKeys=new_bugs,new_vulnerabilities,new_code_smells,new_coverage,new_duplicated_lines_density,new_maintainability_rating,new_reliability_rating,new_security_rating" \
  -o sonar-measures.json
```

**Community Edition (no branch param):**

```bash
# Quality Gate status
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/qualitygates/project_status?projectKey=$SONAR_PROJECT_KEY" \
  -o sonar-quality-gate.json

# All open issues
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/issues/search?componentKeys=$SONAR_PROJECT_KEY&resolved=false&ps=100&s=SEVERITY&asc=false" \
  -o sonar-issues.json

# Project metrics
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/measures/component?component=$SONAR_PROJECT_KEY&metricKeys=bugs,vulnerabilities,code_smells,coverage,duplicated_lines_density,sqale_rating,reliability_rating,security_rating" \
  -o sonar-measures.json
```

Parse the JSON and produce a Quality Gate summary in chat. **Fallback when SonarQube not configured:** Run lint + tests + coverage (per sprint workflow) and produce code-review.md. Document tool used in PR. Do not skip the quality gate phase.

## Phase 2: Language-Specific Linting

### TypeScript / JavaScript — ESLint

```bash
ls .eslintrc* eslint.config.* .eslintrc.js .eslintrc.json 2>/dev/null || echo "No ESLint config found"

CHANGED_TS=$(echo "$CHANGED_FILES" | grep -E '\.(ts|tsx|js|jsx)$' | tr '\n' ' ')
if [ -n "$CHANGED_TS" ]; then
  npx eslint $CHANGED_TS --format json --output-file eslint-results.json 2>/dev/null || true
  npx eslint $CHANGED_TS --format stylish 2>&1 | tee eslint-summary.txt
fi
```

### Java — Checkstyle + SpotBugs (via Maven)

```bash
mvn checkstyle:check -q 2>&1 | tee checkstyle-output.txt
mvn spotbugs:check -q 2>&1 | tee spotbugs-output.txt
```

### Angular — ESLint via Angular CLI

```bash
ng lint 2>&1 | tee ng-lint-results.txt
```

## Phase 3: Code Metrics Summary

Produce a metrics table covering changed files. See full template in rules-code-quality-gate (archived).

## Phase 4: Architectural Standards Validation

Validate new code against the conventions in `architecture.md` (produced by architect mode). If architecture.md does NOT exist, skip and note "architecture.md not found" in code-review.md.

## Output: code-review.md

**MANDATORY**: Produce/update `code-review.md` in the workspace root. Include **Create** block at top:

```markdown
### Create

| Nayan | User Name | Create Date |
| :----- | :-------- | :---------- |
|        |           |             |
```

See full template in rules-code-quality-gate (archived).

**HANDOFF**: If **PASS** → proceed to Phase 5 (code review second pass); then hand off to **secure**. If **FAIL** → return to **code** with full issues list; re-run after fixes committed.
