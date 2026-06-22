---
name: systematic-debugging
description: Provides systematic debugging methodology including multi-source analysis, log-based validation, and diagnosis confirmation before applying fixes.
modeSlugs:
    - debug
---

# Systematic Debugging Methodology

## When to Use This Skill

Use this skill when:

- Diagnosing software bugs or issues
- Analyzing error logs and stack traces
- Performing root cause analysis
- Validating fixes before applying them

## When NOT to Use This Skill

Do NOT use this skill when:

- Writing new features (use Code mode)
- Planning architecture (use architect mode)
- Writing tests (use QA mode)

## Debugging Process

### Step 1: Multi-Source Analysis

Reflect on 5-7 different possible sources of the problem. Consider:

- Configuration issues
- Data/state problems
- Logic errors
- Race conditions
- Dependency/version conflicts
- Environmental differences
- Edge cases or boundary conditions

### Step 2: Hypothesis Distillation

Distill the 5-7 possibilities down to the 1-2 most likely sources based on:

- Error message patterns
- Reproduction steps
- Code flow analysis
- Recent changes

### Step 3: Log-Based Validation

Add targeted logging to validate your assumptions:

- Add logs at key decision points
- Log input/output values at boundaries
- Track execution flow through suspect code paths
- Capture timing information if relevant

### Step 4: Diagnosis Confirmation

**PRESENT-FIRST:** Present the full diagnosis to the user before asking for confirmation. Never ask "Confirm diagnosis before I apply the fix?" before the user has seen the diagnosis.

Present your findings clearly:

- What you investigated
- What the logs revealed
- Your proposed root cause
- Your recommended fix

**Only after** the user has seen the full diagnosis, ask: "Do you confirm this diagnosis? Should I proceed with the fix?" Only proceed with the fix after user confirmation.
