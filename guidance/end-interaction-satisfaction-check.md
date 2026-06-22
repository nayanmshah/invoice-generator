# End Interaction Satisfaction Check

Before ending any interaction with `attempt_completion`, run a satisfaction confirmation step.

## Present-First Principle (CRITICAL)

**Never ask for satisfaction before the user has seen the complete deliverable.** Users cannot meaningfully consent to something they have not seen.

1. **Present the full deliverable first** — Show the user the complete result (summary, details, artifact, etc.). For Jira/SOW context: display the full synthesized summary before any satisfaction question.
2. **Then** ask whether they are satisfied.

**Wrong:** "I have retrieved the Jira details. Are you satisfied with me presenting this summary now?" (User has not seen the summary yet.)

**Correct:** "Here is the Jira ticket summary: [full details]. Are you satisfied with this? Should I proceed?"

## Flow

1. **Present the complete deliverable** to the user (full summary, artifact, or result).
2. **After** the user has seen it, call `ask_followup_question` to ask whether they are satisfied.
3. Include at least two options:
    - `Yes, satisfied`
    - `Not yet, I want more updates`
4. **If user is not satisfied:** Continue working. Do not call `attempt_completion`. Address the user's feedback and run the satisfaction check again after completing the updates.
5. **If user is satisfied:** Provide the final summary via `attempt_completion` and close normally.
6. **Skip instruction:** If the user explicitly says to skip satisfaction checks for the current conversation (e.g. "skip satisfaction checks", "no need to ask"), follow that instruction and proceed to `attempt_completion` when the task is done.

## Exceptions

- **Greetings:** No satisfaction check (greetings do not use `attempt_completion`; task stays open).
- **Delegation/subtasks:** Satisfaction check applies at the leaf task level before the subtask returns to parent.
- **Handoff to next mode:** When handing off to another mode (e.g., brainstorm → prd, prd → architect), use **new_task** — do NOT use attempt_completion. attempt_completion ends the task and shows "Task Completed"; the user will not be auto-transitioned. new_task must be called so the user is taken to the next mode automatically.

## Example

```
1. Present the complete deliverable to the user (e.g., full Jira summary, PRD, architecture).
2. After user has seen it:
   ask_followup_question(
     question: "I've completed [X]. Here is the result: [summary or reference]. Are you satisfied with it?",
     follow_up: ["Yes, satisfied", "Not yet, I want more updates"]
   )

If "Not yet" → continue working → present updates → ask again when done.
If "Yes, satisfied" → attempt_completion with final summary.
```

**Key:** The question "Are you satisfied?" must come AFTER the user has seen the full result. Never ask for satisfaction before presenting.
