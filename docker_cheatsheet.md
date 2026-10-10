# 🐳 Docker Command Cheat Sheet

[![Docker](https://img.shields.io/badge/Docker-CLI-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/reference/)
[![Level](https://img.shields.io/badge/Level-Beginner%20%E2%86%92%20Expert-16A34A?style=for-the-badge)](#-command-catalog)
[![Safety](https://img.shields.io/badge/Safety-Review%20destructive%20commands-F59E0B?style=for-the-badge)](#-safety-first)
[![Reference](https://img.shields.io/badge/Reference-Command%20catalog-0EA5E9?style=for-the-badge)](#-command-catalog)

> **Scope:** Docker Engine CLI, Compose, Buildx, registries, security, and Swarm. Syntax is verified against the [official Docker reference](https://docs.docker.com/reference/). Docker Desktop bundles the client and Engine on Windows/macOS; Linux normally installs Engine separately.

> [!TIP]
> **🎨 Visual legend:** 🟢 beginner-friendly · 🟡 intermediate operations · 🔴 advanced/production · 💻 copyable command · 🔍 flags and behavior · 💡 practical advice · ⚠️ destructive or security-sensitive action.

## 📚 Table of contents

- [🚦 Start safely](#-start-safely)
- [🚀 Essential command cards](#-essential-command-cards)
- [🧩 Command catalog](#-command-catalog)
- [🏗️ Dockerfile and builds](#️-dockerfile-and-builds)
- [🧱 Compose](#-compose)
- [🌐 Networking and storage](#-networking-and-storage)
- [🔐 Registries, security, and Swarm](#-registries-security-and-swarm)
- [🛠️ Ten practical workflows](#️-ten-practical-workflows)
- [📋 Complete reference and help](#-complete-reference-and-help)

## 🚦 Start safely

**Architecture:** the `docker` client asks the Docker daemon to create images, containers, networks, volumes, and (optionally) Swarm resources. An **image** is an immutable template; a **container** is its runnable instance.

> [!WARNING]
> Commands marked **⚠️ destructive** can remove data or resources. Inspect first with `docker ps -a`, `docker image ls`, `docker volume ls`, or `docker system df`. Never put credentials in an image, command history, or committed `compose.yaml`.

## 🚀 Essential command cards

Each row includes a copyable example and its use; detailed flag explanations follow in the catalog.

| Command | Friendly purpose | Example | When to use |
|---|---|---|---|
| `docker --version` | Print client version. | `docker --version` | Confirm installation. |
| `docker info` | Show daemon, storage, and runtime details. | `docker info` | Diagnose daemon/configuration issues. |
| `docker run` | Create and start a container. | `docker run --rm hello-world` | Test Docker or start an app. |
| `docker ps -a` | List running and stopped containers. | `docker ps -a` | Find an exited container. |
| `docker logs` | Print a container's stdout/stderr. | `docker logs --tail 100 api` | Diagnose startup failure. |
| `docker exec` | Run a command in a running container. | `docker exec -it api sh` | Inspect a live container. |
| `docker stop` | Gracefully stop a container. | `docker stop api` | Stop a service before maintenance. |
| `docker rm` | **⚠️** Remove stopped containers. | `docker rm api` | Remove a no-longer-needed container. |
| `docker pull` | Download an image. | `docker pull nginx:1.27-alpine` | Pin a tested image. |
| `docker image ls` | List local images. | `docker image ls` | Audit cached images. |
| `docker build` | Build an image from a Dockerfile. | `docker build -t demo:1.0 .` | Package an application. |
| `docker compose up` | Create/start a Compose app. | `docker compose up -d` | Run a multi-service stack. |
| `docker compose down` | **⚠️** Stop/remove Compose resources. | `docker compose down` | Tear down a development stack. |
| `docker network create` | Create an isolated network. | `docker network create app-net` | Let services resolve each other by name. |
| `docker volume create` | Create durable Docker-managed storage. | `docker volume create db-data` | Persist database files. |
| `docker inspect` | Print low-level resource metadata. | `docker inspect api` | Check mounts, ports, or environment. |
| `docker stats` | Stream resource usage. | `docker stats api` | Investigate CPU or memory pressure. |
| `docker login` | Authenticate to a registry. | `docker login ghcr.io` | Pull private or push owned images. |
| `docker push` | Upload a tagged image. | `docker push registry.example.com/team/api:1.0` | Publish a release image. |
| `docker system prune` | **⚠️** Remove unused resources. | `docker system prune` | Reclaim development disk space. |

## 🧩 Command catalog

> [!IMPORTANT]
> **🧭 Read each card left to right:** command → plain-English purpose → copyable example → flags and safe-use guidance.

### 🟢 Setup, help, contexts, and configuration

| Command | 📖 Description and 🎯 when | 💻 Example | 🔍 Flags, arguments, and 💡 tip |
|---|---|---|---|
| `docker version` | Shows client and daemon API versions; use it when a client/daemon mismatch is suspected. | `docker version` | `--format '{{.Server.Version}}'` emits only the daemon version for scripts. |
| `docker info` | Shows daemon state, cgroup driver, storage driver, runtimes, and resource limits; use for host diagnosis. | `docker info --format '{{.Driver}}'` | `--format` produces stable script output. |
| `docker <command> --help` | Opens supported syntax for one command; use it before relying on a version-specific flag. | `docker run --help` | This is the safest source for the installed CLI version. |
| `docker context ls` | Lists daemon endpoints; use when switching local, SSH, or cloud daemons. | `docker context ls` | The `*` marks the active context. |
| `docker context use NAME` | Selects a saved daemon endpoint; use before targeting a remote Engine. | `docker context use default` | Verify with `docker context show`; remote actions affect that endpoint. |
| `docker context create` | Saves an endpoint configuration; use for an SSH-accessible Engine. | `docker context create prod --docker "host=ssh://ops@example.com"` | Use SSH keys/least privilege; do not embed passwords. |
| `docker context rm NAME` | **⚠️** Removes a local context definition, not remote resources. | `docker context rm old-lab` | Switch away first; `default` cannot be removed. |

### 🟢 📦 Images and registries

| Command | 📖 Description and 🎯 when | 💻 Example | 🔍 Flags, arguments, and 💡 tip |
|---|---|---|---|
| `docker search TERM` | Searches Docker Hub public metadata; use to discover official images. | `docker search --filter is-official=true nginx` | Pin a tag/digest after reviewing its publisher. |
| `docker pull IMAGE[:TAG]` | Downloads an image; use to prefetch a known version. | `docker pull postgres:16.4-alpine` | Prefer a tested version or immutable digest over `latest`. |
| `docker image ls` | Lists local image references; use before cleanup. | `docker image ls --digests` | `-a` includes intermediate images; `--filter dangling=true` finds untagged layers. |
| `docker image inspect IMAGE` | Prints image config, layers, labels, and digest; use to audit an image. | `docker image inspect nginx:1.27-alpine` | `--format '{{.Config.User}}'` checks its configured user. |
| `docker image tag SOURCE TARGET` | Adds a new local reference without copying layers; use before a registry push. | `docker image tag demo:1.0 registry.example.com/team/demo:1.0` | The target registry/repository/tag controls the push destination. |
| `docker image save` | Exports one or more images to a tar archive; use for air-gapped transfer. | `docker image save -o demo-images.tar demo:1.0` | Archives can be large; verify provenance before loading elsewhere. |
| `docker image load` | Imports an image archive created by `save`; use on the destination host. | `docker image load -i demo-images.tar` | Inspect the loaded image before running it. |
| `docker image import` | Creates an image from a filesystem tar stream; use only for legacy/rootfs workflows. | `docker image import rootfs.tar example/rootfs:1.0` | Unlike `load`, it does not preserve image history/configuration. |
| `docker image rm IMAGE` | **⚠️** Removes local tags/images; use after confirming no needed container depends on them. | `docker image rm demo:old` | `-f` can untag/remove forcefully; inspect first. |
| `docker login [REGISTRY]` | Authenticates the CLI; use before private pulls or pushes. | `docker login ghcr.io` | Prefer stdin token input: `Get-Content token.txt \| docker login ghcr.io -u USER --password-stdin`; never put tokens on a command line. |
| `docker logout [REGISTRY]` | Removes local registry credentials; use on shared machines. | `docker logout ghcr.io` | Credential helper behavior is platform-dependent. |
| `docker push IMAGE` | Uploads a tagged local image; use after build/test/scan. | `docker push registry.example.com/team/api:1.0` | A registry-qualified tag is required for the intended registry. |
| `docker manifest inspect IMAGE` | Displays a registry manifest or manifest list; use to confirm platforms/digests. | `docker manifest inspect nginx:1.27-alpine` | Helpful before multi-platform deployment. |

### 🟢 🏃 Containers: create, run, inspect, and operate

| Command | 📖 Description and 🎯 when | 💻 Example | 🔍 Flags, arguments, and 💡 tip |
|---|---|---|---|
| `docker create` | Creates a stopped container; use when creation and start must be separate. | `docker create --name web -p 8080:80 nginx:1.27-alpine` | Start it later with `docker start web`. |
| `docker run` | Creates and starts a container; use for a new workload. | `docker run -d --name web -p 8080:80 --restart unless-stopped nginx:1.27-alpine` | `-d` detaches, `--name` names, `-p HOST:CONTAINER` publishes, and restart policy recovers after daemon restart. |
| `docker run --rm` | Removes the container on exit; use for one-off tools/tests. | `docker run --rm alpine:3.20 echo "hello"` | Do not use when you need post-exit logs/files from its writable layer. |
| `docker run -it` | Allocates stdin and a terminal; use for interactive shells. | `docker run --rm -it ubuntu:24.04 bash` | `-i` keeps input open; `-t` allocates a pseudo-TTY. |
| `docker run --env/-e` | Sets runtime environment variables; use for non-secret configuration. | `docker run --rm -e LOG_LEVEL=info demo:1.0` | Prefer `--env-file .env` for local non-secret values; never commit secrets. |
| `docker run --mount` | Attaches a volume/bind/tmpfs with explicit syntax; use for durable or host data. | `docker run --rm --mount type=volume,src=db-data,dst=/var/lib/postgresql/data postgres:16` | Prefer `--mount` over short `-v` in documentation because fields are explicit. |
| `docker run --read-only` | Makes the root filesystem read-only; use to limit writes. | `docker run --read-only --tmpfs /tmp nginx:1.27-alpine` | Supply writable tmpfs/volumes for legitimate writes. |
| `docker ps` | Lists running containers; use for a fast health/status view. | `docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'` | `-a` includes exited containers; `-q` outputs IDs for scripts; `--no-trunc` shows full fields. |
| `docker start/stop/restart` | Starts, gracefully stops, or restarts existing containers; use for lifecycle changes. | `docker stop -t 30 api` | `-t 30` allows 30 seconds before kill; `docker start -ai job` attaches to an interactive job. |
| `docker kill` | **⚠️** Sends a signal immediately; use only when graceful stop fails. | `docker kill --signal SIGKILL hung-api` | Default is `SIGKILL`; prefer `stop` first. |
| `docker pause/unpause` | Freezes/unfreezes processes; use for a short diagnostic experiment. | `docker pause api` | This is not a graceful maintenance stop. |
| `docker rm` | **⚠️** Removes stopped containers; use after logs/data are no longer needed. | `docker rm old-api` | `-v` removes anonymous volumes too; `-f` stops then removes—both require review. |
| `docker rename` | Renames a container; use to free a name or clarify ownership. | `docker rename web web-old` | Network DNS aliases are not automatically rewritten. |
| `docker logs` | Reads container stdout/stderr; use first for startup errors. | `docker logs --tail 100 --timestamps -f api` | `-f` follows output; `--since 10m` narrows incident investigation. |
| `docker exec` | Runs a process in a running container; use for diagnosis, not persistent configuration. | `docker exec -it api sh` | `-u 1000:1000` changes exec user; images may not include `bash`. |
| `docker cp` | Copies files between host and container; use to retrieve diagnostics. | `docker cp api:/app/logs/error.log .\error.log` | Treat copied secrets/logs as sensitive. |
| `docker inspect` | Returns JSON metadata; use to check actual port, mount, health, or IP settings. | `docker inspect --format '{{json .State.Health}}' api` | Use `--format` instead of brittle JSON parsing. |
| `docker top` | Shows container processes; use to locate a runaway process. | `docker top api` | Output format depends on the host OS. |
| `docker stats` | Streams CPU, memory, I/O, and network use; use under load. | `docker stats --no-stream api` | `--no-stream` captures one script-friendly sample. |
| `docker events` | Streams daemon events; use to correlate restarts/destroys. | `docker events --filter container=api --since 1h` | Filters include `type`, `event`, `container`, `image`, and `label`. |
| `docker diff` | Shows container filesystem changes; use to find unexpected writes. | `docker diff api` | Persist intentional state in volumes, not the writable container layer. |
| `docker update` | Changes some live resource/restart settings; use for an urgent temporary adjustment. | `docker update --memory 768m --restart unless-stopped api` | Validate the workload after changing limits. |

## 🏗️ Dockerfile and builds

> [!TIP]
> **✨ Build mantra:** small trusted base → reproducible build → non-root runtime → health check → minimal published ports.

### Dockerfile instructions

| Instruction | 📖 Description and 🎯 when | 💻 Minimal example | 🔍 Important note |
|---|---|---|---|
| `FROM` | Selects a base image; use first in every build stage. | `FROM python:3.12-slim` | Pin a trusted version/digest. |
| `ARG` | Defines a build-time variable; use for non-secret build choices. | `ARG VERSION=1.0` | **⚠️** Not safe for secrets; it can appear in image history. |
| `ENV` | Sets runtime/build environment defaults. | `ENV PYTHONDONTWRITEBYTECODE=1` | Override safely at runtime where appropriate. |
| `WORKDIR` | Sets the working directory for later instructions. | `WORKDIR /app` | Prefer it over repeated `cd`. |
| `COPY` | Copies build-context files. | `COPY requirements.txt .` | Use `.dockerignore` to exclude secrets/build output. |
| `ADD` | Copies plus archive/URL behavior. | `ADD app.tar.gz /app/` | Prefer `COPY` unless `ADD`'s extra behavior is necessary. |
| `RUN` | Executes a build-time command. | `RUN pip install --no-cache-dir -r requirements.txt` | Combine related package steps to control layers. |
| `CMD` | Supplies default process/arguments. | `CMD ["python", "app.py"]` | One effective `CMD`; runtime arguments can override it. |
| `ENTRYPOINT` | Fixes the executable for an image. | `ENTRYPOINT ["python"]` | Combine with `CMD` for default arguments. |
| `EXPOSE` | Documents intended ports. | `EXPOSE 8080` | It does **not** publish a port; use `-p`/Compose `ports`. |
| `USER` | Selects the process user. | `USER 10001` | Run as non-root whenever possible. |
| `VOLUME` | Declares a mount point. | `VOLUME ["/data"]` | Prefer explicit runtime mounts for lifecycle control. |
| `HEALTHCHECK` | Defines container health probing. | `HEALTHCHECK CMD curl -f http://localhost:8080/health || exit 1` | Provide a lightweight, meaningful endpoint. |
| `LABEL` | Adds metadata. | `LABEL org.opencontainers.image.source="https://example.com/repo"` | OCI labels improve traceability. |
| `SHELL` | Changes shell form processing. | `SHELL ["powershell", "-Command"]` | Most useful for Windows containers. |
| `STOPSIGNAL` | Sets graceful-stop signal. | `STOPSIGNAL SIGTERM` | Match application shutdown handling. |
| `ONBUILD` | Registers a trigger for child images. | `ONBUILD COPY . /src` | Avoid for general-purpose images; behavior is implicit. |

### Build commands

| Command | 📖 Description and 🎯 when | 💻 Example | 🔍 Flags, arguments, and 💡 tip |
|---|---|---|---|
| `docker build` | Builds an image from a Dockerfile; use for a single-platform build. | `docker build -t example/api:1.0 -f Dockerfile .` | `-t` tags, `-f` chooses a Dockerfile, and final `.` is the build context. |
| `docker build --target` | Stops at a named multi-stage target; use for test/debug stages. | `docker build --target test -t api:test .` | Keep production artifacts in a final minimal stage. |
| `docker build --no-cache` | Rebuilds without cached layers; use to rule out stale cache. | `docker build --no-cache -t api:debug .` | Slower; use selectively. |
| `docker build --secret` | Makes a BuildKit secret available only during a `RUN --mount=type=secret`; use for private dependency access. | `docker build --secret id=npmrc,src=$HOME/.npmrc -t api:1.0 .` | Requires Dockerfile secret mount; secret must not be copied into a layer. |
| `docker buildx create/use/ls` | Creates/selects/lists BuildKit builders; use for multi-platform or isolated builds. | `docker buildx create --name multi --use` | Confirm active builder with `docker buildx ls`. |
| `docker buildx build` | Builds with BuildKit features; use for multi-platform output. | `docker buildx build --platform linux/amd64,linux/arm64 -t registry.example.com/team/api:1.0 --push .` | `--push` publishes a multi-platform manifest; use `--load` only for a single local platform. |

```dockerfile
# ✅ Small multi-stage production image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /out .
USER 10001
EXPOSE 8080
ENTRYPOINT ["dotnet", "Api.dll"]
```

## 🧱 Compose

> [!NOTE]
> **🪄 Compose turns one `compose.yaml` into a repeatable local environment.** Validate with `docker compose config` before starting a stack.

| Command | 📖 Description and 🎯 when | 💻 Example | 🔍 Flags, arguments, and 💡 tip |
|---|---|---|---|
| `docker compose config` | Resolves/validates a Compose model; use before deployment. | `docker compose config` | It reveals variable interpolation; keep secrets out of output/screenshots. |
| `docker compose up` | Creates/starts services; use for a defined application stack. | `docker compose up -d --build` | `-d` detaches; `--build` rebuilds before start; `--wait` waits for running/healthy services where supported. |
| `docker compose ps` | Lists project containers; use for service status. | `docker compose ps` | `--all` includes stopped services. |
| `docker compose logs` | Displays project logs; use during local incidents. | `docker compose logs -f --tail 100 api` | Target one service to reduce noise. |
| `docker compose exec` | Runs a command in an existing service container. | `docker compose exec api sh` | Unlike `run`, it uses the running service container. |
| `docker compose run` | Runs a one-off service container; use for migrations/tests. | `docker compose run --rm api dotnet ef database update` | `--rm` removes the one-off container; ports are not published by default. |
| `docker compose restart/stop/start` | Changes lifecycle without recreating definitions; use for local maintenance. | `docker compose restart api` | Use `up --force-recreate` when configuration changes require recreation. |
| `docker compose down` | **⚠️** Stops/removes project containers/networks; use to reset a stack. | `docker compose down` | `-v` also deletes named volumes; `--rmi local` removes locally built images. |
| `docker compose pull/push` | Pulls/pushes service images; use in image-based delivery. | `docker compose pull --policy always` | Ensure service `image:` names point to the intended registry. |
| `docker compose watch` | Watches configured files and syncs/rebuilds; use for development. | `docker compose watch` | Requires `develop.watch` configuration and a recent Compose version. |

```yaml
# compose.yaml — app + database, with no hard-coded password
services:
  api:
    build: .
    ports: ["8080:8080"]
    environment:
      ConnectionStrings__Main: "Host=db;Database=app;Username=app"
    depends_on:
      db:
        condition: service_healthy
    networks: [app]
  db:
    image: postgres:16.4-alpine
    environment:
      POSTGRES_DB: app
      POSTGRES_USER: app
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    secrets: [db_password]
    volumes: [db-data:/var/lib/postgresql/data]
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U app -d app"]
    networks: [app]
volumes: { db-data: {} }
networks: { app: {} }
secrets:
  db_password:
    file: ./secrets/db_password.txt
```

## 🌐 Networking and storage

> [!WARNING]
> **💾 Containers are disposable; persistent data is not.** Back up named volumes before any volume prune or removal.

| Command | 📖 Description and 🎯 when | 💻 Example | 🔍 Flags, arguments, and 💡 tip |
|---|---|---|---|
| `docker network ls` | Lists networks; use before attaching services. | `docker network ls` | The default `bridge` is not the same as a user-defined bridge. |
| `docker network create` | Creates a network; use for service discovery/isolation. | `docker network create --driver bridge app-net` | User-defined bridge networks provide name-based DNS. |
| `docker network connect/disconnect` | Attaches/detaches a running container; use for controlled network changes. | `docker network connect app-net api` | Prefer declaring networks at creation/Compose time. |
| `docker network inspect/rm` | Inspects/removes networks; use to troubleshoot endpoints or clean unused networks. | `docker network inspect app-net` | **⚠️** `rm` fails with attached containers; disconnect them deliberately. |
| `docker port` | Shows published mappings; use to identify host reachability. | `docker port api` | Publishing with `-p 127.0.0.1:8080:8080` limits access to the host. |
| `docker volume create/ls/inspect` | Creates/lists/inspects managed persistent storage; use for databases. | `docker volume create db-data` | Volumes outlive containers. |
| `docker volume rm` | **⚠️** Deletes a volume and its data; use only after backup/confirmation. | `docker volume rm old-db-data` | `docker volume prune` deletes all unused volumes—review carefully. |
| `docker volume prune` | **⚠️** Removes unused local volumes; use to reclaim disk after inspection. | `docker volume prune` | A stopped container may be your only reference to needed data. |

## 🔐 Registries, security, and Swarm

| Command | 📖 Description and 🎯 when | 💻 Example | 🔍 Flags, arguments, and 💡 tip |
|---|---|---|---|
| `docker scan` | Deprecated/removed in current Docker distributions; use a supported scanner such as Docker Scout instead. | `docker scout quickview nginx:1.27-alpine` | Install/availability varies; follow current Docker Scout docs. |
| `docker secret create` | Creates a Swarm secret from stdin/file; use for Swarm service secrets. | `Get-Content .\db_password.txt \| docker secret create db_password -` | **⚠️** Swarm-only; secrets are immutable—create a new one to rotate. |
| `docker swarm init` | Initializes the current Engine as a manager; use only when intentionally adopting Swarm. | `docker swarm init --advertise-addr 10.0.0.10` | Protect manager access and save join tokens securely. |
| `docker swarm join-token` | Prints a worker/manager join command; use when adding a node. | `docker swarm join-token worker` | **⚠️** Treat output as sensitive until rotated. |
| `docker node ls/inspect/update` | Lists, inspects, or changes Swarm node availability/labels. | `docker node update --availability drain worker-1` | Drain before maintenance; manager-only commands require a manager. |
| `docker service create` | Creates a replicated/global Swarm workload. | `docker service create --name web --replicas 3 -p 8080:80 nginx:1.27-alpine` | Use `--limit-cpu`, `--limit-memory`, update/rollback policy, and health-aware app design. |
| `docker service ls/ps/logs/inspect` | Observes service/task state; use for Swarm diagnosis. | `docker service ps web` | `docker service logs -f web` reads aggregated task logs. |
| `docker service scale/update/rollback/rm` | Scales, changes, rolls back, or removes a service. | `docker service update --image nginx:1.27.1-alpine web` | **⚠️** Validate update policy; `rollback` returns to the prior service spec. |
| `docker stack deploy/ls/services/rm` | Deploys and manages a Swarm stack from a Compose-format file. | `docker stack deploy -c stack.yml prod` | `docker stack rm prod` is **⚠️ destructive** to that stack's services/networks. |

## 🛠️ Ten practical workflows

| Scenario | Safe sequence and why |
|---|---|
| 1. Verify installation | Run `docker --version` (client version), `docker info` (daemon health), then `docker run --rm hello-world` (create/run/remove a test container). |
| 2. Find an app that exited | Run `docker ps -a` (include stopped containers), `docker logs --tail 100 NAME` (read error), then `docker inspect NAME` (check exit state/config). |
| 3. Debug a running app | Run `docker exec -it NAME sh` (shell), `docker top NAME` (processes), and `docker stats --no-stream NAME` (one resource snapshot). |
| 4. Publish a local service safely | Use `docker run -d --name api -p 127.0.0.1:8080:8080 IMAGE` (bind only localhost) and `docker port api` (confirm mapping). |
| 5. Persist database data | Create `docker volume create db-data`, mount with `--mount type=volume,src=db-data,dst=/var/lib/postgresql/data`, then inspect with `docker volume inspect db-data`. |
| 6. Move an image offline | Use `docker image save -o app.tar IMAGE` (export), transfer securely, then `docker image load -i app.tar` (import). |
| 7. Build/release an image | Run `docker build -t registry.example.com/team/api:1.0 .`, `docker login registry.example.com`, then `docker push registry.example.com/team/api:1.0`. |
| 8. Run a local stack | Run `docker compose config` (validate), `docker compose up -d --build` (start), `docker compose ps` and `docker compose logs -f api` (observe). |
| 9. Reclaim disk carefully | Run `docker system df` (measure), `docker ps -a`/`docker image ls` (inspect), then `docker system prune` only after reviewing what is unused. |
| 10. Multi-platform release | Create/select a builder with `docker buildx create --use`, then use `docker buildx build --platform linux/amd64,linux/arm64 --push -t REGISTRY/IMAGE:TAG .`. |

## 📋 Complete reference and help

Docker ships more command-specific flags than a static document can safely reproduce across Engine and Compose releases. Use the command cards above for practical syntax, then ask your installed version for the authoritative complete option set:

| Need | Command | 📖 How to use it | 💻 Example |
|---|---|---|---|
| All Docker command groups | `docker --help` | Lists every command group supported by the installed client; use it when you need a command not covered by a workflow. | `docker --help` |
| Exact command syntax | `docker COMMAND --help` | Lists every supported flag, argument, default, and subcommand for one command; use it before automating a version-dependent option. | `docker service update --help` |
| Exact Compose syntax | `docker compose COMMAND --help` | Lists Compose-plugin options for the installed version; use it before production scripts. | `docker compose up --help` |
| Exact Buildx syntax | `docker buildx COMMAND --help` | Lists the active Buildx builder command options; use it for multi-platform or cache configuration. | `docker buildx build --help` |

## ✅ Production checklist

- Use minimal trusted bases, pin versions/digests, and rebuild regularly.
- Run as a non-root `USER`; drop unneeded capabilities; use read-only roots where feasible.
- Use secrets/secret stores rather than environment variables, image layers, logs, or source control.
- Set CPU/memory limits, health checks, graceful shutdown, logging, and monitoring.
- Back up persistent data; test restore—not merely backup creation.
- Use explicit networks, least-privilege published ports, and TLS/authentication at boundaries.

## 🔗 Official documentation

- [Docker reference](https://docs.docker.com/reference/)
- [Docker CLI reference](https://docs.docker.com/reference/cli/docker/)
- [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)
- [Compose reference](https://docs.docker.com/compose/reference/)
- [Buildx reference](https://docs.docker.com/buildx/working-with-buildx/)
- [Swarm mode](https://docs.docker.com/engine/swarm/)

## ➕ Additional Docker command cards

| Command | 📖 Description / 🎯 when | 💻 Usage example | 🔍 Notes |
|---|---|---|---|
| `docker container prune` | **⚠️** Removes all stopped containers; use only after reviewing `docker ps -a`. | `docker container prune` | Prompts by default; add `--filter until=24h` to constrain age. |
| `docker image history` | Shows image layers and creation commands; use for image-size/security investigation. | `docker image history nginx:1.27-alpine` | Never rely on history to hide secrets—do not build them into layers. |
| `docker image prune` | **⚠️** Removes dangling images; use after checking builds. | `docker image prune` | `-a` removes all unused images and is much broader. |
| `docker container wait` | Blocks until containers exit and prints exit codes; use in CI scripts. | `docker container wait test-run` | Combine with a separately started test container. |
| `docker container attach` | Attaches terminal streams to a running container; use for foreground processes. | `docker container attach job` | Detach with the configured detach keys; `logs -f` is safer for observation. |
| `docker container export` | Streams a container filesystem tar; use for forensic capture. | `docker container export api -o api-rootfs.tar` | Does not preserve image config, volumes, or history. |
| `docker container commit` | Creates an image from a container's writable layer; use for emergency debugging snapshots. | `docker container commit api api:debug-snapshot` | Prefer a reproducible Dockerfile for normal delivery. |
| `docker network prune` | **⚠️** Removes unused networks; use only after checking active stacks. | `docker network prune` | Docker-managed default networks are retained. |
| `docker builder prune` | **⚠️** Removes build cache; use when disk is constrained. | `docker builder prune --filter until=168h` | `-a` removes all unused cache and causes slower rebuilds. |
| `docker buildx prune` | **⚠️** Removes cache belonging to the active Buildx builder. | `docker buildx prune --filter until=168h` | Use `--verbose` to understand reclaimed cache. |
| `docker plugin ls/inspect/enable/disable/rm` | Lists and manages Engine plugins; use only for approved storage/network plugins. | `docker plugin ls` | **⚠️** Disabling/removing an in-use plugin can interrupt workloads. |
| `docker trust inspect/sign` | Inspects/signs Docker Content Trust metadata where supported. | `docker trust inspect IMAGE` | Docker Content Trust workflow support is ecosystem/version dependent; follow current registry policy. |
| `docker checkpoint create/ls/rm` | Creates, lists, or removes CRIU checkpoints for supported containers; use for specialized state-migration testing. | `docker checkpoint create api api-checkpoint` | Requires compatible host/kernel support; validate restored application behavior. |
| `docker image build` | Alias of `docker build`; use when scripts prefer the image command namespace. | `docker image build -t api:1.0 .` | Keep one style consistently in team documentation. |
| `docker container ls` | Alias of `docker ps`; use when grouping scripts by resource type. | `docker container ls -a` | `-a` includes stopped containers. |
| `docker system df` | Reports Docker disk usage; use before prune operations. | `docker system df -v` | `-v` provides per-image/container details. |
| `docker system events` | Streams daemon events; use for lifecycle troubleshooting. | `docker system events --filter type=container` | Equivalent command family to `docker events`. |
