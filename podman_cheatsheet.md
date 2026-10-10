# 🦭 Podman Command Cheat Sheet

[![Podman](https://img.shields.io/badge/Podman-CLI-892CA0?style=for-the-badge&logo=podman&logoColor=white)](https://docs.podman.io/)
[![Rootless](https://img.shields.io/badge/Default-Rootless%20ready-16A34A?style=for-the-badge)](#-rootless-and-rootful)
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
| SELinux mount failure | Use `:Z` for a private bind mount or `:z` for shared content; do not disable SELinux casually. |

## 🔗 Official documentation

- [Podman command reference](https://docs.podman.io/en/latest/Commands.html)
- [Podman rootless run options](https://docs.podman.io/en/latest/markdown/podman-run.1.html)
- [Pods](https://docs.podman.io/en/latest/markdown/podman-pod.1.html)
- [Machine](https://docs.podman.io/en/latest/markdown/podman-machine.1.html)
- [Quadlet](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html)

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
