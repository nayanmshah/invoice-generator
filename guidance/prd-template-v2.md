# PRD Template v2 (Canonical Format)

**Purpose:** This is the canonical PRD format for Nayan. All PRDs must be generated in this structure. Fill in what you know about the problem, users, and expected behavior. The AI will generate technical specifications, architecture, and code.

**Gap validation:** Before handoff, run `.nayan/guidance/prd-gap-validation.md` to verify all 15 sections present and no gaps.

**Reference:** Based on `/Users/rpatil/Downloads/prd-template-v2.md`

---

## 1. Basic Information

**Help:** Provide the essential metadata for this PRD. Priority should reflect business urgency (P0 = critical/blocking, P1 = high, P2 = normal).

| Field          | Value        |
| :------------- | :----------- |
| Project Name   |              |
| Priority       | P0 / P1 / P2 |
| Target Release |              |

### Create

**Help:** Document creation metadata. Two create names: (1) **Nayan** — "Nayan" when AI created the document; (2) **User Name** — Logged-in user who created using Nayan (from `environment_details` section "Nayan Logged-in User"). **Create Date:** YYYY-MM-DD.

| Nayan | User Name | Create Date |
| :----- | :-------- | :---------- |
|        |           |             |

### Sign-Off

**Help:** This formalizes the review and alignment process. **One user = one role.** Creator approves for their role only; other roles stay Pending until a different person in that role approves. Each role is approved independently by a different approver. Share PRD with Engineering Lead and Design for their approvals. Engineering sign-off is required during Q-60 planning and estimation. All parties should confirm they have reviewed and understood the requirements before development begins.

**Approver Name:** Per SDLC human gates — use the Nayan logged-in user from `environment_details` (section "Nayan Logged-in User") when the user approves for a role. See `.nayan/guidance/sdlc-human-gates.md`.

**MANDATORY before filling Sign-Off:** Ask the user "Which role are you? (PM, Engineering Lead, or Design)" — do NOT assume or default to PM. Fill only the role the user identifies. Other roles stay Pending. **Do this only after the user has approved the PRD content.** Sign-off is the last step before handoff. Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off.

**Nayan gate:** PRD will NOT be accepted by architect until:

- All three roles (PM, Engineering Lead, Design) have Status = "Approved"
- Each Approved role has **Approver Name** and **Sign-Off Date** filled
- Pending or Needs Revision blocks handoff

| Role             | Approver Name | Sign-Off Date | Status (Pending / Approved / Needs Revision) |
| :--------------- | :------------ | :------------ | :------------------------------------------- |
| PM               |               |               |                                              |
| Engineering Lead |               |               |                                              |
| Design           |               |               |                                              |

---

## 2. Problem Statement

**Help:** Focus on the customer/user problem — what's broken, who feels the pain, and how they experience it today. Keep this section about the problem itself, not the business case (that belongs in Section 3).

### What problem are we solving?

### Who has this problem?

### How do they experience this problem today?

---

## 3. KPIs & Business Justification

**Help:** This section justifies why this project deserves investment. Every PRD must demonstrate measurable business value — revenue impact, cost savings, retention improvement, or strategic enablement. If you cannot articulate the KPIs, the project should not move forward. This is different from success criteria (Section 4), which defines how we know the feature works correctly once built. Example distinction: KPI = "increase order conversion by 5%." Success criterion = "checkout completes in under 3 seconds with zero data loss."

### Key Performance Indicators

| KPI | Current Baseline | Expected Impact | How Measured | Timeline to Impact |
| :-- | :--------------- | :-------------- | :----------- | :----------------- |
|     |                  |                 |              |                    |
|     |                  |                 |              |                    |

### Revenue / Business Impact

- Estimated revenue impact (new revenue, retained revenue, or cost savings):
- Customer segments affected:
- Strategic alignment (which company objective does this support?):

### Why is this essential now?

- What happens if we delay or don't do this?
- Are there competitive, contractual, or regulatory drivers?

---

## 4. Success Criteria

**Help:** Define what "done" looks like from a functional and quality standpoint. These are the measurable thresholds that confirm the feature works as intended — not the business outcomes (those belong in Section 3). Example: "All orders sync to ERP within 30 seconds" or "Form submission succeeds with all required fields validated."

### How will we measure success?

| Metric | Current State | Target | How Measured |
| :----- | :------------ | :----- | :----------- |
|        |               |        |              |
|        |               |        |              |

### What does "done" look like?

---

## 5. Users & Personas

**Help:** Identify who will use this feature. Use the organization's published persona list for User Type values to ensure consistency across PRDs and alignment with engineering. If a new persona is needed, flag it for addition to the master list.

| User Type | Description | Primary Goal |
| :-------- | :---------- | :----------- |
|           |             |              |
|           |             |              |

### User Context

---

## 6. Scope

**Help:** Draw a clear boundary around what is and isn't included in this effort. This prevents scope creep and sets expectations with stakeholders and engineering.

### What's IN scope (MVP)?

### What's OUT of scope?

---

## 7. Use Cases

**Help:** Each use case should be self-contained and specific enough for engineering to implement without interpretation. Include only the sub-sections that apply to each use case. For simpler features, delete the sub-sections that don't apply rather than leaving them blank — not every use case needs calculation logic or state transitions.

**Nayan traceability:** For pipeline compatibility, each Use Case may include optional identifiers (e.g., US-001, FR-001) for plan and development-plan traceability. Use Case names serve as the primary identifier when identifiers are omitted.

**Specificity checklist (include where applicable):**

- **Business rules & conditions** — Exact logic, success/failure criteria, fallback behavior. (e.g., don't say "implement 2FA" — specify "implement MFA for login using OTP via SMS as a second authentication method")
- **Validation rules** — Mandatory vs. optional fields, allowed values, error messages when invalid
- **Calculation logic** — Inputs, formulas, rounding rules, min/max, edge cases (e.g., split case pricing: conversion, proration, overrides, min order rules)
- **State transitions** — If the entity moves through states, define current state → trigger → new state

_Note: Data & entity information is documented in Section 8 (feature-wide). Integration scope is documented in Section 9._

---

### Use Case 1: [Name]

**As a** [user type — use published persona] **I want to** [action] **So that** [benefit]

**Steps:**

1. User does:
    - System responds:
2. User does:
    - System responds:
3. User does:
    - System responds:

**Acceptance Criteria:**

**Business Rules & Logic** _(if applicable)_

**Validation Rules** _(if applicable)_

| Field | Valid Values | Error if Invalid |
| :---- | :----------- | :--------------- |
|       |              |                  |

**Calculation Logic** _(if applicable)_

**State Transitions** _(if applicable)_

| Current State | Trigger | New State |
| :------------ | :------ | :-------- |
|               |         |           |

---

### Use Case 2: [Name]

**As a** [user type — use published persona] **I want to** [action] **So that** [benefit]

**Steps:**

1. User does:
    - System responds:
2. User does:
    - System responds:

**Acceptance Criteria:**

**Business Rules & Logic** _(if applicable)_

**Validation Rules** _(if applicable)_

| Field | Valid Values | Error if Invalid |
| :---- | :----------- | :--------------- |
|       |              |                  |

**Calculation Logic** _(if applicable)_

**State Transitions** _(if applicable)_

| Current State | Trigger | New State |
| :------------ | :------ | :-------- |
|               |         |           |

---

_(Copy the use case block above for additional use cases)_

---

## 8. Data, Entities & Information

**Help:** This section captures feature-wide data concerns tied to the business entities involved (e.g., Contract, Order, Product, User, Invoice). Document what entities are touched, what data flows through the system, where it comes from, and how it must be protected. The depth should match the complexity of the feature: for simple features a brief summary is enough; for anything involving PII or third-party data sharing, be detailed.

### Entities Involved

List the core business entities this feature creates, reads, updates, or deletes. For each entity, note which fields are affected and any relationships between entities.

| Entity | Action (Create / Read / Update / Delete) | Key Fields Affected | Related Entities |
| :----- | :--------------------------------------- | :------------------ | :--------------- |
|        |                                          |                     |                  |
|        |                                          |                     |                  |

### Data Elements

| Data Element | Entity | Source                         | Required? | Default | Example Value |
| :----------- | :----- | :----------------------------- | :-------- | :------ | :------------ |
|              |        | User input / System / External | Yes/No    |         |               |

### What information is created/stored?

| Data Element | Entity | Description | Retention |
| :----------- | :----- | :---------- | :-------- |
|              |        |             |           |

### Privacy & Sensitivity

**Help:** Document what data is sensitive, who can access it, how it must be stored/transmitted, what should/shouldn't be logged, masking rules, retention rules, and compliance considerations (e.g., GDPR, SOC 2, HIPAA). Security and compliance teams will use this section as a single reference point for review.

---

## 9. Integrations

**Help:** Document all external and internal system integrations required for this feature. Specify enough detail so engineering does not have to guess at interface type, data format, or error handling approach.

### External Systems

| System | Purpose | Direction                 | Interface Type          | Format | Error Handling |
| :----- | :------ | :------------------------ | :---------------------- | :----- | :------------- |
|        |         | Inbound / Outbound / Both | API / File Feed / Event |        |                |

### Internal Systems

| System | Interaction |
| :----- | :---------- |
|        |             |

---

## 10. Error Handling & Edge Cases

**Help:** Cover system-level failures, timeouts, downstream service errors, and unexpected edge cases. Note: field-level input validation (e.g., invalid email format, required fields) belongs in the validation rules within each use case in Section 7. This section is for broader system behavior — what happens when an API is down, a job times out, data is partially written, or a user hits an unexpected state.

### Expected Errors

| Scenario | Expected Behavior | User Message |
| :------- | :---------------- | :----------- |
|          |                   |              |

### Edge Cases

| Scenario | Expected Behavior |
| :------- | :---------------- |
|          |                   |

---

## 11. Non-Functional Expectations

**Help:** Define performance, availability, security, accessibility, and platform requirements. These set the quality bar engineering must meet beyond functional correctness.

### Performance

- Response time expectation:
- Expected concurrent users:
- Data volume:

### Availability

- Follows standard contractual SLAs: Yes / No
- If No, specify exceptions and justification (e.g., a payment processing flow may need higher uptime than a reporting dashboard):

### Security

- Authentication required: Yes / No
- Authorization/roles:
- Compliance requirements:

### Accessibility

- WCAG level required:
- Specific needs:

### Platform Support

- Browsers:
- Devices:
- OS:

---

## 12. UI/UX Requirements

**Help:** Link to design assets and describe key interaction patterns. The Figma link is required and should be source-controlled. Include Locofy output if available. If the user shared screenshots or mockups during PRD drafting, reference them here.

### Design Assets

- Figma/Design link:
- Locofy link (if applicable):
- Brand guidelines:

### Visual Depth / Surface Style (as applicable)

- Flat / Skeuomorphic / Neumorphism / Glassmorphism:
- Design system alignment (Material, Fluent, HIG, custom):

### Theme and Responsive

- Theme: Light / Dark / System; High contrast? Reduced motion?
- Responsive: Breakpoints; Mobile-first vs desktop-first; Adaptive vs responsive:

### Design System / Component Library (as applicable)

- Design system (Material, Fluent, Bootstrap, Tailwind, custom):
- Component library (shadcn, Radix, Chakra, none):
- Custom vs off-the-shelf components:

### Material Types (as applicable)

- 2D / 3D / Animation / Video / Immersive (check all that apply):
- Design direction (aesthetic, references, constraints):

### Key UI Elements

### Interaction Patterns

---

## 13. Constraints & Dependencies (if applicable)

**Help:** Keep this lightweight — just the dependency name, type, and current status. Detailed operational tracking should live in JPDs/Epics. Include this when a feature is blocked by or blocks another team's API, a third-party integration, or other work that impacts planning, timelines, or sequencing.

### Constraints

- Sprint cadence / week of work (when known): e.g., 2-week sprint, 3-week sprint — affects MVP sizing and development plan.

### Dependencies

| Dependency | Type                         | Status |
| :--------- | :--------------------------- | :----- |
|            | Blocks this work / Needed by |        |

---

## 14. Open Questions (if applicable)

**Help:** Signal what the PM has considered but does not yet have answers to. The "Impact if Unresolved" column helps prioritize which questions need answers before work begins versus which can be figured out during development.

| Question | Impact if Unresolved |
| :------- | :------------------- |
|          |                      |

---

## 15. Appendix (Optional)

**Help:** Include any supporting material — glossary of domain terms, reference documents, prior research, or links to related PRDs. The glossary is especially important for features touching contracts, pricing, or compliance. Define any domain-specific terms that engineering may not be familiar with (e.g., Allowances, FOB, split case pricing, proration, rebate types). Ambiguous terminology is a common source of misaligned implementation.

### Glossary (Domain Glossary)

**Nayan:** Architect and plan use this glossary for module/entity naming. Ask user for key domain terms; use consistent terms throughout the PRD. See `.nayan/guidance/domain-knowledge.md`.

| Term | Definition |
| :--- | :--------- |
|      |            |

### References
