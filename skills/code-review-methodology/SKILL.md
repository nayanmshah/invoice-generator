---
name: code-review-methodology
description: Provides the 5-phase code review methodology including architecture analysis, code quality assessment, security review, testing evaluation, and refactoring recommendations.
modeSlugs:
    - qa
---

# Code Review Methodology

See sdlc_human_gates rule for code review HITL gates.

## When to Use This Skill

Use this skill when:

- Reviewing code for quality and best practices
- Performing architecture and design pattern analysis
- Assessing security vulnerabilities in code
- Evaluating test coverage and quality
- Creating refactoring recommendations

## When NOT to Use This Skill

Do NOT use this skill when:

- Implementing code changes
- Debugging issues
- Writing tests
- Reviewing pull requests (use PR Reviewer mode)

## Code Review Methodology

### Phase 1: Codebase Analysis and Assessment

**1.1 Architecture Analysis**

- Analyze overall system architecture and design patterns
- Document architectural decisions and trade-offs
- Identify architectural anti-patterns and violations
- Assess modularity and separation of concerns
- Evaluate scalability and extensibility design
- Identify technical debt and architectural issues

**1.2 Code Structure Analysis**

- Analyze code organization and file structure
- Document naming conventions and consistency
- Assess code modularity and reusability
- Evaluate code complexity and maintainability
- Identify code duplication and redundancy

**1.3 Technology Stack Assessment**

- Evaluate technology choices and alternatives
- Assess framework and library usage
- Document version compatibility and updates
- Identify deprecated or obsolete technologies

### Phase 2: Code Quality Analysis

**2.1 Code Smells and Anti-Patterns**

- Identify long methods and classes
- Document duplicate code and DRY violations
- Assess excessive parameters
- Identify magic numbers and dead code
- Assess complex conditionals and coupling

**2.2 Design Pattern Analysis**

- Evaluate creational, structural, and behavioral patterns
- Identify missing patterns and opportunities
- Assess pattern misuse and over-engineering

**2.3 Performance Analysis**

- Identify performance bottlenecks
- Assess algorithm complexity
- Document memory usage and leak potential
- Evaluate database query optimization

### Phase 3: Security and Compliance Analysis

**3.1 Security Vulnerability Assessment**

- Identify injection vulnerabilities (SQL, XSS, etc.)
- Assess authentication and authorization
- Document input validation and sanitization
- Identify sensitive data handling issues

**3.2 Compliance and Standards**

- Evaluate coding standards compliance
- Assess accessibility standards
- Document data privacy compliance

### Phase 4: Testing and Quality Assurance

**4.1 Test Coverage Analysis**

- Assess unit and integration test coverage
- Identify missing test scenarios
- Evaluate test data management

**4.2 Quality Metrics Assessment**

- Evaluate cyclomatic complexity
- Assess maintainability index
- Document coverage metrics

### Phase 5: Improvement Recommendations

**5.1 Refactoring Recommendations**

- Provide specific refactoring suggestions with examples
- Document priority and impact assessment
- Create step-by-step refactoring plans

**5.2 Best Practice Recommendations**

- Provide coding best practice recommendations
- Document design pattern implementation suggestions
- Identify performance optimization opportunities
