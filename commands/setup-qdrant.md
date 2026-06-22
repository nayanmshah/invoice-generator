---
description: "Set up Qdrant vector database locally (Docker or native macOS)"
argument-hint: "[port]"
---

Host Qdrant locally for development or lightweight RAG pipelines. Choose **Docker** (official, simpler) or **native macOS** (no Docker, better performance for large models; see [Qdrant discussion #6943](https://github.com/orgs/qdrant/discussions/6943)).

Default HTTP port: **6333**. Web UI: **http://localhost:6333/dashboard**.

---

## Option A — Docker (recommended)

1. Ensure Docker is running. Start Qdrant:

    ```bash
    docker run -p 6333:6333 -p 6334:6334 -v $(pwd)/qdrant_storage:/qdrant/storage qdrant/qdrant
    ```

2. Open **http://localhost:6333/dashboard** to use the Web UI.

3. To use a different port (e.g. 6335): replace `6333:6333` with `6335:6333` and use `http://localhost:6335/dashboard`.

---

## Option B — Native macOS (no Docker)

Use when Docker's resource limits or Linux VM overhead are a problem (e.g. large embedding models). Not officially supported; community approach from [Qdrant discussion #6943](https://github.com/orgs/qdrant/discussions/6943).

1. **Prerequisites** (install if missing):

    ```bash
    brew install rustup protobuf
    rustup component add rustfmt
    ```

2. **Clone and build Qdrant** (from a directory of your choice, e.g. `~/src`):

    ```bash
    git clone https://github.com/qdrant/qdrant.git
    cd qdrant
    cargo build --release --bin qdrant
    ```

    If the repo includes a web UI sync script:

    ```bash
    ./tools/sync-web-ui.sh
    ```

3. **Run Qdrant** (default port 6333):

    ```bash
    # Optional: stop any existing Qdrant process
    pkill qdrant || true

    # Run (PORT defaults to 6333 if not set)
    PORT=${PORT:-6333}
    QDRANT__HTTP_PORT=$PORT ./target/release/qdrant
    ```

    Web UI: **http://localhost:6333/dashboard** (or `http://localhost:$PORT/dashboard` if you set `PORT`).

4. **Stop:** `pkill qdrant` or Ctrl+C.

---

## Management (when user explicitly asks)

Only run these when the user explicitly asks to **shutdown**, **uninstall**, **reinstall**, **clean reinstall**, or **restart** Qdrant. If already set up, the user can **start** again without reinstalling.

- **Shutdown / Start (if already set up)**  
  Stop the service (see Restart or Uninstall below for stop commands). To start again: use the same start command from the option they used (Docker or native)—no reinstall needed.
- **Restart**
    - **Docker:** `docker stop <container_id_or_name>` then `docker start <container_id_or_name>`, or if you used `--name qdrant`: `docker stop qdrant && docker start qdrant`. For one-off run (no name): stop the container and run the same `docker run ...` again.
    - **Native:** `pkill qdrant` (or Ctrl+C), then start again: `PORT=${PORT:-6333} QDRANT__HTTP_PORT=$PORT ./target/release/qdrant` from the `qdrant` clone directory.
- **Uninstall**
    - **Docker:** Stop and remove the container: `docker stop <container> && docker rm <container>`. To remove data: `rm -rf ./qdrant_storage` (if you used `$(pwd)/qdrant_storage`).
    - **Native:** Stop: `pkill qdrant`. To uninstall: remove the Qdrant clone directory (e.g. `rm -rf ~/src/qdrant`) and optionally uninstall Rust: `rustup self uninstall` (only if not needed for other projects).
- **Reinstall:** Perform uninstall for the method in use, then follow Option A or B again from the top.
- **Clean reinstall:** Uninstall and remove data (Docker: remove container and `rm -rf ./qdrant_storage`; native: remove clone directory), then follow Option A or B again from the top.

---

**Notes:**

- Persistence: Docker option uses `./qdrant_storage`; native runs from the clone directory (storage under that tree unless configured otherwise).
- Native build can take several minutes. Use Option A for quickest local setup.
