# Context Input Handling

Users can provide context in three ways. Nayan must detect the input type and fetch full context before responding or exploring. This applies to **greenfield** and **brownfield** pipelines.

---

## Present-First Principle (CRITICAL)

**Never ask for consent or satisfaction before showing the user the content.** Users cannot meaningfully approve something they have not seen.

1. **Fetch** the context (SOW, Jira, etc.)
2. **Present** the full synthesized summary to the user immediately
3. **Then** ask for satisfaction/approval: "Are you satisfied with this summary? Should I proceed to explore/PRD/plan based on it?"

**Wrong:** "I have retrieved the Jira details. Are you satisfied with me presenting this summary now?" → User says yes → Then show details.

**Correct:** "Here is the Jira ticket summary: [full details]. Are you satisfied with this? Should I proceed to explore based on it?"

---

## Input Types Overview

| Input Type      | User Shares                                              | Nayan Action                                                                                                           |
| --------------- | -------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **SOW doc**     | Statement of Work (link, file, Google Drive, Confluence) | Fetch and read full document content                                                                                    |
| **Jira**        | Jira issue key (e.g., PROJ-123, JIRA-456)                | Fetch description, attachments, comments via Atlassian MCP; synthesize into a detailed summary before sharing with user |
| **Direct text** | Typed message in chat                                    | Use message as-is; no fetch needed                                                                                      |

---

## 1. SOW Document

**Trigger:** User shares SOW doc via:

- Google Drive link
- Confluence page link
- File path (workspace or attached)
- Reference to a document by name

**Fetch:** Use MCP when configured (Google Drive, Confluence) or `read_file` for local/attached files. Extract full document content.

**Present first:** Display the full SOW content (or key sections) to the user immediately. Do NOT ask for satisfaction before showing. Only after the user has seen it, ask if they want to proceed. See Present-First Principle above.

**When:** Before exploration, PRD creation, or planning. Use SOW content to inform structured concept, use cases, scope, and technical specs.

**Fallback:** If MCP unavailable or fetch fails, ask user to paste key sections or share an accessible link.

**Modes affected:** brainstorm, prd, architect, plan, orchestrator, ask

---

## 2. Jira

**Trigger:** Detect Jira issue key pattern in user message. Common format: `[A-Z][A-Z0-9]+-\d+` (e.g., PROJ-123, JIRA-456, ABC-789).

**Fetch sequence:**

1. Use Atlassian MCP to get issue by key (description, summary, status, assignee)
2. Fetch attachments (when MCP supports `jira_download_attachments` or equivalent)
3. Fetch comments (when MCP supports it; Atlassian MCP may have limited comment retrieval)
4. **Synthesize a detailed summary** — Combine description, attachments (names, types, relevance), and comments into a coherent, structured summary.
5. **Present the summary to the user immediately** — Do NOT ask for satisfaction or consent before showing. Display the full summary first. Only after the user has seen it, ask "Are you satisfied with this summary? Should I proceed to explore/PRD/plan based on it?" See Present-First Principle above.

**Summary structure (recommended):**

- **Issue overview:** Summary, status, assignee
- **Description & requirements:** Core description and acceptance criteria
- **Comments:** Key points, decisions, or clarifications from the discussion thread
- **Attachments:** What was attached and how it relates to the issue (e.g., "Design mockup: login-flow.png — shows updated wireframe for auth screen")

**When:** Before any exploration, PRD creation, architecture, or planning that references the Jira. Use the synthesized summary (and underlying data) to inform use cases, entities, and sprint tasks.

**Fallback:** If Atlassian MCP unavailable or fetch fails, acknowledge to user and proceed with whatever context is available. Do not block; ask user to paste key details if needed.

**Modes affected:** brainstorm, prd, architect, plan, orchestrator, ask, code (when fix-bug references Jira)

**MCP reference:** Atlassian MCP server (`mcp.atlassian.com`). Document any known limitations (comments, attachments) in mode behavior.

---

## 3. Direct Text Chat

**Trigger:** User types idea, requirements, or request directly in chat. No SOW link, no Jira key detected.

**Action:** No fetch required. Use message content as-is. Proceed with exploration, PRD creation, or planning based on the typed content.

---

## Detection Order

When processing a user message:

1. **Check for SOW:** Does the message contain a document link (Google Drive, Confluence, file path)? If yes, fetch SOW content.
2. **Check for Jira:** Does the message contain a Jira issue key pattern? If yes, fetch Jira context.
3. **Otherwise:** Treat as direct text; use message as-is.

If both SOW and Jira are present, fetch both and combine context.

---

## Entry point when user provides JIRA or SOW (instead of PRD)

**Rule:** When the user provides **JIRA ID** or **SOW** (and not a full PRD document), the **entry point is brainstorm first** for both **greenfield and brownfield**, all use cases.

1. **Orchestrator** delegates to **brainstorm** (not directly to prd or architect).
2. **Brainstorm** fetches JIRA/SOW context per Present-First Principle, presents the full summary to the user immediately, then **deeply understands requirements with the user** through **question-answer and brainstorm** (clarify scope, use cases, constraints, acceptance criteria, ambiguities). Do not hand off until the user and Nayan have aligned on a clear understanding.
3. **Then** brainstorm hands off to the next mode per pipeline: greenfield → prd; brownfield extend/migrate → architect; brownfield add-feature (substantial or JIRA/SOW) → prd (then prd → architect → prototype/plan); brownfield add-feature (small/spec clear) → prototype or plan.

This applies to **all use cases** where the primary input is JIRA or SOW: greenfield new product, brownfield extend, brownfield add/enhance feature, brownfield migrate (when scope comes from JIRA/SOW).

---

## Architect When JIRA / SOW / PRD Drives Add or Enhance Feature

**Rule:** When the user provides **JIRA ID**, **SOW**, or **PRD** and the work is **add feature**, **enhance existing feature**, or **greenfield development**, the flow **must include architect** (after brainstorm when JIRA/SOW, then prd when applicable).

| Context                                                         | Pipeline               | Entry when JIRA/SOW                                 | Architect usage                                                                                                           |
| --------------------------------------------------------------- | ---------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **Greenfield** (new product; JIRA/SOW/PRD as input)             | greenfield             | **JIRA/SOW:** brainstorm first → prd. **PRD:** prd. | **Always.** brainstorm → prd → architect → prototype/plan. Architect creates architecture.md from refined PRD.            |
| **Brownfield add or enhance feature** (JIRA/SOW/PRD as input)   | brownfield-add-feature | **JIRA/SOW:** brainstorm first → prd. **PRD:** prd. | **When PRD is used.** Orchestrator → brainstorm (when JIRA/SOW) → prd → architect (architecture impact) → prototype/plan. |
| **Brownfield extend** (significant feature; may use JIRA/SOW)   | brownfield-extend      | **JIRA/SOW:** brainstorm first → architect.         | **Always.** Orchestrator → brainstorm (when JIRA/SOW) → architect (condensed scope).                                      |
| **Brownfield migrate** (product migration; scope from JIRA/SOW) | brownfield-migrate     | **JIRA/SOW:** brainstorm first → architect.         | **Always.** Orchestrator → brainstorm (when JIRA/SOW) → architect → prototype (when UI) → plan (migration plan).          |

Ensure JIRA/SOW context is fetched and presented first (Present-First Principle); **entry = brainstorm first** to deeply understand requirements with the user; then route to the correct next mode so architect is included for add/enhance/greenfield/migrate as above.

---

## Pipeline Applicability

| Pipeline               | Modes That Use Context Inputs                                               |
| ---------------------- | --------------------------------------------------------------------------- |
| Greenfield             | brainstorm, prd, architect                                                  |
| Brownfield-extend      | brainstorm, architect                                                       |
| Brownfield-migrate     | brainstorm, architect, prototype (when UI), plan                            |
| Brownfield-add-feature | brainstorm, prd, architect (when PRD used for add/enhance), prototype, plan |
| Brownfield-fix-bug     | code (Jira ticket common)                                                   |
| Brownfield-refactor    | brainstorm, qa                                                              |

---

## References

- `.nayan/rules-brainstorm/1_workflow.md` — Context input detection step
- `.nayan/rules-prd/1_workflow.md` — MCP and context input in PRD phases
- `.nayan/rules-architect/1_workflow.md` — MCP and context input for architecture; `.nayan/rules-plan/1_workflow.md` — for dev plan
- `.nayan/mcp.json` — MCP server configuration (Atlassian, etc.)
