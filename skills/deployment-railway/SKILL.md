---
name: deployment-railway
description: "Railway-only deployment: Projects, Services, environment variables, build/start, Railway Postgres/Redis, cron, and deploy from Git or CLI."
modeSlugs:
    - deploy
---

# Railway Deployment (Provider-Specific)

Use **only** when the deployment target is **Railway**. For deploy workflow context see `.nayan/rules-deploy/1_workflow.md` and `.nayan/skills/standard-deploy/SKILL.md`.

## When to Use This Skill

- The deployment target is Railway (per architecture.md or user confirmation).
- Deploying a service, full-stack app, or worker to Railway.
- Configuring or executing a Railway deployment.

## When NOT to Use This Skill

- Deployment target is not Railway (use deployment-vercel, deployment-render, or deployment-gcp as appropriate).
- Writing application code or designing architecture.

---

## Greenfield and brownfield

- **Greenfield:** Create a new Railway project (dashboard or CLI). From repo root run `railway link` (creates or selects project/environment), then `railway up` to deploy. For new projects without link, create project in dashboard and connect Git, or use `railway init` and add a service from the repo. Use `railway up -d` for detached deploy; `railway up -c` for CI (exits when build completes).
- **Brownfield:** Deploy an existing codebase: in repo root run `railway link` to link to an existing project (e.g. `railway link --project my-api --environment staging`). Then `railway up` deploys from current directory. Set Root Directory in service settings when app is in a subdirectory (e.g. `backend/`). Use `railway variables` to sync or set env vars.

---

## Railway-Only Concepts and Workflow

**Projects and Services**

- **Project:** Top-level container. One project can hold multiple services (e.g. backend, worker, cron).
- **Service:** One deployable unit. Create from “New” → GitHub repo or Railway CLI. Each service has its own build and start commands, env vars, and URL.
- **Repo linkage:** One service per repo (or per directory in a monorepo via Root Directory). For multi-repo, create one service per repo in the same or different projects.

**Build and Start**

- **Build Command:** Optional; default runs `npm install` / `pip install` etc. per detected stack. Override to match the repo (e.g. `pip install -r requirements.txt`, `npm ci && npm run build`).
- **Start Command:** Required for runnable services. Use `$PORT` for web apps (Railway injects `PORT`). Examples: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`, `node server.js`, `npm start`.
- **Root Directory:** Set when the app is in a subdirectory (e.g. `backend/`). Build and start run from this root.

**Environment Variables**

- **Variables:** Project or Service → Variables. Add key-value pairs; use the same names as `.env.example`. Railway can reference other services’ variables (e.g. `${{Postgres.DATABASE_URL}}`).
- **Secrets:** Sensitive values are encrypted; reference them the same way as variables in the dashboard or CLI.

**Databases and Add-ons (Railway)**

- **Postgres:** Add from Railway dashboard (New → Database → Postgres). Connect to the service via `DATABASE_URL` (or `POSTGRES_URL`) that Railway provides; use internal hostname for same-project access.
- **Redis:** Add similarly; use the provided URL in the app.
- **Templates:** Use Railway templates (e.g. Postgres + backend) when starting from scratch; then customize build/start and env.

**Cron and Workers**

- **Cron:** Use a Cron service type (or a worker service with a cron schedule in Railway). Set the schedule and the command to run (e.g. `python run_cron.py`). No HTTP port.
- **Workers:** Create a service with no public HTTP; set start command for queue consumers or jobs.

**Deploy and Branch**

- **Git:** Connect GitHub (or GitLab); deploys trigger on push. Set which branch to deploy (e.g. `main` or sprint branch). Each deployment gets a unique URL for preview if configured.
- **CLI:** Link with `railway link`; deploy with `railway up`. Options: `-s, --service` (specific service), `-e, --environment`, `-p, --project` (with `--environment`), `-d` (detached), `-c` or `--ci` (CI mode). **Note:** `railway deploy` is for pre-built templates (e.g. Postgres, Redis); use `railway up` for application code.

**CLI and MCP support**

- **CLI:** **Install:** `npm i -g @railway/cli` or `brew install railway` or `bash <(curl -fsSL cli.new)`. **Auth:** `railway login` or set `RAILWAY_TOKEN` / `RAILWAY_API_TOKEN`. **Link:** `railway link` (interactive) or `railway link --project <name> [--environment <env>]`. **Deploy:** `railway up` (streams logs), `railway up -d` (detached), `railway up -c` (CI). **Logs:** `railway logs`. **Variables:** `railway variables`, `railway variables set KEY=value`. Required for MCP. Docs: https://docs.railway.com/reference/cli-api.
- **MCP:** Railway MCP server for AI assistants (Cursor, Claude, Cline). **Setup:** One-click install or add to `.cursor/mcp.json` / `.vscode/mcp.json`: `npx -y @railway/mcp-server`; Claude: `claude mcp add Railway npx @railway/mcp-server`. **Prerequisite:** Railway CLI installed and authenticated. **Capabilities:** deploy, deploy-template, list-services, link-service, create-environment, link-environment, create-project-and-link, list-projects, set-variables, list-variables, generate-domain, get-logs. Destructive operations (delete) are not exposed. Use MCP when the deploy flow is driven by an AI client. Docs: https://docs.railway.com/reference/mcp-server.

**Verification (Railway)**

- Open the service URL and health endpoint (e.g. `/health`). Use Railway dashboard for deploy status, logs, and metrics. Request user post-deploy verification per HITL in `.nayan/skills/standard-deploy/SKILL.md`.
