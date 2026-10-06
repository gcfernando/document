# 🐳 Docker: Learn Containers by Doing

**🏷️ Difficulty:** 🟢 Beginner → 🟡 Intermediate (by [section 9](#docker-dotnet))

## Start here

A container packages your application with everything it needs to run — code, runtime, libraries, settings — so it behaves the same on your machine, a teammate's machine, and a server. This guide skips container theory and gets you running, building, and debugging containers immediately.

**Minimum prerequisites:** Windows with [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed (WSL2 backend). Basic PowerShell comfort. No prior container experience assumed. Python and .NET examples reuse concepts from the [Local AI Learning Lab](local_ai_learning_lab.md) and [C#/.NET OOP guide](csharp_dotnet_oop_guide.md), but you do not need to have finished either first.

**Execution status:** commands were run against Docker Desktop on Windows (WSL2 backend). Image download speed and exact output formatting depend on your Docker version and network; the behavior shown is stable across recent versions.

### Essential path

1. [Install and verify](#docker-setup)
2. [Run and inspect your first container](#docker-run)
3. [Images vs. containers](#docker-images)
4. [Build your own image](#docker-build)
5. [Environment variables and configuration](#docker-env)
6. [Volumes: persist data](#docker-volumes)
7. [Networking: connect two containers](#docker-network)
8. [Docker Compose: multi-container apps](#docker-compose)
9. [Containerize a .NET console app](#docker-dotnet)
10. [Troubleshooting](#docker-troubleshoot)

---

<a id="docker-setup"></a>

# 1. 🛠️ Install and verify

Install Docker Desktop, then open a **new** PowerShell window:

```powershell
docker --version
docker run hello-world
```

👀 **Expected output:** version string, then a message starting `Hello from Docker!` that explains the four things Docker just did: pulled the image, created a container from it, ran it, and streamed its output back to you.

❌ **If you see** `error during connect... Is the docker daemon running?` — open Docker Desktop (the whale icon) and wait for it to say "Engine running," then retry.

---

<a id="docker-run"></a>

# 2. ▶️ Run and inspect your first real container

```powershell
docker run -d --name my-nginx -p 8080:80 nginx
```

- `-d` — run in the background ("detached")
- `--name` — give it a friendly name instead of a random one
- `-p 8080:80` — map your machine's port 8080 to the container's port 80

```powershell
docker ps
```

👀 **Expected output:** a table row showing `my-nginx`, image `nginx`, status `Up ... seconds`, and the port mapping `0.0.0.0:8080->80/tcp`.

Open `http://localhost:8080` in a browser — you'll see nginx's welcome page. It's running **inside** the container, not installed on your machine.

### 🧪 Inspect it while it runs

```powershell
docker logs my-nginx
docker exec -it my-nginx bash
```

Inside the container's shell:

```bash
ls /usr/share/nginx/html
cat /etc/os-release
exit
```

👀 You're inside a minimal Linux filesystem that exists only inside this container — changes you make here vanish when the container is removed (that's the point: containers are disposable).

### Stop and remove it

```powershell
docker stop my-nginx
docker rm my-nginx
docker ps -a
```

👀 After `docker rm`, `my-nginx` no longer appears even with `-a` (which shows stopped containers too).

### ✅ Checkpoint

You should be able to explain: a running **container** is a process; the **image** (`nginx`) is the read-only template it was created from; stopping a container doesn't delete it, `docker rm` does.

### 🏋️ Exercise

Run a second nginx container named `my-nginx-2` published on host port `8090` instead of `8080`. Confirm both respond in a browser at the same time, then stop and remove only `my-nginx-2`, leaving `my-nginx` running.

---

<a id="docker-images"></a>

# 3. 📦 Images vs. containers

```powershell
docker images
docker pull python:3.12-slim
docker images
```

👀 The second `docker images` now lists `python` alongside `nginx` and `hello-world`.

```text
Image                         Container
─────                         ─────────
Read-only template      ──►   Running (or stopped) instance
One image                ──►  Many containers can be created from it
docker pull / build      ──►  docker run
```

### 🧪 Experiment: one image, many containers

```powershell
docker run -d --name web1 -p 8081:80 nginx
docker run -d --name web2 -p 8082:80 nginx
docker ps
```

👀 Both `web1` and `web2` run from the same `nginx` image simultaneously on different host ports. Clean up:

```powershell
docker stop web1 web2
docker rm web1 web2
```

### 🏋️ Exercise

Run `docker inspect nginx` and find the `Id`, `RepoTags`, and `Size` fields. Then run `docker image ls --digests` and explain, in one sentence, the difference between an image's **tag** (e.g. `nginx:latest`) and its content-addressed **digest**.

---

<a id="docker-build"></a>

# 4. 🏗️ Build your own image

Create a tiny Python API:

```powershell
mkdir docker-lab
cd docker-lab
```

`app.py`:

```python
from http.server import BaseHTTPRequestHandler, HTTPServer
import os

GREETING = os.environ.get("GREETING", "Hello")

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(f"{GREETING} from inside a container!\n".encode())

if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 8000), Handler).serve_forever()
```

`Dockerfile`:

```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY app.py .
EXPOSE 8000
CMD ["python", "app.py"]
```

### ▶️ Build and run it

```powershell
docker build -t docker-lab-app .
docker run -d --name lab-app -p 8000:8000 docker-lab-app
curl http://localhost:8000
```

👀 **Expected output:** `Hello from inside a container!`

### 🧠 What just happened?

`docker build` executed each `Dockerfile` instruction **in order**, caching each layer. `FROM` picked a base image with Python pre-installed; `WORKDIR` set the working directory inside the image; `COPY` brought your file in; `EXPOSE` documents the port (it does not publish it — `-p` at `docker run` does that); `CMD` is what runs when a container starts.

### 💥 Break it, then fix it

Remove the `EXPOSE 8000` line — rebuild and rerun with the same `-p 8000:8000`. It still works, because `EXPOSE` is documentation only, not enforcement. Now instead, change `CMD ["python", "app.py"]` to `CMD ["python", "missing.py"]`, rebuild, and run:

```powershell
docker build -t docker-lab-app .
docker run --name lab-app-broken docker-lab-app
```

👀 **Expected output:** `python: can't open file '/app/missing.py'` and the container exits immediately. `docker ps` won't show it; `docker ps -a` will, with status `Exited (2)`. This is the single most common "my container won't start" scenario — **always check `docker logs <name>` first.**

```powershell
docker logs lab-app-broken
docker rm lab-app-broken
```

### 🏋️ Exercise

Add a second route by checking `self.path` in `do_GET` (e.g., `/health` returns `"ok"`). Rebuild, rerun, and `curl` both paths.

---

<a id="docker-env"></a>

# 5. ⚙️ Environment variables and configuration

```powershell
docker stop lab-app; docker rm lab-app
docker run -d --name lab-app -p 8000:8000 -e GREETING="Bonjour" docker-lab-app
curl http://localhost:8000
```

👀 **Expected output:** `Bonjour from inside a container!` — same image, different behavior, no code change. This is exactly how production configuration (API keys, endpoints, feature flags) is passed into containers; never bake secrets into the image itself.

> [!WARNING]
> Anyone who can run `docker history <image>` or inspect its layers can potentially see values that were baked in at build time (e.g. via `ARG`/`COPY` of a secrets file). Pass secrets at **run time** (`-e`, `--env-file`, or an orchestrator's secret store), never in the `Dockerfile`.

### 🏋️ Exercise

Create a file `lab.env` containing `GREETING=Hola`, then start the container with `--env-file lab.env` instead of `-e`. Confirm the greeting changes, and explain why an env file checked into `.gitignore` is safer than hardcoding the same value with `-e` in a shared script.

---

<a id="docker-volumes"></a>

# 6. 💾 Volumes: persist data beyond the container's life

Containers are disposable — their writable layer disappears with `docker rm`. Volumes and bind mounts survive that.

```powershell
docker stop lab-app; docker rm lab-app
mkdir data
docker run -d --name lab-app -p 8000:8000 -v ${PWD}/data:/app/data docker-lab-app
```

`-v ${PWD}/data:/app/data` is a **bind mount**: your local `data` folder appears at `/app/data` inside the container. Prove it:

```powershell
docker exec lab-app sh -c "echo saved > /app/data/note.txt"
Get-Content .\data\note.txt
```

👀 The file exists on your **host** machine even though it was written from inside the container. Remove the container entirely and the file is still there:

```powershell
docker rm -f lab-app
Get-Content .\data\note.txt
```

### 🧪 Named volumes (Docker-managed storage)

```powershell
docker volume create lab-data
docker run -d --name lab-app -p 8000:8000 -v lab-data:/app/data docker-lab-app
docker volume inspect lab-data
```

Use a **bind mount** when you need to see/edit the files from your host (like source code during development). Use a **named volume** when you just need durable storage managed by Docker (like a database's data directory).

### 🏋️ Exercise

Remove `lab-app` and its named volume (`docker rm -f lab-app && docker volume rm lab-data`), then recreate the container with the same named volume and write a new file into `/app/data`. Confirm the volume survived container removal but is now empty again after `docker volume rm` — demonstrating that volumes, not containers, own the data's lifetime.

---

<a id="docker-network"></a>

# 7. 🌐 Networking: connect two containers

```powershell
docker network create lab-net
docker run -d --name sql-db --network lab-net `
  -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong!Passw0rd" `
  -p 1433:1433 mcr.microsoft.com/mssql/server:2022-latest
```

Wait about 20 seconds for SQL Server to finish starting, then check:

```powershell
docker logs sql-db --tail 20
```

👀 **Expected output:** eventually includes `SQL Server is now ready for client connections`. This is the same SQL Server used in the [SQL guide](sql_complete_guide.md) — now running in a disposable container instead of a full install.

Run a second container on the **same network** and reach the database by container name (not `localhost`):

```powershell
docker run -it --rm --network lab-net mcr.microsoft.com/mssql-tools18 `
  /opt/mssql-tools18/bin/sqlcmd -S sql-db -U sa -P "YourStrong!Passw0rd" -C -Q "SELECT @@VERSION"
```

👀 **Expected output:** SQL Server's version string, proving container `sql-db` was reachable by **name** from another container on `lab-net` — Docker's embedded DNS resolves container names automatically on a user-created network (the default `bridge` network does not do this).

Clean up:

```powershell
docker rm -f sql-db
docker network rm lab-net
```

### 🏋️ Exercise

Create the `lab-net` network again, start `sql-db` on it, but try reaching it **by name** from a container that is *not* attached to `lab-net` (omit `--network lab-net` on the `mssql-tools18` run). Confirm it fails to resolve, then rerun it correctly attached — proving container-name DNS only works for containers sharing a user-defined network.

---

<a id="docker-compose"></a>

# 8. 📋 Docker Compose: describe multi-container apps declaratively

Running two `docker run` commands by hand doesn't scale. Compose describes the whole stack in one file.

`docker-compose.yml` (in `docker-lab/`):

```yaml
services:
  web:
    build: .
    ports:
      - "8000:8000"
    environment:
      GREETING: "Hello from Compose"
    volumes:
      - ./data:/app/data
    depends_on:
      - db

  db:
    image: mcr.microsoft.com/mssql/server:2022-latest
    environment:
      ACCEPT_EULA: "Y"
      MSSQL_SA_PASSWORD: "YourStrong!Passw0rd"
    ports:
      - "1433:1433"
```

```powershell
docker compose up -d
docker compose ps
curl http://localhost:8000
docker compose logs web
```

👀 Compose created a dedicated network automatically — `web` can reach `db` by the service name `db`, exactly like the manual `lab-net` example above, with no extra network commands.

```powershell
docker compose down
```

👀 **Expected output:** both containers and the auto-created network are removed. Add `-v` to also delete named volumes: `docker compose down -v`.

### ✅ Checkpoint

- [ ] Explain the difference between `docker stop` and `docker rm`
- [ ] Build an image from a `Dockerfile` and explain what each instruction does
- [ ] Diagnose a container that exits immediately using `docker logs`
- [ ] Explain when to use a bind mount vs. a named volume
- [ ] Run two containers that talk to each other by container name

---

<a id="docker-dotnet"></a>

# 9. 💜 Mini project: containerize a .NET console app

```powershell
cd ..
dotnet new console -o dotnet-docker-lab
cd dotnet-docker-lab
```

`Dockerfile` (multi-stage: build with the full SDK, ship only the small runtime):

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/runtime:10.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "dotnet-docker-lab.dll"]
```

```powershell
docker build -t dotnet-docker-lab .
docker run --rm dotnet-docker-lab
```

👀 **Expected output:** `Hello, World!` — produced by a container that never had the .NET SDK installed on your actual machine, and whose final image is far smaller than if you'd copied the SDK stage's output directly (`docker images` will show the size difference versus a single-stage build using only the `sdk` image).

### 🏋️ Challenge

Rewrite this Dockerfile as a **single-stage** build using only `mcr.microsoft.com/dotnet/sdk:10.0`, compare `docker images` sizes between the two, and explain why multi-stage builds matter for production images.

---

<a id="docker-troubleshoot"></a>

# 10. 🐛 Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `port is already allocated` | Another container/process already uses that host port | Pick a different host port (`-p 8081:80`) or `docker ps` to find and stop the conflicting container |
| Container exits immediately, `docker ps` shows nothing | The main process crashed or exited on its own | `docker ps -a` to find it, then `docker logs <name>` for the real error |
| `Cannot connect to the Docker daemon` | Docker Desktop isn't running | Start Docker Desktop and wait for "Engine running" |
| Changes to code don't appear after rebuild | Build cache reused a stale layer, or you forgot `docker build` before `docker run` | Rebuild with `docker build --no-cache -t <tag> .` as a last resort; normally just re-run `docker build` |
| Two containers can't see each other | They're on different networks (or both on the default bridge without explicit links) | Put them on the same user-defined network (`docker network create`) or the same Compose file |
| Disk filling up over time | Old stopped containers, dangling images, and build cache accumulate | `docker system df` to see usage, `docker system prune` to clean up (review what it will remove first) |

### 🏋️ Exercise

Deliberately trigger the first row: start two containers both published on host port `9000`. Read the exact error, fix it by changing one container's host port, and confirm both run side by side.

---

<a id="docker-capstone"></a>

# 🏋️ Progressive practice lab: baby steps → advanced

Work through these in order — each tier assumes the previous one is solid. Do not skip ahead; later tiers deliberately reuse earlier commands under more realistic conditions.

### 🐣 Tier 1 — baby steps (repeat until automatic)

1. Run `docker run -d --name tier1-web -p 8100:80 nginx`, confirm it in a browser, then `docker stop tier1-web` and `docker rm tier1-web`.
2. Run `docker pull redis:7-alpine` and `docker images`; identify its size versus `nginx`'s.
3. Start a container, `docker exec -it` into it, run one harmless command (`whoami`, `pwd`), then `exit` without stopping the container.
4. Run `docker logs <name> --tail 5 --follow` against a running container and generate new output for it to display (e.g. `curl` it a few times in another window).

### 🧒 Tier 2 — building confidence

5. Containerize a one-file Python or Node "hello" script from scratch (your own `Dockerfile`, not copied from section 4) and run it.
6. Add an environment variable to tier 5's app and prove, with `docker run -e`, that the same image can behave two different ways.
7. Add a bind-mounted volume to tier 5's app so it writes a log file you can read from your host.
8. Intentionally misspell a `Dockerfile` instruction (e.g. `COPYY`), run `docker build`, and read the exact error Docker gives before fixing it.

### 🧑 Tier 3 — intermediate

9. Put tier 5's app and a second container (e.g. `redis:7-alpine`) on the same user-defined network, and prove connectivity by name from inside the app container (`docker exec` in and `ping`/`curl` the other by its container name).
10. Convert tier 9's two containers into a single `docker-compose.yml` with `depends_on`, bring it up with `docker compose up -d`, and confirm `docker compose logs` shows both.
11. Break something on purpose: stop just the dependency container (`docker compose stop redis`) while the app keeps running, observe what happens to the app's behavior/logs, then restart the dependency.

### 🏆 Tier 4 — advanced / capstone

12. Write a multi-stage `Dockerfile` for a compiled language (.NET, from [section 9](#docker-dotnet), or any other you know) and compare final image size against a deliberately single-stage version of the same app.
13. Add a `.dockerignore` to a real project directory, rebuild, and use `docker history <image>` to confirm files you excluded never entered a layer.
14. Design (on paper or in a `docker-compose.yml`) a three-service stack — a web app, a database, and a cache — with explicit networks, named volumes for the database only, and environment-based configuration for all secrets. Justify each choice in one sentence per service.
15. Diagnose a container you deliberately break (wrong `CMD`, missing env var the app requires, or a port never published) using only `docker ps -a`, `docker logs`, and `docker inspect` — without looking at the `Dockerfile` first — then confirm your diagnosis against the actual cause.

### ✅ Capstone checkpoint

- [ ] Completed all four tiers without copying commands verbatim from earlier sections
- [ ] Can explain every exercise's expected result *before* running it, not just after
- [ ] Can diagnose a broken container using only runtime commands (no source inspection) in under five commands

---

## 🔗 Related topics

- [SQL Guide](sql_complete_guide.md) — the containerized SQL Server above uses the same engine taught there.
- [Azure Resources Cheatsheet](azure_resources_cheatsheet.md) — Azure Container Apps and Container Registry are the natural next step once an image works locally.
- [Git Guide](git_practical_guide.md) — commit your `Dockerfile` and `docker-compose.yml`; add a `.dockerignore` the same way you'd add a `.gitignore`.

## ➡️ Next

Continue to **[Building Agents & Multi-Agent Systems](agents_and_subagents_lab.md)**, or return to the **[README](README.md)** for the full map.
