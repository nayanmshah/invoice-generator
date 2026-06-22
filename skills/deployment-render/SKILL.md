---
name: deployment-render
description: "Render-only deployment: Web Services, Static Sites, Background Workers, environment variables, build/start commands, and Render add-ons (e.g. PostgreSQL)."
modeSlugs:
    - deploy
---

# Render Deployment (Provider-Specific)

Use **only** when the deployment target is **Render**. For deploy workflow context see `.nayan/rules-deploy/1_workflow.md` and `.nayan/skills/standard-deploy/SKILL.md`.

## When to Use This Skill

- The deployment target is Render (per architecture.md or user confirmation).
- Deploying a web service, static site, or background worker to Render.
- Configuring or executing a Render deployment.

## When NOT to Use This Skill

- Deployment target is not Render (use deployment-vercel, deployment-railway, or deployment-gcp as appropriate).
- Writing application code or designing architecture.

---

## Greenfield and brownfield

- **Greenfield:** Create a new Web Service, Static Site, or Background Worker from the Render dashboard (New → connect Git repo). Set build command, start command (or publish directory for static), and env vars. Render builds and deploys on push; zero-downtime deploys and auto-scaling.
- **Brownfield:** Connect an existing repo to Render: add a new service, select the repo and branch, set Root Directory if the app is in a subdirectory. Configure build/start to match the existing project. Use Manual Deploy from the dashboard or CLI when not using auto-deploy. Preview environments (per PR/branch) when enabled.

---

## Render-Only Concepts and Workflow

**Services**

- **Web Service:** Long-running HTTP service. Set build command, start command, and listen on `PORT` (Render sets `PORT`). Use for backends (e.g. FastAPI, Flask, Express, Spring Boot).
- **Static Site:** Pre-built static assets. Set build command (e.g. `npm run build`) and publish directory (e.g. `dist`, `out`, `build`). Render serves the output; no server process.
- **Background Worker:** No HTTP port. Set build and start command for queues, cron, or workers. No health check URL.

**Build and Start Commands**

- **Build Command:** Installs deps and builds (e.g. `pip install -r requirements.txt`, `npm install && npm run build`, `mvn -DskipTests package`). Use the project’s actual build steps.
- **Start Command:** Runs the app. Must listen on `$PORT` for Web Services (e.g. `uvicorn app.main:app --host 0.0.0.0 --port $PORT`, `node server.js`, `java -jar target/app.jar`). Do not hardcode a port; use `PORT` from the environment.

**Environment and Secrets**

- **Environment:** Render dashboard → Service → Environment. Add env vars and secrets; same keys as `.env.example`. Use **Secret Files** for multi-line or file-based config when needed.
- **Environment Groups:** Reuse the same env set across multiple services if applicable.

**Branch and Deploy**

- Connect a Git repo; choose branch for auto-deploys (e.g. `main` or sprint branch). Each push can trigger a new deploy; use Manual Deploy when not using auto-deploy.
- **Preview environments:** When enabled, PRs or branches get a dedicated URL; configure per Render plan.

**CLI and MCP support**

- **CLI:** Install from https://github.com/render-oss/cli (Go). Auth: `render login` (CLI token from Render dashboard → Account Settings). **Deploy:** `render deploys create [SERVICE_ID]` — optional `--commit <SHA>` (Git-backed), `--image <URL>` (image-backed), `--wait` (block until deploy completes). **List:** `render deploys list [SERVICE_ID]`. Use for CI/CD and scripted deploys. Docs: https://render.com/docs/cli.
- **API:** REST API for services, deploys, jobs, metrics, logs, custom domains, Blueprints, env. Use for automation when CLI is insufficient. Docs: https://docs.render.com/api.
- **MCP:** Official Render MCP server for AI apps (Cursor, Claude, etc.). **Setup:** Create an API key in Render dashboard; add MCP config (e.g. Cursor: `~/.cursor/mcp.json`) with URL `https://mcp.render.com/mcp` and API key. **Capabilities:** Provision web services, static sites, cron jobs, databases; monitor (metrics, CPU, memory, HTTP traffic); query logs; set env vars and deployment options. Destructive operations (e.g. delete services) are not exposed. Use MCP when the deploy flow is driven by an AI client. Docs: https://render.com/docs/mcp-server.

**Add-ons (Render)**

- **PostgreSQL:** Create from Render dashboard; attach to the service. Use the provided `DATABASE_URL` (or `INTERNAL_URL`) in the app. No external DB URL needed when using Render Postgres.
- Other add-ons (Redis, etc.) per Render’s catalog; wire via env vars they provide.

**Verification (Render)**

- **Web Service:** Hit the service URL and health endpoint (e.g. `/health`). Check Render dashboard for deploy status and logs.
- **Static Site:** Confirm the published URL serves the built assets.
- Request user post-deploy verification per HITL in `.nayan/skills/standard-deploy/SKILL.md`.
