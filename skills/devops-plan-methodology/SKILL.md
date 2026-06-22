---
name: devops-plan-methodology
description: Provides the DevOps planning methodology including CI/CD pipeline design, infrastructure as code, monitoring/observability, security/compliance, and operational excellence frameworks.
modeSlugs:
    - deploy
---

# DevOps Plan Methodology

For workflow steps, see `.nayan/rules-ops-plan-creator/1_workflow.md`. See sdlc_human_gates rule for DevOps plan sign-off gate.

## When to Use This Skill

Use this skill when:

- Designing CI/CD pipelines and deployment strategies
- Planning infrastructure as code implementations
- Creating monitoring and observability strategies
- Establishing DevOps processes and best practices

## When NOT to Use This Skill

Do NOT use this skill when:

- Implementing actual infrastructure (use deploy mode)
- Writing application code
- Debugging issues

## DevOps Plan Methodology

### Phase 1: Infrastructure Analysis and Assessment

**1.1 Current State Analysis**

- Analyze existing infrastructure architecture and components
- Document current deployment processes and procedures
- Identify existing tools, technologies, and platforms
- Assess current monitoring, logging, and alerting systems
- Evaluate security measures and compliance requirements
- Document performance metrics and bottlenecks
- Identify technical debt and improvement opportunities

**1.2 Requirements Gathering**

- Define scalability and performance requirements
- Document security and compliance requirements
- Identify disaster recovery and business continuity needs
- Assess cost optimization and resource utilization goals
- Define monitoring and observability requirements

**1.3 Gap Analysis**

- Compare current state with target requirements
- Identify missing tools, processes, and capabilities
- Document skill gaps and training requirements
- Create prioritized improvement roadmap

### Phase 2: CI/CD Pipeline Design

**2.1 Pipeline Architecture**

- Design multi-stage pipeline: Build → Test → Security → Deploy → Monitor
- Define parallel and sequential execution strategies
- Design pipeline triggers and event-driven execution

**2.2 Build and Integration Strategy**

- Source code management and branching strategy
- Automated build processes, dependency management, artifact versioning

**2.3 Testing Integration**

- Unit, integration, performance, and security testing automation

**2.4 Security Integration**

- Security scanning, secrets management, compliance checking

**2.5 Deployment Strategy**

- Blue-green, canary, rolling deployments
- Rollback procedures, deployment validation

### Phase 3: Infrastructure as Code

**3.1 Infrastructure Design**

- Cloud architecture, container orchestration, network architecture

**3.2 Configuration Management**

- IaC standards, configuration versioning, drift detection

**3.3 Automation Framework**

- Automation toolchain, standards, testing, monitoring

### Phase 4: Monitoring and Observability

**4.1 Monitoring Strategy**

- APM, infrastructure monitoring, log management, distributed tracing

**4.2 Observability Framework**

- Data collection, storage, analysis, reporting

**4.3 Alerting and Incident Response**

- Alerting rules, incident detection, escalation, post-incident analysis

### Phase 5: Security and Compliance

**5.1 Security Architecture**

- Security controls, network security, data protection, vulnerability management

**5.2 Compliance Framework**

- Compliance requirements, monitoring, reporting, continuous improvement

### Phase 6: Operational Excellence

**6.1 Process Optimization**

- Process maturity assessment, improvement methodologies, automation

**6.2 Team Structure and Skills**

- DevOps team structure, skill requirements, training programs
