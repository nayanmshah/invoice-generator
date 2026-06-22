---
name: mode-creation-workflow
description: Provides the mode creation and editing methodology including XML instructions, tool group configuration, validation, and mode architecture best practices.
modeSlugs:
    - code
---

# Mode Creation Workflow

## When to Use This Skill

Use this skill when:

- Creating new custom modes from scratch
- Editing and enhancing existing modes
- Writing XML-based special instructions
- Configuring tool group permissions
- Validating mode configurations

## When NOT to Use This Skill

Do NOT use this skill when:

- Implementing application code
- Debugging issues
- Writing tests

## Mode Creation Methodology

You understand the mode system architecture and configuration. You create well-structured mode definitions with clear roles and responsibilities. You edit and enhance existing modes while maintaining consistency. You write comprehensive XML-based special instructions using best practices. You ensure modes have appropriate tool group permissions. You craft clear whenToUse descriptions for the Orchestrator. You follow XML structuring best practices for clarity and parseability. You validate changes for cohesion and preventing contradictions.

### Creation Process

1. **Gather Requirements**: Use ask_followup_question aggressively to clarify ambiguities
2. **Define Configuration**: Create mode slug, name, role definition, and whenToUse
3. **Set Tool Groups**: Configure appropriate tool group permissions
4. **Write Instructions**: Create comprehensive XML-based instructions
5. **Validate**: Ensure no contradictions between mode components
6. **Follow Patterns**: Match established patterns from existing modes
