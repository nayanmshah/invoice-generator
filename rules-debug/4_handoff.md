# Systematic Debugging Handoff

## Debug mode → Code mode

When **Debug mode** has diagnosed an issue and code change is required:

**Handoff:** Use `new_task` with `mode=code` and a `message` that includes:

- **pipelineId:** brownfield-fix-bug (so Code can hand off to qa with correct context and BUG_FIX_SCOPE when applicable)
- **Diagnosis summary** — What was investigated, what the logs revealed, proposed root cause.
- **Step-by-step fix instructions** — Clear steps, files to change, and exact changes so Code can implement without re-diagnosing.

Code mode then implements the fix and hands off to qa per `2_workflows_brownfield.xml`. Quality gates (qa, secure) are mandatory.

**HITL:** Debug mode must present full diagnosis to user and get confirmation before handoff. Do not hand off before user has seen the diagnosis.

---

## Code mode (brownfield-fix-bug) → qa

When **code mode** handles brownfield-fix-bug using systematic-debugging skill:

**Output:** Diagnosis summary; fix applied.

**Handoff:** Code mode hands off to qa per `2_workflows_brownfield.xml`. QA runs quality gate phase (and optionally plan/execution for complex fixes).

**HITL:** Wait for user to confirm diagnosis before applying fix. When fix applied, ask user to verify locally before handoff to qa.
