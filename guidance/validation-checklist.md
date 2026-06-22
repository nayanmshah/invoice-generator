# Migration Validation Checklist

Use this checklist to verify the migrated modes produce equivalent output and handoff correctly.

## Handoff Validation (Greenfield)

Run `/greenfield` or select Orchestrator mode with a product idea. Verify:

| Step | Mode                  | Expected Output                                                                                                                                                                                    | Handoff To                                                     |
| ---- | --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| 1    | orchestrator          | Delegation with context                                                                                                                                                                            | prd or brainstorm                                              |
| 2a   | brainstorm (optional) | Structured concept, user approval                                                                                                                                                                  | prd                                                            |
| 2b   | prd                   | initial-prd.md → refined-prd.md, user approval                                                                                                                                                     | architect                                                      |
| 3    | architect             | architecture.md, user approval                                                                                                                                                                     | prototype (when UI) or plan (dev-plan) or code (when API-only) |
| 4    | prototype             | Interactive HTML prototype per persona, wireframes, interaction flows, prototypes, **explicit sign-off** — prototype is authoritative for UI design and look-and-feel in development plan and code | plan                                                           |
| 5    | plan (dev-plan)       | development-plan.md, user approval                                                                                                                                                                 | code                                                           |
| 6    | code                  | Working code, local verification                                                                                                                                                                   | qa                                                             |
| 7    | qa                    | Code review first pass, QA plan, QA execution, quality gate, code review second pass; user approval                                                                                                | secure                                                         |
| 8    | secure                | security-review.md, Critical/High resolved, security assessment, user approval                                                                                                                     | deploy                                                         |
| 9    | deploy                | Deployed app (after all sprints), user approval                                                                                                                                                    | orchestrator                                                   |

## Brownfield Validation

| Scenario                             | Entry                                                              | Skip                                         | Verify                                                                                                                                                                                                                                                           |
| ------------------------------------ | ------------------------------------------------------------------ | -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Extend product                       | orchestrator → architect                                           | prd                                          | Architect receives condensed scope                                                                                                                                                                                                                               |
| Product migration (legacy→new)       | orchestrator → architect                                           | prd                                          | **Brownfield-migrate.** Architect → prototype (when UI) → plan (migration plan). Do not skip architect or prototype before plan.                                                                                                                                 |
| Add or enhance feature (arch exists) | orchestrator → brainstorm (when JIRA/SOW) or prd or prototype/plan | prd when skipped; architect when PRD skipped | When JIRA/SOW: brainstorm first (deep understanding with user) → prd → architect → prototype/plan. When full PRD used: prd → architect → prototype/plan. Add/enhance with PRD always uses architect. Dev plan receives architecture.md (+ impact when PRD used). |
| Fix bug                              | orchestrator → debug (diagnose only) or code (diagnose+fix)        | prd, architect, plan, prototype              | True bug only. When "bug" is enhancement → use add-feature or extend + PRD. Debug = debug phase; code = code implementation phase. Quality gates (qa, secure) required. Deployment when user confirms.                                                           |
| Refactor                             | orchestrator → qa                                                  | prd, architect, plan                         | qa receives refactor request; produces refactor-scope (Phase 0). Handoff to code when approved.                                                                                                                                                                  |

### Brownfield Fix Bug Handoff Validation

| Step | Mode             | Expected Output                                         | Handoff To                            |
| ---- | ---------------- | ------------------------------------------------------- | ------------------------------------- |
| 1    | debug (optional) | Diagnosis only; fix instructions; hand off to code      | code                                  |
| 2    | code (fix-bug)   | Implements fix (from debug or diagnose+fix in one flow) | qa                                    |
| 3    | qa               | code-review.md, quality gate PASS                       | secure                                |
| 4    | secure           | security-review.md                                      | deploy or orchestrator (if no deploy) |

## HITL Validation

| Gate                             | Where     | Verify                                                                                                                                                                                                                                                                                                                                          |
| -------------------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| PRD sign-off                     | prd       | Mode presents PRD; Sign-Off table (Section 1) must have all three roles Approved with Approver Name and Sign-Off Date filled for each; waits for "approved" before new_task. **Approver Name:** Per sdlc-human-gates — use Nayan logged-in user from environment_details. **Reject handoff if Pending, Needs Revision, or missing Name/Date.** |
| Architecture sign-off            | architect | Mode presents architecture; waits for approval before new_task                                                                                                                                                                                                                                                                                  |
| Development plan sign-off        | plan      | Mode presents plan; waits for approval before new_task                                                                                                                                                                                                                                                                                          |
| Sprint verification (local)      | code      | Mode asks "Please verify [X] works locally" between tasks                                                                                                                                                                                                                                                                                       |
| PR creation (no auto-merge)      | code      | Mode creates PR; does not merge; states human approves                                                                                                                                                                                                                                                                                          |
| Cloud deploy (after all sprints) | deploy    | Mode confirms deploy target; gets explicit approval; does not deploy mid-pipeline                                                                                                                                                                                                                                                               |

## Mode Output Equivalence

For each mode, run a representative prompt and compare to pre-migration:

| Mode                             | Test Prompt                                | Expected                                                 |
| -------------------------------- | ------------------------------------------ | -------------------------------------------------------- |
| code (issue-resolution-workflow) | "Fix GitHub issue #X"                      | Same workflow, PR creation                               |
| architect                        | "Design architecture for [product]"        | Mermaid diagrams, ADRs, handoff to prototype/code        |
| code                             | "Implement sprint 1 from development-plan" | Per-task verification, local testing                     |
| code (fix-bug)                   | "Debug [error]"                            | Diagnosis confirmation before fix (systematic-debugging) |
| translate                        | "/nayan-translate de"                     | Same translation workflow                                |

## Commands

| Command                   | Verify                                                                                                              |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| /init                     | Creates AGENTS.md; multi-repo: documents per-repo commands; ends with pipeline reference (/greenfield, /brownfield) |
| /commit                   | Single-repo: git from root. Multi-repo: discover child repos; git per repo                                          |
| /greenfield               | Starts orchestrator with greenfield flow                                                                            |
| /brownfield               | Starts orchestrator with brownfield flow                                                                            |
| /nayan-translate         | Translation workflow; references Orchestrator for full pipeline                                                     |
| /nayan-resolve-conflicts | Merge resolution; references Orchestrator for full pipeline                                                         |

