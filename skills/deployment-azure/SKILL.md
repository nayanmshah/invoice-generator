---
name: deployment-azure
description: "Azure deployment for personal or org-managed setups; greenfield and brownfield. App Service, AKS, Functions, Static Web Apps; org-managed IAM patterns (A1/A2/B)."
modeSlugs:
    - deploy
---

# Azure Deployment

Use when the deployment target is **Azure**. For workflow see `.nayan/rules-deploy/1_workflow.md` and `.nayan/skills/standard-deploy/SKILL.md`.

## When to Use This Skill

- The deployment target is Azure (per architecture.md or user confirmation).
- Deploying to App Service, AKS, Functions, Static Web Apps, or other Azure services.
- Configuring or executing an Azure deployment.

## When NOT to Use This Skill

- Deployment target is not Azure (use deployment-gcp, deployment-vercel, deployment-render, deployment-railway, or deployment-aws as appropriate).
- Writing application code or designing architecture.

---

## Deployment context: personal vs org-managed, greenfield vs brownfield

Establish both dimensions so the right steps and docs are produced.

| Dimension       | Meaning                                                                                                                                                                                                     | What to ask / document                                                                                                                                                                                                                                                                                                                |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Personal**    | User has direct access to an Azure subscription (Owner or Contributor) or to a resource group. No org-level constraints.                                                                                    | User confirms they have subscription/resource-group access. Proceed with standard setup and deploy steps in deployment.md.                                                                                                                                                                                                            |
| **Org-managed** | Org uses Entra ID (Azure AD) and management groups; access is controlled via RBAC and billing roles. Full subscription or app setup uses one of three patterns (see "Personal vs org-managed Azure" below). | Ask: "Which org-managed model?" → **A1** (admin creates subscription, grants user Owner/Contributor), **A2** (user has billing role to create subscriptions, gets access to new subscription), or **B** (bootstrap pipeline; user only triggers, gets limited access). Document chosen model and RBAC/billing steps in deployment.md. |
| **Greenfield**  | New subscription or new resources (new App Service, AKS, Function App, Static Web App, etc.). Setup from scratch.                                                                                           | Create subscription or resources, configure RBAC and Key Vault, deploy. Produce full deployment.md and runbook.                                                                                                                                                                                                                       |
| **Brownfield**  | Existing subscription and existing resources (App Service, AKS, Function App, etc.). Deploy app into current infra.                                                                                         | Use existing subscription, ACR, resource group; ensure RBAC and networking align. Deploy with CLI/CI; update runbook and rollback procedures.                                                                                                                                                                                         |

**Rule:** For every deployment, confirm (1) **Personal or org-managed?** If org-managed, which of A1, A2, or B. (2) **Greenfield or brownfield?** Then apply the matching procedures below and in deployment.md.

---

## Greenfield and brownfield

- **Greenfield:** New App Service: `az webapp up` from app directory or create via portal/CLI and deploy (ZIP, Git, or container). New Static Web App: connect Git in Azure portal or use `swa init` then `swa deploy`. New Functions: create Function App then `func azure functionapp publish <app-name>`. New AKS: create cluster, then `kubectl apply` or Helm.
- **Brownfield:** **Static Web Apps:** Deploy existing build with `swa deploy ./my-dist` (or `swa deploy ./my-dist --api-location ./api`). Get deployment token via `az staticwebapp secrets list --name APP_NAME --query "properties.apiKey"` or `SWA_CLI_DEPLOYMENT_TOKEN`. Use `swa-cli.config.json` or `swa init` for config. **App Service:** Link existing repo in Deployment Center or use `az webapp deployment source config`; or ZIP deploy. **Functions:** Publish existing project with `func azure functionapp publish`. **AKS:** Deploy to existing cluster with `kubectl apply` or Helm.

---

## Personal vs org-managed Azure

**Personal:** User has direct access to a subscription (Owner/Contributor) or resource group. No special RBAC flow; document standard setup and deploy steps in deployment.md.

**Org-managed:** Org uses Entra ID and management groups; full subscription or app setup uses one of three patterns. In deployment.md include an "Org-managed setup model" subsection under Initial Setup and Security Configuration that states which option is used and the exact RBAC/CLI steps (with placeholders for subscription ID, tenant ID, principal ID).

| Model                                             | Who creates/sets up the subscription or scope?                                                                                                                                                                                                                                                             | What the user gets                                                                                         |
| ------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| **A1** Admin creates subscription / grants access | Admin creates a new subscription (portal, EA, MCA, or CSP) and assigns user **Owner** or **Contributor** on the subscription (Azure RBAC).                                                                                                                                                                 | Full access to that subscription only; user runs setup and deploy.                                         |
| **A2** User creates subscription                  | User has a **billing role** that allows creating subscriptions: e.g. **Azure subscription creator** on an invoice section, or **Owner/Contributor** on an invoice section, billing profile, or billing account (Microsoft Customer Agreement). User creates subscription and gets Owner/Contributor on it. | Access to the new subscription they created; user runs setup and deploy.                                   |
| **B** Bootstrap pipeline                          | Automation (Terraform, Bicep, ARM, Azure DevOps) runs with a service principal that has subscription/resource creation rights; user only triggers.                                                                                                                                                         | User triggers pipeline; gets limited access (e.g. Contributor on a resource group); no subscription Owner. |

**Actionable steps for deployment.md (org-managed only)**

- **A1 — Admin creates subscription or grants access**  
  Admin: Create subscription in Azure portal (or via EA/MCA/CSP) and assign user **Owner** or **Contributor** on the subscription (or scope to a resource group). User: `az login`, `az account set --subscription SUBSCRIPTION_ID`, then run setup and deploy from deployment.md. [RBAC: https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal; Subscriptions: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/create-subscription]
- **A2 — User creates subscription**  
  Admin: Grant user a **billing role** that allows subscription creation: e.g. **Azure subscription creator** on an invoice section, or **Owner** or **Contributor** on an invoice section, billing profile, or billing account (Microsoft Customer Agreement). These are billing roles, not standard Azure RBAC. User: Create subscription via Azure portal or programmatic API (MCA); switch to new subscription (`az account set --subscription SUBSCRIPTION_ID`); run setup and deploy. [Subscriptions: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/create-subscription; Billing roles: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/understand-mca-roles]
- **B — Bootstrap pipeline**  
  Admin: Define subscription/resource bootstrap in Terraform, Bicep, or Azure DevOps. Pipeline runs with a service principal that has subscription and resource creation permissions. Store credentials in Key Vault or CI secrets; never give to end users. Optionally assign user Contributor on a resource group in the new subscription. User: Trigger pipeline (e.g. "Create subscription" or "Deploy to subscription" job with params).

---

## Azure-Only Concepts and Workflow

**Compute Options**

- **App Service:** Managed web apps (Windows or Linux). Use for backends (Node, Python, Java, .NET, Docker). Set stack/runtime, build and start commands; app listens on `PORT` (Azure sets it). Use App Service Plan for scaling (B1, P1v2, etc.).
- **AKS (Azure Kubernetes Service):** Managed Kubernetes. Use for containerized workloads. Deploy with kubectl/Helm; use ACR for images. Configure ingress (e.g. NGINX or Application Gateway), HPA, and secrets (Key Vault CSI or Kubernetes secrets).
- **Functions:** Serverless (HTTP trigger, timer, queue, etc.). Use Azure Functions Core Tools or VS Code for local dev; deploy via `func azure functionapp publish <app-name>`. Supports Node, Python, Java, .NET, PowerShell. Use Function App with consumption or premium plan.
- **Static Web Apps:** Static and full-stack (API in same app). Connect Git; Azure builds (e.g. `npm run build`) and deploys. Use for React, Vue, Next.js static export, or Blazor. Configure build (app and API locations), env vars, and custom domains.

**Containers and Registry**

- **ACR:** Azure Container Registry for Docker images. Push with `az acr login`, then `docker push <registry>.azurecr.io/<repo>:<tag>`. AKS can pull from ACR via managed identity or admin credentials.
- **App Service (Linux) with Docker:** Use Web App for Containers; set image from ACR or Docker Hub in configuration.

**Environment and Secrets**

- **Env vars:** Set in App Service (Configuration → Application settings), Functions (Application settings), Static Web Apps (Environment variables), or AKS (ConfigMaps/Secrets). Use same keys as `.env.example`.
- **Key Vault:** Use for production secrets. Reference in App Service (Key Vault references), Functions (Key Vault references), or AKS (CSI driver or init container). Never commit secrets.

**Build and Deploy**

- **Build:** Static Web Apps runs build in Azure (config in repo). For App Service/Functions/AKS, build locally or in CI (e.g. GitHub Actions, Azure DevOps) and push image or deploy (ZIP, run-from-package, or kubectl).
- **Deploy:** App Service: `az webapp up`, ZIP deploy, or Git; Functions: `func azure functionapp publish`; AKS: `kubectl apply` or Helm; Static Web Apps: auto-deploy on Git push. Use Azure DevOps Pipelines or GitHub Actions for custom pipelines if required.

**CLI and Automation**

- **Azure CLI:** Install: `brew install azure-cli` or https://docs.microsoft.com/en-us/cli/azure/install-azure-cli. Auth: `az login`. **App Service:** `az webapp up` (from app dir), or `az webapp deployment source config` for Git. **Static Web Apps:** `swa login`, then `swa deploy ./output`; token from `az staticwebapp secrets list`. **ACR:** `az acr login` then `docker push`. **AKS:** `az aks get-credentials --resource-group RG --name CLUSTER` then `kubectl apply`. Docs: https://docs.microsoft.com/en-us/cli/azure/.
- **Static Web Apps CLI:** Install: `npm i -g @azure/static-web-apps-cli`. Config: `swa init`; deploy: `swa deploy ./dist` (see build config for app/api locations).
- **Functions Core Tools:** `npm i -g azure-functions-core-tools@4`. Publish: `func azure functionapp publish <app-name>`.
- **CI/CD:** GitHub Actions (OIDC or secrets), Azure DevOps Pipelines. Build → test → push to ACR or deploy to App Service/Functions/Static Web Apps/AKS.
- **MCP:** Official **Azure MCP Server** (Microsoft) for AI tools (Cursor, VS Code, Claude, Cline). **Install:** NPM `@azure/mcp`, PyPI `msmcp-azure`, or NuGet `Azure.Mcp`. **Auth:** Uses Azure CLI credentials or managed identity (RBAC). **Capabilities:** App Service (e.g. database connections), Functions (list), AKS (list clusters), ACR (list registries), Key Vault, Storage, and many other Azure services; read and write where allowed. Supports read-only mode and namespace filtering. Use for AI-assisted deploy flows and resource inspection. Remote deploy: `azd init -t azmcp-foundry-aca-mi` and `azd up` for Container Apps. Docs: https://learn.microsoft.com/en-us/azure/developer/azure-mcp-server/get-started.

**Networking and Security**

- **Application Gateway / App Service custom domains:** Terminate HTTPS and attach custom domains; use App Service Managed Certificates or upload certificate.
- **Managed identity:** Use for App Service, Functions, or AKS to access Key Vault, ACR, or storage without storing credentials.

**Verification (Azure)**

- **App Service / Functions:** Hit the app URL and health endpoint (e.g. `/health`). Check App Service/Functions logs and metrics in Azure portal.
- **AKS:** Use `kubectl` to check pods and services; hit ingress URL and health endpoint.
- **Static Web Apps:** Confirm the app URL serves the built assets; check deployment status in Azure portal.
- Request user post-deploy verification per HITL in `.nayan/skills/standard-deploy/SKILL.md`.
