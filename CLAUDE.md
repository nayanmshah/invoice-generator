# Nayan SDLC — Claude Code Plugin

A strategic, human-in-the-loop SDLC pipeline for Claude Code. Orchestrates 12 specialized agents across an 8-step lifecycle for both greenfield (new product) and brownfield (extend / add-feature / fix-bug / refactor / migrate) work.

## Agents

| Agent          | Role                                                                  |
| -------------- | --------------------------------------------------------------------- |
| `orchestrator` | Coordinator — delegates work to specialists; never implements         |
| `ask`          | Answers questions and explains code                                   |
| `brainstorm`   | Explores ideas; structures concepts before PRD                        |
| `prd`          | Creates and refines PRDs (15-section canonical format)                |
| `architect`    | Designs architecture (diagrams, ADRs, tech stack)                     |
| `plan`         | Builds sprint roadmap from architecture (development plan)            |
| `prototype`    | Wireframes, flows, interactive HTML prototypes per persona            |
| `code`         | Implements one sprint at a time with local verification               |
| `debug`        | Diagnoses bugs; hands off fix instructions to `code`                  |
| `qa`           | Code review → QA plan → execution → quality gate → second-pass review |
| `secure`       | Veracode + OWASP Top 10 review; gates deploy                          |
| `deploy`       | Deployment plan + execution (Vercel, AWS, Azure, GCP, etc.)           |

## Slash Commands

- `/nayan:greenfield` — start a new product
- `/nayan:brownfield` — extend, add-feature, fix-bug, refactor, or migrate
- `/nayan:init` — analyze codebase, create AGENTS.md
- `/nayan:commit` — descriptive commit + push
- `/nayan:release` — cut a release
- `/nayan:nayan-translate` — translate/localize strings
- `/nayan:nayan-resolve-conflicts` — resolve merge conflicts
- `/nayan:setup-sonarqube` — local SonarQube
- `/nayan:setup-qdrant` — local Qdrant

## Pipeline Flow

**Greenfield:** `orchestrator` → `brainstorm`/`prd` → `architect` → `prototype` (when UI) → `plan` → `code` (per sprint, with local verification) → `qa` → `secure` → `deploy`

**Brownfield-fix-bug:** `orchestrator` → `debug` (diagnose) → `code` (fix) → `qa` → `secure` → optional `deploy`

Every phase has a HITL gate: present full deliverable, get explicit user approval, then hand off via `new_task`.

## Repository Layout

| Path             | Contents                                                              |
| ---------------- | --------------------------------------------------------------------- |
| `agents/`        | Claude Code subagent definitions (one per pipeline mode)              |
| `commands/`      | Slash command entry points                                            |
| `skills/`        | Reusable methodology skills, namespaced by mode (`modeSlugs:` field)  |
| `rules/`         | Auto-injected XML rules: prerequisites, HITL gates, security/quality  |
| `rules-{mode}/`  | Per-mode workflow rules (loaded when that agent is active)            |
| `guidance/`      | Cross-cutting reference docs (templates, validation, handoff schemas) |
| `.claude-plugin` | Plugin and marketplace manifests                                      |

## Universal Code Quality

1. **Test coverage:** Code changes must have tests; tests must pass before completion.
2. **Lint rules:** Never disable lint rules without explicit user approval.
3. **Secrets:** Never commit `.env`, credentials, or API keys; never echo secrets to chat.
