# 🦭 Podman Command Cheat Sheet

[![Podman](https://img.shields.io/badge/Podman-CLI-892CA0?style=for-the-badge&logo=podman&logoColor=white)](https://docs.podman.io/)
[![Rootless](https://img.shields.io/badge/Default-Rootless%20ready-16A34A?style=for-the-badge)](#-fundamentals)
[![Reference](https://img.shields.io/badge/Reference-Command%20catalog-0EA5E9?style=for-the-badge)](#-command-cards)

> Official reference: [docs.podman.io](https://docs.podman.io/). Podman is daemonless and Docker-CLI compatible for many—not all—commands. Run `podman COMMAND --help` for the installed version.

> [!TIP]
> **🎨 Visual legend:** 🟢 getting started · 🟡 daily operations · 🔴 expert/platform work · 💻 copyable command · 🔍 option behavior · 💡 practical advice · ⚠️ destructive or security-sensitive action.

## 📚 Contents
- [🚦 Fundamentals](#-fundamentals)
- [🚀 Essential command cards](#-essential-command-cards)
- [🧩 Command cards](#-command-cards)
- [🦭 Pods, machine, kube, and Quadlet](#-pods-machine-kube-and-quadlet)
- [🔐 Security and workflows](#-security-and-workflows)

## 🚦 Fundamentals

**Rootless** containers run as your normal user and are the recommended default; they map container IDs through user namespaces. **Rootful** commands (`sudo podman ...`) use separate images, containers, and storage. On Windows/macOS, `podman machine` manages the Linux VM.

> [!WARNING]
> `podman rm -f`, `podman rmi -f`, `podman volume rm`, `podman system prune`, and `podman system reset` are destructive. Inspect first with `podman ps -a`, `podman images`, `podman volume ls`, and `podman system df`.


**Containerization and Podman architecture:** Containerization packages an application with its dependencies as an OCI-compatible image and runs it as isolated host processes rather than a separate virtual machine. Podman uses a daemonless CLI (or optional API service), OCI runtimes such as `crun`/`runc`, local image/container storage, and registry access. Modern Podman uses Netavark for network management and Aardvark DNS on DNS-enabled networks. Images are built in layers; running containers add writable state that is not a substitute for durable storage.

**Screenshot topic cross-reference** (Docker concepts translated to Podman; Docker Engine and Podman are not the same architecture):

| Screenshot topic | Podman equivalent / where to start |
|---|---|
| Containerization | OCI images, isolated container processes, rootless operation. |
| Docker Architecture | Podman CLI + OCI runtime + image storage + networking; no permanently running Engine daemon is required. |
| Docker Engine | Podman runtime/CLI and optional `podman system service` API, **not** a Docker Engine daemon. |
| Docker Images | `podman images`, `podman pull`, `podman image inspect`. |
| Docker Containers | `podman run`, `podman ps -a`, `podman logs`, `podman exec`. |
| Dockerfile | `Containerfile` or `Dockerfile` with `podman build`. |
| Docker Image Layers | `podman history IMAGE`, `podman image tree IMAGE`. |
| Docker Volumes | `podman volume create/ls/inspect/rm`; volumes persist independently of containers. |
| Bind Mounts | `podman run --mount type=bind,...` or `-v HOST:CONTAINER`; account for SELinux/UIDs. |
| Docker Networking | `podman network ls/create/inspect`, `podman run --network`. |
| Docker Bridge Network | Rootful default bridge or user-defined `podman network create --driver bridge app-net`. |
| Docker Host Network | `podman run --network host IMAGE`; reduces network isolation. |
| Docker Compose | `podman compose` using an **installed external Compose provider**. |
| Docker Registry | OCI-compatible registries: `podman login`, `tag`, `pull`, `push`. |
| Docker Hub and Amazon ECR | `docker.io/YOUR_USER/IMAGE` or an account-specific ECR repository; examples below. |
| Multi-Stage Builds | Multiple `FROM` stages in a `Containerfile`; `podman build --target`. |

## 🚀 Essential command cards

The complete command catalog follows; every displayed command includes its use and copyable syntax.

| Command | 📖 Purpose / 🎯 when | 💻 Example | 🔍 Notes |
|---|---|---|---|
| `podman info` | Show host/store/network details; diagnose setup. | `podman info` | Confirms rootless/rootful mode. |
| `podman run` | Create/start a container. | `podman run --rm quay.io/podman/hello` | `--rm` removes it after exit. |
| `podman ps -a` | List all containers; find failures. | `podman ps -a` | `-q` emits IDs. |
| `podman logs` | Read container output; diagnose crashes. | `podman logs -f api` | `--tail 100` limits output. |
| `podman exec` | Run in a running container. | `podman exec -it api sh` | Use for diagnosis, not configuration. |
| `podman build` | Build a Containerfile/Dockerfile. | `podman build -t api:1.0 .` | Supports multi-stage builds. |
| `podman pod create` | Create a shared-network pod. | `podman pod create --name app -p 8080:8080` | Port publishing belongs on the pod. |
| `podman kube play` | Create resources from Kubernetes YAML. | `podman kube play app.yaml` | Podman extension; review YAML. |
| `podman machine init` | Create Windows/macOS VM. | `podman machine init` | Not normally needed on Linux. |
| `podman system prune` | **⚠️** Remove unused resources. | `podman system prune` | Use `--all` only after review. |
| `podman images` | List locally stored images and tags. | `podman images --digests` | Review image origins and digests before cleanup. |
| `podman history` | Inspect image layers and build history. | `podman history --no-trunc localhost/api:1.0` | Layers may reveal build commands; never embed secrets. |
| `podman volume create` | Create reusable persistent storage. | `podman volume create db-data` | Volumes outlive the containers using them. |
| `podman run --mount` | Bind a host directory or attach a managed volume. | `podman run --rm --mount type=bind,src="$PWD",dst=/workspace,ro docker.io/library/alpine:3.20 ls /workspace` | Bash/Linux example; rootless ownership and SELinux may need attention. |
| `podman network create` | Create a dedicated bridge network. | `podman network create --driver bridge app-net` | Use `--network app-net` when starting containers. |
| `podman run --network host` | Share the host's network namespace. | `podman run --rm --network host docker.io/library/alpine:3.20 ip addr` | ⚠️ Reduced isolation; `-p` is not applicable. |
| `podman compose` | Run a Compose-defined multi-container stack. | `podman compose up -d` | An external Compose provider must be installed; behavior varies by provider. |
| `podman login` | Authenticate to a registry. | `podman login docker.io` | Use `--password-stdin` for automation. |
| `podman push` | Upload a local image to a registry. | `podman push docker.io/YOUR_USER/api:1.0` | Tag appropriately and authenticate first. |
| `podman build --target` | Build a named multi-stage target. | `podman build -f Containerfile --target build -t localhost/api:build .` | Use a `FROM ... AS build` stage. |

## 🧩 Command cards

> [!IMPORTANT]
> **🧭 Each card follows one path:** command → why it exists → safe real-world example → flags and compatibility notes.

| Command | 📖 Description / 🎯 when | 💻 Example | 🔍 Flags and advice |
|---|---|---|---|
| `podman --version`, `podman --help` | Print version or supported help; use before relying on a flag. | `podman run --help` | Installed versions differ across distributions. |
| `podman system connection list/default/add/remove` | List, choose, add, or remove remote service connections. | `podman system connection list` | `podman system connection default NAME` selects a target; use SSH/TLS securely. |
| `podman search/pull/images/image inspect` | Find, download, list, and audit images. | `podman pull docker.io/library/nginx:1.27-alpine` | Fully qualify image names; prefer immutable tags/digests. |
| `podman tag/push/login/logout` | Tag and publish images; authenticate only when needed. | `podman tag api:1.0 quay.io/acme/api:1.0` | Use `--password-stdin` with `login`; never expose tokens in history. |
| `podman save/load/export/import` | Transfer images (`save/load`) or container filesystems (`export/import`). | `podman save -o api.tar api:1.0` | `export` does not preserve image history. |
| `podman rmi` | **⚠️** Remove local images. | `podman rmi api:old` | Check dependent containers first. |
| `podman create/run` | Create only or create/start a container. | `podman run -d --name api -p 127.0.0.1:8080:8080 api:1.0` | `-d` detaches; bind localhost to avoid accidental exposure. |
| `podman run -e/--env-file` | Set runtime config. | `podman run --rm -e LOG_LEVEL=info api:1.0` | Do not store secrets in source-controlled env files. |
| `podman run -v/--mount` | Mount bind paths or volumes. | `podman run --rm -v data:/data:Z image` | On SELinux hosts, `:Z` relabels a private mount; `:z` shares it. |
| `podman ps/start/stop/restart/kill/rm` | Observe and control lifecycle. | `podman stop -t 30 api` | `kill`/`rm -f` are **⚠️** forceful; prefer graceful stop. |
| `podman inspect/top/stats/events/diff` | Inspect metadata, processes, resources, events, and filesystem changes. | `podman stats --no-stream api` | Use `--format` for stable automation output. |
| `podman cp/commit` | Copy files or make an image from a container. | `podman cp api:/app/log.txt .` | Prefer reproducible Containerfiles over `commit`. |
| `podman network create/ls/inspect/rm` | Manage isolated networks. | `podman network create app-net` | Rootless networking uses user-mode networking; behavior/performance differs from rootful. |
| `podman volume create/ls/inspect/rm` | Manage persistent storage. | `podman volume create db-data` | **⚠️** Removing a volume deletes its data. |
| `podman generate systemd` | Generates legacy systemd units from existing containers/pods. | `podman generate systemd --new --name api` | For new systems, prefer Quadlet. |
| `podman system df/prune/reset` | Measure, prune, or reset local storage. | `podman system df` | `reset` is **⚠️ extremely destructive**: removes all Podman resources. |
| `podman images` | Lists local image references; check before deleting. | `podman images --digests` | Fully qualified registry names avoid short-name ambiguity. |
| `podman history` / `podman image history` | Displays image layer sizes and creation instructions; investigate image size and unexpected content. | `podman history --no-trunc localhost/api:1.0` | History is not a security boundary; build secrets must not be written to layers. |
| `podman image inspect` | Shows layers, config, ports, labels, and image metadata. | `podman image inspect docker.io/library/nginx:alpine` | Use `--format` when parsing metadata in scripts. |
| `podman build -f` | Builds OCI images from a `Containerfile` or `Dockerfile`. | `podman build -f Containerfile -t localhost/api:1.0 .` | The final `.` is the build context; exclude secrets using `.containerignore` or `.dockerignore`. |
| `podman build --target` | Selects a stage from a multi-stage build. | `podman build --target build -t localhost/api:build .` | Final minimal stage copies required artifacts via `COPY --from=build`. |
| `podman run --mount type=bind` | Shares host source code/config with a container; useful for development. | `podman run --rm --mount type=bind,src="$PWD",dst=/workspace,ro docker.io/library/alpine:3.20 ls /workspace` | `ro` prevents container writes; host path is on the Podman host/VM. |
| `podman run --mount type=volume` | Mounts Podman-managed persistent data. | `podman run --rm --mount type=volume,src=db-data,dst=/data docker.io/library/alpine:3.20 ls /data` | Create with `podman volume create db-data`; back up data before deleting. |
| `podman volume prune` | **⚠️** Deletes unused volumes and their data. | `podman volume ls` | Inspect/back up first; `podman volume prune` is destructive. |
| `podman network create --driver bridge` | Creates a user-defined bridge network. | `podman network create --driver bridge app-net` | The default rootful bridge and rootless networking differ. |
| `podman run --network app-net` | Attaches a new container to a named network. | `podman run -d --name web --network app-net -p 127.0.0.1:8080:80 docker.io/library/nginx:alpine` | DNS-enabled user-defined networks resolve container names. |
| `podman run --network host` | Shares host network namespace instead of isolating it. | `podman run --rm --network host docker.io/library/alpine:3.20 ip addr` | **⚠️** Host-bound services can become reachable; port publishing flags do not apply. |
| `podman network connect/disconnect` | Attaches/detaches an existing container from a network. | `podman network connect app-net api` | Review service reachability before detaching. |
| `podman compose config/up/ps/logs/down` | Uses an external Compose provider to validate, start, observe, and stop stacks. | `podman compose config` | Install/configure a provider first; `down -v` **⚠️** removes project volumes. |
| `podman login/tag/push` | Publishes images to Docker Hub, Amazon ECR, or other registries. | `podman tag localhost/api:1.0 docker.io/YOUR_USER/api:1.0` | Always choose the full target registry/repository and use approved credentials. |


**Containerfile and image layers:** `Containerfile` and `Dockerfile` use the same Dockerfile instruction syntax (`FROM`, `WORKDIR`, `COPY`, `RUN`, `ENV`, `USER`, `EXPOSE`, `CMD`, `ENTRYPOINT`, etc.). Instructions can contribute layers and build metadata. Use a small trusted runtime stage, `.containerignore` to omit build output/secrets, and `podman history` to inspect the result.

```dockerfile
# Containerfile — example single-project ASP.NET Core API (replace Api.dll as needed)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /out

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out .
USER 10001
EXPOSE 8080
ENTRYPOINT ["dotnet", "Api.dll"]
```

```bash
# Build the minimal runtime image and inspect its image layers
podman build -f Containerfile -t localhost/api:1.0 .
podman history localhost/api:1.0

# Build only the intermediate stage for troubleshooting
podman build -f Containerfile --target build -t localhost/api:build .
```

**Storage and networking essentials:** named volumes are managed by Podman and survive container removal; bind mounts expose existing host paths and should usually be read-only unless writes are required. On SELinux systems, `-v /host/path:/container/path:Z` relabels for private container use (`:z` for shared use); changing labels on system directories can cause host issues. On macOS/Windows, bind paths are resolved by the Linux VM/remote Podman host. `--network bridge` is typical for rootful isolated containers; recent rootless installations commonly use `pasta` by default. `--network host` removes network-namespace isolation, so avoid it unless necessary. `-p` exposes ports for supported isolated modes rather than host mode.

**Compose:** `podman compose` delegates to an external provider (such as Docker Compose or podman-compose). It is not a built-in Compose implementation. Install/select a provider and validate with `podman compose config` before starting the stack:

```bash
podman compose config
podman compose up -d
podman compose ps
podman compose logs --tail 100
podman compose down       # CAUTION: down -v also deletes project volumes
```

## 🦭 Pods, machine, kube, and Quadlet

> [!NOTE]
> **🧩 Podman superpower:** pods share a network namespace, Quadlet integrates declarative containers with systemd, and `kube play` tests Kubernetes-style YAML locally.

| Command | 📖 Description / 🎯 when | 💻 Example | 🔍 Notes |
|---|---|---|---|
| `podman pod create` | Creates a pod with shared network namespace; use for tightly coupled containers. | `podman pod create --name app -p 8080:8080` | Publish ports at pod creation. |
| `podman run --pod` | Adds a container to a pod. | `podman run -d --pod app --name api api:1.0` | Containers communicate through `localhost` inside a pod. |
| `podman pod ls/inspect/start/stop/restart/rm` | Lists, examines, controls, or removes pods. | `podman pod inspect app` | **⚠️** `pod rm -f app` removes member containers. |
| `podman kube generate` | Generates Kubernetes YAML from pod/container state. | `podman kube generate app > app.yaml` | Review generated YAML before reuse. |
| `podman kube play/down` | Creates/removes resources described by YAML. | `podman kube play --replace app.yaml` | `--replace` removes same-named resources first. |
| `podman machine init/start/stop/list/ssh/rm` | Manages Podman VM on Windows/macOS. | `podman machine init --cpus 4 --memory 4096; podman machine start` | **⚠️** `machine rm` deletes that VM. |

```ini
# ~/.config/containers/systemd/api.container — rootless Quadlet
[Unit]
Description=Example API
[Container]
Image=quay.io/acme/api:1.0
PublishPort=127.0.0.1:8080:8080
Environment=LOG_LEVEL=info
[Service]
Restart=always
[Install]
WantedBy=default.target
```

Use `systemctl --user daemon-reload` then `systemctl --user start api.service`; Quadlet is read by systemd generators and is preferable to hand-maintained generated units.

## 🔐 Security and workflows

> [!TIP]
> **🛡️ Secure default:** begin rootless, publish only required ports, use SELinux labels correctly, and keep credentials in secrets—not images or shell history.

- **Rootless first:** `podman run --rm --userns=keep-id IMAGE` keeps your host identity mapping useful for bind mounts.
- **Least privilege:** use `--read-only`, `--cap-drop=ALL`, then add only required capabilities; use `--security-opt no-new-privileges`.
- **Secrets:** create `podman secret create db_password ./db_password.txt`, then use `--secret db_password`; never bake passwords into images.
- **Docker migration:** replace `docker` with `podman` for basic image/container commands, but use `podman pod`, `podman machine`, and Quadlet intentionally—Docker Compose behavior is not identical.

| Workflow | Steps |
|---|---|
| Rootless web app | `podman run -d --name web -p 127.0.0.1:8080:80 nginx:1.27-alpine`; check with `podman ps`, then `podman logs web`. |
| Debug exit | `podman ps -a` (find), `podman logs NAME` (error), `podman inspect NAME` (state). |
| Build/publish | `podman build -t quay.io/acme/api:1.0 .`, `podman login quay.io`, `podman push quay.io/acme/api:1.0`. |
| Persistent database | `podman volume create db-data`, then `podman run -v db-data:/var/lib/postgresql/data postgres:16`. |
| Multi-container app | `podman pod create --name app -p 8080:8080`; run API and sidecar with `--pod app`. |
| Windows/macOS start | `podman machine init`, `podman machine start`, then `podman info`. |
| Kubernetes handoff | `podman kube generate app > app.yaml`, review, then test with `podman kube play app.yaml`. |
| Systemd service | Save the Quadlet above, reload systemd, start `api.service`, inspect with `systemctl --user status api.service`. |
| Storage cleanup | `podman system df` first, then only if understood `podman system prune`. |
| Inspect an image layer | `podman history --no-trunc localhost/api:1.0`; compare size/config with `podman image inspect localhost/api:1.0`. |
| Bind-mount working files | Use `--mount type=bind,src="$PWD",dst=/workspace,ro` for read-only source inspection; adapt host/VM paths and SELinux policy. |
| Custom bridge network | `podman network create --driver bridge app-net`; start a container with `--network app-net` and inspect via `podman network inspect app-net`. |
| Host network diagnostics | Use `podman run --rm --network host IMAGE COMMAND` only for controlled debugging; it shares the host network namespace. |
| Compose app | Install a Compose provider, run `podman compose config`, `podman compose up -d`, then `podman compose ps`. |
| Image release to ECR | Get an ECR token with `aws ecr get-login-password`, pass it to `podman login --password-stdin`, then tag/push to the correct account/Region registry. |
| SELinux mount failure | Use `:Z` for a private bind mount or `:z` for shared content; do not disable SELinux casually. |


**Docker Hub publishing** (replace `YOUR_USER`, assume the local image `localhost/api:1.0` already exists):

```bash
podman login docker.io
podman tag localhost/api:1.0 docker.io/YOUR_USER/api:1.0
podman push docker.io/YOUR_USER/api:1.0
```

**Amazon ECR publishing** (Bash; requires AWS CLI credentials, IAM permissions, and an existing private ECR repository named `api` in the chosen Region):

```bash
AWS_REGION=eu-north-1
AWS_ACCOUNT_ID=123456789012  # Replace with your AWS account ID
ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

# Authenticate using a temporary ECR token; do not expose passwords in arguments.
aws ecr get-login-password --region "$AWS_REGION" | \
  podman login --username AWS --password-stdin "$ECR_REGISTRY"

podman tag localhost/api:1.0 "$ECR_REGISTRY/api:1.0"
podman push "$ECR_REGISTRY/api:1.0"
```

## 🔗 Official documentation

- [Podman command reference](https://docs.podman.io/en/latest/Commands.html)
- [Podman rootless run options](https://docs.podman.io/en/latest/markdown/podman-run.1.html)
- [Pods](https://docs.podman.io/en/latest/markdown/podman-pod.1.html)
- [Machine](https://docs.podman.io/en/latest/markdown/podman-machine.1.html)
- [Quadlet](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html)
- [Podman architecture and networking](https://docs.podman.io/en/latest/markdown/podman-network.1.html)
- [Image history and layers](https://docs.podman.io/en/latest/markdown/podman-history.1.html)
- [Containerfile builds and multi-stage options](https://docs.podman.io/en/latest/markdown/podman-build.1.html)
- [Bind mounts, named volumes, and network modes](https://docs.podman.io/en/latest/markdown/podman-run.1.html)
- [Compose wrapper and provider requirement](https://docs.podman.io/en/latest/markdown/podman-compose.1.html)
- [Amazon ECR with Podman](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Podman.html)

## ➕ Additional Podman command cards

| Command | 📖 Description / 🎯 when | 💻 Usage example | 🔍 Notes |
|---|---|---|---|
| `podman attach` | Attaches terminal streams to a running container; use for an interactive foreground process. | `podman attach job` | `podman logs -f job` is less disruptive for observation. |
| `podman wait` | Waits for a container exit and prints status; use in test automation. | `podman wait test-run` | Start the container separately before waiting. |
| `podman healthcheck run` | Runs the configured health check now; use for health diagnosis. | `podman healthcheck run api` | Requires a health check configured on the container. |
| `podman container checkpoint/restore` | Saves/restores supported container state; use for specialized migration/experiments. | `podman container checkpoint api` | Requires CRIU/kernel support; validate application correctness after restore. |
| `podman auto-update` | Updates containers managed by auto-update labels; use with a deliberate update policy. | `podman auto-update` | Test rollback/notification behavior before production. |
| `podman unshare` | Runs a command in the rootless user namespace; use to diagnose ownership mappings. | `podman unshare cat /proc/self/uid_map` | Advanced rootless troubleshooting tool. |
| `podman mount/unmount` | Mounts/unmounts a container root filesystem on the host; use for offline inspection. | `podman mount api` | Treat contents as sensitive; unmount when finished. |
| `podman image tree` | Shows image layer relationships; use to understand image ancestry. | `podman image tree api:1.0` | Available behavior depends on Podman version. |
| `podman image prune` | **⚠️** Removes unused images; use after inspecting image references. | `podman image prune` | Add `-a` only when all unused images may be discarded. |
| `podman network reload` | Reloads network configuration for running containers; use after approved network changes. | `podman network reload api` | Verify application connectivity afterward. |
| `podman secret ls/inspect/rm` | Lists, inspects metadata for, or removes secrets. | `podman secret ls` | **⚠️** Removing a referenced secret breaks future container starts. |
| `podman manifest create/add/push` | Builds and publishes a multi-architecture manifest list. | `podman manifest create quay.io/acme/api:1.0` | Add architecture-specific images before push. |
| `podman generate kube` | Exports a pod/container definition as Kubernetes YAML; use before testing a Kubernetes-style handoff. | `podman generate kube app > app.yaml` | Review generated YAML and secret values before sharing. |
| `podman system service` | Exposes the Podman API over a socket; use for approved remote/API clients. | `podman system service --time 0 unix:///tmp/podman.sock` | Protect the socket: API access can control containers. |
| `podman info --debug` | Prints detailed runtime, store, and network diagnostics; use for support investigations. | `podman info --debug` | Review output before sharing because it can expose environment details. |
| `podman container cleanup` | Cleans mounts/resources for stopped containers; use after an abnormal stop. | `podman container cleanup api` | Intended for stopped containers; inspect state first. |
| `podman rm --depend` | Removes a container and dependent containers; use only for intentional teardown. | `podman rm --depend api` | **⚠️** Review dependencies before removal. |
