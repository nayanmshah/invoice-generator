# Condensed Scope Template (Brownfield A)

Use when extending an existing product. The architect mode uses this to extend architecture.md. **Orchestrator or user** should provide this when delegating to architect for Brownfield A.

---

## Required Sections

### Create

**Help:** Document creation metadata. Two create names: Nayan (AI) and User Name (logged-in user who created using Nayan, from `environment_details`).

| Nayan | User Name | Create Date |
| :----- | :-------- | :---------- |
|        |           |             |

---

### 1. Feature / Extension Summary

Brief description of what is being added or extended.

- **What:** [e.g., Add product search to existing catalog]
- **Why:** [e.g., Users need to find products by name]
- **Scope:** [e.g., Search API, search UI, no new entities]

### 2. Key Domain Terms

Domain terminology for consistency with existing architecture and naming.

- [Term 1]: [Definition]
- [Term 2]: [Definition]

**Required before handoff to Architect:** Key domain terms (Section 2) must be filled. If user did not provide, ask before delegating. Architect uses these; does not re-ask.

### 3. Functional Scope

What capabilities the extension provides. Can be structured as use cases or bullet list.

- [Capability 1]
- [Capability 2]
- [Capability 3]

### 3a. Users/Personas Affected (Optional — when UI involved)

When the extension adds or modifies UI, list which user types/personas are affected. Helps prototype mode infer personas when creating UX artifacts.

- [User type / Persona 1]: [How they are affected]
- [User type / Persona 2]: [How they are affected]

_If omitted, prototype infers from functional scope ("As a [user]..."), feature description, or architecture._

### 4. Integration Points & Impacted Integrations

How the new work connects to existing modules, APIs, data. **Which existing integrations are impacted** by this change?

- **Existing modules to extend:** [e.g., Product API, Catalog UI]
- **Existing APIs to modify:** [e.g., GET /api/products — add ?q= param]
- **Data sources:** [e.g., Product table; add full-text index]

### 5. Out of Scope

What is explicitly excluded.

- [Excluded item 1]
- [Excluded item 2]

### 6. Constraints (Optional)

When the extension has technical constraints, list them. Architecture will map each to an architectural decision (Section 19 in architecture-brownfield-structure.md).

| Constraint | Description |
| :--------- | :---------- |
|            |             |

### 7. Open Questions (Optional)

When scope has unresolved questions that affect architecture. Architecture will resolve, defer, or escalate each (Section 18 in architecture-brownfield-structure.md).

| Question | Impact if unresolved |
| :------- | :------------------- |
|          |                      |

### 8. References

- **architecture.md:** [path or confirm architect has access]
- **Codebase:** [repo path or confirm architect has access]

---

## Minimal Viable Scope

If user provides only a brief description, the plan mode should ask for:

1. Feature description (what, why)
2. Key domain terms
3. Integration points (which existing modules/APIs are affected)

Do not proceed with architecture extension until scope is sufficient to design new/modified modules and APIs.
