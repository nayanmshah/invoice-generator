---
description: "Analyze codebase and create concise AGENTS.md files for AI assistants"
argument-hint: ""
---

<task>
Please analyze this codebase and create an AGENTS.md file containing:
1. Build/lint/test commands - especially for running a single test
2. Code style guidelines including imports, formatting, types, naming conventions, error handling, etc.
</task>

<initialization>
  <purpose>
    Create (or update) a concise AGENTS.md file that enables immediate productivity for AI assistants.
    Focus ONLY on project-specific, non-obvious information that you had to discover by reading files.
    
    CRITICAL: Only include information that is:
    - Non-obvious (couldn't be guessed from standard practices)
    - Project-specific (not generic to the framework/language)
    - Discovered by reading files (config files, code patterns, custom utilities)
    - Essential for avoiding mistakes or following project conventions
    
    Usage notes:
    - The file you create will be given to agentic coding agents (such as yourself) that operate in this repository
    - Keep the main AGENTS.md concise - aim for about 20 lines, but use more if the project complexity requires it
    - If there's already an AGENTS.md, improve it
    - If there are Claude Code rules (in CLAUDE.md), Cursor rules (in .cursor/rules/ or .cursorrules), or Copilot rules (in .github/copilot-instructions.md), make sure to include them
    - Be sure to prefix the file with: "# AGENTS.md\n\nThis file provides guidance to agents when working with code in this repository."
  </purpose>
  
  <todo_list_creation>
    If the update_todo_list tool is available, create a todo list with these focused analysis steps:
    
    0. **Detect repo layout (BEFORE Discovery):** Check for `.git` at workspace root. If absent, discover child repos: list immediate child dirs; for each `D`, check `D/.git`. If any exist → multi-repo. Child names are project-specific (e.g., web-app, api, client, server, frontend, backend). Use this to determine single vs multi-repo analysis.
    1. Check for existing AGENTS.md files
       CRITICAL - Check these EXACT paths IN THE PROJECT ROOT:
       - AGENTS.md (in project root directory)
       - .nayan/rules-code/AGENTS.md (relative to project root; create .nayan in project root, not system root!)
       - .nayan/rules-debug/AGENTS.md (relative to project root)
       - .nayan/rules-ask/AGENTS.md (relative to project root)
       - .nayan/rules-architect/AGENTS.md (relative to project root)
       - .nayan/rules-plan/AGENTS.md (relative to project root)
       - .nayan/rules-brainstorm/AGENTS.md (relative to project root)
       - .nayan/rules-prd/AGENTS.md (relative to project root)
       - .nayan/rules-prototype/AGENTS.md (relative to project root)
       - .nayan/rules-qa/AGENTS.md (relative to project root)
       - .nayan/rules-secure/AGENTS.md (relative to project root)
       - .nayan/rules-deploy/AGENTS.md (relative to project root)
       
       IMPORTANT: All paths are relative to the project/workspace root, NOT system root!
       
       If ANY of these exist:
       - Read them thoroughly
       - CRITICALLY EVALUATE: Remove ALL obvious information
       - DELETE entries that are standard practice or framework defaults
       - REMOVE anything that could be guessed without reading files
       - Only KEEP truly non-obvious, project-specific discoveries
       - Then add any new non-obvious patterns you discover
       
       Also check for other AI assistant rules:
       - .cursorrules, CLAUDE.md, .roorules
       - .cursor/rules/, .github/copilot-instructions.md
    
    2. Identify stack
       - Language, framework, build tools
       - Package manager and dependencies
    
    3. Extract commands
       - Build, test, lint, run
       - Critical directory-specific commands
    
    4. Map core architecture and module identification
       - Architecture style: monolith, modular monolith, microservices, or hybrid (detect from structure: separate services, packages, or deployable units)
       - Module/service identification: how many modules or microservices; which directories or packages correspond to which; what purpose each serves (e.g. UI, API gateway, auth service, order service, database layer)
       - Interconnection: how modules connect from UI through to database (request flow, API boundaries, which service talks to which, data flow)
       - Module and repo interdependencies: which modules or repos depend on which (from imports, package.json, workspace refs, config)
       - Main components, boundaries, and flow; key entry points
       - Folder structure conventions (where features vs shared code live)
    
    5. Document critical patterns and best practices
       - Design patterns used in code (which, where, for what)
       - Project-specific utilities and non-standard approaches (from reading code)
       - Naming conventions (files, functions, types, exports) not enforced by linters
       - Custom conventions that aren't obvious from file structure
    
    6. Extract code style
       - From config files only
       - Key conventions
    
    7. Testing specifics
       - Framework and run commands
       - Directory requirements
    
    8. Compile/Update AGENTS.md files
       - For mode-specific files: Base content on deep code analysis — module identification (what each module/service does, how many), architecture understanding (e.g. microservices: count and purpose; interconnection from UI to database), module and repo interdependencies (which depend on which), layers, boundaries, key modules, design patterns (where and for what), folder structure, naming conventions, and best practices as implemented in code. Do not invent; discover by reading code and config.
       - If files exist: AGGRESSIVELY clean them up
         * DELETE all obvious information (even if it was there before)
         * REMOVE standard practices, framework defaults, common patterns
         * STRIP OUT anything derivable from file structure or names
         * ONLY KEEP truly non-obvious discoveries
         * Then add newly discovered non-obvious patterns
         * Result should be SHORTER and MORE FOCUSED than before
       - If creating new: Follow the non-obvious-only principle
       - Create mode-specific files in .nayan/rules-*/ directories (IN PROJECT ROOT)

    9. **Self-review against code/workspace (deep scan in loop):** Run at least 2 passes. In each pass: deep-scan the codebase (key configs, structure, entry points, module/repo dependencies) and compare against what is documented in each AGENTS.md. Check accuracy (paths, commands, conventions) and completeness (per-mode checklist). Correct any gaps, inaccuracies, or remaining obvious content. Repeat until the captured information is accurate and meets the required context for each mode.

    Note: If update_todo_list is not available, proceed with the analysis workflow directly without creating a todo list.

</todo_list_creation>
</initialization>

<analysis_workflow>
Follow the comprehensive analysis workflow to:

1. **Discovery Phase**:
   CRITICAL - First check for existing AGENTS.md files at these EXACT locations IN PROJECT ROOT:

    - AGENTS.md (in project/workspace root)
    - .nayan/rules-code/AGENTS.md (relative to project root)
    - .nayan/rules-debug/AGENTS.md (relative to project root)
    - .nayan/rules-ask/AGENTS.md (relative to project root)
    - .nayan/rules-architect/AGENTS.md (relative to project root)
    - .nayan/rules-plan/AGENTS.md (relative to project root)
    - .nayan/rules-brainstorm/AGENTS.md (relative to project root)
    - .nayan/rules-prd/AGENTS.md (relative to project root)
    - .nayan/rules-prototype/AGENTS.md (relative to project root)
    - .nayan/rules-qa/AGENTS.md (relative to project root)
    - .nayan/rules-secure/AGENTS.md (relative to project root)
    - .nayan/rules-deploy/AGENTS.md (relative to project root)

    IMPORTANT: The .nayan folder should be created in the PROJECT ROOT, not system root!

    If found, perform CRITICAL analysis:

    - What information is OBVIOUS and must be DELETED?
    - What violates the non-obvious-only principle?
    - What would an experienced developer already know?
    - DELETE first, then consider what to add
    - The file should get SHORTER, not longer

    Also find other AI assistant rules and documentation

2. **Project Identification**: Identify language, stack, and build system. **Multi-repo:** Identify stack **per repo** — each child dir (e.g., Next.js in web-app/, FastAPI in api/).
3. **Command Extraction**: Extract and verify essential commands. **Multi-repo:** Extract commands **per repo**: for each child repo `D`, `cd D && <build/test/lint>`. Document all in AGENTS.md.
4. **Architecture Mapping & Module Identification**: Identify architecture style (monolith, microservices, hybrid). List modules or services: how many, which dirs/packages are which, what purpose each serves (e.g. UI, API, auth service, DB layer). Document interconnection: how request/data flows from UI through APIs or services to database. Document module and repo interdependencies: which modules or repos depend on which (from imports, package.json, workspace refs). Create visual flow diagrams of core processes where helpful.
5. **Component Analysis**: Document key components and their interactions; which module owns what; boundaries between modules.
6. **Pattern Analysis**: Identify project-specific patterns and conventions
7. **Code Style Extraction**: Extract formatting and naming conventions
8. **Security & Performance**: Document critical patterns if relevant
9. **Testing Discovery**: Understand testing setup and practices
10. **Example Extraction**: Find real examples from the codebase
11. **Self-review (deep scan in loop):** Before finalizing, run a self-review at least twice. Each pass: deep-scan the code/workspace (configs, structure, dependencies, commands) and compare against every AGENTS.md (root and mode-specific). Verify accuracy (paths, commands, names) and completeness against the checklist for each mode. Fix gaps, errors, or obvious content. Repeat until the documented information accurately reflects the codebase and meets required context.
    </analysis_workflow>

<output_structure>
<main_file>
Create or deeply improve AGENTS.md with ONLY non-obvious information:

    **Multi-repo:** Root AGENTS.md must state: "Multi-repo workspace: [list repo dirs] are separate git repos. Run build/test/lint from each directory (cd <repo> && ...)." Include per-repo commands discovered.

    If AGENTS.md exists:
    - FIRST: Delete ALL obvious information
    - REMOVE: Standard commands, framework defaults, common patterns
    - STRIP: Anything that doesn't require file reading to know
    - EVALUATE: Each line - would an experienced dev be surprised?
    - If not surprised, DELETE IT
    - THEN: Add only truly non-obvious new discoveries
    - Goal: File should be SHORTER and MORE VALUABLE

    Content should include:
    - Header: "# AGENTS.md\n\nThis file provides guidance to agents when working with code in this repository."
    - Build/lint/test commands - ONLY if they differ from standard package.json scripts
    - Code style - ONLY project-specific rules not covered by linter configs
    - Custom utilities or patterns discovered by reading the code
    - Non-standard directory structures or file organizations
    - Project-specific conventions that violate typical practices
    - Critical gotchas that would cause errors if not followed

    EXCLUDE obvious information like:
    - Standard npm/yarn commands visible in package.json
    - Framework defaults (e.g., "React uses JSX")
    - Common patterns (e.g., "tests go in __tests__ folders")
    - Information derivable from file extensions or directory names

    Keep it concise (aim for ~20 lines, but expand as needed for complex projects).
    Include existing AI assistant rules from CLAUDE.md, Cursor rules (.cursor/rules/ or .cursorrules), or Copilot rules (.github/copilot-instructions.md).

</main_file>

<mode_specific_files>
Create or deeply improve mode-specific AGENTS.md files IN THE PROJECT ROOT.

    CRITICAL – Base on deep code analysis: Each mode-specific AGENTS.md must be derived from deep analysis of the actual codebase.

    **SRP — Codebase only:** Each mode's AGENTS.md must contain only **codebase-derived context** (per the checklist below): accurate, non-obvious information discovered from this repo. That context helps the mode generate correct documents and fulfill its job by enabling **right decisions** — so the mode can follow its **own** instructions, skills, and rules (in mode rules, skills, etc.). Init does **not** document those instructions, skills, or rules; it only instructs what codebase context to capture. Do **not** document pipeline mechanics (handoffs, input/output doc names, template paths); do not invent or assume — discover by reading code, config, and structure.

    Before writing or updating any mode file, analyze the repo for: **module identification** (how many modules or microservices; which dirs/packages are which; what purpose each serves); **architecture understanding** (architecture style — monolith, microservices, hybrid; how modules are interconnected from UI through APIs/services to database); **module and repo interdependencies** (which modules or repos depend on which, from code/config — imports, package.json, workspace refs); architecture (layers, boundaries, key modules, entry points), design patterns (which patterns are used, where, and for what), folder structure (conventions, where features vs shared code live), naming conventions (files, functions, types, exports), and best practices as implemented in code. Document only non-obvious findings that give that mode greater context when working in the repo.

    Current workspace context: For the current codebase, document what the mode needs **from this repo**. When the workspace has existing code, also document: existing structure, where to add or extend, conventions to match, and any existing artifact locations **in this repo** (e.g. where this project keeps architecture or plan docs, if present). Apply the same analysis whether the workspace is greenfield or existing — the repo in context defines what to document.

    **Multi-repo workspace (non-obvious only):** When the workspace is multi-repo, document what each repo serves, how they are interconnected, and module/repo interdependencies (which depend on which). Modes that need this upfront: Code, Debug, Ask, Architect, Brainstorm, Plan, QA, Secure, Deploy.

    What each Nayan mode must know in AGENTS.md (codebase-derived only — discover from repo): Document only **accurate, non-obvious** information from this codebase. This context lets the mode make right decisions and follow its own instructions, skills, and rules (without documenting those here). No pipeline steps or handoffs.
    - **Code:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies (which depend on which) (non-obvious only). Tech stack; module identification (what each module/service is and where it lives); architecture style and interconnection (UI → API → services → DB); folder structure and where to add/extend code; naming conventions; design patterns in use; required/forbidden patterns; how to build, run, test (commands + cwd); extension points; REPO_STRATEGY (single vs multi-repo) when applicable.
    - **Debug:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies so reproduce targets right repos (non-obvious only). How to run the app to reproduce; which module(s) to run for a given flow; where logs and errors surface; required env vars; debug config; gotchas that cause silent failures. Where configuration and application state live in code (for hypothesis and log placement).
    - **Ask:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies (non-obvious only). What each top-level folder contains; module map (what each module serves); architecture style and how modules connect (UI to DB); canonical docs/examples in repo; counterintuitive structure; system boundaries and integration points. Where types, interfaces, and API surface are defined; entry points for tracing behavior.
    - **Architect:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies (non-obvious only). Tech stack; build tool; how to run and test; module identification (how many modules/microservices, purpose of each, where they live); architecture style and interconnection (UI through to database); same code-context as Code (folder structure, naming, design patterns, best practices); boundaries; key modules; communication; constraints. When existing code: where this repo keeps architecture docs if present; existing folder structure as source for extensions; legacy and target system boundaries and integration points discoverable from codebase; data migration touchpoints. DB/schema script strategy from codebase: where scripts live; how they are managed, organized, and rolled out.
    - **Brainstorm:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies (non-obvious only). Domain terminology from code/docs; existing product/feature boundaries; legacy and integration touchpoints; where product context lives (Jira, Confluence, key docs if in repo or config). Existing capability or feature map from code/structure (so exploration is grounded).
    - **PRD:** Domain/entity naming and glossary alignment (from code and docs); which sections map to implementation (from codebase); sign-off/role meaning if in docs; where specs live (MCP or repo). MVP/scoping rules if discoverable from repo or docs. When existing code: existing data model/entities and API or use-case-like flows in code (for Section 8/7 alignment).
    - **Prototype:** Design system location (tokens, components, theme) in code; layout and breakpoints; a11y/i18n as implemented. Component patterns (reusable vs page-specific); styling approach (CSS modules, Tailwind, tokens); design library in use (Material, shadcn, etc.); custom components path; key screens/flows from code; where this repo keeps UX prototypes if present. Existing UI tech stack (framework, libs, versions from code); custom components, styles, and design to be followed (tokens, design system, patterns, conventions). When existing UI: existing UI location in repo and as source of truth; design discovery only for net-new UI.
    - **Plan:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies so sprint tasks respect dependency order (non-obvious only). Repo layout (single vs multi-repo); module map (what each module is); architecture style and interconnection (UI→DB); build/test/deploy commands and cwd; existing folder structure from codebase when adding features; folder structure conventions from codebase (e.g. feature-based vs layer-based) so plan Section 2.6 aligns. DB script location and how changes are applied (so plan can sequence or call out DB steps). When existing code: where this repo keeps plan/architecture docs if present.
    - **QA:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies so tests/gates run in right repos and order (non-obvious only). Test framework and file layout; which modules to test for which flows; how to run tests and coverage (commands + cwd); lint/sonar config and thresholds; project-specific review checklist (from AGENTS.md, architecture, or code patterns). Project type per repo (for SonarScanner); lint config path; test types (unit, e2e, integration) and where they live. When existing code: existing test layout; which flows need which repos.
    - **Secure:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies so scans run in right repos (non-obvious only). Scan tooling and config (audit, Veracode) in repo; where auth and secrets are handled in code; sensitive paths. Where build output/artifact is produced (for Veracode); entry points from codebase (API endpoints, user inputs, file uploads, webhooks, scheduled jobs) for OWASP. When existing code: existing auth/scan pattern in codebase.
    - **Deploy:** Multi-repo: what each repo serves and how interconnected; module and repo interdependencies so deploy order and pipelines respect dependency order (non-obvious only). Target platform and infra paths (in repo); CI/CD location and triggers; env and secret management; rollback or runbook patterns. Where deployment docs or runbooks live in repo if present; deployment target convention if in config. DB script deploy strategy and rollout: where scripts live; how and when they are applied (from code/CI/config). When existing code: current deploy pipeline and target in repo.

    CRITICAL: For each of these paths (RELATIVE TO PROJECT ROOT), check if the file exists FIRST:
    - .nayan/rules-code/AGENTS.md (create .nayan in project root, not system root!)
    - .nayan/rules-debug/AGENTS.md (relative to project root)
    - .nayan/rules-ask/AGENTS.md (relative to project root)
    - .nayan/rules-architect/AGENTS.md (relative to project root)
    - .nayan/rules-plan/AGENTS.md (relative to project root)
    - .nayan/rules-brainstorm/AGENTS.md (relative to project root)
    - .nayan/rules-prd/AGENTS.md (relative to project root)
    - .nayan/rules-prototype/AGENTS.md (relative to project root)
    - .nayan/rules-qa/AGENTS.md (relative to project root)
    - .nayan/rules-secure/AGENTS.md (relative to project root)
    - .nayan/rules-deploy/AGENTS.md (relative to project root)

    IMPORTANT: The .nayan directory must be created in the current project/workspace root directory,
    NOT at the system root (/) or home directory. All paths are relative to where the project is located.

    If files exist:
    - AGGRESSIVELY DELETE obvious information
    - Remove EVERYTHING that's standard practice
    - Strip out framework defaults and common patterns
    - Each remaining line must be surprising/non-obvious
    - Only then add new non-obvious discoveries
    - Files should become SHORTER, not longer

    Example structure (ALL IN PROJECT ROOT):
    ```
    project-root/
    ├── AGENTS.md                         # General project guidance
    ├── .nayan/                          # IN PROJECT ROOT, NOT SYSTEM ROOT!
    │   ├── rules-code/
    │   │   └── AGENTS.md
    │   ├── rules-debug/
    │   │   └── AGENTS.md
    │   ├── rules-ask/
    │   │   └── AGENTS.md
    │   ├── rules-architect/
    │   │   └── AGENTS.md
    │   ├── rules-plan/
    │   │   └── AGENTS.md
    │   ├── rules-brainstorm/
    │   │   └── AGENTS.md
    │   ├── rules-prd/
    │   │   └── AGENTS.md
    │   ├── rules-prototype/
    │   │   └── AGENTS.md
    │   ├── rules-qa/
    │   │   └── AGENTS.md
    │   ├── rules-secure/
    │   │   └── AGENTS.md
    │   └── rules-deploy/
    │       └── AGENTS.md
    ├── src/
    ├── package.json
    └── ... other project files
    ```

    .nayan/rules-code/AGENTS.md – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves and how they are interconnected. From deep code analysis: Document everything Code mode must know about this codebase so it does not assume. **Required:** Module identification (how many modules or microservices; which dirs/packages are which; what each serves — e.g. UI, auth service, order API, DB layer); architecture style (monolith, microservices, hybrid) and interconnection (request flow from UI through APIs/services to database); module and repo interdependencies (which depend on which, from code/config). Tech stack (language, framework, package manager); how to build, run, and test (exact commands and cwd — e.g. per-module or root); folder structure (where features vs shared code live, entry points); naming conventions; design patterns in use and where; required/forbidden patterns; hidden coupling; where to add or extend code without breaking existing patterns; extension points. **Multi-repo:** REPO_STRATEGY and per-repo build/test/lint. Document ONLY non-obvious, project-specific discoveries from the codebase—omit anything an experienced developer would assume.

    Example of non-obvious coding rules worth documenting:
    ```
    # Project Coding Rules (Non-Obvious Only)
    - Multi-repo workspace: [e.g. when multi-repo: list repo dirs; what each repo serves; how interconnected; which repos/modules depend on which — non-obvious only]
    - Architecture & modules: [e.g. microservices: 3 — web (UI), api (REST), worker (jobs); or monolith with src/, webview-ui/, packages/; interconnection: UI → api → db]
    - Interdependencies: [e.g. module A imports B; packages/types used by all; repo api depends on repo shared-lib]
    - Module map: [e.g. packages/auth = auth service; packages/orders = order API; webview-ui/ = UI; which module owns what]
    - Tech stack: [e.g. Node/TS, React, pnpm; versions if non-obvious]
    - Build/run/test: [e.g. pnpm build, pnpm dev, pnpm test; run from root or which dirs per module]
    - Folder structure: [e.g. src/ for extension, webview-ui/ for UI; packages/ for shared]
    - Naming: [e.g. *.spec.ts beside source; Provider suffix for X; no default exports in Y]
    - Design patterns: [e.g. provider pattern in path/to/providers; query builder in path/to/db]
    - Best practices in code: [e.g. use safeWriteJson for file writes; raw SQL not used — use query layer]
    - Hidden coupling: [e.g. package A depends on types in B; tests must run from directory D]
    - Extend/add: [e.g. where to add new features (dirs, entry points); how to extend existing modules without breaking callers]
    - REPO_STRATEGY: [e.g. single repo; or multi-repo with frontend/backend dirs and per-repo commands]
    ```

    .nayan/rules-debug/AGENTS.md – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves and how they are interconnected so reproduce steps target the right repos. From deep code analysis: Document non-obvious debugging context. Include which module(s) to run for a given flow (e.g. UI + API + DB) when the project has multiple services. Analyze: where logging and errors surface (output channels, log files, IPC), how to attach or inspect (dev tools, debug configs), environment or flags that change behavior, and gotchas that cause silent failures (e.g. unwrapped async, missing env vars). Where config and state are managed in code (for multi-source hypothesis and targeted logging). How to run and reproduce the app; where user-facing errors appear; existing error paths and logs so diagnosis stays within current behavior. Use real paths and config from the repo. Document ONLY non-obvious discoveries—omit standard debug practices.

    Example of non-obvious debug rules worth documenting:
    ```
    # Project Debug Rules (Non-Obvious Only)
    - Config/state: [e.g. config in path/to; state in store/ or context/]
    - Modules for reproduce: [e.g. run web + api for full flow; or single process; which services must be up]
    - Logging/runtime: [e.g. Extension Host vs Debug Console; webview dev tools via Command Palette]
    - Environment: [e.g. NODE_ENV requirements; required env vars for DB or APIs]
    - Gotchas: [e.g. IPC must be try/catch; migrations run from directory X not root]
    - Debug config: [e.g. launch.json patterns; where breakpoints are useful]
    - Reproduce: [e.g. how to run app to reproduce; where errors surface in existing flows]
    ```

    .nayan/rules-ask/AGENTS.md (Ask mode – Q&A, explanations, code analysis) – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves and how they are interconnected. From deep code analysis: Document context so Ask mode can answer accurately about the codebase. Include module identification (how many modules/microservices; what each serves; where they live), architecture understanding (how they connect from UI to database), and module/repo interdependencies (which depend on which) so answers describe the real system. Analyze: what each top-level folder actually contains (vs what names suggest), where authoritative docs or canonical examples live, counterintuitive structure (e.g. two i18n systems, separate UI vs extension roots), and naming/organization that affects search or explanation. Where types, interfaces, and API surface are defined; entry points (for tracing "how does X work"). Existing system behavior and boundaries (what’s in scope, integration points, legacy areas) so answers align with the current product.     Include MCP sources when configured. Document ONLY non-obvious context—omit what is evident from file structure or names.

    Example of non-obvious Ask-mode rules worth documenting:
    ```
    # Project Documentation Rules (Non-Obvious Only)
    - API/types: [e.g. API surface in path/to; types in packages/types/]
    - Entry points: [e.g. for tracing flows]
    - Module map: [e.g. N modules; packages/auth = auth; packages/api = REST API; webview-ui/ = UI; what each serves]
    - Interconnection: [e.g. UI → api (REST) → db; or UI ↔ extension (IPC) ↔ backend]
    - Interdependencies: [e.g. which modules/repos depend on which; package refs]
    - Folder semantics: [e.g. src/ = extension; webview-ui/ = UI; what "packages/X" contains]
    - Canonical references: [e.g. implementation in path/to/ is source of truth; docs at X are stale]
    - Counterintuitive: [e.g. two locale trees; scripts run from dir not root; runtime restrictions]
    - Naming/organization: [e.g. how to find providers, API surface, public vs internal]
    - Boundaries: [e.g. existing scope; integration points; legacy modules to reference]
    ```

    .nayan/rules-architect/AGENTS.md – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves and how they are interconnected. From deep code analysis: Document non-obvious architecture so Architect mode aligns with the repo. **Required:** Module identification (how many modules or microservices; which dirs/packages are which; what purpose each serves) and architecture understanding (architecture style — monolith, microservices, hybrid; interconnection from UI through APIs/services to database); module and repo interdependencies (which depend on which). Architect must also know the same code context as Code mode (folder structure, naming conventions, design patterns, best practices in code). Analyze: tech stack and build tool (from package.json, configs), how to run and how to test (scripts, cwd, env); architectural boundaries (extension vs webview vs packages), key modules and their responsibilities, communication patterns (IPC, events, APIs), constraints (statelessness, migration policy, layering), and hidden coupling or intentional circular deps. When the project has existing code: where this repo keeps architecture or scope docs if present; existing folder structure as source for extensions; align to existing and document scope of change, impacted integrations, and migration path when extending; legacy and target system boundaries and integration points from codebase; data migration touchpoints. DB and schema script strategy as implemented: location of scripts; how they are managed, organized, and rolled out (from code or config). Use real module names and paths. Document ONLY non-obvious architectural constraints and hidden coupling discovered from the codebase.

    Example of non-obvious architecture rules worth documenting:
    ```
    # Project Architecture Rules (Non-Obvious Only)
    - Architecture style: [e.g. microservices (3): web, api, worker; or modular monolith with src/, webview-ui/, packages/]
    - Module map: [e.g. each module/service: path, purpose, owned domain; how many and what each serves]
    - Interconnection: [e.g. UI → API gateway → service A/B → DB; or UI ↔ extension (IPC) ↔ backend; request flow from UI to database]
    - Interdependencies: [e.g. which modules/repos depend on which; package refs; build order]
    - Tech stack: [e.g. Node/TS; React; package manager; framework versions]
    - Build tool: [e.g. tsup, vite, webpack; config location]
    - How to run: [e.g. pnpm dev, npm start; from which dirs; required env]
    - How to test: [e.g. vitest/jest; pnpm test; run from root or per-package]
    - Code-mode context (align architecture with): [folder structure; naming conventions; design patterns in use; best practices as implemented]
    - Boundaries: [e.g. extension (src/) vs webview (webview-ui/); packages as shared]
    - Key modules: [e.g. providers, core/, services/ and what they own]
    - Communication: [e.g. IPC channels; event flow; API boundaries]
    - Constraints: [e.g. providers stateless; migrations forward-only; types package usage]
    - Coupling: [e.g. intentional circular deps; modules that must not depend on X]
    - DB scripts: [e.g. path to migrations/; tool (e.g. Flyway, Liquibase, custom); ordering/naming; how applied in deploy]
    - When existing code: [e.g. where this repo keeps architecture/scope docs if present; existing folder structure as source for extensions; pre/post and impacted-integrations from codebase; legacy and target boundaries and integration points from code; data migration touchpoints]
    ```

    .nayan/rules-brainstorm/AGENTS.md – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves and how they are interconnected. From deep code analysis: Document context that shapes idea exploration. Include high-level module/product map (what the system is made of — e.g. UI app, API, services — so exploration is grounded in real structure). Analyze: domain terminology and boundaries (from code and docs), existing product/feature boundaries, integration points and legacy systems (from architecture or code), and where product context lives (MCP: Jira, Confluence, Google Drive when configured). When the project has existing code: document existing product and feature boundaries so exploration extends rather than replaces; JIRA/SOW entry flow (fetch and present first, then explore); legacy systems and constraints that affect options. Document real names and paths. Document ONLY non-obvious constraints and product-context sources.

    Example of non-obvious brainstorm rules worth documenting:
    ```
    # Project Brainstorm Rules (Non-Obvious Only)
    - System shape: [e.g. 3 microservices (web, api, worker) or monolith with UI + backend; how they connect]
    - Domain/terminology: [e.g. terms used in code and docs; platform vs experiences]
    - Product boundaries: [e.g. features/modules from structure; integration touchpoints]
    - Legacy/integrations: [e.g. systems referenced in code or architecture; constraints]
    - Product context sources: [e.g. Jira project keys, Confluence spaces, key docs]
    - Capability map: [e.g. features/modules from code structure; what the system does today]
    - When existing code: [e.g. scope of existing product; JIRA/SOW entry when scoping changes; legacy touchpoints]
    ```

    .nayan/rules-prd/AGENTS.md – From deep code analysis: Document PRD/scope context **from this codebase**. Analyze: how domain and entities are named in code (glossary alignment); which sections map to implementation (e.g. UI/UX, integrations, non-functional) from code and docs; sign-off and role conventions if present in docs; where product specs live (MCP or repo). When existing code: existing entities and data model in code; existing API or user flows (so PRD Section 8 and Section 7 align with existing implementation). Include MVP/scoping rules if discoverable from docs or structure. Document ONLY non-obvious PRD/scope and MVP context discovered in the repo.

    Example of non-obvious PRD rules worth documenting:
    ```
    # Project PRD Rules (Non-Obvious Only)
    - Domain/entities: [e.g. entity names in code; glossary location; section mapping]
    - UI/UX linkage: [e.g. design tokens path; component library from codebase]
    - Sign-off/roles: [e.g. approver meaning; where roles are defined in docs]
    - Spec sources: [e.g. Jira, Confluence, key doc paths in repo or config]; MVP rules if any
    - When existing code: [e.g. domain and scope conventions from existing docs/code; entities/APIs in code for Section 8/7 alignment]
    ```

    .nayan/rules-prd/AGENTS.md (PRD mode, MVP scoping) – From analysis: dependencies, sequencing, exclusions or deferrals as found in code or docs.

    .nayan/rules-prototype/AGENTS.md – From deep code analysis: Document UX/design context **from this codebase**. Analyze: design system location (tokens, theme, component library) in code; layout and breakpoints (CSS, config, or docs); interaction patterns used in code; accessibility/i18n as implemented (e.g. aria, i18n paths). When the workspace has existing UI: document existing UI tech stack (framework, libs, versions from code or package.json); custom components, styles, and design to be followed (tokens, design system, patterns, conventions so new or changed UI aligns); existing UI location in repo; component patterns (reusable vs page-specific); styling approach (CSS modules, Tailwind, tokens, theme); design library in use (Material, shadcn, etc.); custom components path; key screens and flows from code; where this repo keeps UX prototypes if present; match existing look-and-feel pixel by pixel; run design discovery only for net-new UI with no existing pattern. Use real paths and values. Document ONLY non-obvious UX/design and design-system context discovered in the repo.

    Example of non-obvious prototype rules worth documenting:
    ```
    # Project Prototype Rules (Non-Obvious Only)
    - UI tech stack: [e.g. React 18, Vite; UI libs and versions from package.json]
    - Design to follow: [e.g. tokens path; design system; patterns or conventions from code that must be followed]
    - Design system: [e.g. tokens path; component library; theme/breakpoints in code]
    - Layout/patterns: [e.g. layout components; responsive approach; interaction patterns]
    - Component patterns: [e.g. reusable vs page-specific; layout patterns]
    - Styling: [e.g. CSS modules, Tailwind, tokens path]
    - Design library: [e.g. Material, shadcn, custom]
    - Custom components: [e.g. path to shared buttons, cards, modals]
    - Key screens/flows: [e.g. from code]
    - Prototype location: [e.g. ux/prototypes/ or repo-specific]
    - A11y/i18n: [e.g. locale paths; a11y patterns or requirements in code]
    - When existing UI: [e.g. existing UI code location in repo; match existing pixel-by-pixel for changes; design discovery only for net-new UI]
    ```

    .nayan/rules-plan/AGENTS.md (plan mode) – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves and how they are interconnected so sprint tasks target the right repos. From deep code analysis: Document dev-plan context **from this codebase**. **Required:** Module identification (how many modules/microservices; what each serves; where they live) and interconnection (UI→DB); module and repo interdependencies (which depend on which, so task order respects dependencies); repo layout (single vs multi-repo from .git and structure); build/test/deploy commands and where they run; environment or integration requirements (env vars, ports, DB); existing folder structure conventions (e.g. feature vs layer) so dev plan Section 2.6 aligns to existing. Where DB/schema scripts live and how they are applied (from codebase), so dev plan can align with existing strategy. When the project has existing code: where this repo keeps architecture or plan docs if present; existing folder structure from codebase (mandatory when adding features); build/test/deploy as they exist in repo. Use real paths and scripts. Document ONLY non-obvious dev-plan and sprint context discovered in the codebase.

    Example of non-obvious plan rules worth documenting:
    ```
    # Project Plan Rules (Non-Obvious Only)
    - Folder conventions: [e.g. feature-based vs layer-based; from codebase]
    - Interdependencies: [e.g. which modules/repos depend on which; build/task order implications]
    - DB scripts: [e.g. migrations/; how run (script, tool, CI step); ordering]
    - Multi-repo workspace: [e.g. when multi-repo: what each repo serves; how interconnected so sprint tasks target right repos — non-obvious only]
    - Architecture & modules: [e.g. microservices: web, api, worker; or monolith with src/, webview-ui/, packages/; interconnection UI → API → DB]
    - Module map: [e.g. which dir = which service so sprint tasks target correct module]
    - Repo layout: [e.g. single vs multi-repo; clone/git conventions; root vs package dirs]
    - Build/test/deploy: [e.g. scripts per package; where to run; required env]
    - When existing code: [e.g. where this repo keeps plan/architecture docs if present; existing folder structure from codebase]
    ```

    .nayan/rules-qa/AGENTS.md – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves and how they are interconnected so tests and quality gates run in the right repos. From deep code analysis: Document QA context **from this codebase**. Analyze: test framework and layout (vitest/jest, __tests__ location), how to run tests and coverage (scripts, cwd), lint/sonar config and thresholds, and project-specific review checklist (from AGENTS.md, architecture, or code patterns); project type detection per repo (package.json, pom.xml, etc.); lint config path; test types (unit, e2e, integration) and their locations. When the project has existing code: existing test layout so new tests follow same pattern; which modules/flows need testing in which repos. Use real paths and commands. Document ONLY non-obvious QA and quality-gate context discovered in the repo.

    Example of non-obvious QA rules worth documenting:
    ```
    # Project QA Rules (Non-Obvious Only)
    - Project type: [e.g. per repo for SonarScanner]
    - Test layout: [e.g. *.spec.ts beside source; e2e location; fixture paths]
    - Lint config: [e.g. eslint.config path; Checkstyle path]
    - Test types: [e.g. unit in __tests__; e2e in e2e/]
    - Commands: [e.g. test/coverage/lint commands; run from which dirs]
    - Quality gate: [e.g. sonar config path in repo; thresholds; exclusions]
    - Review checklist: [e.g. conventions from root AGENTS.md; no raw SQL; stateless providers]
    - When existing code: [e.g. existing tests to extend; which repos to run tests for which flows]
    ```

    .nayan/rules-secure/AGENTS.md – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves and how they are interconnected so security scans run in the right repos. From deep code analysis: Document security context **from this codebase**. Analyze: scan tooling and config (Veracode, npm/pnpm audit, config files) in repo; where auth and secrets are handled in code; sensitive paths (auth, validation, env); where build artifact is produced (for Veracode); entry points in code (API endpoints, user inputs, uploads, webhooks, jobs) for OWASP review. When the project has existing code: existing scan and auth patterns in codebase. Use real paths and env var names. Document ONLY non-obvious security and scan context discovered in the repo.

    Example of non-obvious secure rules worth documenting:
    ```
    # Project Secure Rules (Non-Obvious Only)
    - Build artifact: [e.g. dist/, target/, build/ per repo]
    - Entry points: [e.g. API routes; user input surfaces; upload handlers; webhooks; jobs]
    - Scans: [e.g. audit command; Veracode env vars and run dir; config file paths in repo]
    - Auth/secrets: [e.g. where secrets are read in code; .env usage; never-commit rules]
    - Focus areas: [e.g. auth module path; input validation locations; from code structure]
    - When existing code: [e.g. existing auth pattern in codebase; scan run as in current pipeline]
    ```

    .nayan/rules-deploy/AGENTS.md – **Multi-repo (non-obvious only):** When the workspace is multi-repo, document what each repo serves, how they are interconnected, and module/repo interdependencies so deploy order and pipelines respect dependency order. From deep code analysis: Document deployment context **from this codebase**. Analyze: target platform and infra (Terraform, Docker, K8s paths) in repo; CI/CD location and triggers; env and secret management (where configured); rollback or runbook patterns; where deployment docs or runbooks live in repo if present; deployment target convention if in config; module and repo interdependencies (which depend on which). DB script deploy strategy from codebase: where scripts live; how and when they are applied; rollout order or gates (from config or pipelines). When the project has existing code: current deploy pipeline and target in repo. Use real paths and workflow names. Document ONLY non-obvious deployment and CI/CD context discovered in the repo.

    Example of non-obvious deploy rules worth documenting:
    ```
    # Project Deploy Rules (Non-Obvious Only)
    - Platform/infra: [e.g. Terraform or Docker location in repo; where to apply/run from]
    - Interdependencies: [e.g. which repos/modules depend on which; deploy order to respect dependencies]
    - DB scripts: [e.g. path; when applied in pipeline; rollout order or runbook]
    - CI/CD: [e.g. workflow paths; secrets location; deploy trigger]
    - Env/secrets: [e.g. required vars; where they are set]
    - Rollback: [e.g. image/tag strategy; rollback steps from repo or docs]
    - Deploy docs: [e.g. where runbooks or deployment docs live in repo]
    - Target convention: [e.g. from config if present]
    - When existing code: [e.g. existing pipeline in repo to extend]
    ```

</mode_specific_files>
</output_structure>

<quality_criteria>

- ONLY include non-obvious information discovered by reading files
- Exclude anything that could be guessed from standard practices
- Focus on gotchas, hidden requirements, and counterintuitive patterns
- Include specific file paths when referencing custom utilities
- Be extremely concise - if it's obvious, don't include it
- Every line should prevent a potential mistake or confusion
- Test: Would an experienced developer be surprised by this information?
- If updating existing files: DELETE obvious info first, files should get SHORTER
- Measure success: Is the file more concise and valuable than before?
- Verification: For each mode's AGENTS.md, confirm it contains only codebase-derived, accurate, non-obvious context (per the checklist) and no pipeline mechanics. That context should be enough for the mode to drive right decisions and follow its own instructions, skills, and rules (defined in mode rules, skills — not in init.md).
- Self-review: Before finishing, run a deep scan of the code/workspace in a loop (at least 2 passes), comparing documented content to the actual codebase. Correct inaccuracies and fill gaps until the AGENTS.md set is accurate and complete as required.
  </quality_criteria>

Remember: Each mode's AGENTS.md gives that mode the **codebase-derived, accurate, non-obvious information** it needs to generate correct documents and fulfill its job — so the mode can make right decisions and follow its own workflow, skills, and rules. Init does not document the mode's instructions or rules; it only defines what codebase context to capture.

<pipeline_reference>
After creating AGENTS.md, to start product development:

- **New product:** Use /greenfield or select Orchestrator mode with a product idea
- **Extend existing:** Use /brownfield or select Orchestrator mode with scope (extend feature, add feature, fix bug, refactor, migrate)
  See .nayan/guidance/pipeline-entry-points.md for details.
  </pipeline_reference>
