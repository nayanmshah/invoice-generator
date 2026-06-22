---
name: deployment-vercel
description: "Vercel-only deployment: Projects, framework presets, environment variables, branch and preview deployments, serverless functions, and Vercel CLI."
modeSlugs:
    - deploy
---

# Vercel Deployment (Provider-Specific)

Use **only** when the deployment target is **Vercel**. For deploy workflow context see `.nayan/rules-deploy/1_workflow.md` and `.nayan/skills/standard-deploy/SKILL.md`.

## When to Use This Skill

- The deployment target is Vercel (per architecture.md or user confirmation).
- Deploying a frontend or full-stack app to Vercel.
- Configuring or executing a Vercel deployment.

## When NOT to Use This Skill

- Deployment target is not Vercel (use deployment-render, deployment-railway, or deployment-gcp as appropriate).
- Writing application code or designing architecture.

---

## Greenfield and brownfield

- **Greenfield:** Create a new Vercel project (dashboard or CLI). Run `vercel link` in the repo root (or `vercel link --yes` in CI); first deploy with `vercel` (preview) or `vercel --prod` (production). Vercel creates the project if it doesn’t exist. For CI without interactive link, set `VERCEL_ORG_ID` and `VERCEL_PROJECT_ID`.
- **Brownfield:** Deploy an existing codebase to Vercel. In the repo root run `vercel link` to connect to an existing project (or create one). Pull env with `vercel env pull .env.local`. Deploy with `vercel` (preview) or `vercel deploy --prod`. Use `vercel promote [deployment-id]` to promote a preview to production. Root Directory in project settings when app lives in a subdirectory (e.g. `frontend/`).

---

## Vercel-Only Concepts and Workflow

**Projects**

- One Vercel Project per repo (or per frontend repo in multi-repo). Link Git repository in Vercel dashboard; Vercel uses the repo’s build and output settings.
- **Root Directory:** Set when the app lives in a subdirectory (e.g. `frontend/`). Leave blank when repo root is the app root.
- **Framework Preset:** Auto-detected for Next.js, or set explicitly (Next.js, Vite, Create React App, Static Export, etc.). Do not override with a different provider’s preset.

**Build and Output**

- **Build Command:** From project (e.g. `npm run build` or `next build`). Override only if the repo uses a different script.
- **Output Directory:** Next.js → `.next` (or Vercel default); static export → `out` or `dist` per framework. Must match the framework preset.
- **Install Command:** Default `npm install` or `yarn install`; use `pnpm install` if the repo uses pnpm.

**Environment Variables**

- Set in Vercel: Project → Settings → Environment Variables. Add variables per environment (Production, Preview, Development). Use same names as `.env.example`; never commit secrets.
- For Preview deployments, use Preview env vars or inherit from Production as needed.

**Deployments**

- **Production:** Deploys from the production branch (usually `main`). Production URL is the project’s main domain.
- **Preview:** Every push to a non-production branch (e.g. `story/IRD-123-sprint-0`) gets a unique preview URL. Use for sprint or PR verification.
- **Vercel CLI:** From repo root: `vercel` (preview) or `vercel deploy --prod` (production). `vercel [path-to-project]` deploys from a specific path. For staging without domain: `vercel --prod --skip-domain`; then `vercel promote [deployment-id]` when ready.

**CLI and MCP support**

- **CLI:** Install: `npm i -g vercel` (or `pnpm add -g vercel`). Auth: `vercel login`. **Link (greenfield/brownfield):** `vercel link` (interactive) or `vercel link --yes` (non-interactive). **Env:** `vercel env pull .env.local`. **Deploy:** `vercel` (preview), `vercel --prod` (production). **CI:** Set `VERCEL_ORG_ID` and `VERCEL_PROJECT_ID` to skip interactive link. Docs: https://vercel.com/docs/cli.
- **MCP:** Official Vercel MCP for AI tools (Cursor, Claude, etc.). **Setup:** `npx add-mcp https://mcp.vercel.com` or configure MCP server URL `https://mcp.vercel.com` (OAuth). **CLI:** `vercel mcp` (global), `vercel mcp --project` (project-specific). **Capabilities:** List projects/teams, fetch deployment logs, search Vercel docs. Use MCP when the deploy flow is driven by an AI client. Docs: https://vercel.com/docs/agent-resources/vercel-mcp, https://vercel.com/docs/cli/mcp.

**Serverless Functions (Vercel)**

- Next.js API routes under `app/api/` or `pages/api/` deploy as Vercel Serverless Functions. No extra config for default runtime.
- For other frameworks, place functions in the configured directory (e.g. `api/`) and follow Vercel’s serverless contract (request/response).

**Verification (Vercel)**

- Confirm the deployment URL (production or preview) loads and, if applicable, that API routes or serverless functions respond. Use Vercel’s deployment status and logs in the dashboard. Request user post-deploy verification per HITL in `.nayan/skills/standard-deploy/SKILL.md`.
