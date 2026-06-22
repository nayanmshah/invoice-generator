# Prototype Figma Matching

**Purpose:** When the user provides a Figma design (or screenshots/mockups) in PRD Section 12 or condensed scope, prototype mode must generate HTML prototypes that match the design pixel-by-pixel. Figma (or the provided design) is the source of truth — skip design discovery for aesthetic choices and replicate exact specs.

**Reference:** `.nayan/rules-prototype/1_workflow.md` | `.nayan/guidance/ux-artifacts.md`

---

## When This Applies

- PRD Section 12 (Design Assets) contains a Figma link, Locofy link, or reference to shared screenshots/mockups
- Condensed scope (brownfield) specifies design assets
- User explicitly provides Figma or design mockups during prototype phase

---

## Workflow

1. **Check for design source** — Read PRD Section 12 or scope for Figma link, Locofy link, or attached screenshots/mockups.
2. **Skip design discovery** — Do not ask aesthetic, theme, colors, or typography questions. The design is the source of truth.
3. **Extract design specs** — Use available tools or manual inspection:
    - **Figma MCP** (when authenticated): Fetch design specs, node structure, styles.
    - **Locofy MCP**: Use `getLatestComponentAndDependencyCode` or `getLatestFileCode` when Figma is synced — adapt output for HTML prototype.
    - **Fallback**: User provides Dev Mode specs, design token export, or screenshots with measurements. Inspect Figma link manually if accessible.
4. **Apply to HTML prototype** — Use exact values (no approximation). See Design Tokens below.
5. **Self-verify** — Compare prototype against Figma/design; confirm no visual drift.

---

## Design Tokens to Extract

| Token          | Extract From                           | Apply As                                                                |
| -------------- | -------------------------------------- | ----------------------------------------------------------------------- |
| **Colors**     | Fill, stroke, background               | Hex/rgb in CSS variables or inline                                      |
| **Typography** | Font family, size, weight, line-height | `font-family`, `font-size`, `font-weight`, `line-height`                |
| **Spacing**    | Padding, margin, gap                   | `padding`, `margin`, `gap` in px or rem                                 |
| **Layout**     | Flex/grid, alignment                   | `display`, `flex-direction`, `align-items`, `justify-content`, `grid-*` |
| **Borders**    | Radius, width, color                   | `border-radius`, `border-width`, `border-color`                         |
| **Shadows**    | Box shadow                             | `box-shadow`                                                            |

**Output format:** Use CSS variables (e.g. `--color-primary`, `--spacing-md`) or inline styles with exact px/rem values. Do not approximate.

---

## Fallback When MCP Unavailable

When Figma MCP or Locofy is not available:

1. Ask user to share Figma Dev Mode specs (Copy as CSS) or design token export.
2. If user provides screenshots only: Extract layout, spacing, and approximate colors from the image; document that design fidelity is approximate.
3. Provide link to Figma file and instruct user to open for side-by-side comparison during review.

---

## Integration

- **Workflow:** Prototype mode step 2a skips design discovery when Figma/design is provided. Step 3 requires pixel-by-pixel matching.
- **Self-verification:** Add todo `Verify: prototype matches Figma design pixel-by-pixel (colors, typography, spacing, layout)` when design source is present.
