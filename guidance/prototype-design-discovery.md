# Prototype Design Discovery

**Purpose:** Before creating UX and UI prototypes, and when iterating after user feedback, ask follow-up questions to align design direction with user expectations. Reduces rework and ensures prototypes reflect the right aesthetic, material types (2D, 3D, animation, etc.), and per-type preferences.

**Reference:** `.nayan/rules-prototype/1_workflow.md` | `.nayan/guidance/ux-artifacts.md`

**Scope of choices:** Design discovery answers (theme, colors, palette, typography, surface style, brand) apply to the **entire product** — all persona prototypes must use the same design choices. Do not vary theme or color scheme by persona.

**When Figma design is provided:** Skip design discovery for aesthetic, theme, colors, typography. Figma (or the provided design) is the source of truth. Proceed to prototype creation with pixel-by-pixel matching per `.nayan/guidance/prototype-figma-matching.md`.

**When brownfield and existing app has UI code:** Skip design discovery for aesthetic, theme, colors, typography, design system. The existing codebase is the source of truth. Run existing-UI analysis and match existing UI pixel by pixel per `.nayan/guidance/prototype-brownfield-existing-ui.md`. Ask discovery only for net-new UI elements that have no existing pattern in the app.

---

## Principle: Clarity Through Questions

**Ask one question at a time** — wait for the user's answer before asking the next. Do not batch multiple questions in a single message. This keeps the conversation focused and makes it easier for the user to respond clearly.

**Mandatory:** Read PRD Section 12 (or condensed scope) first. If any design field is filled (not blank, not TBD), use it. Do not re-ask. Only ask for fields that are blank or explicitly deferred. **Skip or abbreviate** when PRD Section 12 or condensed scope already specifies design assets, brand guidelines, and material types clearly.

---

## Before Creating Prototypes

When PRD Section 12 or condensed scope lacks sufficient design direction, ask follow-up questions in these groups. Cover each group as needed; for each group, ask one question at a time.

### Aesthetic & Style

- Preferred look? (e.g., minimalist, corporate, playful, bold, editorial, brutalist, luxury, retro-futuristic)
- Brand guidelines or design system to follow?
- Design references? (links to products, Figma, or similar that capture the desired feel)

### Visual Depth / Surface Style

- Preferred surface style? (e.g., **flat** — minimal depth, flat colors; **skeuomorphic** — realistic textures, shadows, depth; **neumorphism** — soft shadows, extruded/embossed look; **glassmorphism** — frosted glass, blur, transparency)
- Design system to align with? (Material Design, Fluent, Human Interface Guidelines / HIG, or custom)

### Theme and Color Mode

- Preferred theme? (light, dark, or system — follow OS preference)
- High contrast needed for accessibility?
- Reduced motion preferred? (minimal or no animations for accessibility)

### Responsive Strategy

- Which breakpoints matter? (e.g., mobile 320–768px, tablet 768–1024px, desktop 1024px+)
- Mobile-first or desktop-first priority?
- Adaptive (discrete layout changes per breakpoint) or responsive (fluid scaling)?

### Design System / Component Library

- Design system? (Material, Fluent, Bootstrap, Tailwind, or custom)
- Component library? (e.g., shadcn, Radix, Chakra, or none)
- Custom vs off-the-shelf? (fully custom components vs library-based)

### Material Types

Which material types apply to this product? Ask about each that may be relevant:

| Material Type   | Examples                                                                | When to Ask                                                      |
| --------------- | ----------------------------------------------------------------------- | ---------------------------------------------------------------- |
| **2D**          | Flat graphics, illustrations, icons, charts, diagrams, typography       | Most UIs                                                         |
| **3D**          | 3D models, spatial UIs, product configurators, scenes                   | Product configurators, spatial dashboards, gaming, visualization |
| **Animation**   | Motion, transitions, micro-interactions, loading states, scroll effects | Any interactive UI                                               |
| **Video/audio** | Embedded media, autoplay, captions                                      | Media-heavy products, tutorials, marketing                       |
| **Immersive**   | AR/VR, 360° views, interactive 3D                                       | When scope or architecture indicates AR/VR or immersive UX       |

### Per-Material Preferences

For each applicable material type, ask targeted questions. One question at a time.

- **2D:** Illustration style? (line art, flat, photorealistic) Icon style? Chart type preferences?
- **3D:** Realistic vs. stylized? Level of interactivity? (rotate, zoom, configure)
- **Animation:** Subtle or prominent? Duration preferences? (fast, medium, slow) Any motion to avoid?
- **Video/audio:** Autoplay? Muted by default? Captions required? Fallbacks for unsupported browsers?
- **Immersive:** WebXR scope for prototype vs. production? 360° vs. full AR/VR?

---

## After User Rejects (Does Not Approve)

When the user does not approve the UX and UI design, ask clarifying questions before iterating or returning to prd/architect.

1. **"What would you like to change?"** — Offer structured options:

    - Layout (structure, spacing, component placement)
    - Colors (palette, contrast, theme)
    - Typography (fonts, hierarchy, sizing)
    - Visual depth / surface style (flat, skeuomorphic, neumorphism, glassmorphism)
    - Theme (light, dark, system) or accessibility (high contrast, reduced motion)
    - Responsive strategy (breakpoints, mobile-first vs desktop-first, adaptive vs responsive)
    - Design system / component library (Material, Fluent, Tailwind, shadcn, Radix, Chakra, custom)
    - 2D assets (icons, illustrations, charts)
    - 3D elements (models, scenes, interactivity)
    - Animation style (motion, transitions, micro-interactions)
    - Interaction patterns (navigation, feedback, flows)
    - Density (information density, whitespace)

2. **Offering alternatives:** "Would you like me to explore a different design direction or show 2–3 style options?"

3. **One question at a time** — Wait for the user's answer before proceeding. Do not assume.

---

## Integration

- **Workflow:** Prototype mode step 2a references this guidance. See `.nayan/rules-prototype/1_workflow.md`.
- **Artifacts:** Prototype artifacts should reflect material types discovered here. See `.nayan/guidance/ux-artifacts.md` for format and tech choices per material type.
