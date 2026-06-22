# Prototype: Brownfield Existing UI and Prototype Enhancement

**Purpose:** When the app already has UI code (brownfield extend, add-feature, or migrate with UI), prototype mode must **first** deeply understand existing UI and any existing prototype, **then** produce or update prototypes that add to or enhance the current experience. New or updated prototypes must **follow existing UI components, styles, and look-and-feel pixel by pixel** — not ignore or replace them.

**Reference:** `.nayan/rules-prototype/1_workflow.md` (step 2b, step 3) | `.nayan/guidance/ux-artifacts.md`

---

## When This Applies

- **CONTEXT: brownfield** and the solution involves UI (e.g. brownfield-extend, brownfield-add-feature, brownfield-migrate with UI).
- The codebase contains an existing UI layer (components, pages, views, styles).

---

## Flow

1. **Analyze existing UI code (before generating prototypes)**  
   Inspect the codebase and document:

    - **Structure:** Folders (e.g. `components/`, `pages/`, `views/`, `styles/`), how UI is organized.
    - **Patterns:** Reusable vs page-specific components, layout patterns, navigation.
    - **Styling:** CSS approach (modules, Tailwind, design tokens, theme); **extract exact values** — colors, spacing, typography, borders, shadows — so the prototype can match **pixel by pixel**.
    - **Design system / library:** Material, Fluent, Tailwind, shadcn, Radix, Chakra, custom, etc. — identify which one the app uses so the prototype and **production solution are based on that only**.
    - **Custom components:** Shared/reusable components (buttons, cards, modals, inputs, navigation, etc.) — prototype must reflect these so production implements by extending the same component set.
    - **Key screens and flows:** What exists today so the new prototype can extend or align.
    - **Pixel-level specs:** From components and styles, capture exact dimensions, font sizes, line heights, margins, padding, and color tokens to replicate in the prototype.

2. **If an old prototype exists**  
   Check `ux/prototypes/`, `prototypes/`, or paths from architecture/scope. For that prototype:

    - What screens and flows it covers.
    - What to **extend** or **refine** (new screens, improved flows, new features).
    - Use it as the **baseline** for enhancement rather than starting from scratch where it remains valid.

3. **Generate or update prototype**
    - **Follow existing UI components, styles, and look-and-feel pixel by pixel.** Reuse or replicate the same component structure, colors, spacing, typography, and visual details from the codebase.
    - **Production solution based on existing stack only:** When the app uses a **design library** (e.g. Material, Fluent, shadcn, Tailwind) or **custom components**, the prototype must consider the production solution based on **that only** — prototype should use or replicate that design lib and those custom component patterns so the development plan and code implement using the same stack (no unrelated lib or generic components).
    - **Add to or enhance** existing UI features within that visual system; do not introduce new visual language or a different component stack unless the scope explicitly requests it.
    - If an old prototype exists: **enhance it** (extend screens, refine flows, add features) instead of replacing it entirely, keeping pixel-level consistency with existing UI.

---

## Output Expectation

- New or updated prototype **matches existing UI components, styles, and look-and-feel pixel by pixel** (exact colors, spacing, typography, component structure from the codebase).
- **Production solution aligned:** When a design library or custom components are in use, the prototype is based on **that only** — so the development plan and code can implement using the same design lib and component set; no different lib or generic components.
- Enhancement is **explicit**: document what was added or changed relative to existing UI or existing prototype.
- For **migration** (brownfield-migrate): align prototype to target architecture while matching legacy UI pixel-by-pixel where continuity is required.
