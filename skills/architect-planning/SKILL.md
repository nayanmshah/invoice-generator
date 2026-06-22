---
name: architect-planning
description: "Use when designing architecture: Provides the planning workflow methodology for architect mode including information gathering, todo list creation, brainstorming, Mermaid diagrams, company tech stack reference, and mode switching coordination."
modeSlugs:
    - architect
---

# Architect Planning Workflow

See sdlc_human_gates rule for architecture sign-off gate.

## When to Use This Skill

Use this skill when:

- Planning system architecture or technical design
- Creating todo lists for implementation tasks
- Gathering information and context for technical decisions
- Creating Mermaid diagrams for workflows or architecture
- Coordinating mode switches for implementation

## When NOT to Use This Skill

Do NOT use this skill when:

- Implementing code directly
- Debugging issues
- Writing tests
- Performing non-planning activities

## Planning Workflow

1. Do some information gathering (using provided tools) to get more context about the task.

2. You should also ask the user clarifying questions to get a better understanding of the task.

3. Once you've gained more context about the user's request, break down the task into clear, actionable steps and create a todo list using the `update_todo_list` tool. Each todo item should be:

    - Specific and actionable
    - Listed in logical execution order
    - Focused on a single, well-defined outcome
    - Clear enough that another mode could execute it independently

    **Todo ordering — sign-off must be last:** Sign-off collection/verification (e.g., "Get user sign-off on architecture") must be the **last** todo(s) before handoff or attempt_completion—after all substantive work (review, clarify, produce, validate) and after user confirms docs are good. Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off. **Architect mode:** Last todo is "Hand off to prototype/plan/code per 4_handoff.xml" (use new_task)—NOT attempt_completion. **Prerequisite vs todo:** "Verify prerequisites" (e.g., PRD Sign-Off complete for architect input) is a gate at mode entry—do it before the todo list, not as an early todo. If input fails, redirect. Do NOT include prerequisite verification as todo #2.

    **Note:** If the `update_todo_list` tool is not available, write the plan to a markdown file (e.g., `plan.md` or `todo.md`) instead.

4. As you gather more information or discover new requirements, update the todo list to reflect the current understanding of what needs to be accomplished.

5. Ask the user if they are pleased with this plan, or if they would like to make any changes. Think of this as a brainstorming session where you can discuss the task and refine the todo list.

6. Include all required architecture sections per structure. **Greenfield:** Input is `refined-prd.md` (PRD per `.nayan/guidance/prd-template-v2.md`; created by PRD per `.nayan/skills/prd-creation/SKILL.md`). **Brownfield A:** Input is condensed scope (`.nayan/guidance/condensed-scope-template.md`), existing architecture.md, codebase. Required sections: **Domain model** (greenfield), **Data model diagram (ERD)**, **Database schema with table/column purpose**, C4 diagrams, **NFRs & architecture**, **Security architecture**, **Error handling & resilience**, **Cross-cutting concerns**, **External integrations**, **Integration map & impact** (greenfield) or **Impacted integrations** (brownfield), **Testing strategy**, **Architecture risks & trade-offs**, **Scope boundaries** (greenfield), **Open questions resolution** (greenfield), **Constraints mapping**, **data flow / core end-to-end sequence** (2–4 flows), **end-to-end architecture & deployment diagram**, **module & PRD use case mapping** (greenfield) or **module & scope mapping** (brownfield). See `.nayan/guidance/architecture-greenfield-structure.md` or `architecture-brownfield-structure.md`. **After each diagram added:** self-review the doc — validate Mermaid diagrams for syntax errors and fix any issues before presenting to user.

7. **HITL at decision points**: Confirm tech stack (including **deploy tech stack**—see below), architectural pattern (Modular Monolith vs Decoupled), and key modules with the user before finalizing. Present full architecture and wait for explicit approval. Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off.

8. **Self-review before user approval and handoff** — Run through `.nayan/rules-architect/3_architecture_validation.md`: (1) Self-review the doc: validate all Mermaid diagrams in architecture.md for syntax errors and fix any issues until all pass; (2) **Run architecture gap validation** per `.nayan/guidance/architecture-gap-validation.md` — verify all required sections present, no gaps; fix any failures before presenting. Do not present to user for approval or handoff with unresolved syntax errors or section gaps.

9. When architecture is complete, reviewed, and user has given explicit sign-off, hand off per `.nayan/rules-architect/4_handoff.xml`. **Greenfield:** Include PRD_FILE (refined-prd.md). **Brownfield:** Include SCOPE (condensed scope). Include ARCHITECTURE_FILE (architecture.md) and instruction to synthesize into development-plan.md.

**IMPORTANT: Focus on creating clear, actionable todo lists rather than lengthy markdown documents. Use the todo list as your primary planning tool to track and organize the work that needs to be done.**

---

## Company Technology Stack Reference

When making architecture or technology recommendations, **consult this reference first** and justify any deviation. See Product Technology Matrix and patterns below.

**Deploy tech stack is an architect responsibility:** The architect **selects and documents** the full technology stack in architecture.md, including **deployment** (frontend hosting, backend hosting, cloud platform). Document in architecture.md Section 1 (Technology Stack) per `.nayan/rules-architect/2_tech_stacks.md`. The development plan **consumes** this—it does not select or override deployment targets. Bootcamp → Vercel (frontend), Render or Railway (backend); Enterprise → GKE; Custom/company → document the chosen deployment targets explicitly.

### Preferred Stack for New Projects (Greenfield)

| Layer        | Recommended                | Rationale                                              |
| :----------- | :------------------------- | :----------------------------------------------------- |
| **Backend**  | Spring Boot 3.2+, Java 17+ | Most adopted modern stack across products              |
| **Frontend** | Angular 19, Node 22        | Latest adopted frontend in active products             |
| **Database** | MySQL or Oracle            | Most common; Oracle/MS-SQL for enterprise integrations |
| **Cloud**    | GKE (GCP)                  | Primary cloud platform                                 |
| **CI/CD**    | Jenkins                    | Primary CI/CD tool                                     |
| **SCM**      | Bitbucket                  | Standard source control                                |

### Anti-Patterns to Avoid

1. **Never substitute local-only databases for production databases** — If the plan says Oracle, don't use H2 "with Oracle compatibility mode" unless the user explicitly confirms
2. **Never introduce a framework not in the company stack** without explicit user approval and business justification
3. **Never default to MongoDB/NoSQL** when the existing ecosystem is relational-heavy
4. **Never skip Keycloak** for IAM when the product family uses it — don't substitute with simple JWT unless confirmed

### Architecture Decision Questions

When recommending a stack, ask the user:

1. Which product family does this project belong to or integrate with?
2. Are there existing databases or services this must connect to?
3. What is the deployment target (GKE, GCP, on-premises)?
4. Are there specific compliance or security requirements (ISDS, LDAP, SAML)?
5. Is this a greenfield project or an extension of an existing product?
