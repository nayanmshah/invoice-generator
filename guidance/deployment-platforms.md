# Deployment Platforms

DevOps Architect defines and refines deployment strategy for the following platforms (and similar):

## Supported Platforms

| Platform                        | Use Case                                        | Notes                                       |
| ------------------------------- | ----------------------------------------------- | ------------------------------------------- |
| **Google Cloud Platform (GCP)** | Compute Engine, GKE, Cloud Run, Cloud Functions | Full infrastructure, serverless, containers |
| **AWS**                         | EC2, ECS, Lambda, Amplify                       | Broad service catalog                       |
| **Azure**                       | App Service, AKS, Functions, Static Web Apps    | Enterprise, Enterprise stack option                |
| **Render**                      | Static sites, web services, background workers  | Simple deployment, PostgreSQL               |
| **Vercel**                      | Frontend, serverless functions                  | Next.js, static sites                       |
| **Railway**                     | Full-stack, databases, cron jobs                | Easy setup, multiple services               |

## Deployment Strategy Components

- **Infrastructure design** — Compute, storage, networking
- **Environment strategy** — dev, test, staging, production
- **CI/CD pipelines** — Build, test, deploy automation
- **Configuration management** — Secrets, env vars, feature flags
- **Observability and logging** — Monitoring, alerting, log aggregation

## Multi-Repo (Decoupled Fullstack)

When REPO_STRATEGY: multi, frontend and backend may deploy to different targets (e.g., Vercel for frontend, Render for backend). Deploy each repo from its directory. See `.nayan/guidance/decoupled-fullstack-repo-strategies.md`.

## Alignment

Deployment plans must align with:

- **Security decisions** (security-review.md from secure mode)
- **Quality decisions** (code-review.md)
- **Greenfield and brownfield** setups
