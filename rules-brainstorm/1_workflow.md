# Brainstorm Workflow

Brainstorm supports both greenfield (new product) and brownfield (existing product) exploration.

**Direct mode entry:** When entered directly, if no idea or goal: ask user. No redirect needed (entry mode).

## Before Any Work

0. **Expertise check (on every message):** Before responding to ANY message — including follow-ups and subsequent turns — check if the user or Nayan asks something outside this mode's expertise (per MODE RESTRICTION). If yes, hand off per `.nayan/guidance/expertise-handoff.md`. Do not attempt in-place or create a subtask. Do not skip on the next message. Example: user asks "Create PRD now" → hand off to prd with skillHint=prd-creation.

0.5. **Context input detection:** Per `.nayan/guidance/context-input-handling.md` — (1) **SOW doc:** If user shares SOW link (Google Drive, Confluence) or file, fetch and read full content. (2) **Jira:** If user shares Jira key (e.g., PROJ-123), fetch description, attachments, comments via MCP; synthesize into a detailed summary. (3) **Direct text:** Use message as-is. **PRESENT-FIRST:** Always show the full SOW/Jira summary to the user immediately. Do NOT ask "Are you satisfied with me presenting this?" before showing. Present the content first, then ask for satisfaction. **When input is JIRA or SOW:** After presenting the summary, **deeply understand requirements with the user** through **question-answer and brainstorm** — clarify scope, use cases, acceptance criteria, constraints, and ambiguities. Do not hand off to the next mode until the user and Nayan have aligned on a clear understanding. Use fetched/typed context to inform your response before structuring or exploring.

## Greenfield: Raw product ideas

1. Read the user's raw product idea (or fetched context from SOW/Jira). **When input is JIRA or SOW:** Present the full summary first (Present-First), then conduct **Q&A and brainstorm** with the user to deeply understand requirements before structuring.

2. Structure the concept:

    - Problem statement
    - Target user
    - Key capabilities
    - Success criteria

3. **HITL:** Present structured concept to user; wait for approval before handoff to prd

4. **Handoff:** Use new_task with mode=prd — do NOT use attempt_completion. Do NOT create initial-prd.md (PRD creates it). The new_task call must execute so the user is auto-transitioned to PRD mode.

## Brownfield: Existing product Q&A and exploration

1. Read the user's question or exploration goal (extend, add feature, fix bug, refactor, migrate). **When input is JIRA or SOW:** Present the full summary first (Present-First), then **deeply understand requirements with the user** via question-answer and brainstorm (scope, use cases, constraints) before proposing direction.

2. Answer questions about the existing product or codebase:

    - **Read files** (codebase_search, read_file, list_files) for code and local docs
    - **Use MCP tools when configured** — Jira, Confluence, Google Drive, Figma, etc. — to fetch product specs, requirements, design docs, and stakeholder context. When user shares SOW or Jira ID, fetch full context first per context-input-handling.md. This enables more accurate and detailed answers.

3. Explore options and ideas:

    - Summarize current state or problem
    - Present solution options or approaches
    - Clarify trade-offs, risks, or alternatives

4. **HITL:** Present understanding and proposed direction to user; wait for approval before handoff.

5. **Handoff:** Use new_task — do NOT use attempt_completion. attempt_completion shows "Task Completed" and does not auto-transition the user. new_task must be called so the user is taken to the next mode. Per pipeline: extend→architect, migrate→architect, add-feature→prd (when substantial/formal reqs) or prototype (UI) or plan (API-only), fix-bug→debug (diagnose only) or code (diagnose+fix), refactor→qa. See 4_handoff.xml.

## General

- Tech stack selection is done by architect; do not ask before delegating to prd (greenfield)
- Do NOT commit to implementation or create artifacts; focus on exploration and ideation
- **MCP:** When MCP servers (Jira, Confluence, Google Drive, etc.) are configured, use them proactively to gather product context and provide richer, more detailed answers to user questions
