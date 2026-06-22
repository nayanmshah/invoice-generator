---
name: dev-plan-enforcement
description: Enforces mandatory development plan updates before task completion. Use when working on tasks that should be tracked in development-plan.md, including planning, coding, debugging, and testing activities.
modeSlugs:
    - plan
    - code
    - qa
---

# Development Plan Enforcement

## When to Use This Skill

Use this skill when:

- Working on any task that modifies code, architecture, or test coverage
- Completing a sprint or milestone
- Before using attempt_completion to finish a task
- When development-plan.md exists in the workspace

## When NOT to Use This Skill

Do NOT use this skill when:

- Answering questions or providing information only
- Working on tasks unrelated to the project's development plan
- The task is a quick one-off fix with no plan context

## Mandatory Development Plan Enforcement

**CRITICAL RULE: Before using attempt_completion, you MUST update development-plan.md**

### Pre-Completion Checklist (MANDATORY)

- Check if development-plan.md exists in the workspace
- If no development plan exists, create one with current project status
- Mark ALL completed tasks in the plan
- Document all completed work
- Save the updated development plan file

### Enforcement Message

If you attempt to complete without updating the development plan, you MUST first say: "I cannot complete this task yet. I need to update the development-plan.md file first to reflect all completed work. Let me do that now."

## Development Plan Integration

### Development Plan Understanding

- **Read Development Plans**: Always check for existing development plan files (e.g., `development-plan.md`, or user-specified file names)
- **Parse Plan Structure**: Understand sprint organization, task breakdown, and sequential progression
- **Track Progress**: Monitor completed tasks
- **Respect Dependencies**: Follow sequential task progression and dependencies outlined in plans

### Development Plan Actions by Mode

#### Plan Mode Actions

- **Plan-Based Architecture**: Design architecture based on development plan requirements and constraints
- **Progress-Aware Planning**: Consider current progress when making architectural decisions
- **Sprint-Aligned Design**: Align architectural plans with sprint structure and milestones
- **Task-Sequenced Planning**: Plan tasks in sequence following development plan dependencies
- **Milestone-Driven Design**: Design with development plan milestones and completion criteria in mind

#### Code Mode Actions

- **Plan-Based Implementation**: Implement code based on development plan requirements and specifications
- **Progress-Aware Coding**: Consider current progress when making implementation decisions
- **Sprint-Aligned Development**: Align code implementation with sprint structure and milestones
- **Task-Sequenced Coding**: Implement tasks in sequence following development plan dependencies
- **Milestone-Driven Development**: Code with development plan milestones and completion criteria in mind
- **Update Progress**: Mark completed tasks in development plan files

#### Code Mode (Debugging) Actions

- **Track Debugging Progress**: Document resolved issues and fixes applied in the development plan
- **Mark Completed Debugging Tasks**: Update plan with debugging milestones

#### QA Mode Actions

- **Track Test Progress**: Document test coverage and results in the development plan
- **Mark Completed Test Tasks**: Update plan with testing milestones

### Implementation Guidelines

- Follow the technical architecture and technology stack specified in development plans
- Implement features according to sprint priorities and task sequencing
- Update development plan progress as tasks are completed
- Respect task dependencies and completion criteria from development plans
- Align implementation with sprint goals and milestones
