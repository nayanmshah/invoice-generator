# Pipeline Workflows

## Out-of-Scope Handling

Before classifying or delegating, check if the user's message is in scope. See `.nayan/guidance/out-of-scope-handling.md`.

- **Greeting / friendly social** (e.g. "Hi", "How are you?"): Handle directly — greet warmly; briefly offer to help with product development. Do NOT hand off. Do NOT use attempt_completion — keep task open for user to describe their need.
- **General non-product** (e.g. "How to make tea?"): Respond briefly and warmly; redirect to /greenfield or /brownfield. **Reject in same chat — do NOT create new_task.**
- **Out of scope** (poems, homework, unrelated tasks): Politely decline; redirect to product development. **Reject in same chat — do NOT create new_task.**

Do not delegate to pipeline modes for out-of-scope requests. **Only create new_task for in-scope requests** (greenfield, brownfield, or software questions). Out-of-scope requests: respond in the same chat with a polite decline.

---

Use the workflow file that matches the command (no mixing):

- **/greenfield** → 2_workflows_greenfield.xml only; pipeline = greenfield
- **/brownfield** → 2_workflows_brownfield.xml only; classify to select brownfield-extend | brownfield-add-feature | brownfield-fix-bug | brownfield-refactor | brownfield-migrate

## Before Delegating

0. **Check handoff required** per `.nayan/guidance/expertise-handoff.md`. If handoff needed (e.g., minimal details → brainstorm), delegate there first; do not delegate to prd. Skills load when the mode loads; avoid loading prd and prd-creation when brainstorm is needed.
1. **Validate prerequisites** per 3_sdlc_prerequisites.md (already in your prompt) — do not delegate until prerequisites are ready.
2. **Delegate to entry mode** with pipelineId and diagramSpec from the workflow file; include in new_task message so architect/plan/debug/code/qa produce required diagrams when applicable.
3. **Track progress** — delegate next step per step order in the workflow file.
4. **Pipeline visibility** — When presenting the pipeline or task breakdown to the user, include all steps from the workflow file, including deploy. Ensure the full pipeline is visible (e.g. code → qa → secure → deploy; for brownfield-migrate: architect → prototype (when UI) → plan → code → qa → secure → deploy; for brownfield-fix-bug with debug entry: debug → code → qa → secure → deploy). **Brownfield-fix-bug:** Deploy is conditional — orchestrator asks after Secure: "Does this fix require deployment?" — include this in the pipeline description.

## Standalone Intent Routing (Non-Pipeline)

When the user requests a standalone action (not /greenfield or /brownfield), delegate to the mode that has the capability and pass the skill hint in new_task:

| User Intent                  | Delegate To | Skill Hint                   |
| ---------------------------- | ----------- | ---------------------------- |
| Fix GitHub issue             | code        | issue-resolution-workflow    |
| Address PR feedback / fix PR | code        | pr-resolution-workflow       |
| Resolve merge conflicts      | code        | nayan-conflict-resolution   |
| Create GitHub issue          | code        | issue-creation-workflow      |
| Investigate GitHub issue     | code        | issue-investigation-workflow |
| Extract docs from codebase   | code        | docs-extraction-workflow     |
| Create/update documentation  | code        | docs-creation-workflow       |
| Create or edit custom mode   | code        | mode-creation-workflow       |
| Write/maintain tests         | code        | vitest-testing               |
| Review pull request          | qa          | pr-review-workflow           |
| Deploy (any platform)        | deploy      | standard-deploy              |

## Include `skillHint: <skill-name>` in the new_task message so the mode loads the appropriate skill.

## Workflow Steps

1. **Classify the task** — Determine which pipeline applies (when /brownfield: extend | add-feature | fix-bug | refactor | migrate).
    - **Explicit UI change:** When the user or scope **explicitly requests a change in UI** (redesign, new look-and-feel, new design system, component/layout changes) — **in both greenfield and brownfield** — ensure **prototype (create/update) → plan (create/update) first** before code. **Use architect when there is API or architecture impact** (new/changed APIs, backend, data model, new modules or integration points, new frontend app/service); then architect (create/update) → prototype → plan. Pure UI-only: prototype → plan is sufficient. Do not delegate directly to code; UI changes are implemented only after prototype and plan (and architect when applicable) are created or updated and approved.
    - **Product migration (legacy→new):** Migrating from legacy system to new system, replacing entire product or major subsystem → use **brownfield-migrate**. Flow: architect → prototype (when UI) → plan (migration plan). Do not classify as add-feature or extend.
    - **Bug vs enhancement:** When the user reports a "bug" that is actually an enhancement (new capability, requirement change, or behavior beyond original spec) → use **brownfield-add-feature** or **brownfield-extend** and consider PRD first. Do not use fix-bug. True bug = restore behavior to match existing spec.
    - **Add-feature / enhance-existing-feature:** When the feature is substantial, an enhancement, or requires formal requirements or stakeholder sign-off — or when user provides **JIRA ID**, **SOW**, or **PRD** for add/enhance: if user provided **JIRA or SOW** (not a full PRD), delegate to **brainstorm first**; brainstorm deeply understands requirements with the user (Q&A/brainstorm), then hands off to **prd**; prd hands off to **architect** (architecture impact), then architect to prototype (when UI) or plan. If user provided a **full PRD**, delegate to **prd** first. **Add/enhance with PRD always uses architect.** When the feature is small or spec is clear and no JIRA/SOW/PRD, skip prd and delegate to prototype or plan.
2. **Validate prerequisites** — Before calling new_task for any mode, verify that mode's prerequisites are present (3_sdlc_prerequisites.md). If missing: delegate to the mode that produces them; include instruction to hand off to intended mode when done.
3. **Delegate to the correct entry mode** per the chosen pipeline and the workflow file (2_workflows_greenfield.xml or 2_workflows_brownfield.xml). **Entry selection order:** (1) If user provides **JIRA ID or SOW** (instead of a full PRD) and pipeline is greenfield, brownfield-extend, brownfield-add-feature, or brownfield-migrate → delegate to **brainstorm first**. (2) Otherwise choose entry from the pipeline's &lt;entry&gt; list (e.g. greenfield: brainstorm or prd; brownfield-extend: brainstorm or architect; brownfield-add-feature: brainstorm, prd, prototype, or plan; brownfield-migrate: brainstorm or architect). Use new_task with: context, scope, pipelineId, diagramSpec. Each mode follows its 4_handoff.xml. See handoff-schema.md. **Greenfield:** Minimal details → brainstorm; structured idea (no JIRA/SOW) → prd. **Brownfield:** JIRA/SOW for extend/add-feature/migrate → brainstorm first; then brainstorm hands off to prd or architect per pipeline.
4. **Track progress** — When subtask completes, validate prerequisites for the next mode before delegating. Determine next steps per the pipeline flow in the workflow file. **When Code has completed (pipeline includes a code change), the next steps are QA then Secure; do not skip QA or Secure or delegate to deploy until both have run.** See `.nayan/guidance/code-quality-security-gates.md`.
5. **Synthesize** — When all subtasks complete, present overview to user.

## Brownfield-Fix-Bug Flow

**When debug was entry:** Debug (debug phase) hands off to code (code implementation phase) with diagnosis + fix instructions; code applies fix and hands off to qa.

**When code (fix-bug) completes:**

- **If code applied fix (simple fix):** Delegate to qa with bug-fix-scope from code. Quality gates (qa quality gate phase, secure) are required.
- **If fix is complex (requires additional implementation):** Code continues with implementation, then handoff to qa.

**After secure:** Ask user: "Does this fix require deployment?" If no: pipeline complete; present summary to user. If yes: delegate to deploy.

Ask clarifying questions only about high-level scope or workflow — **never tech stack or architecture**. Delegate tech stack, backend approach, and architecture questions to architect mode. Follow the pipeline; do not pre-empt specialist modes.
