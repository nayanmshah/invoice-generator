# Development Plan Document Templates

Development plans use **separate templates per use case** (SRP). All templates share the same **Sprint Format**.

## Template Selection

| Use Case       | Template                                                                             | Sprint 0               |
| -------------- | ------------------------------------------------------------------------------------ | ---------------------- |
| **Greenfield** | [development-plan-greenfield-template.md](./development-plan-greenfield-template.md) | Required               |
| **Brownfield** | [development-plan-brownfield-template.md](./development-plan-brownfield-template.md) | Omit if no scaffolding |

## Shared Sprint Format

[Sprint format](./development-plan-sprint-format.md) — HITL Checkpoints, Tech Stack Integration, User Validation, Verification Criteria, Task Format, Sample Sprints. Used by both greenfield and brownfield.

## Quick Reference

- **Create**: All development plans include Create table (Nayan, User Name, Create Date — two create names) after title
- **Greenfield**: Foundational Strategy & Tech Choices, Application Anatomy & Design, Incremental Delivery Plan
- **Brownfield**: Context & Existing Assets, Changes to Application Anatomy, Incremental Delivery Plan
- **Tech stack**: Use architecture.md. See `.nayan/rules-architect/2_tech_stacks.md`
- **HITL**: See sdlc_human_gates rule
