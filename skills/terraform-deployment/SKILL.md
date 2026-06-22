---
name: terraform-deployment
description: "Terraform for deployment and infrastructure: state, providers (AWS, GCP, Azure), plan/apply, workspaces, backend config, and integration with deployment targets."
modeSlugs:
    - deploy
---

# Terraform Deployment

Use this skill when **deployment or infrastructure** is managed with **Terraform** (infrastructure as code). For deploy workflow see `.nayan/rules-deploy/1_workflow.md`. For provider-specific resources and app deployment patterns, combine with deployment-gcp, deployment-aws, or deployment-azure as needed.

## When to Use This Skill

- The organization or user uses Terraform for provisioning or managing deployment infrastructure (e.g. VPC, clusters, registries, app services).
- Creating or updating Terraform configuration (`.tf`), state, and backend for deployment-related resources.
- Planning or applying infrastructure changes (terraform plan / apply) as part of the deployment flow.
- Managing multiple environments (dev, staging, prod) via Terraform workspaces or separate state.

## When NOT to Use This Skill

- Infrastructure is not managed with Terraform (e.g. pure Cloud Formation, ARM, or manual/console). Use the deployment-{provider} skill only.
- Only writing application code or designing application architecture.
- Only defining CI/CD (e.g. Jenkinsfile) without Terraform.

---

## Greenfield and brownfield

- **Greenfield:** Create a new Terraform project: `terraform init`, define provider(s) (e.g. aws, google, azurerm), resources (e.g. ECS cluster, GKE cluster, App Service), and a remote backend (S3, GCS, or Azure Storage) for state. Use `terraform plan` then `terraform apply` with approval. Document required variables and outputs in README or deployment.md.
- **Brownfield:** Use existing state and backend. Run `terraform init` (with backend config if needed). For existing resources not in state, use `terraform import` to bring them under Terraform. Use workspaces or separate state per environment. Change resources via code then `plan` and `apply`; avoid ad-hoc console changes to avoid drift.

---

## Core concepts

- **State:** Terraform state tracks resources. Use a **remote backend** (S3 + DynamoDB, GCS, or Azure Storage) for team/production. Never commit `.tfstate` with secrets; use backend config and locking.
- **Providers:** Declare and pin provider versions (e.g. `required_providers` for aws, google, azurerm). Authenticate via env vars or provider-specific config (e.g. AWS credentials, GCP ADC, Azure CLI).
- **Plan and apply:** Always run `terraform plan` before `apply`; in CI, run plan in the pipeline and require manual or automated approval for apply. Use `-out=tfplan` and `terraform apply tfplan` for predictable applies.
- **Workspaces:** Use `terraform workspace` for multiple environments (e.g. dev, staging, prod) with one codebase and separate state per workspace, or use separate state files/backends per environment.

---

## CLI and workflow

- **Install:** https://developer.hashicorp.com/terraform/install. Use a version consistent with the project (e.g. `required_version` in Terraform block).
- **Init:** `terraform init` (and `-reconfigure` when changing backend). Use `-backend-config=` for non-default backend settings.
- **Plan:** `terraform plan -out=tfplan` (optional). Review plan for expected creates/updates/destroys.
- **Apply:** `terraform apply` or `terraform apply tfplan`. Use `-auto-approve` only in automated pipelines when appropriate.
- **Destroy:** `terraform destroy` for teardown; use with care and prefer targeting when possible.
- **Import:** `terraform import RESOURCE_ADDRESS ID` to add existing resources to state.
- **Workspace:** `terraform workspace list`, `terraform workspace select NAME`, `terraform workspace new NAME`.

---

## Terraform MCP server

When generating or updating Terraform configuration, prefer **current provider documentation and registry data** over static training data. The [Terraform MCP server](https://developer.hashicorp.com/terraform/mcp-server) (HashiCorp, beta) implements the Model Context Protocol so an AI model can:

- **Search and retrieve current provider documentation** — Reduces outdated or incorrect resource/argument usage in generated `.tf`.
- **Access Terraform Registry** — Provider docs, **modules** (inputs, outputs, examples), and **Sentinel policies** for governance.
- **HCP Terraform / Terraform Enterprise** — When the org uses HCP Terraform or TFE: list organizations and workspaces, create/update/delete workspaces, manage variables, tags, and variable sets, and run operations.

**Use it when:** The environment has the Terraform MCP server configured and connected to the AI client (e.g. Cursor, Claude Desktop). Then rely on its tools for provider lookups and module examples when writing or refining Terraform for deployment. This yields more accurate, registry-aligned configuration.

**Note:** This feature is [in beta](https://developer.hashicorp.com/terraform/mcp-server); do not depend on it as the sole source of truth for production-critical automation without user awareness. For setup: [Terraform MCP server repository](https://github.com/hashicorp/terraform-mcp-server) and [releases](https://developer.hashicorp.com/terraform/mcp-server#additional-resources) for prebuilt binaries; transport can be stdio or streamable HTTP.

---

## Backend and variables

- **Backend:** Prefer remote backend (e.g. `backend "s3"` with bucket and DynamoDB table for lock). Configure via `backend "..."` block or `-backend-config` so state and lock are shared and secure.
- **Variables:** Use `variable` and `terraform.tfvars` or env vars (`TF_VAR_*`). Never commit secrets in `.tf` or `.tfvars`; use a secrets manager or CI variables and inject at plan/apply time.
- **Outputs:** Define `output` for values needed by app deploy or other systems (e.g. cluster name, registry URL, app URL).

---

## Integration with deployment targets

- **Terraform provisions infra only:** Use Terraform to create clusters, registries, queues, etc. Application deployment (e.g. container image push and service update) is done separately via deployment-gcp, deployment-aws, deployment-azure, or Jenkins/GitHub Actions.
- **Terraform deploys app-related resources:** Use provider resources (e.g. aws_ecs_service, google_cloud_run_service, azurerm_linux_web_app) to manage the runtime; keep build and image push in CI (e.g. Jenkins, Cloud Build). Combine this skill with the relevant deployment-{provider} skill for naming, regions, and best practices.
- **State and credentials:** Ensure the pipeline or user running Terraform has provider credentials (AWS/GCP/Azure) and access to the state backend.
- **Org-managed bootstrap (e.g. GCP):** For “full project setup from scratch” without sharing org admin, Terraform can run as a **pipeline service account** with org/folder privileges (Project Creator, APIs, GKE, etc.). Users only trigger the pipeline and receive limited access (e.g. Viewer/Developer) on the new project; they never get the powerful credentials. See deployment-gcp “Org-managed GCP: full project setup without sharing org admin” for the full pattern and IAM options.

---

## Verification

- `terraform plan` shows no unexpected changes when re-run after apply (no drift).
- State is stored in the configured backend and locked during apply.
- Outputs and provisioned resources align with deployment.md and the chosen deployment-{provider} setup.
- Request user post-deploy verification per HITL in `.nayan/skills/standard-deploy/SKILL.md` when Terraform is part of the deployment flow.
