---
name: dockerization-methodology
description: Provides the containerization methodology including multi-stage builds, Docker Compose configuration, Kubernetes deployment, prerequisites verification, and production optimization strategies.
modeSlugs:
    - deploy
---

# Dockerization Methodology

For workflow steps, see `.nayan/rules-dockerization-architect/1_workflow.md`.

## When to Use This Skill

Use this skill when:

- Dockerizing existing codebases
- Creating production-ready container configurations
- Designing multi-stage Docker builds
- Setting up Docker Compose for development
- Planning Kubernetes deployments

## When NOT to Use This Skill

Do NOT use this skill when:

- Deploying to cloud platforms without Docker (use deploy mode)
- Writing application code
- Debugging application issues

## Sprint Deployment Workflow (When Containerization Needed)

**YOUR ROLE**: Called when Docker containerization is required before deployment.

**Pre-Containerization Verification:**

1. Confirm Developer mode completed implementation
2. Confirm local testing completed and user confirmed
3. Confirm detailed git commit created and pushed

**Containerization Process:**

1. **Analyze and Create Docker Config**:

    - Analyze codebase to detect tech stack
    - Create production-ready Dockerfile(s)
    - Create docker-compose.yml for local development
    - Configure environment variables

2. **Commit Docker Configuration**:

    ```
    chore(sprint-<number>): add Docker containerization

    Docker Configuration:
    - Created production Dockerfile with multi-stage builds
    - Added docker-compose.yml for local development
    - Configured environment variables for containers
    - Optimized for security and performance
    ```

3. **Local Docker Testing**:

    - Ask user to run: `docker-compose build` and `docker-compose up`
    - Wait for user confirmation containers work

4. **Delegate to Deploy mode**:
    - Inform user: "Docker containerization complete. Please switch to deploy mode for deployment."

**WORKFLOW**: Developer → Dockerization (deploy mode) → Deploy mode

## Initial Codebase Analysis Phase

Before proceeding with Docker configuration, you must:

1. **Deep Codebase Analysis** - Thoroughly analyze the entire codebase structure, dependencies, and architecture
2. **Technology Stack Identification** - Identify all frameworks, languages, databases, and external services
3. **Dependency Analysis** - Map all dependencies, package managers, and build requirements
4. **Environment Requirements** - Identify environment variables, configuration files, and runtime requirements
5. **Database and Service Dependencies** - Analyze database connections, external services, and data persistence needs
6. **Build Process Analysis** - Understand build tools, compilation steps, and asset generation
7. **Deployment Environment Detection** - Detect available tools and ask user about deployment preferences
8. **Create Detailed TODO List** - Break down the entire dockerization process into manageable, trackable tasks

### Docker Prerequisites Verification

**Before proceeding with any dockerization, you MUST verify Docker is installed and running:**

1. Check Docker Installation: `docker --version`
2. Check Docker Daemon Status: `docker info` or `docker ps`
3. Verify Docker is Running: Test with `docker run hello-world`

**If Docker is NOT installed or NOT running:** Stop and inform the user with platform-specific installation instructions.

**If Docker IS installed and running:** Continue and check for kubectl, Docker Compose, Helm, Minikube/Kind.

## Comprehensive Dockerization Methodology

### Phase 1: Codebase Analysis and Technology Mapping

**Technology Stack Identification:**

- Analyze package.json, requirements.txt, Gemfile, pom.xml, or other dependency files
- Identify frontend, backend, databases, and build tools

**Application Structure Analysis:**

- Monorepo vs single application, microservices vs monolithic
- Frontend/backend separation, static assets, configuration files

### Phase 2: Multi-Stage Docker Strategy Design

**Multi-Stage Build Strategy:**

- **Development Stage**: Base image with development tools, hot reloading support
- **Build Stage**: Optimized build environment, dependency installation and caching
- **Production Stage**: Minimal production base image, only runtime dependencies

**Base Image Selection:**

- Node.js: node:18-alpine or node:20-alpine
- Python: python:3.11-slim or python:3.12-slim
- Java: openjdk:17-jre-slim or openjdk:21-jre-slim
- Frontend: nginx:alpine for static files

### Phase 3: Production-Ready Configuration

**Security and Performance Optimization:**

- Non-root user configuration
- Minimal base images
- Security scanning and vulnerability assessment
- Multi-stage build optimization
- Layer caching strategies
- Image size optimization

**Monitoring and Logging:**

- Health check endpoints, metrics collection
- Centralized logging, structured logging

### Phase 4: Deployment and Orchestration Strategy

**Deployment Strategy Selection:**

- **Local Development**: Docker Compose with hot reloading and debugging support
- **Production Deployment**: Kubernetes manifests with resource limits and auto-scaling
- **Simple Docker**: Basic Dockerfile for single-container deployment

**Kubernetes Configuration** (only if requested or kubectl detected):

- Deployment manifests with resource limits and probes
- Service and Ingress configuration
- ConfigMap and Secrets management

## Quality Assurance and Testing

- Test Docker build process and multi-stage builds
- Validate container startup and health checks
- Test service communication and database connections
- Verify monitoring integration
