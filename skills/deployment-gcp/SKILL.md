---
name: deployment-gcp
description: "GCP deployment for personal or org-managed setups; greenfield (new project/cluster) and brownfield (existing). Dockerfiles, GKE/Cloud Run, Artifact Registry, Jenkins/Cloud Build, Nginx; org-managed IAM patterns (A1/A2/B)."
modeSlugs:
    - deploy
---

# GCP Deployment

For workflow steps, see `.nayan/rules-deploy/1_workflow.md`. This skill covers deployment context (personal vs org-managed; greenfield vs brownfield), input validation, GCP stack, artifacts, and completion criteria.

## When to Use This Skill

- Deployment target is **GCP** (per architecture or user confirmation).
- Setting up or updating GCP deployment infrastructure (GKE, Cloud Run, Artifact Registry, Cloud SQL, etc.).
- Creating Dockerfiles, Kubernetes manifests, Jenkins or Cloud Build pipelines, Nginx configs.
- Aligning with an organization’s GCP/GKE/Jenkins/Nginx stack.

## When NOT to Use This Skill

- Deployment target is not GCP (use deployment-vercel, deployment-render, deployment-railway, deployment-aws, or deployment-azure).
- Writing application code or designing application architecture.

---

## Deployment context: personal vs org-managed, greenfield vs brownfield

Establish both dimensions so the right steps and docs are produced.

| Dimension       | Meaning                                                                                                           | What to ask / document                                                                                                                                     |
| --------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Personal**    | User has direct project access (Owner/Editor on a project — their own or granted). No org-level constraints.      | User confirms they have project access. Proceed with standard Initial Setup and deploy steps in deployment.md.                                             |
| **Org-managed** | Org controls access; full project setup uses one of three IAM patterns (see "Personal vs org-managed GCP" below). | Ask: "Which org-managed model?" → **A1**, **A2**, or **B**. Document chosen model and IAM steps in deployment.md.                                          |
| **Greenfield**  | New project and/or new cluster / new Cloud Run service. Setup from scratch.                                       | Create project (or use pipeline), enable APIs, create GKE cluster or Cloud Run, Artifact Registry, VPC, etc. Produce full deployment.md and runbook.       |
| **Brownfield**  | Existing project and existing cluster or Cloud Run service. Deploy app into current infra.                        | Use existing project, cluster, registry; ensure IAM/VPC align. Deploy with `kubectl apply` or `gcloud run deploy`; update runbook and rollback procedures. |

**Rule:** For every deployment, confirm (1) **Personal or org-managed?** If org-managed, which of A1, A2, or B. (2) **Greenfield or brownfield?** Then apply the matching procedures below and in deployment.md.

---

## Greenfield and brownfield (what to do)

- **Greenfield:** New GKE: create cluster, apply manifests (namespace, deployment, service, ingress). New Cloud Run: `gcloud run deploy SERVICE_NAME --source .` or `--image=IMAGE_URL --region=REGION`. Enable APIs, create Artifact Registry, VPC as needed. Use Cloud Build triggers for continuous deployment from Git. Produce deployment.md and deployment-runbook.md per this skill.
- **Brownfield:** Existing GKE: `kubectl apply -f k8s/` (or Helm upgrade). Existing Cloud Run: `gcloud run deploy SERVICE_NAME --image=IMAGE_URL --region=REGION` (creates or updates). Use existing Artifact Registry; ensure IAM and VPC align with current org. Runbooks and rollback procedures apply to both.

---

## Mandatory Input Validation

**CRITICAL RULE: Architecture and implementation must be complete before deployment**

### 1. Check Prerequisites

- `architecture.md`: Required — STOP and request it if missing
- `development-plan.md`: Required — for understanding what to deploy
- `security-review.md`: Warn if missing — Critical/High findings must be resolved before production
- Ask user to confirm the application builds successfully

### 2. Identify Technology Stack

- Read `package.json`, `pom.xml`, `build.gradle`, or equivalent build files
- Determine: language/runtime, framework, build tool, port(s) exposed
- Determine: database type, cache, message queue requirements

### 3. Request Required GCP Information (ask these explicitly)

- GCP Project ID and deployment region
- GKE cluster name (or confirm Cloud Run is preferred)
- Artifact Registry repository URL
- Domain/subdomain for the service
- Target environments: dev / staging / production
- **Deployment context:** Personal (user has project Owner/Editor) or org-managed? If org-managed: which model — **A1** (admin creates project, grants user), **A2** (user has Project Creator on folder, creates project), or **B** (bootstrap pipeline)? Document in deployment.md.

## GCP Infrastructure Design

### Align with Existing Organizational Infrastructure

The organization's standard GCP stack (from tech stack matrix) is:

- **GKE (Google Kubernetes Engine)**: Primary container orchestration for all products — default choice
- **Nginx**: Reverse proxy / ingress (standard across all products)
- **Jenkins**: CI/CD pipeline (standard in most products)
- **Keycloak / ISDS**: IAM and authentication (match the product's auth system)
- **Cloud SQL**: Managed PostgreSQL or MySQL (match existing product DB)
- **Memorystore (Redis)**: Caching where applicable

**Default to this stack** unless the architecture explicitly requires otherwise.

### Personal vs org-managed GCP

**Personal:** User has direct Owner/Editor access to a project (their own or granted). No special IAM flow; document standard Initial Setup and deploy steps in deployment.md.

**Org-managed:** Full project setup uses one of three patterns (A1, A2, B). In deployment.md include an "Org-managed setup model" subsection under Initial Setup and Security Configuration that states which option is used and the exact commands (with PROJECT_ID, USER_EMAIL, FOLDER_ID, BILLING_ACCOUNT_ID as placeholders).

| Model                            | Who creates/sets up the project?                                                           | What the user gets                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- |
| **A1** Admin creates project     | Admin creates empty project, grants user Owner/Editor on that project only                 | Full control of that one project; user runs Initial Setup                          |
| **A2** Project Creator on folder | User has Project Creator (and Billing User) on a folder; user creates project under folder | Owner of new project only; user runs Initial Setup                                 |
| **B** Bootstrap pipeline         | Service account runs Terraform/scripts; user only triggers pipeline                        | User triggers "new project"; gets limited access (e.g. Viewer/Developer); no Owner |

**Actionable steps for deployment.md (org-managed only)**

- **A1 — Admin creates project, user does setup**  
  Admin: `gcloud projects create PROJECT_ID --organization=ORG_ID` or `--folder=FOLDER_ID` (use one; cannot use both). Link billing: `gcloud billing projects link PROJECT_ID --billing-account=BILLING_ACCOUNT_ID`. Grant user: `gcloud projects add-iam-policy-binding PROJECT_ID --member="user:USER_EMAIL" --role="roles/owner"` (or `roles/editor`). User: `gcloud config set project PROJECT_ID`, then run Initial Setup from deployment.md. [Projects: https://cloud.google.com/resource-manager/docs/creating-managing-projects; IAM: https://cloud.google.com/iam/docs/granting-changing-revoking-access]
- **A2 — User creates project**  
  Admin: On folder: `gcloud resource-manager folders add-iam-policy-binding FOLDER_ID --member="user:USER_EMAIL" --role="roles/resourcemanager.projectCreator"`. On billing account: `gcloud billing accounts add-iam-policy-binding BILLING_ACCOUNT_ID --member="user:USER_EMAIL" --role="roles/billing.user"` (Billing Account User; required to link new projects to billing). User: `gcloud projects create PROJECT_ID --folder=FOLDER_ID`, then `gcloud billing projects link PROJECT_ID --billing-account=BILLING_ACCOUNT_ID` if not auto-linked, `gcloud config set project PROJECT_ID`, run Initial Setup. [Billing: https://cloud.google.com/billing/docs/how-to/modify-project]
- **B — Bootstrap pipeline**  
  Admin: Create pipeline SA; grant at folder or org: `roles/resourcemanager.projectCreator`, `roles/serviceusage.serviceUsageAdmin` (enables APIs), plus e.g. `roles/container.admin`, `roles/artifactregistry.admin`. Store SA key in Secret Manager or CI; never give to users. Pipeline runs Terraform/scripts to create project, enable APIs, create GKE/Cloud Run/Artifact Registry. Optionally grant user `roles/viewer` or `roles/developer` on new project. User: trigger pipeline with PROJECT_ID (and params).

### GCP Services Reference

| Layer         | Service                    | When to Use                                             |
| ------------- | -------------------------- | ------------------------------------------------------- |
| Compute       | GKE                        | Default; containerized workloads matching org pattern   |
| Compute       | Cloud Run                  | Stateless services needing zero-config auto-scale       |
| Database      | Cloud SQL                  | PostgreSQL / MySQL (align with existing product choice) |
| Cache         | Memorystore                | Redis caching (aligns with iTradeOrder, OrderMaestro)   |
| Storage       | Cloud Storage              | Files, static assets, backups                           |
| Secrets       | Secret Manager             | All production secrets (replace .env in production)     |
| Registry      | Artifact Registry          | Docker image storage and vulnerability scanning         |
| Networking    | Cloud Load Balancing       | HTTPS ingress (with managed SSL certificate)            |
| Security      | Cloud Armor                | WAF / DDoS protection for public-facing services        |
| Observability | Cloud Monitoring + Logging | Metrics, logs, uptime checks, and alerting              |

## Deployment Artifacts to Create

### 1. Dockerfile (multi-stage build)

```dockerfile
# Build stage
FROM [base-image]:[version] AS build
WORKDIR /app
COPY . .
RUN [build command]

# Production stage
FROM [runtime-image]:[version]
WORKDIR /app
COPY --from=build /app/[build-output] .
USER nonroot:nonroot
EXPOSE [port]
CMD ["[start command]"]
```

### 2. Kubernetes Manifests (k8s/ directory)

Create these files:

- `k8s/namespace.yaml`
- `k8s/deployment.yaml` — include resource limits, liveness/readiness probes, non-root user
- `k8s/service.yaml`
- `k8s/ingress.yaml` — Nginx ingress with TLS
- `k8s/configmap.yaml` — non-secret configuration
- `k8s/hpa.yaml` — Horizontal Pod Autoscaler

**Security requirements in all manifests:**

- Container runs as non-root user
- CPU and memory requests/limits defined on every container
- Liveness and readiness probes configured
- Secrets referenced from GCP Secret Manager (not hardcoded)

### 3. CI/CD Pipeline (Jenkinsfile)

Following the organization's Jenkins standard:

```groovy
pipeline {
  stages {
    stage('Checkout') { ... }
    stage('Build & Test') { ... }
    stage('Code Quality') { ... }       // SonarQube if configured
    stage('Docker Build & Push') { ... } // Push to Artifact Registry
    stage('Deploy to GKE') { ... }       // kubectl apply or Helm upgrade
    stage('Smoke Test') { ... }
  }
}
```

### 4. Nginx Configuration (nginx/nginx.conf)

- Reverse proxy to application service
- SSL termination
- Gzip compression
- Security headers (HSTS, X-Frame-Options, CSP, X-Content-Type-Options)
- Rate limiting on authentication endpoints

### 5. Environment Configuration

- `.env.example`: Template with all required variables (no actual values)
- `k8s/secrets/README.md`: Instructions for setting up GCP Secret Manager secrets
- Kustomize overlays or Helm values files for dev/staging/prod environments

## CLI and automation (greenfield and brownfield)

- **gcloud:** Install: https://cloud.google.com/sdk/docs/install. Auth: `gcloud auth login`; `gcloud config set project PROJECT_ID`. **Cloud Run:** `gcloud run deploy SERVICE_NAME --image=IMAGE_URL --region=REGION` (creates or updates); from source: `gcloud run deploy SERVICE_NAME --source . --region=REGION`. **Artifact Registry:** `gcloud auth configure-docker REGION-docker.pkg.dev`. **GKE:** `gcloud container clusters get-credentials CLUSTER_NAME --region=REGION` then `kubectl apply`.
- **Cloud Build:** Use `cloudbuild.yaml` to build image, push to Artifact Registry, and run `gcloud run deploy` (or deploy to GKE). Set up triggers for Git push for continuous deployment.
- **MCP:** GCP does not provide a single “deploy my app” MCP. You can host custom MCP servers on Cloud Run (streamable HTTP transport). For deployment automation, use gcloud/Cloud Build in scripts or CI; for AI-assisted deploy flows, use CLI from an AI client or custom MCP hosted on Cloud Run. Docs: https://cloud.google.com/run/docs/host-mcp-servers, https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run.

## Output: deployment.md and deployment-runbook.md

**MANDATORY**: Produce/update TWO files in the workspace root.

### File 1: deployment.md — Deployment Guide

1. **Overview**: What is deployed, to which GCP project and environments
2. **GCP Infrastructure Architecture**: Mermaid diagram of the full GCP stack
3. **GCP Services Required**: Table of services, purpose, and configuration notes
4. **Environment Configuration**: Required env vars and GCP Secret Manager setup
5. **Initial Setup**: First-time setup steps (enable GCP APIs, create GKE cluster, Artifact Registry, etc.). For org-managed setups, add subsection "Org-managed setup model" stating A1, A2, or B and the exact gcloud/Console steps (see "Personal vs org-managed GCP" above).
6. **Build & Deploy Procedures**: Step-by-step commands with examples
7. **CI/CD Pipeline**: Jenkins pipeline description and configuration
8. **Rollback Procedure**: How to roll back a failed deployment
9. **Monitoring & Alerting**: Cloud Monitoring dashboards and alert policies to configure
10. **Security Configuration**: IAM service accounts, Secret Manager setup, network policies. For org-managed, repeat which model (A1/A2/B) and any admin IAM steps here.
11. **Troubleshooting**: Common issues and their solutions

### File 2: deployment-runbook.md — Deployment Runbook (T14)

```markdown
# Deployment Runbook

Release: [v#.#.#]
Date: [YYYY-MM-DD]
Window: [HH:MM – HH:MM TZ]
Deployer: [Name]
On-Call: [Name, contact]
Rollback Owner: [Name]
Estimated Duration: [## minutes]

## Pre-Deployment Checklist (T-2 hours)

- [ ] QA sign-off received (link: \_\_\_\_)
- [ ] Security scan passed (link: \_\_\_\_)
- [ ] Release notes drafted (link: \_\_\_\_)
- [ ] Rollback procedure reviewed and tested
- [ ] On-call engineer confirmed available
- [ ] Stakeholders notified of deployment window
- [ ] Database migration tested on staging (if applicable)
- [ ] Feature flags configured for controlled rollout
- [ ] Monitoring dashboards open and baselined

## Deployment Steps

[Step 1: Database Migration, Step 2: Deploy Backend Services, Step 3: Deploy Frontend, Step 4: Post-Deployment Smoke Tests]

## Rollback Triggers (execute immediately if any are true)

- Error rate > 2x baseline for > 5 minutes
- P50 latency > 3x baseline for > 5 minutes
- Any smoke test fails
- Data integrity check fails
- Customer-reported critical issue

## Rollback Procedure

[Step-by-step rollback commands]

## Post-Deployment (T+1 hour)

[Verification checklist]

## Deployment Log

| Time | Action | Result | Notes |
```

In chat: summary of GCP services selected and key configuration decisions, then confirm `deployment.md`, `deployment-runbook.md`, and all config files were created.

## Security Requirements for All Deployment Configs

- [ ] No secrets hardcoded — all use GCP Secret Manager references in production
- [ ] Container runs as non-root user
- [ ] Resource limits defined on all containers
- [ ] IAM service accounts with minimal required permissions (least privilege)
- [ ] Container images scanned by Artifact Registry vulnerability scanning
- [ ] `.gitignore` covers all sensitive files (.env, credentials, service account keys)

## Completion Criteria

Before handoff, ensure:

- Read `architecture.md` and `development-plan.md`
- Confirmed deployment context: **personal** or **org-managed** (if org-managed: A1, A2, or B); **greenfield** or **brownfield**
- Gathered required GCP info from user (project ID, cluster, registry, domain, environments)
- Identified all required GCP services and documented them
- Created `Dockerfile` with multi-stage build
- Created Kubernetes manifests (namespace, deployment, service, ingress, configmap, HPA)
- Created `Jenkinsfile` CI/CD pipeline
- Created `nginx/nginx.conf`
- Created `.env.example`
- Created `deployment.md` with complete deployment guide
- Created `deployment-runbook.md` with pre-deployment checklist, step-by-step commands, rollback triggers, and deployment log
- All security requirements met in configs
- User reviewed and approved the deployment configuration

## Mandatory Output: release-notes.md

After deployment is verified, produce `release-notes.md` with:

- Release Date, Release Type (Major/Minor/Patch/Hotfix)
- New Features, Improvements, Bug Fixes
- Breaking Changes, Deprecations, Security
- Upgrade Instructions, Known Issues

**HANDOFF**: This is the final delivery mode. The pipeline is complete once deployment is verified and operational. Verify that all Critical and High findings from `security-review.md` have been addressed before deploying to production.
