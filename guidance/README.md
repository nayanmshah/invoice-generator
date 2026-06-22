# Nayan Guidance

Cross-cutting reference docs shared across modes. See `.nayan/rules-{mode}/` for mode-specific workflows.

## Categories

| Category               | Files                                                                                                                                                                            | Purpose                                                                                            |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| **SDLC**               | sdlc-prerequisites.md, sdlc-human-gates.md, pipeline-entry-points.md, context-input-handling.md, validation-checklist.md, handoff-schema.md, expertise-handoff.md                 | Pipeline flow, prerequisites, gates; JIRA/SOW → brainstorm first                                   |
| **Architecture**       | architecture-\*-structure.md, architecture-document-structure.md, architecture-gap-validation.md, architecture-impact-\*.md, plan-input-requirements.md                           | Architecture templates and requirements                                                            |
| **Development plan**   | development-plan-\*-template.md, development-plan-sprint-format.md, development-plan-document-template.md, sample-sprints.md, branch-sprint-commit-strategy.md                    | Dev plan templates; sample-sprints shows two full sprint examples                                  |
| **Brownfield**         | brownfield-guide.md, brownfield-use-cases.md, brownfield-migration-use-cases.md, condensed-scope-template.md                                                                      | Brownfield flows and templates                                                                     |
| **Quality & security** | code-quality-security-gates.md                                                                                                                                                   | Code quality and security gates                                                                    |
| **Testing**            | test-mode-selection.md                                                                                                                                                           | QA mode and skill selection                                                                        |
| **PRD**                | prd-template-v2.md, prd-gap-validation.md, prd-sharing-sign-off.md                                                                                                               | Canonical PRD format (15 sections); all PRDs must follow this structure                            |
| **Multi-repo**         | decoupled-fullstack-repo-strategies.md                                                                                                                                           | Strategies for single vs multi-repo projects                                                       |
| **Prototype**          | prototype-brownfield-existing-ui.md, prototype-design-discovery.md, prototype-figma-matching.md, ux-artifacts.md                                                                  | UX artifacts and prototype workflows                                                               |
| **Other**              | deployment-platforms.md, use-case-coverage.md, sdlc-index.md                                                                                                                     | Deployment platforms; coverage matrix; SDLC index                                                  |

## Critical Rules (Auto-Loaded)

The following content is in `.nayan/rules/` as XML and is auto-injected into the system prompt for all modes:

- `sdlc_prerequisites.xml` — Prerequisite validation before delegation
- `sdlc_human_gates.xml` — HITL gates and end-interaction satisfaction check
- `plan_input_requirements.xml` — Plan input readiness
- `code_quality_security_gates.xml` — Code quality and security gates
- `secrets_chat.xml` — Secrets handling in chat

## References

- `.nayan/rules-orchestrator/` — Pipeline definitions
- `.nayan/rules-{mode}/` — Per-mode workflows (architect, code, qa, secure, deploy, etc.)
