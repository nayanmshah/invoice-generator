---
name: jenkins-cicd
description: Jenkins CI/CD for deployment: Jenkinsfile (declarative pipeline), stages (checkout, build, test, code quality, Docker/build, deploy), and integration with deployment targets (GKE, ECS, Azure, etc.).
modeSlugs:
    - deploy
---

# Jenkins CI/CD Deployment

Use this skill when the **CI/CD pipeline** for deployment is **Jenkins**. For deploy workflow see `.nayan/rules-deploy/1_workflow.md`. For the actual deployment target (GCP, AWS, Azure, etc.), use the corresponding deployment-{provider} skill; this skill covers the Jenkins pipeline and Jenkinsfile only.

## When to Use This Skill

- The organization or user has chosen Jenkins as the CI/CD tool for deployment.
- Creating or updating a Jenkinsfile (declarative pipeline) for build, test, and deploy.
- Designing deployment pipeline stages (checkout, build, test, code quality, artifact push, deploy, smoke test).
- Integrating Jenkins with a deployment target (GKE, ECS, Azure, Artifact Registry, ECR, ACR).

## When NOT to Use This Skill

- CI/CD is not Jenkins (e.g. GitHub Actions, GitLab CI, Cloud Build, CodePipeline). Use the provider’s native CI or the referenced pipeline tool.
- Only defining infrastructure or runbooks without a Jenkins pipeline.
- Writing application code or designing application architecture.

---

## Greenfield and brownfield

- **Greenfield:** Create a new Jenkinsfile in the repo root (or in each repo for multi-repo). Define a declarative pipeline with stages for checkout, build, test, code quality (e.g. SonarQube), Docker build and push (or equivalent artifact), deploy to target, and smoke test. Create the Jenkins job (Pipeline from SCM) pointing at this repo and branch.
- **Brownfield:** Update an existing Jenkinsfile or Jenkins job. Add or adjust stages (e.g. code quality, security scan, deploy step) to match the current deployment target. Use existing credentials and agents; parameterize branch, environment, or target when needed.

---

## Pipeline structure (declarative)

Use a **declarative pipeline** with clear stages. Typical order:

1. **Checkout** — SCM checkout (Git).
2. **Build & Test** — Build the app and run unit/integration tests.
3. **Code Quality** — SonarQube (or equivalent) when configured; fail the build on quality gate if required.
4. **Security scan** — Run security scan (e.g. Veracode, npm/pip audit) when required; fail on critical/high per org policy.
5. **Build artifact / Docker** — Build the deployable artifact (e.g. Docker image, ZIP). Push to the appropriate registry (Artifact Registry, ECR, ACR, or private registry).
6. **Deploy** — Deploy to the target using the provider’s method (e.g. `kubectl apply` for GKE, `aws ecs update-service` for ECS, `az webapp` or Azure DevOps for Azure). Use the deployment-{provider} skill for exact commands and patterns.
7. **Smoke test** — Hit health or smoke endpoints to verify the deployment.

Keep credentials in Jenkins (credentials store), not in the Jenkinsfile. Use `environment {}` or `withCredentials` for secrets.

---

## Jenkinsfile outline

```groovy
pipeline {
  agent any
  environment {
    // Use Jenkins credentials; avoid hardcoding
    REGISTRY = credentials('registry-creds-id')
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Build & Test') {
      steps {
        sh 'npm ci'   // or mvn, pip, etc.
        sh 'npm run test'
      }
    }
    stage('Code Quality') {
      when { anyOf { buildingTag(); expression { env.SONAR_ENABLED == 'true' } } }
      steps {
        // SonarQube scanner or equivalent
      }
    }
    stage('Docker Build & Push') {
      steps {
        script {
          docker.build("${IMAGE}:${BUILD_NUMBER}")
          docker.withRegistry(REGISTRY_URL, 'registry-creds-id') {
            docker.image("${IMAGE}:${BUILD_NUMBER}").push()
          }
        }
      }
    }
    stage('Deploy') {
      steps {
        // Target-specific: use deployment-gcp, deployment-aws, deployment-azure
        // e.g. GKE: sh 'kubectl set image deployment/...'
        // e.g. ECS: sh 'aws ecs update-service ...'
      }
    }
    stage('Smoke Test') {
      steps {
        sh 'curl -f ${APP_URL}/health || true'
      }
    }
  }
  post {
    failure { /* notify */ }
    success { /* optional notify */ }
  }
}
```

---

## Integration with deployment targets

- **GCP (GKE / Artifact Registry):** Build and push image to Artifact Registry; deploy with `kubectl apply` or Helm. Use **deployment-gcp** for registry URL, GKE context, and runbook. Jenkins needs a service account key or workload identity for GCP.
- **AWS (ECS / ECR):** Build and push to ECR; deploy with `aws ecs update-service --force-new-deployment`. Use **deployment-aws** for ECR and ECS details. Jenkins needs AWS credentials (access key or IAM role).
- **Azure (ACR / AKS / App Service):** Build and push to ACR; deploy with `az webapp` or `kubectl` for AKS. Use **deployment-azure** for commands and config. Jenkins needs Azure service principal or managed identity.
- **Multi-target:** Use a parameter (e.g. `DEPLOY_TARGET`) or branch-based logic to choose the deploy stage (GKE vs ECS vs Azure). Keep one Jenkinsfile with conditional deploy steps, or one per target if preferred.

---

## Credentials and agents

- Store secrets in Jenkins Credentials (e.g. registry IDs, cloud provider keys). Reference by credential ID in the pipeline.
- Use dedicated agents (labels) for Docker build or cloud CLI if required (Docker-in-Docker, or agents with `kubectl`/`aws`/`az` installed).
- For greenfield, document required credentials and agent capabilities in deployment.md.

---

## Verification

- Pipeline runs on the intended branch (e.g. `main` or release branch).
- All stages (build, test, code quality, deploy, smoke test) are present and pass when applicable.
- Deployment target and commands match the chosen provider (see deployment-gcp, deployment-aws, deployment-azure).
- Request user post-deploy verification per HITL in `.nayan/skills/standard-deploy/SKILL.md`.
