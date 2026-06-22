# Mermaid Diagram Rules

When creating Mermaid diagrams in architecture.md, adhere to these rules to ensure correct rendering.

## Self-Review and Validation (Mandatory)

**Whenever you add or modify a Mermaid diagram:**

1. **Self-review only** — Do not run any script or command (e.g. `python`, `validate_mermaid.py`, or any .nayan script) to validate Mermaid. Validate only by reviewing the document and checking each diagram for syntax errors. Check for common errors (see list and table in `3_architecture_validation.md`): quotes/parentheses in `[]`, reserved words, unclosed brackets, colons/special chars in labels, arrow and subgraph syntax, duplicate IDs. Fix any issues before presenting or handoff.
2. If you find syntax errors, fix them and re-check until the diagram is valid.
3. **If validation still fails after 3 fix attempts**, ask the user for confirmation: continue trying to fix, or proceed with the errors documented.
4. Do not present the architecture to the user for approval until all diagrams validate (or user has explicitly chosen to proceed with errors).
5. Do not handoff to prototype or plan until all diagrams render correctly (or user has explicitly chosen to proceed with errors).

Mermaid syntax errors must be avoided or rectified **before** user approval and **before** handoff — unless the user chooses to proceed with errors after 3 attempts.

## Syntax Rules (Avoid Parsing Errors)

- **Avoid double quotes (`"`) and parentheses `()` inside square brackets `[]`** — use single quotes or simplified text instead.
- **Reserved words**: `end`, `subgraph`, `graph` as bare labels break parsing — use `["end"]`, `["subgraph"]` or rename (e.g. `finish`, `phase`).
- **Colons (`:`) in node text** — can break parsing; use " - " or put the label in quotes e.g. `["Label: value"]`.
- **Angle brackets `<>` in labels** — escape or use words (e.g. "optional" instead of `<optional>`).
- **Unclosed brackets or quotes** — match every `[]`, `()`, `""`, `''` pair.
- **Arrow syntax** — use `-->`, `---`, `--text-->`; avoid stray `-` or `>`.
- **Subgraphs** — use `subgraph id [Label]` (label in brackets); avoid spaces in the ID; close with `end`.
- **Duplicate node IDs** — same ID with different labels can cause issues; keep IDs unique or use consistent shape/label.
- **Every diagram must have a descriptive title**
- **Use C4 diagrams** (C4Context, C4Container, C4Component) for architecture; label connections with protocol (HTTPS, REST, etc.)

## Diagram Types

- System context, container, component
- Data flow, deployment, sequence
