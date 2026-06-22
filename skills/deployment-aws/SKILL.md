---
name: deployment-aws
description: "AWS deployment for personal or org-managed setups; greenfield and brownfield. EC2, ECS, Lambda, Amplify, Elastic Beanstalk; org-managed IAM patterns (A1/A2/B)."
modeSlugs:
    - deploy
---

# AWS Deployment

Use when the deployment target is **AWS**. For workflow see `.nayan/rules-deploy/1_workflow.md` and `.nayan/skills/standard-deploy/SKILL.md`.

## When to Use This Skill

- The deployment target is AWS (per architecture.md or user confirmation).
- Deploying to EC2, ECS, Lambda, Amplify, Elastic Beanstalk, or other AWS services.
- Configuring or executing an AWS deployment.

## When NOT to Use This Skill

- Deployment target is not AWS (use deployment-gcp, deployment-vercel, deployment-render, deployment-railway, or deployment-azure as appropriate).
- Writing application code or designing architecture.

---

## Deployment context: personal vs org-managed, greenfield vs brownfield

Establish both dimensions so the right steps and docs are produced.

| Dimension       | Meaning                                                                                                                                                                      | What to ask / document                                                                                                                                                                                                                                                                                                                                           |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Personal**    | User has direct access to an AWS account (root, IAM admin, or Developer in that account). No org-level constraints.                                                          | User confirms they have account access. Proceed with standard setup and deploy steps in deployment.md.                                                                                                                                                                                                                                                           |
| **Org-managed** | Org uses AWS Organizations; access is controlled via OUs, SCPs, and IAM/SSO. Full account or app setup uses one of three patterns (see "Personal vs org-managed AWS" below). | Ask: "Which org-managed model?" → **A1** (admin creates account, grants user access), **A2** (user in management account creates account via Organizations or Account Factory, gets access via OrganizationAccountAccessRole/SSO), or **B** (bootstrap pipeline; user only triggers, gets limited access). Document chosen model and IAM steps in deployment.md. |
| **Greenfield**  | New account or new resources (new ECS cluster, new Lambda, new Amplify app, etc.). Setup from scratch.                                                                       | Create account or resources, configure IAM, deploy. Produce full deployment.md and runbook.                                                                                                                                                                                                                                                                      |
| **Brownfield**  | Existing account and existing resources (cluster, function, Amplify app). Deploy app into current infra.                                                                     | Use existing account, ECR, cluster; ensure IAM and networking align. Deploy with CLI/CI; update runbook and rollback procedures.                                                                                                                                                                                                                                 |

**Rule:** For every deployment, confirm (1) **Personal or org-managed?** If org-managed, which of A1, A2, or B. (2) **Greenfield or brownfield?** Then apply the matching procedures below and in deployment.md.

---

## Greenfield and brownfield

- **Greenfield:** New Amplify app: connect Git in Amplify console; configure build spec and env. New ECS/Lambda/Beanstalk: create task definition or function or environment; deploy via CLI or CI. New EC2: launch from AMI, configure user data and security groups.
- **Brownfield:** **Amplify:** Connect existing repo; reuse existing Amplify backend across apps (Gen 1) or connect to existing backend env. **ECS:** Deploy to existing cluster with `aws ecs update-service --cluster CLUSTER --service SERVICE --force-new-deployment`. **Lambda:** Update code with `aws lambda update-function-code --function-name NAME --zip-file|--image-uri`. **Elastic Beanstalk:** `eb deploy` to existing environment. **Existing infra:** Use CDK migrate (`cdk migrate --from-scan` or `--from-stack`) or `cdk import` to bring existing resources under IaC; then `cdk deploy` for updates.

---

## Personal vs org-managed AWS

**Personal:** User has direct access to an AWS account (root, IAM admin, or sufficient roles). No special IAM flow; document standard setup and deploy steps in deployment.md.

**Org-managed:** Org uses AWS Organizations; full account or app setup uses one of three patterns. In deployment.md include an "Org-managed setup model" subsection under Initial Setup and Security Configuration that states which option is used and the exact IAM/CLI steps (with placeholders for account ID, OU ID, role ARNs).

| Model                                                         | Who creates/sets up the account or scope?                                                                                                                                                                                                                                                                                         | What the user gets                                                                                                              |
| ------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **A1** Admin creates account / grants access                  | Admin creates a new account (or OU) or grants user access to an existing account (e.g. IAM role or SSO permission set scoped to that account).                                                                                                                                                                                    | Full access to that account only; user runs setup and deploy.                                                                   |
| **A2** User creates account (Organizations / Account Factory) | User (in the **management account**) has `organizations:CreateAccount` and creates the account via CLI/Console, or user uses **Account Factory** (Control Tower) with the right IAM Identity Center group (e.g. AWSAccountFactory). New account gets **OrganizationAccountAccessRole** so management-account users can assume in. | Access to the new account (e.g. via assume role or SSO); user runs setup and deploy.                                            |
| **B** Bootstrap pipeline                                      | Automation (Terraform, Control Tower, StackSets, Account Factory) runs with an org-level or management-account role; user only triggers (e.g. request new account or deploy).                                                                                                                                                     | User triggers pipeline; gets limited access (e.g. PowerUser or Developer in the new account); no org/management-account access. |

**Actionable steps for deployment.md (org-managed only)**

- **A1 — Admin creates account or grants access**  
  Admin: From the **management account**, create account (Console or `aws organizations create-account`); new account gets OrganizationAccountAccessRole. Grant user an IAM role or SSO permission set scoped to that account (or OU). User: Assume role or use SSO to that account, then run setup and deploy from deployment.md. [IAM: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html; Organizations: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_create.html]
- **A2 — User creates account**  
  Admin: In the **management account**, grant user `organizations:CreateAccount` (and `organizations:DescribeCreateAccountStatus`). For Account Factory: grant `AWSServiceCatalogEndUserFullAccess` and add user to IAM Identity Center group (e.g. AWSAccountFactory). New member accounts get **OrganizationAccountAccessRole** by default (management-account users can assume it). User: Run `aws organizations create-account` (from management account only) or provision via Account Factory; assume OrganizationAccountAccessRole in the new account; run setup and deploy. [Organizations: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_create.html; Account Factory: https://docs.aws.amazon.com/controltower/latest/userguide/account-factory.html]
- **B — Bootstrap pipeline**  
  Admin: Define account/resource bootstrap in Terraform, Control Tower, or StackSets. Pipeline or automation runs with a role that has org/account-creation and resource-creation permissions. Store credentials in CI/secrets; never give to end users. Optionally grant user a limited role (e.g. PowerUser) in the new account. User: Trigger pipeline (e.g. "Create account" or "Deploy to account" job with params).

---

## AWS-Only Concepts and Workflow

**Compute Options**

- **EC2:** Virtual servers. Use for long-running apps, custom AMIs, or when you need full OS control. Configure security groups, IAM instance profiles, and user data for bootstrap.
- **ECS (Fargate):** Serverless containers. Use for Dockerized apps without managing servers. Task definitions define image (ECR), CPU/memory, env, and logging. Use Application Load Balancer (ALB) for HTTP(S).
- **Lambda:** Serverless functions. Use for event-driven or API (API Gateway) workloads. Package as ZIP or container image (ECR). Set handler, runtime, memory, timeout, and env vars. Use Lambda function URL or API Gateway for HTTP.
- **Elastic Beanstalk:** Platform-as-a-Service for web apps (Node, Python, Java, .NET, Docker). Handles capacity, load balancing, and scaling. Deploy via EB CLI or `eb deploy`; use `.ebextensions` for config.
- **Amplify:** Frontend and full-stack (static sites, SSR with Next.js). Connect Git; Amplify builds and deploys. Use for React, Vue, Next.js, or static hosting. Configure build spec (build command, output dir), env vars, and custom domains.

**Containers and Registry**

- **ECR:** Elastic Container Registry for Docker images. Push with `aws ecr get-login-password | docker login`, then `docker push <account>.dkr.ecr.<region>.amazonaws.com/<repo>:<tag>`.
- **ECS:** Use Fargate for serverless or EC2 launch type for more control. Task definition references ECR image; service maintains desired count and integrates with ALB.

**Environment and Secrets**

- **Env vars:** Set in Elastic Beanstalk (configuration), Lambda (configuration), ECS (task definition), or Amplify (Environment variables). Use same keys as `.env.example`.
- **Secrets Manager / Parameter Store:** Use for production secrets. Reference in Lambda via env or SDK; in ECS inject at task definition; in Beanstalk use `.ebextensions` or Parameter Store integration. Never commit secrets.

**Build and Deploy**

- **Build:** Amplify runs build in cloud (build spec). For ECS/Lambda/Beanstalk, build locally or in CI (e.g. GitHub Actions, CodeBuild) and push image or deploy artifact.
- **Deploy:** `eb deploy` (Beanstalk), `aws ecs update-service` (ECS), Lambda via `aws lambda update-function-code` or CI; Amplify auto-deploys on Git push. Use CodePipeline + CodeDeploy for custom pipelines if required.

**CLI and Automation**

- **AWS CLI:** Install: `pip install awscli` or `brew install awscli`. Configure: `aws configure` (access key, secret, region) or IAM roles. **ECR:** `aws ecr get-login-password --region REGION | docker login ...` then `docker push`. **ECS:** `aws ecs update-service --cluster CLUSTER --service SERVICE --force-new-deployment`. **Lambda:** `aws lambda update-function-code --function-name NAME --zip-file fileb://dist.zip` or `--image-uri ECR_URI`. **Beanstalk:** `eb init`, `eb create` (greenfield), `eb deploy` (deploy to existing env). **Amplify:** Git-based deploys from console or Amplify CLI for backend. Docs: https://docs.aws.amazon.com/cli/.
- **Amplify CLI:** `npm i -g @aws-amplify/cli` for local backend and hosting; Amplify Hosting typically uses Git connect for deploys.
- **CDK/SAM:** `cdk deploy` for CDK apps; `sam deploy` for serverless (Lambda/API Gateway). Brownfield: `cdk migrate`, `cdk import` for existing resources.
- **CI/CD:** CodePipeline, CodeBuild, CodeDeploy, or GitHub Actions (OIDC). Build → test → push to ECR or deploy to Beanstalk/ECS/Lambda/Amplify.
- **MCP:** AWS does not provide a single “deploy my app” MCP. **Amazon Q Developer CLI** supports MCP (April 2025+) for extended tooling. **EKS MCP Server** (preview) enables AI-assisted Kubernetes operations on EKS. For general deployment automation, use AWS CLI or CDK from scripts/CI; for AI-driven flows, use CLI from an AI client or deploy custom MCP on ECS (see AWS guidance for deploying MCP servers). Docs: https://docs.aws.amazon.com/eks/latest/userguide/eks-mcp-introduction.html.

**Networking and Security**

- **ALB:** Use for ECS, Beanstalk, or EC2 to terminate HTTPS and route to targets. Attach ACM certificate for custom domain.
- **Security groups:** Restrict ingress/egress by port and source. IAM roles for least-privilege access from EC2/ECS/Lambda.

**Verification (AWS)**

- **ECS/Beanstalk/EC2:** Hit the ALB or instance URL and health endpoint (e.g. `/health`). Check ECS service events, Beanstalk health, or EC2 status.
- **Lambda:** Invoke via function URL or API Gateway; check CloudWatch Logs.
- **Amplify:** Confirm app URL serves the built app; check Amplify console for build and deploy status.
- Request user post-deploy verification per HITL in `.nayan/skills/standard-deploy/SKILL.md`.
