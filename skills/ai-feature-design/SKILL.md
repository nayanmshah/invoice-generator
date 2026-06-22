---
name: ai-feature-design
description: Design and implement features powered by LLMs — model selection, prompt design, tool use, prompt caching, evals, safety, and telemetry. Use when the architecture or development plan includes any LLM-backed feature (chat, summarization, extraction, classification, agents, RAG, code-gen, etc.).
modeSlugs:
    - architect
    - plan
    - code
    - qa
---

# AI Feature Design

Use this skill whenever the work involves building or modifying a feature that calls an LLM (Claude, GPT, Gemini, OSS models). It covers the full lifecycle: choose the right model, design the prompt, ship the integration, evaluate it, and operate it in production.

## When to Use

- Adding a chat, agent, summarization, extraction, classification, RAG, or code-gen feature
- Adding tool use / function calling to an existing app
- Migrating between models (e.g. Claude Sonnet 4.5 → 4.6) or providers
- Investigating LLM-feature regressions, cost spikes, or quality drift
- Designing evals for an existing AI feature

## When NOT to Use

- Plain CRUD or frontend work with no LLM call (use code-implementation)
- Vector-search infrastructure setup that doesn't involve generation (use architect-planning)
- General prompt-engineering questions outside of building a feature (use ask)

## Phase 1 — Architect: Decide the Shape

Before any code, the architect (or plan) records these decisions in `architecture.md` (or the feature design doc):

1. **Task type:** classification / extraction / summarization / generation / chat / agent (multi-turn tool use) / RAG. The task type drives model and prompt choice.
2. **Model choice:** pick the smallest model that hits the quality bar.
    - **Haiku** — high-throughput, latency-sensitive, simple structured tasks (classification, extraction, routing).
    - **Sonnet** — default for most product features (complex extraction, summarization, agentic tool use, code review).
    - **Opus** — only when Sonnet provably underperforms on critical-path quality (deep reasoning, hard agentic loops). Document the eval result that justifies Opus.
3. **Provider & SDK:** Anthropic SDK (preferred for Claude), OpenAI SDK, AWS Bedrock, Vertex AI. Pin the SDK version.
4. **Latency / cost budget:** target P50/P95 latency and $/request. Used as a gate during eval.
5. **Failure mode:** what happens on timeout, refusal, malformed output, or a low-confidence score? Define fallback (retry / degrade / human review).
6. **Privacy / compliance:** what data leaves the user's environment? PII handling, retention, region pinning, audit logging.
7. **Versioning:** pin the model snapshot (e.g. `claude-sonnet-4-6`, not `claude-sonnet-latest`). Plan a migration path.

## Phase 2 — Code: Build the Integration

1. **Prompt structure** — system prompt (role + constraints), user prompt (task + inputs), explicit output format. Use XML tags or JSON schema for structured output.
2. **Prompt caching (Anthropic):** mark large stable prefixes (system prompt, long context, tool schemas, few-shot examples) with `cache_control: {"type": "ephemeral"}`. Aim for >70% cache hit rate on hot paths. Cache TTL is 5 minutes by default — design call patterns to stay within the window when latency matters.
3. **Tool use:** define tools with explicit JSON schemas; validate every tool call result before passing back to the model. Keep tool descriptions tight — they are part of the prompt budget.
4. **Streaming:** use streaming for any user-facing latency-sensitive surface; buffer-and-validate for structured output paths.
5. **Output validation:** parse + schema-check every model output. On failure, retry with a tightened prompt or fall back per Phase 1 decision.
6. **Idempotency & retries:** wrap calls with bounded exponential backoff for 429/529. Log the request ID for every call.
7. **Secrets:** never hardcode API keys; load from env or a secret manager. Never log full prompts containing user PII.

## Phase 3 — QA: Evaluate

Every AI feature ships with an eval suite. Treat evals as production code.

1. **Golden set (50–500 examples):** real or representative inputs paired with expected outputs (or rubric). Cover the happy path, edge cases, adversarial inputs, and known regressions.
2. **Eval mode per task type:**
    - Classification / extraction → exact match, F1, or schema-conformance.
    - Summarization / generation → LLM-as-judge with a rubric (faithfulness, completeness, tone).
    - Agent / tool use → trace-level checks (right tools called in the right order; final answer correct).
3. **Quality gate:** define pass thresholds before launch (e.g. ≥95% schema-conformance, ≥85% rubric pass, P95 latency under budget). Block deploy if gate fails.
4. **Regression suite:** every reported defect becomes a permanent eval case. Run the full suite before any prompt or model change.
5. **Cost & latency assertions:** every eval run reports total cost, P50/P95 latency, and cache hit rate. Block on regressions.

## Phase 4 — Operate: Telemetry & Drift

1. **Tracing:** log per-request input hash, model + version, prompt template version, token counts, latency, cost, cache hit rate, output (or output hash if PII), and downstream feedback (thumbs up/down, click, conversion).
2. **Online evals:** sample 1–5% of production traffic through the LLM-as-judge rubric daily. Alert on rubric pass-rate drops > X%.
3. **Drift detection:** monitor input distribution shift and output distribution shift. Bumping the model snapshot is a deploy event — re-run the full eval suite first.
4. **Cost guardrails:** per-user and per-feature budgets; circuit-breaker on cost spikes.
5. **Safety:** content-moderation pass on user input (when relevant) and on model output (when shown to users). Log refusals.

## Anti-Patterns

- Picking a model by gut feel instead of evals.
- Shipping without an eval suite ("we'll add it later" — you won't).
- Using `claude-sonnet-latest` or any unpinned alias in production — silent quality regressions.
- Stuffing the prompt with everything the model "might" need; bloats latency and cost.
- Skipping prompt caching on hot paths.
- Logging full prompts with raw PII.
- Treating prompt changes as "config" instead of versioned, reviewed deploys.

## Handoff

- **architect → plan:** include the Phase 1 decisions in `architecture.md` (task type, model, budget, failure mode, privacy).
- **plan → code:** include eval-suite creation as a first-class sprint task (not a footnote).
- **code → qa:** hand off the eval suite + telemetry dashboard URL alongside the code.
- **qa → secure:** secure reviews prompt-injection surface, output-rendering XSS risk, and PII leakage in logs.
- **secure → deploy:** deploy gates on eval pass rate AND security review.
