# Orchestrator Handoff

The orchestrator delegates to the first mode in the pipeline. It does not produce a file—it produces a delegation via `new_task`.

**new_task message must include:** pipelineId (greenfield | brownfield-extend | brownfield-add-feature | brownfield-fix-bug | brownfield-refactor | brownfield-migrate), diagramSpec from workflow file, context, scope.

**First delegation:** When user provides **JIRA ID or SOW** (instead of a full PRD): delegate to **brainstorm first** for greenfield and brownfield (all use cases where JIRA/SOW is the input). Brainstorm fetches context, presents it, deeply understands requirements with the user (Q&A/brainstorm), then hands off to prd (greenfield or brownfield add-feature) or architect (brownfield-extend, brownfield-migrate). When user does not provide JIRA/SOW: brainstorm or prd (greenfield) | architect (brownfield-extend, brownfield-migrate) | **prd** (brownfield-add-feature — when substantial/formal reqs or user provides PRD) or prototype or plan (brownfield-add-feature when prd skipped) | **debug** or **code** (brownfield-fix-bug) | qa (brownfield-refactor). **Brownfield-migrate:** architect first (or brainstorm first when JIRA/SOW), then prototype (when UI), then plan. **Greenfield and brownfield add/enhance with JIRA/SOW/PRD always use architect** (after brainstorm when JIRA/SOW, then prd). **Phase distinction:** **Debug** = debug phase; **Code** = code implementation phase. For brownfield-fix-bug: delegate to **debug** (diagnose only) or **code** (diagnose+fix).

**Final handoff:** When deploy completes, it calls `attempt_completion` back to orchestrator. Orchestrator synthesizes results and presents overview to user.
