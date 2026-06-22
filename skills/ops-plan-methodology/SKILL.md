---
name: ops-plan-methodology
description: Provides the operations planning methodology including monitoring strategy, incident response framework, capacity management, on-call procedures, and SRE best practices.
modeSlugs:
    - deploy
---

# Operations Plan Methodology

For workflow steps, see `.nayan/rules-ops-plan-creator/1_workflow.md`.

## When to Use This Skill

Use this skill when:

- Creating operational procedures and monitoring plans
- Designing incident response frameworks and runbooks
- Planning capacity management and performance optimization
- Establishing on-call procedures and SRE practices

## When NOT to Use This Skill

Do NOT use this skill when:

- Implementing infrastructure (use deploy mode)
- Writing application code
- Debugging issues

## Operations Plan Methodology

### Phase 1: System Analysis and Operational Assessment

**1.1 Current System Analysis**

- Analyze existing system architecture and components
- Document current operational procedures and workflows
- Assess existing monitoring and alerting systems
- Evaluate current incident response procedures
- Identify operational pain points and bottlenecks
- Document current performance metrics and baselines

**1.2 Operational Requirements**

- Define availability and uptime requirements (99.9%, 99.99%, etc.)
- Document performance requirements and SLAs
- Identify compliance and regulatory requirements
- Define security operational requirements
- Assess disaster recovery and business continuity needs

**1.3 Risk Assessment**

- Identify operational risks and failure modes
- Assess business impact of system failures
- Evaluate security risks and vulnerabilities
- Document dependency risks and single points of failure
- Create risk mitigation strategies and contingency plans

### Phase 2: Monitoring and Observability Strategy

**2.1 Monitoring Architecture**

- Design comprehensive monitoring strategy and framework
- Define infrastructure monitoring (CPU, memory, disk, network)
- Document application performance monitoring (APM)
- Design database monitoring and performance tracking
- Define network monitoring and traffic analysis

**2.2 Alerting Strategy**

- Design alerting rules and thresholds
- Define alert severity levels and classification
- Document alert routing and escalation procedures
- Design alert fatigue prevention and optimization

**2.3 Observability Framework**

- Design logging strategy and log aggregation
- Define metrics collection and storage
- Document distributed tracing and correlation
- Design observability data retention and archival

### Phase 3: Incident Management and Response

**3.1 Incident Response Framework**

- Design incident detection and classification
- Define incident severity levels and criteria
- Document incident response team structure and roles
- Design incident communication and notification
- Define incident escalation procedures

**3.2 Runbook Development**

- Create detailed runbooks for common operational tasks
- Document emergency response procedures
- Create troubleshooting guides and procedures
- Document maintenance and update procedures
- Create backup and recovery procedures

**3.3 On-Call Management**

- Design on-call rotation and scheduling
- Define on-call responsibilities and expectations
- Document on-call escalation and handoff procedures
- Create on-call training and preparation

### Phase 4: Performance and Capacity Management

**4.1 Performance Monitoring**

- Design performance monitoring and measurement
- Define performance baselines and benchmarks
- Document performance trend analysis and forecasting

**4.2 Capacity Planning**

- Design capacity planning methodology and processes
- Define capacity measurement and tracking
- Document capacity forecasting and modeling
- Design capacity scaling and optimization

**4.3 Resource Optimization**

- Design resource utilization monitoring
- Define resource optimization strategies
- Document cost optimization and management

### Phase 5: Security and Compliance Operations

**5.1 Security Operations**

- Design security monitoring and threat detection
- Define security incident response procedures
- Document vulnerability management and patching

**5.2 Compliance Operations**

- Design compliance monitoring and reporting
- Define compliance audit procedures
- Document compliance documentation and evidence

### Phase 6: Operational Excellence

**6.1 Process Optimization**

- Design operational process maturity assessment
- Define process improvement methodologies
- Document process automation and optimization

**6.2 Team Development**

- Design operations team structure and roles
- Define skill requirements and competency matrix
- Document training and development programs
