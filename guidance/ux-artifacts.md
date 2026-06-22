# UX Artifacts

Prototype mode produces UX artifacts that inform development planning and implementation.

**Once the user explicitly approves the prototype, it becomes the authoritative source for UI design and final look-and-feel** in the development plan and development (code) phase. Code mode implements UI to match the approved prototype for layout, components, and look-and-feel **using the tech stack documented in architecture.md (by architect)** (e.g., Next.js, Angular, React).

## Required Artifacts (when UI is involved)

| Artifact                                     | Purpose                                                                                                                                                                                                 | Format                                                                               |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| **Interactive HTML prototype (per persona)** | **Primary deliverable.** One prototype per persona. Each prototype exactly mimics that persona's views/pages after login. All views/pages that persona can access (from use cases or functional scope). | `.html` file(s) per persona in `ux/prototypes/{persona}/` or `prototypes/{persona}/` |
| **Wireframes**                               | Screen layout, component placement, key UI elements                                                                                                                                                     | Mermaid diagrams, markdown with ASCII, or links to Figma/Figma-like tools            |
| **Interaction flows**                        | User flows, navigation, state transitions                                                                                                                                                               | Mermaid flowcharts, sequence diagrams                                                |
| **Visual design prototypes**                 | As needed to validate user experience                                                                                                                                                                   | Descriptions, style tokens, or links to design tools                                 |

## Persona-Specific Prototypes (MANDATORY)

**One prototype per persona.** Prototypes must exactly mimic the different views/pages each persona sees. Do not create a single generic prototype when multiple personas have distinct UIs.

| Personas (example)   | Prototypes Required | Views/Pages to Mimic                                                                               |
| -------------------- | ------------------- | -------------------------------------------------------------------------------------------------- |
| Persona A, Persona B | 2 prototypes        | Each: login (or entry) + all screens from use cases (greenfield) or functional scope (brownfield). |
| Single persona       | 1 prototype         | All views for that persona.                                                                        |

**Rules:**

- Extract personas from PRD Section 5 (Users & Personas) (greenfield) or condensed scope (brownfield); infer from functional scope when not explicit
- Create one HTML prototype per persona with that persona's full view set
- Each persona's prototype: login (or entry) + all pages/views that persona can access
- Location: `ux/prototypes/{persona}/` or `prototypes/{persona}/`

## Prototype Quality Rules (MANDATORY)

- **All screens:** Derive the complete screen list from **greenfield:** PRD Section 7 (Use Cases — every step with UI), Section 5 (Personas), acceptance criteria, and architecture; **brownfield:** condensed scope (functional scope), feature spec, and architecture. **When existing app has UI:** First analyze existing UI and any existing prototype per `.nayan/guidance/prototype-brownfield-existing-ui.md`; then produce prototype that adds to or enhances existing UI (or existing prototype) and **matches existing UI components, styles, and look-and-feel pixel by pixel**. Include: login/entry (or first screen for public apps), every view/page each persona can access, all modals/dialogs, success/error/confirmation states, empty states, loading states. **Every use case step with a UI surface must have a corresponding screen.** No partial prototypes.
- **No temp/todo/placeholder content:**
    - **No `alert()`** — Use in-page feedback: toast notifications, success modals, confirmation screens, inline messages.
    - **No placeholder images** — Use representative content (e.g., static map SVG, chart placeholder with real structure, or domain-appropriate illustration). No `via.placeholder.com` or "Image placeholder" text.
    - **No "TODO", "TBD", "Coming soon"** — Use realistic mock data or representative content.
    - **No placeholder screens** — Every action (submit, approve, reject) must show an actual result screen or in-page feedback, not an alert.
- **Fully functional:** Prototypes must be interactive (clickable navigation, form inputs, buttons, modals). Users can simulate key flows without backend. All links and actions lead to real screens or in-page feedback.
- **One web, responsive to all devices:** One prototype per persona (single web app) that adapts to all device sizes. Use CSS media queries; layout, navigation, and content reflow for mobile, tablet, desktop. Verify at key breakpoints (e.g., 320px, 768px, 1024px). Not separate mobile/desktop versions — one responsive web. Document breakpoints used.
- **Integrated screens:** All screens must be navigable from within the prototype. Nav links, tabs, buttons, and actions lead to the correct screens. User can complete full use case flows without dead ends. No isolated or disconnected screens.

## Interactive HTML Prototype Requirements

- **Persona-specific:** One prototype per persona; each mimics that persona's exact views
- **Complete screen coverage:** One prototype per persona. Each prototype includes login/entry (or first screen for public apps) + **every screen** that persona can access per use cases (greenfield) or functional scope (brownfield) and architecture. Include empty states, loading states, success/error/confirmation states. **Every use case step with a UI must map to a screen.** No screens omitted.
- **In-page feedback only:** Success, error, and confirmation states must be shown as in-page elements (toast, modal, inline message, or dedicated confirmation screen). Do not use `alert()`, `confirm()`, or `prompt()`.
- **Representative content:** Use realistic mock data. No "TBD", "TODO", "Coming soon", or placeholder image URLs. For maps/charts, use static SVG, CSS-based representation, or domain-appropriate mock.
- **Fully functional:** All navigation, forms, and actions work within the prototype (client-side only). No dead links or non-functional buttons.
- **One web, responsive to all devices:** Single prototype per persona that adapts to mobile, tablet, desktop. Use CSS media queries; layout reflows for all screen sizes. One responsive web — not separate device versions.
- **Integrated screens:** All screens must be wired together. Navigation, links, and actions flow from one screen to another. User can traverse the full flow; no isolated or disconnected screens.
- **Self-contained:** Single HTML file or minimal set (HTML + CSS; optional vanilla JS) that users can open in a browser
- **Location:** Save to project (e.g., `ux/prototypes/{persona}/` or `prototypes/{persona}/`) so user can open each persona's prototype
- **Open in browser when ready:** Once prototypes are created, open each in the default browser for review (e.g., `open ux/prototypes/{persona}/index.html` on macOS). If that fails, provide the path and instruct the user to open it.
- **Material types:** Prototype artifacts should reflect material types discovered during design discovery (see `.nayan/guidance/prototype-design-discovery.md`).

## Design Dimensions (from Design Discovery)

Prototypes should reflect design discovery choices. Key dimensions include:

- **Visual depth / surface style:** Flat, skeuomorphic, neumorphism, glassmorphism; Material Design, Fluent, or HIG alignment
- **Theme:** Light, dark, or system; high contrast; reduced motion
- **Responsive strategy:** Breakpoints, mobile-first vs desktop-first, adaptive vs responsive
- **Design system / component library:** Material, Fluent, Bootstrap, Tailwind, custom; shadcn, Radix, Chakra, or none

**Consistency across personas:** Design discovery choices (theme, colors, palette, typography, surface style, brand) are **user choices that apply to the whole product**. Apply them **identically across all persona prototypes**. Only the persona-specific content (views, screens, workflows, navigation) differs per prototype — not the theme or design system. Do not assign different themes or color schemes per persona.

See `.nayan/guidance/prototype-design-discovery.md` for discovery questions.

## Figma as Design Source

When a Figma link, design assets, or UI mockups are provided in PRD Section 12 or condensed scope:

- **Prototypes must match the design pixel-by-pixel** — exact colors, typography, spacing, layout. No approximation.
- **Skip design discovery** for aesthetic, theme, colors, typography — the design is the source of truth.
- **Extract and apply:** colors (hex/rgb), typography (font, size, weight, line-height), spacing (padding, margin, gap), layout dimensions, borders, shadows.
- Use Figma MCP or Locofy when available; otherwise extract specs from Dev Mode or manual inspection.

See `.nayan/guidance/prototype-figma-matching.md` for extraction and application steps.

## Brownfield: Existing UI as Design Source

When CONTEXT is brownfield and the codebase has existing UI (components, pages, styles):

- **Existing UI is the source of truth** — match it pixel by pixel. Skip design discovery for aesthetic, theme, colors, typography, design system (see `.nayan/guidance/prototype-brownfield-existing-ui.md`).
- **Prototypes must match existing UI components, styles, and look-and-feel pixel by pixel** — exact colors, spacing, typography, component structure from the codebase. No new visual language unless scope explicitly requests it.
- **Production solution based on existing stack only:** When the app uses a **design library** (Material, Fluent, shadcn, Tailwind, etc.) or **custom components**, the prototype must consider the production solution based on **that only** — prototype reflects that design lib and those custom components so the development plan and code implement using the same stack.
- **Add or enhance** within that visual system; if an old prototype exists, enhance it rather than replacing from scratch where it remains valid.

## Material Types

Prototypes may include different material types depending on product needs. Use formats and tech choices appropriate for each:

| Material Type   | Examples                                        | Format / Tech                          | Notes                                       |
| --------------- | ----------------------------------------------- | -------------------------------------- | ------------------------------------------- |
| **2D**          | Icons, illustrations, charts, diagrams          | SVG, PNG, CSS, or inline HTML/CSS      | Standard for most UIs                       |
| **3D**          | 3D models, scenes, spatial UIs                  | Three.js (or equivalent) in prototype  | Document tech choice for dev plan           |
| **Animation**   | Transitions, micro-interactions, loading states | CSS animations; optional GSAP/anime.js | Document motion principles                  |
| **Video/audio** | Embedded media                                  | HTML5 video/audio                      | Document autoplay, captions, fallbacks      |
| **Immersive**   | AR/VR, 360° views                               | Links to WebXR or equivalent           | Document scope for prototype vs. production |

## Pre-Handoff Checklist (Prototype Mode)

Before handoff to plan, run self-verification per `.nayan/guidance/prototype-self-verification.md` (granular todo list, verify one by one). Then verify:

- [ ] All personas have a prototype (from PRD Section 5 or condensed scope; infer when brownfield has no explicit personas)
- [ ] Each prototype includes login/entry + every screen from use cases (greenfield) or functional scope (brownfield)
- [ ] No `alert()`, `confirm()`, or `prompt()` — in-page feedback only
- [ ] No "TODO", "TBD", "Coming soon", or placeholder images
- [ ] One web, responsive to all devices (mobile, tablet, desktop) — single prototype per persona, not separate device versions
- [ ] All navigation and actions functional (client-side)
- [ ] Integrated — all screens wired together and navigable; no isolated screens

## Approval Criteria

- Artifacts are informed by approved architecture and refined requirements
- **One interactive HTML prototype per persona** — each mimics that persona's exact views/pages
- User can open each persona's prototype to see how that persona's UI works
- **Explicit sign-off:** Once user approves, the prototype is **authoritative for UI design and look-and-feel** — development plan and code must implement to match it
- Stakeholders can review and approve
- No handoff to development-plan until explicit approval
- If UX findings require changes to requirements or architecture, return to prd or architect first

## Pipeline Placement

- **After:** plan (when solution involves UI)
- **Before:** plan (dev-plan phase)
- **Skipped when:** Solution is API-only or backend-only (plan hands off directly to code)
