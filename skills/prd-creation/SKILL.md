---
name: prd-creation
description: Provides comprehensive PRD methodology for both creating PRDs from scratch and refining for MVP scope. Includes domain discovery, holistic feature mandate, critical path journey, and complete PRD structure per prd-template-v2.
modeSlugs:
    - prd
---

# PRD Creation Methodology

See sdlc_human_gates rule for PRD sign-off gate. See `.nayan/skills/prd-standards/SKILL.md` for canonical structure. Output must follow `.nayan/guidance/prd-template-v2.md` (15 sections) only.

## Part A: PRD Architecture (Creating from Scratch)

Use when creating comprehensive PRDs from draft ideas.

### Clarity Through Questions (Apply Throughout)

**When the PRD needs more details to get clarity**, ask additional questions in PRD mode. Do not assume, guess, or fill with placeholders — ask the user. Stay in PRD mode and clarify with the user before proceeding. Apply to both initial PRD and refined PRD.

**Ask one question at a time** — do NOT batch multiple questions in a single message. Wait for the user's answer before asking the next. This keeps the conversation focused and makes it easier for the user to respond clearly. Only after receiving an answer, ask the next question. Cover use cases and every section. Examples by area:

- **Problem (§2):** Who exactly has this problem? How do they experience it today? What workarounds exist?
- **KPIs & Business (§3):** What is the baseline? How will impact be measured? Why now?
- **Success Criteria (§4):** What does "done" look like? What metrics prove it works?
- **Users & Personas (§5):** Who are the primary users? What are their goals? Any secondary users?
- **Scope (§6):** What is explicitly IN vs OUT? What is deferred?
- **Use Cases (§7):** For each use case: What are the exact steps? What is the acceptance criterion? Any edge cases? Validation rules? State transitions?
- **Data & Entities (§8):** What entities exist? Key fields? Relationships? Privacy/sensitivity?
- **Integrations (§9):** What external systems? APIs? Data flows?
- **Error Handling (§10):** What errors can occur? How should they be handled?
- **Non-Functional (§11):** Performance targets? Availability? Security? Accessibility?
- **UI/UX (§12):** When UI is in scope, **mandatory** to ask and document in Section 12: visual depth/surface style (flat, skeuomorphic, neumorphism, glassmorphism), theme (light/dark/system), responsive strategy, design system/component library, material types (2D, 3D, animation, video, immersive). If user defers, document "TBD" or "To be decided in prototype." Key screens? Interaction patterns? Design references? **Design assets for prototype:** Do you want to share any screenshots or UI mockups (e.g., Figma link, sketches, wireframes) that can be used in the prototype phase? If yes, share the link or attach them now so they can be referenced in Section 12.
- **Constraints (§13):** Technical limits? Dependencies? Deadlines? **Sprint cadence / week of work:** What is the sprint cadence or week of work for MVP? (e.g., 2-week vs 3-week sprint)
- **Open Questions (§14):** What is still unresolved? Impact if not answered?

Continue asking until you have enough clarity to fill each section accurately. Prefer multiple rounds of questions over filling with assumptions. **One question per turn** — never mix role, compliance, integrations, edge cases, or other topics in a single block of questions.

### Minimal Input: Switch to Brainstorm Mode

**When the user asks to create a PRD with minimal details** (e.g., a one-line idea, a vague concept, or "I want to build X" without context), **do NOT proceed to initial PRD**. **Force switch to brainstorm mode** — use new_task or delegation to hand off to brainstorm mode so the user can explore and flesh out the idea there. Brainstorm mode structures raw ideas; when ready, it hands off to prd for PRD creation.

**Note:** The orchestrator should delegate to brainstorm (not prd) when the user provides minimal details for greenfield — that way PRD mode and this skill never load unnecessarily. This "switch to brainstorm" is a **fallback** for when prd is reached directly (e.g., user invoked PRD mode explicitly) despite minimal details.

### Domain Discovery Protocol (when context is low)

When the user's idea is vague or domain-specific terminology is unclear:

1. Research the domain (industry terms, similar products, standards)
2. Draft a Domain Context Brief: key terms, entities, business rules
3. Present findings to the user for validation before proceeding
4. Save validated brief as `domain-context.md` when proceeding

### Process

0. **Assess context sufficiency** — if user provided minimal details, **switch to brainstorm mode** (do not proceed in PRD); if terminology is unclear or scope is vague, run Domain Discovery Protocol
1. If low-context: execute Domain Discovery Protocol and present findings for user validation
2. Deconstruct the draft to identify all requested capabilities, both explicit and implied
3. Enrich each capability using the Holistic Feature Mandate (CRUD+L)
4. Map out data entities required to power all requested features
5. Specify complete lifecycle operations for each entity
6. Perform complexity assessment of the full proposed scope
7. Identify functional ambiguities and formulate precise clarification questions — **ask the user**; do not proceed with assumptions
8. **Before authoring:** Ensure you have asked questions for each section and use case per "Clarity Through Questions" above. Fill only when clarity is sufficient.
9. Author the final, complete PRD markdown file (initial-prd.md)

### Holistic Feature Mandate

CRITICAL: Never define a feature partially. If a user can CREATE something, automatically include Read/View, Update/Edit, Delete/Remove, and List/Search.

### Output

Generate complete PRD as `initial-prd.md`. When Domain Discovery was performed, also save Domain Context Brief to `domain-context.md`.

**Sign-Off:** Ask "Which role are you? (PM, Engineering Lead, or Design)" and fill Sign-Off **only after** the user has confirmed the PRD content is good and approved. Do not ask for sign-off before presenting and getting content approval. Do NOT assume or default to PM. Keep all roles Pending until the user identifies their role; then fill only that role. Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off.

**Before presenting to user:** Run `.nayan/guidance/prd-gap-validation.md` — verify all 15 sections present, no gaps. Fix any failures before handoff.

---

## Part B: PRD Refinement (MVP Scoping)

Use when refining an existing PRD for MVP scope.

**When the refined PRD needs more details to get clarity** (gaps, ambiguities, incomplete use cases), ask additional questions in PRD mode. **Ask one question at a time** — do NOT batch multiple questions. Do not assume — clarify with the user before filling or refining.

### Critical: Enhance, Do Not Remove

- **Preserve** content that downstream modes need
- **Scope** by deferring features, not by stripping sections
- **Maintain template structure** — refined PRD must follow same §1–§15 structure as initial-prd.md

### Process

1. Read `initial-prd.md` and `domain-context.md` (if present)
2. Deconstruct to identify all documented capabilities
3. Enrich each using Holistic Feature Mandate
4. Pinpoint the single "Critical Path Journey" for MVP
5. Segregate capabilities into "Core MVP" and "Deferred"
6. Articulate rationale for every deferred capability
7. Map data entities for Core MVP
8. Refine Use Cases (§7) and acceptance criteria for Core MVP; mark deferred use cases
9. Preserve Problem Statement, KPIs, Success Criteria, Domain Glossary
10. Perform complexity assessment for MVP scope
11. Author final refined PRD as `refined-prd.md`

### Guiding Principles

- **Critical Path Journey**: Single most important user journey that proves core value
- **Sprint-Sized Scope**: MVP must be buildable in a 2-week sprint
- **Ruthless Prioritization**: Every feature → Core MVP or Deferred
- **Justify Every Deferral**: Provide concise reason for each deferred feature

### Output

Generate complete refined PRD as `refined-prd.md`. Conclude with: "PRD Complete - Ready for architect mode (architecture) and prototype (when UI)."

**Sign-Off:** Ask "Which role are you? (PM, Engineering Lead, or Design)" and fill Sign-Off **only after** the user has confirmed the PRD content is good and approved. Do not ask for sign-off before presenting and getting content approval. Do NOT assume or default to PM. Keep all roles Pending until the user identifies their role; then fill only that role. Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off.

**Before presenting to user and handoff to architect:** Run `.nayan/guidance/prd-gap-validation.md` — verify all 15 sections present, Sign-Off complete, architect-required sections (7, 8, 11, 15) sufficient, no gaps. Fix any failures before handoff. Do not handoff to architect until gap validation passes.
