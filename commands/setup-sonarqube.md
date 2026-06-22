---
description: "Set up SonarQube locally for code quality and security analysis"
argument-hint: "[port]"
---

Set up SonarQube Community Edition locally for running analyses, quality gates, and security scans. Use **Docker** (recommended), **Docker Compose with PostgreSQL**, or **ZIP distribution** (no Docker; see [sonarqube-local-setup](https://github.com/ale-blanco-dev/sonarqube-local-setup)).

Default HTTP port: **9000**. Web UI: **http://localhost:9000**. Default login: **admin** / **admin** (you will be prompted to change the password on first login).

---

## Option A — Docker (single container, quick start)

1. Ensure Docker is running. Start SonarQube:

    ```bash
    docker run -d --name sonarqube \
      -p 9000:9000 \
      -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
      -v sonarqube_data:/opt/sonarqube/data \
      -v sonarqube_extensions:/opt/sonarqube/extensions \
      -v sonarqube_logs:/opt/sonarqube/logs \
      sonarqube:lts-community
    ```

    `SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true` is required when running Elasticsearch (used by SonarQube) in a single Docker node.

2. Wait for startup (first run can take 1–2 minutes). Check logs:

    ```bash
    docker logs -f sonarqube
    ```

    When you see "SonarQube is operational", open **http://localhost:9000**.

3. Log in with **admin** / **admin** and change the password when prompted.

4. **Stop:** `docker stop sonarqube`. **Start again:** `docker start sonarqube`.

5. To use a different host port (e.g. 9001): use `-p 9001:9000` and open **http://localhost:9001**.

---

## Option B — Docker Compose with PostgreSQL (persistent, recommended for regular use)

Use when you want data and configuration to persist across container rebuilds and to avoid H2/embedded DB limitations.

1. Create `docker-compose.yml` (e.g. in project root or a `local/sonarqube` folder):

    ```yaml
    version: "3"
    services:
        sonarqube:
            image: sonarqube:lts-community
            ports:
                - "9000:9000"
            environment:
                SONAR_ES_BOOTSTRAP_CHECKS_DISABLE: "true"
                SONAR_JDBC_URL: jdbc:postgresql://postgres:5432/sonarqube
                SONAR_JDBC_USERNAME: sonar
                SONAR_JDBC_PASSWORD: sonar
            volumes:
                - sonarqube_data:/opt/sonarqube/data
                - sonarqube_extensions:/opt/sonarqube/extensions
                - sonarqube_logs:/opt/sonarqube/logs
            depends_on:
                - postgres
            networks:
                - sonarnet

        postgres:
            image: postgres:15-alpine
            environment:
                POSTGRES_USER: sonar
                POSTGRES_PASSWORD: sonar
                POSTGRES_DB: sonarqube
            volumes:
                - postgresql_data:/var/lib/postgresql/data
            networks:
                - sonarnet

    volumes:
        sonarqube_data:
        sonarqube_extensions:
        sonarqube_logs:
        postgresql_data:

    networks:
        sonarnet:
            driver: bridge
    ```

2. Start:

    ```bash
    docker compose up -d
    ```

3. Wait for SonarQube to be operational, then open **http://localhost:9000** and log in with **admin** / **admin**.

4. **Stop:** `docker compose down`. **Stop but keep data:** `docker compose stop`.

---

## Option C — ZIP distribution (no Docker)

Use when you prefer no Docker: run SonarQube natively with Java. Good for offline use and full control. Based on [ale-blanco-dev/sonarqube-local-setup](https://github.com/ale-blanco-dev/sonarqube-local-setup).

**Requirements:** Java 17 or 21 (`java --version`). Any OS (Windows, macOS, Linux).

1. **Download** SonarQube Community Edition (ZIP) from the official site:

    - <https://www.sonarsource.com/products/sonarqube/downloads/>
    - File will be named like `sonarqube-25.7.0.110598.zip`.

2. **Unzip** and go to the `bin` directory:

    ```bash
    unzip sonarqube-*.zip
    cd sonarqube-*/bin
    ```

3. **Start** using the folder for your OS:

    **macOS:**

    ```bash
    cd macosx-universal-64
    ./sonar.sh start
    ```

    **Linux:**

    ```bash
    cd linux-x86-64
    ./sonar.sh start
    ```

    **Windows:** Open `windows-x86-64` and run `StartSonar.bat` (or `.\StartSonar.bat` in PowerShell).

4. Open **http://localhost:9000** and log in with **admin** / **admin**.

5. **Change port (optional):** Edit `sonar.properties` in the installation `config/` folder:

    ```properties
    sonar.web.port=9000
    ```

6. **Stop (macOS/Linux):** From the same `bin/<platform>` directory run `./sonar.sh stop`. **Status:** `./sonar.sh status`.

**Common error:** `UnsupportedClassVersionError` or "class file version 61.0" means your Java is too old — SonarQube requires **Java 17 or 21**. Install a matching JDK and ensure `java --version` shows 17+.

**IDE integration:** For IntelliJ install **SonarQube for IDE** and point it at `http://localhost:9000`. For VS Code install **SonarLint** and use "SonarLint: Bind to SonarQube" with the same URL and a token from the SonarQube UI.

---

## Management (when user explicitly asks)

Only run these when the user explicitly asks to **shutdown**, **uninstall**, **reinstall**, **clean reinstall**, or **restart** SonarQube. If already set up, the user can **start** again without reinstalling.

- **Shutdown / Start (if already set up)**  
  Stop the service (see Restart or Uninstall below for stop commands). To start again: use the same start command for the option they used (Docker, Compose, or ZIP)—no reinstall needed.
- **Restart**
    - **Docker (single container):** `docker stop sonarqube && docker start sonarqube`.
    - **Docker Compose:** `docker compose restart` (or `docker compose restart sonarqube`). From the directory containing `docker-compose.yml`.
    - **ZIP:** From `bin/<platform>` (e.g. `bin/macosx-universal-64`): `./sonar.sh restart`, or `./sonar.sh stop` then `./sonar.sh start`.
- **Uninstall**
    - **Docker (single container):** `docker stop sonarqube && docker rm sonarqube`. To remove data: `docker volume rm sonarqube_data sonarqube_extensions sonarqube_logs` (only if user wants data gone).
    - **Docker Compose:** `docker compose down` (stops and removes containers). To remove data: `docker compose down -v` (removes volumes).
    - **ZIP:** From `bin/<platform>`: `./sonar.sh stop`. To uninstall: remove the SonarQube installation directory.
- **Reinstall:** Perform uninstall for the method in use, then follow the same option (A, B, or C) again from the top.
- **Clean reinstall:** Uninstall and remove data (Docker: `docker rm` + `docker volume rm sonarqube_data sonarqube_extensions sonarqube_logs`; Compose: `docker compose down -v`; ZIP: stop and remove install dir), then follow the same option (A, B, or C) again from the top.

---

## After setup

- **Create a project:** In the UI, add a project (e.g. "Create project manually") and follow the steps to get a project key and token.
- **Run analysis:** Use the SonarScanner CLI or your build plugin (Maven, Gradle, npm, etc.) with the project key and token; point `sonar.host.url` to `http://localhost:9000` (or your chosen port).
- **Documentation:** [SonarQube Community Build — Server installation](https://docs.sonarsource.com/sonarqube-community-build/server-installation).

### Auto-setup for current project (once SonarQube is started)

After SonarQube is running, set up **this workspace** so the user can run a Sonar scan from the current project:

1. **Detect project type** from the workspace root: look for `package.json` (Node/npm/pnpm/yarn), `pom.xml` (Maven), `build.gradle` / `build.gradle.kts` (Gradle), `*.sln` / `*.csproj` (.NET), or other build manifests to choose the right scanner and config format.
2. **Create the project in SonarQube** (if not already present): guide the user to create a project in the UI at http://localhost:9000 (or chosen port)—e.g. "Create project manually" → set a project key (e.g. repo or folder name) → generate a token. If the user prefers, use the SonarQube API to create the project and token when possible.
3. **Add scanner config for this repo** so a scan can be run from the project root:
    - **Node/JavaScript/TypeScript:** Add or update `sonar-project.properties` in the project root with at least `sonar.projectKey`, `sonar.host.url` (e.g. `http://localhost:9000`). Run scans with SonarScanner CLI (`sonar-scanner`) or the `sonarqube-scanner` npm package; ensure the token is provided (e.g. `SONAR_TOKEN` env or in config). If the project uses multiple packages (monorepo), configure per-package or a root config as appropriate.
    - **Maven:** No `sonar-project.properties` required if using the Sonar Maven plugin; pass `-Dsonar.token=...` and `-Dsonar.host.url=http://localhost:9000` (or set in pom/settings). Ensure the project key matches the one created in SonarQube.
    - **Gradle:** Use the SonarQube Gradle plugin; set `sonar.host.url` and token (e.g. in `gradle.properties` or env). Ensure the project key matches.
    - **.NET:** Use the SonarScanner for .NET; set server URL and token. Ensure the project key matches.
4. **Document the run command** for the user: e.g. `npx sonar-scanner -Dsonar.token=<token>`, or `./mvnw sonar:sonar -Dsonar.token=...`, or the equivalent for the detected stack. Prefer storing the token in environment (e.g. `SONAR_TOKEN`) rather than in repo files.

If the user did not ask for "auto-setup for current project", you can skip this subsection and only perform server setup (Options A–C).

---

**Notes:**

- Use Docker volumes (as above) so plugins and data persist. Avoid bind-mounting extension directories if plugins fail to load.
- For CI or scanner-only use, point scanners at this URL and ensure the server is up before running the analysis.
