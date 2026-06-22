# Tech Stack Selection

Before creating architecture.md, ask the user which tech stack approach they prefer. Use this reference when selecting tech stack (see `1_workflow.md` steps 5–6).

**Document in architecture.md**: Include the tech stack with full details (Frontend, Backend, Database, Deployment) in architecture.md. **The development plan is based on the tech stack documented in architecture.md** — folder structure, sprint tasks, run commands, and deployment all derive from it. Do not leave it implicit.

## Option 1: Bootcamp Style (Rapid Prototyping)

- **Frontend**: Next.js (Latest stable) + shadcn/ui
- **Backend**: Python + FastAPI (Latest stable)
- **Database**: MongoDB Atlas (Free Tier) or Postgres (Supabase / Neon)
- **Deployment**: Vercel (frontend), Render or Railway (backend)

Use when: General web apps, rapid prototyping, MVPs, hackathon-style projects.

## Option 2: Enterprise Java Stack

- **Frontend**: Angular (LTS) + Angular Material or PrimeNG
- **Backend**: Java + Spring Boot
- **Database**: Postgres or Oracle
- **Deployment**: Static hosting for Angular, application server for Spring Boot (e.g., Tomcat, AWS, Azure)

Use when: Enterprise integrations, regulated environments, existing Java/Oracle ecosystems.

## Option 3: Custom

When the user wants a different tech stack, ask them to specify: Frontend, Backend, Database, and Deployment. Suggest alternatives if they are unsure:

- **Database**: MySQL, PostgreSQL, SQLite (works well for either bootcamp or enterprise)
- **Bootcamp alternatives**: PostgreSQL, SQLite; React/Vue instead of Next.js
- **Enterprise alternatives**: MySQL or PostgreSQL instead of Oracle; different UI lib (e.g., PrimeNG vs Material)

**Document in architecture.md**: For Custom, capture the user's chosen stack in full (Framework + Version, UI library, Backend + Version, Database, Deployment targets). The development plan will use exactly what you document — there is no predefined Custom template. Folder structure derives from the framework conventions of the selected stack.
