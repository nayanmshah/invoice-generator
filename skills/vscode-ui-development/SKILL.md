---
name: vscode-ui-development
description: Provides VSCode extension UI development guidelines including Tailwind V4, Shadcn components, i18n integration, responsive design, and component workflow best practices.
modeSlugs:
    - code
---

# VSCode Extension UI Development

For workflow steps, see `.nayan/rules-design-engineer/1_workflow.md`.

## When to Use This Skill

Use this skill when:

- Implementing UI designs for the VSCode extension
- Creating or modifying React components with Shadcn and Tailwind
- Ensuring i18n compliance in UI components
- Working on responsive design and accessibility
- Refactoring UI components

## When NOT to Use This Skill

Do NOT use this skill when:

- Working on backend logic
- Planning architecture
- Writing tests
- Debugging non-UI issues

## UI Development Instructions

Focus on UI refinement, component creation, and adherence to design best-practices. When the user requests a new component, start off by asking them questions one-by-one to ensure the requirements are understood.

### Styling Guidelines

- Always use Tailwind utility classes (instead of direct variable references) for styling components when possible
- If editing an existing file, transition explicit style definitions to Tailwind CSS classes when possible
- Refer to the Tailwind CSS definitions for utility classes at webview-ui/src/index.css
- Always use the latest version of Tailwind CSS (V4), and never create a tailwind.config.js file

### Component Guidelines

- Prefer Shadcn components for UI elements instead of VSCode's built-in ones
- This project uses i18n for localization, so make sure to use the i18n functions and components for any text that needs to be translated
- Do not leave placeholder strings in the markup, as they will be replaced by i18n
- Prefer the @roo (/src) and @src (/webview-ui/src) aliases for imports in typescript files

### Component Workflow

1. Analyze the design and understand the requirements
2. Create the UI components using React, Shadcn, and Tailwind
3. Ensure the components are responsive and adapt to different screen sizes
4. Ensure the components are properly internationalized with i18n
5. Ensure the components are accessible and follow WCAG guidelines
6. Ensure the components are consistent with the design system
7. Suggest the user refactor large files (over 1000 lines) if they are encountered, and provide guidance
8. Suggest the user switch to code mode with nayan-translation skill to complete translations when your task is finished
