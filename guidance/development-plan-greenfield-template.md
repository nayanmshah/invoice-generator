# Development Plan: Greenfield Template

Use for new products from scratch. All sections must be present.

**Tech stack is documented in architecture.md:** The development plan (folder structure, sprint tasks, commands, deployment) is **based on the tech stack documented in architecture.md**. Do not re-define or override. Use exactly what is documented. See `.nayan/rules-architect/2_tech_stacks.md` (architect documents tech stack; plan consumes from architecture.md).

**Sprint Format:** Use `.nayan/guidance/development-plan-sprint-format.md` for HITL, tasks, verification, and sample sprints.

---

## Top-Level Structure

1. **# Development Plan: [Product Name]**
2. **## Create** — Table with Nayan, User Name, Create Date. Two create names: Nayan (AI) and User Name (logged-in user who created using Nayan, from `environment_details`). Format: `| Nayan | User Name | Create Date |`
3. **## 1. Foundational Strategy & Technology Choices**
4. **## 2. Application Anatomy & Design**
5. **## 3. Incremental Delivery Plan**

## Section 1: Foundational Strategy & Technology Choices

- **### 1.1. Architectural Pattern Decision** — Decision + Justification. **When Decoupled Fullstack:** Include **Repository Strategy** (single repo vs multi-repo). Single repo: one Repo URL; one commit/PR per sprint. Multi-repo: When frontend/backend: REPO_FRONTEND, REPO_BACKEND. When project-specific names: REPO_DIRS + per-repo URLs; per-repo commit/PR. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.
- **### 1.2. Technology Stack Selection** — **Use the tech stack from architecture.md.** Do not re-define or change it. Copy the stack (Frontend, Backend, Database, Deployment) from architecture.md into this section. _ENSURE ALL SPECIFIED VERSIONS ARE THE LATEST STABLE RELEASES._
- **### 1.3. Core Infrastructure & Services (Local Development Focus)** — Local Development, File Storage, Authentication, External Services
- **### 1.4. Integration and API Strategy** — API Style, Standard Formats
- **### 1.5. Deployment Infrastructure** — Frontend Deployment, Backend Deployment, Deployment Testing

## Section 2: Application Anatomy & Design

- **### 2.1. Module Identification** — Domain Modules, Infrastructure Modules, Shared Module
- **### 2.2. Module Responsibilities and Interfaces** — Responsibilities, Interface
- **### 2.3. Folder Structure** — **MANDATORY**: ```text code block with **deep** tree (3–4 levels), inline comments per directory. **Based on tech stack documented in architecture.md:** Bootcamp → Bootcamp structure; Enterprise → Enterprise structure; Custom → derive from framework conventions in architecture.md. **Match architecture pattern (Section 1.1):** Monolith vs Decoupled. Derive containers/modules/personas from architecture.md. **Folder structure must fulfill sprints** — when Sprint 1 includes auth, include auth dirs. Use template examples for the documented stack (see format below).
- **### 2.4. Key Patterns** — Data Access, Business Logic

## Section 3: Incremental Delivery Plan

- **### HITL Overview** — Brief summary: "User approval required at: (1) development plan sign-off, (2) **user-provided inputs** (repo URL or REPO_FRONTEND + REPO_BACKEND when Decoupled with frontend/backend, or REPO_DIRS + per-repo URLs when generic multi-repo, DB URL, env vars, API keys, deployment target—ask, never assume), (3) after each critical task (local verification), (4) tests pass and coverage reported per sprint, (5) code quality gate and security scan before PR, (6) sprint completion before commit/PR, (7) **PR per sprint** — human reviewer approves before merge, (8) deployment sprint — user approval at each step. **Decoupled Fullstack + multi-repo:** per-repo commit and PR. See sdlc_human_gates rule."
- **### THE SPRINT PLAN**
- **#### Sprint 0: Groundwork & Scaffolding** — Full granular detail including HITL Checkpoints (see `.nayan/guidance/development-plan-sprint-format.md`)
- **#### Sprint 1: [Feature Name]** — Full granular detail; **PR per sprint** (human review); code quality gate; security scan
- **#### Sprint 2+: [Feature Name]** — Continue for each sprint
- **#### Deployment Sprint** — After all feature sprints: code quality, security scan, [User Input] deployment target, pre-deploy approval, deploy, post-deploy verification. See `.nayan/guidance/development-plan-sprint-format.md`.
- **---** and **Development Plan Complete - Ready for implementation.**

---

## Folder Structure Format (### 2.3. Folder Structure)

**MANDATORY**: Use a ```text code block. Each directory must have an inline `# Comment`. **Depth requirement:** The folder structure must be **deep** — at least 3–4 levels. Do NOT show only one level under each top-level dir.

**Tech stack determines structure:** The folder structure is **based on the tech stack documented in architecture.md**. Use the example that matches the documented stack (Bootcamp, Enterprise, or Custom). For Custom, derive from the frameworks documented in architecture.md — use their conventions (e.g., Django `apps/`, Rails `app/controllers/`).

- **Code block**: Use `text` (not `bash`)
- **Tree format**: Use `├──`, `│`, `└──` for tree structure
- **Inline comments**: Every directory must have `# Comment` explaining its purpose
- **Sprint alignment**: Sprint 0 tasks must **create the full folder structure** as outlined here. Sprint 1+ tasks add implementation **within** these directories. Folder structure must fulfill sprints (e.g., auth dirs when Sprint 1 has auth).

### Tech Stack → Folder Structure Mapping

| Tech Stack (documented in architecture.md) | Folder Structure                                                                                     | Example                                       |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| **Bootcamp** (Next.js + FastAPI + MongoDB) | Decoupled: `/frontend` + `/backend`                                                                  | See Bootcamp example below                    |
| **Enterprise** (Angular + Spring Boot + Oracle)   | Decoupled + Microservices: `/frontend` (portals) + `/backend` (services)                             | See Enterprise example below                         |
| **Custom**                                 | Derive from architecture.md — use framework conventions for the selected Frontend, Backend, Database | No predefined template; follow framework docs |

### Monolith vs Decoupled (within tech stack)

| Architecture Pattern (Section 1.1) | Folder Structure                                                                                                                                                                        |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Modular Monolith**               | Single codebase; no separate `/frontend` and `/backend`                                                                                                                                 |
| **Decoupled Fullstack**            | Separate `/frontend` and `/backend`. **Repository Strategy:** Single repo (monorepo) or multi-repo (separate git repos). See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`. |
| **Microservices**                  | Decoupled + multiple backend services                                                                                                                                                   |

**Use the structure that matches both the tech stack and architecture pattern.** See examples below.

---

### When architecture.md documents: Modular Monolith (e.g., Full-Stack Next.js)

Single codebase; frontend and API routes in one app. Use when **tech stack** is full-stack Next.js (or similar single-runtime) and architecture is Modular Monolith.

```text
/
├── src/
│   ├── app/                       # Next.js App Router
│   │   ├── api/                   # Backend API routes by domain
│   │   │   ├── auth/              # Login, register, token (Sprint 1)
│   │   │   ├── products/
│   │   │   ├── orders/
│   │   │   └── ...
│   │   ├── (auth)/                # Login/Register pages (Sprint 1)
│   │   └── ({persona})/           # Persona-specific pages per PRD Section 5
│   ├── components/
│   │   ├── ui/                    # shadcn/ui primitives
│   │   └── features/              # Feature-specific components
│   ├── lib/                       # Utilities, Prisma, NextAuth
│   └── types/                     # Global TypeScript interfaces
├── prisma/                         # Database schema
│   └── schema.prisma
├── package.json
└── docs/
```

---

### When architecture.md documents: Bootcamp (Next.js + FastAPI + MongoDB)

```text
/
├── frontend/                       # Next.js App
│   ├── src/
│   │   ├── app/                   # App Router
│   │   │   ├── api/               # API routes by domain
│   │   │   │   ├── auth/
│   │   │   │   ├── products/
│   │   │   │   ├── orders/
│   │   │   │   └── shipments/
│   │   │   ├── (auth)/            # Login/Register pages
│   │   │   └── ({persona})/       # Persona-specific pages per PRD Section 5
│   │   ├── components/            # Shared and feature components
│   │   │   ├── ui/                 # shadcn/ui primitives
│   │   │   └── features/          # Feature-specific components
│   │   ├── lib/                   # Utilities, Prisma client, NextAuth
│   │   └── types/                 # Global TypeScript interfaces
│   ├── package.json
│   └── next.config.js
├── backend/                        # Python FastAPI
│   ├── app/
│   │   ├── api/                   # Routers by domain
│   │   │   ├── auth/
│   │   │   ├── products/
│   │   │   ├── orders/
│   │   │   └── shipments/
│   │   ├── models/                # Schemas, document definitions
│   │   ├── services/              # Business logic
│   │   ├── core/                  # Config, security, DB connection
│   │   └── main.py
│   ├── tests/
│   └── requirements.txt
├── prisma/                         # Database schema
│   └── schema.prisma
└── docs/                           # Architecture, setup
```

### When architecture.md documents: Enterprise (Angular + Spring Boot + Oracle)

Separate `/frontend` and `/backend`; multiple Spring Boot services. Use when architecture.md documents Enterprise. Derive from architecture.md: one portal per persona (Container Diagram), one service per domain module. **When Sprint 1 includes auth:** MUST include auth folders (see below).

```text
/
├── frontend/                           # Angular Workspace (monorepo)
│   ├── {persona}-portal/               # One SPA per persona (e.g., buyer-portal, seller-portal)
│   │   ├── src/
│   │   │   ├── app/
│   │   │   │   ├── core/               # Singleton services
│   │   │   │   │   ├── auth/           # AuthService, AuthGuard, JwtInterceptor (Sprint 1)
│   │   │   │   │   └── interceptors/
│   │   │   │   ├── shared/             # Reusable UI (from shared-lib)
│   │   │   │   ├── features/           # Feature modules per domain
│   │   │   │   │   ├── auth/           # Login, register, callback (Sprint 1 when auth in scope)
│   │   │   │   │   ├── catalog/        # Domain-specific features
│   │   │   │   │   ├── orders/
│   │   │   │   │   └── ...
│   │   │   │   └── layout/             # Shell, nav, header, footer
│   │   │   ├── assets/
│   │   │   └── environments/
│   │   ├── angular.json
│   │   └── package.json
│   └── shared-lib/                    # Shared Angular library
│       ├── src/lib/
│       │   ├── components/            # Shared UI (tables, forms, modals)
│       │   ├── services/              # Event Bus (RxJS), API clients
│       │   ├── models/                 # DTOs, interfaces
│       │   └── pipes/
│       ├── ng-package.json
│       └── package.json
├── backend/                            # Spring Boot Microservices
│   ├── api-gateway/                    # Spring Cloud Gateway
│   │   ├── src/main/
│   │   │   ├── java/.../gateway/
│   │   │   │   ├── config/             # Route config, CORS, security
│   │   │   │   └── filter/             # JWT validation filter (Sprint 1)
│   │   │   └── resources/
│   │   └── pom.xml
│   ├── user-service/                  # Identity, RBAC (when auth in scope)
│   │   └── src/main/java/.../user/
│   │       ├── controller/
│   │       │   └── auth/               # Login, register, me (Sprint 1)
│   │       ├── service/
│   │       │   └── auth/               # Auth logic, JWT, RBAC (Sprint 1)
│   │       ├── repository/
│   │       ├── model/
│   │       └── config/                 # Auth0/OIDC config (Sprint 1)
│   ├── {domain}-service/               # One service per domain (e.g., catalog-service, order-service)
│   │   ├── src/main/
│   │   │   ├── java/.../{domain}/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   ├── repository/
│   │   │   │   ├── model/
│   │   │   │   └── config/
│   │   │   └── resources/
│   │   └── pom.xml
│   └── common-lib/                     # Shared Java DTOs, security, exception
│       └── src/main/java/.../common/
│           ├── dto/
│           ├── exception/
│           └── security/               # JWT config, security utils (Sprint 1)
└── docs/                               # Architecture, setup
```

**Sprint alignment:** Include auth folders when Sprint 1 (or first feature sprint) covers authentication. Folder structure must fulfill the sprints planned.

### When architecture.md documents: Custom

**No predefined template.** Derive folder structure from the tech stack documented in architecture.md:

- Use the **framework conventions** for the selected Frontend (e.g., Angular → `src/app/`, React → `src/components/`, Vue → `src/views/`)
- Use the **framework conventions** for the selected Backend (e.g., Spring Boot → `src/main/java/.../controller/`, Django → `apps/`, Express → `routes/`)
- Match the **architecture pattern** (Monolith vs Decoupled)
- Keep **deep** structure (3–4 levels); include auth dirs when Sprint 1 has auth

**Reference:** Use the Bootcamp/Enterprise examples as **patterns** when those stacks are selected. For Custom, follow framework docs. Never produce a shallow (one-level) folder structure.
