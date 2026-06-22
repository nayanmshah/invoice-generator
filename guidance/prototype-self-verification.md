# Prototype Self-Verification

Before asking "Do you approve this UX and UI design?" (HITL), run a **self-verification** against PRD (or condensed scope) and architecture. Use a **granular todo list** — one todo per verification point — and verify each item one by one. Do not proceed to HITL until all todos pass.

## MANDATORY: Granular Todo List

Use `todo_write` to create one todo per verification point. Verify each todo one by one; mark complete only when verified. This ensures no feature, use case, or PRD/architecture point is missed.

## Todo Categories (one todo per item)

### 1. PRD / Scope coverage

- **One todo per use case** (PRD Section 7) or capability (functional scope):  
  `Verify UC-X: [use case name] — screens exist, responsive, integrated, flow works`
- **One todo per PRD point** with UI implications (Section 5 personas, Section 12 UI/UX, acceptance criteria):  
  `Verify PRD point: [description]`

### 2. Architecture coverage

- **One todo per UI-relevant architecture element** (modules with UI, containers, components):  
  `Verify architecture: [element] — reflected in prototype`

### 3. Per-screen verification (for each screen in each persona prototype)

- `Verify screen [screen name] in [persona]: exists`
- `Verify screen [screen name] in [persona]: responsive`
- `Verify screen [screen name] in [persona]: integrated (navigable from/to)`
- `Verify screen [screen name] in [persona]: works as desired`

### 4. Quality rules

- `Verify: no alert() — in-page feedback only`
- `Verify: no TODO/TBD/placeholder`
- `Verify: one web responsive to all devices`
- `Verify: all screens integrated`
- `Verify: design discovery choices (theme, colors, brand) applied consistently across all persona prototypes`
- **When Figma or design assets provided:** `Verify: prototype matches Figma design pixel-by-pixel (colors, typography, spacing, layout)`
- **When brownfield and existing app has UI:** `Verify: prototype matches existing UI components, styles, and look-and-feel pixel by pixel (colors, spacing, typography, component structure from codebase)`

## Protocol

1. **Inputs:** refined-prd.md (greenfield) or condensed scope (brownfield), architecture.md, prototype paths
2. **Create todo list:** Build granular todo list from PRD/scope and architecture (see structure above)
3. **Verify one by one:** For each todo, perform the verification; mark complete only when verified
4. **If gap found:** Fix prototype; add new todo for the fix if needed; re-verify
5. **Output:** All todos complete → proceed to HITL; any todo fails → fix and re-run
6. **Reference:** [ux-artifacts.md](ux-artifacts.md) Prototype Quality Rules and Pre-Handoff Checklist

## Per-Todo Verification Actions

| Todo type               | Verification action                                                                                                                                                                    |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Use case / capability   | List required screens; verify each exists; verify responsive, integrated, flow works end-to-end                                                                                        |
| PRD point               | Check prototype reflects the requirement                                                                                                                                               |
| Architecture element    | Check prototype structure/flow aligns with architecture                                                                                                                                |
| Screen exists           | Confirm file/section exists in persona prototype                                                                                                                                       |
| Screen responsive       | Check CSS media queries, layout at breakpoints (e.g., 320px, 768px, 1024px)                                                                                                            |
| Screen integrated       | Verify navigation to/from screen; no dead ends                                                                                                                                         |
| Screen works as desired | Simulate user path; confirm flow completes                                                                                                                                             |
| No alert()              | Grep for alert/confirm/prompt; must use in-page feedback                                                                                                                               |
| No TODO/TBD/placeholder | Grep for TODO, TBD, placeholder; must use realistic content                                                                                                                            |
| One web responsive      | Single prototype per persona; no separate mobile/desktop versions                                                                                                                      |
| All screens integrated  | All screens navigable from within prototype                                                                                                                                            |
| Design consistency      | Same theme, colors, palette, brand across all persona prototypes; no persona-specific theme                                                                                            |
| Figma pixel match       | When Figma/design provided: Compare prototype against Figma; confirm no visual drift (colors, typography, spacing, layout)                                                             |
| Brownfield existing UI  | When brownfield + existing app has UI: Compare prototype to existing codebase; confirm components, styles, look-and-feel match pixel by pixel (colors, spacing, typography, structure) |

## Exception

If the user explicitly says to skip self-verification for the current session, proceed directly to HITL.
