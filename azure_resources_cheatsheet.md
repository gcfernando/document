# 📦 Azure Resources Deep Reference

**🏷️ Difficulty:** 🟡 Intermediate → 🔴 Advanced (reference — assumes [`azure_cheatsheet.md`](./azure_cheatsheet.md)'s architecture map)

> 🌈 **A structured, resource-by-resource Azure engineering reference**  
> **Edition:** 2026-10-03  
> **Companion:** [`azure_cheatsheet.md`](./azure_cheatsheet.md) helps you choose a service quickly. This file goes deeper into **what the resource contains, how it connects, where it fails, and what to verify before production**.
>
> [!IMPORTANT]
> Verify live: **pricing, SKU capabilities, quotas, limits, regions, Availability Zone support, SLA, API versions, preview/GA status, supported runtimes/models, and retirement dates**.

## 🎨 Resource-card legend

| Symbol | Meaning |
|---|---|
| 🟦 | What it is |
| 🧩 | Internal resources / concepts |
| ✅ | Good fit |
| ⚠️ | Production trap / watch-out |
| 🌐 | Networking |
| 🔐 | Identity/security |
| 📈 | Scale/reliability |
| 👀 | Monitoring/troubleshooting |
| 💰 | Cost driver |
| 🔄 | Lifecycle/transition |
| 📚 | Authoritative docs |

<a id="resource-toc"></a>
# 🗺️ Table of Contents

## 0. Fundamentals
0. [🧱 How to Use This Resource Reference](#r0)

## PART I — 🖥️ Compute & Application Hosting
1. [Virtual Machines](#r1)
2. [Managed Application Platforms](#r2)
3. [Containers & Kubernetes](#r3)

## PART II — 🌐 Networking
4. [Network Foundations](#r4)
5. [DNS](#r5)
6. [Hybrid & Global Connectivity](#r6)
7. [Application Delivery & Load Balancing](#r7)
8. [Network Security & Management](#r8)

## PART III — 💾 Storage
9. [Azure Storage Account](#r9)
10. [Object & Data Lake Storage](#r10)
11. [File Storage](#r11)
12. [Block & SAN Storage](#r12)
13. [Storage Data Movement & Management](#r13)

## PART IV — 🗄️ Databases & Caching
14. [Microsoft SQL on Azure](#r14)
15. [Open-Source Relational Databases](#r15)
16. [NoSQL & Distributed Databases](#r16)
17. [Caching](#r17)
18. [Specialized / Partner Databases](#r18)

## PART V — 📨 Messaging, Events & Integration
19. [Azure Service Bus](#r19)
20. [Azure Event Grid](#r20)
21. [Azure Event Hubs](#r21)
22. [Azure Queue Storage](#r22)
23. [Workflow & Integration](#r23)
24. [API Management](#r24)
25. [Real-Time Application Services](#r25)

## PART VI — 👤 Identity, Access & Secrets
26. [Microsoft Entra Concepts Used by Azure Resources](#r26)
27. [Azure RBAC](#r27)
28. [Azure Key Vault](#r28)
29. [Managed HSM](#r29)

## PART VII — 📊 Observability & Operations
30. [Azure Monitor](#r30)
31. [Log Analytics](#r31)
32. [Application Insights](#r32)
33. [Alerts & Visualization](#r33)
34. [Health & Recommendations](#r34)
35. [Automation & Maintenance](#r35)

## PART VIII — 🛡️ Security
36. [Microsoft Defender for Cloud](#r36)
37. [Microsoft Sentinel](#r37)
38. [Network Security Resources](#r38)
39. [Confidential Computing](#r39)

## PART IX — 🧯 Backup, Recovery & Resilience
40. [Azure Backup](#r40)
41. [Azure Site Recovery](#r41)
42. [Azure Chaos Studio](#r42)

## PART X — 🏛️ Governance & Resource Management
43. [Azure Resource Manager](#r43)
44. [Azure Policy](#r44)
45. [Management Groups](#r45)
46. [Resource Graph](#r46)
47. [Cost Management](#r47)
48. [Resource Locks](#r48)

## PART XI — 📈 Data & Analytics
49. [Azure Data Factory](#r49)
50. [Azure Databricks](#r50)
51. [Azure Data Explorer](#r51)
52. [Azure Synapse Analytics](#r52)
53. [Azure Stream Analytics](#r53)
54. [Microsoft Fabric Context](#r54)

## PART XII — 🤖 AI & Machine Learning
55. [Microsoft Foundry](#r55)
56. [Azure OpenAI / Foundry Models](#r56)
57. [Azure AI Search](#r57)
58. [Azure Machine Learning](#r58)
59. [Foundry Tools / AI Services](#r59)

## PART XIII — 🌍 IoT & Edge
60. [Azure IoT Hub](#r60)
61. [Azure IoT Operations](#r61)
62. [Azure Digital Twins](#r62)
63. [IoT Edge](#r63)

## PART XIV — 🔀 Hybrid, Multicloud & Migration
64. [Azure Arc](#r64)
65. [Azure Local](#r65)
66. [Azure VMware Solution](#r66)
67. [Azure Migrate](#r67)
68. [Database Migration Service](#r68)
69. [Azure Storage Mover & Data Box](#r69)

## PART XV — 🖥️ Virtual Desktop
70. [Azure Virtual Desktop](#r70)

## PART XVI — 🧰 Specialized Application Services
71. [Azure Maps](#r71)
72. [Azure Communication Services](#r72)
73. [Azure App Testing](#r73)
74. [Azure Batch](#r74)

## PART XVII — 🔄 Lifecycle & Transitions
75. [Services in Transition / Retirement](#r75)
76. [Preview & Emerging Resources](#r76)

## PART XVIII — 📚 Official Source Map
77. [Official Microsoft Documentation Directory](#r77)

<a id="r0"></a>
# 0. 🧱 How to Use This Resource Reference

> 🟦 **What it is:** Azure Resource Manager (ARM) is the management plane behind Azure resources. A resource provider exposes resource types such as `Microsoft.Compute/virtualMachines` or `Microsoft.KeyVault/vaults`. This reference is organized by resource families rather than by product marketing pages.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Resource provider** | Namespace that exposes REST operations and resource types. |
| **Resource type** | Deployable/manageable ARM object. |
| **API version** | Management contract version used by ARM/Bicep/SDKs. |
| **Control plane** | Create/configure/delete resource. |
| **Data plane** | Use the resource: read blob, send message, query DB. |
| **SKU/tier** | Feature/performance/cost level. |
| **Region/zone** | Placement and resilience characteristics. |
| **Dependencies** | Networking, identity, DNS, storage, monitoring, etc. |

## ✅ Use when
- Use this file after you already know which service family you want.
- Use the resource map to understand internal Azure objects before writing IaC.

## ⚠️ Engineering watch-outs
- Do not assume ARM `Owner` means data-plane access.
- Do not freeze a SKU/API version/region assumption without checking current docs.
- For private PaaS, DNS is frequently part of the resource design.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-resource-manager/management/resource-providers-and-types

## 🧪 Try it yourself

**Goal:** Connect this reference to a real subscription by discovering registered resource providers and resource types.

```bash
az login
az account show --output table
az provider list --query "[?registrationState=='Registered'].namespace" --output table
az provider show --namespace Microsoft.KeyVault --query "resourceTypes[].resourceType" --output table
```

**👀 Expected result:** A table of registered provider namespaces, then a list of resource types exposed by `Microsoft.KeyVault`.

**✅ Checkpoint:** Is `Microsoft.Compute` registered in your subscription?

**🧹 Clean up:**
Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

# PART I — 🖥️ COMPUTE & APPLICATION HOSTING

<a id="r1"></a>
# 1. 🖥️ Virtual Machines

> 🟦 **What it is:** Azure IaaS compute gives you guest-OS control. VMSS adds fleet/autoscale management; disks, NICs, public IPs, images, extensions, update management and monitoring complete the VM platform.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Virtual Machine** | Windows/Linux computer you manage at OS level. |
| **VM Scale Set** | Fleet of VM instances with shared model and scale behavior. |
| **Managed Disk** | Persistent block storage for OS/data. |
| **NIC** | Connects VM to a subnet. |
| **Public IP** | Optional public endpoint resource. |
| **Availability Set** | Older fault/update-domain HA mechanism. |
| **Availability Zone** | Physical zone placement where supported. |
| **Compute Gallery** | Version/share VM images. |
| **Dedicated Host** | Physical host dedicated to one customer. |
| **Spot VM** | Discounted interruptible capacity. |
| **VM Extensions** | Post-provision agents/scripts. |
| **Update Manager** | Patch orchestration for supported machines. |

## ✅ Use when
- Legacy/lift-and-shift workloads.
- Custom drivers/agents/OS configuration.
- Vendor appliances or software not suitable for PaaS.

## ⚠️ Engineering watch-outs
- Avoid public RDP/SSH; use Bastion or private admin paths.
- A single VM is not HA.
- Disk/VM throughput limits can bottleneck each other.
- Deallocate idle VMs to stop compute billing.
- Check regional VM-family quota before scale/DR.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/virtual-machines/

## 🧪 Try it yourself

**Goal:** Deploy the smallest practical Linux VM, confirm it runs, then deallocate it.

```bash
az group create --name <your-resource-group> --location eastus
az vm create --resource-group <your-resource-group> --name demo-vm --image Ubuntu2204 --size Standard_B1s --generate-ssh-keys --public-ip-sku Standard
az vm show --resource-group <your-resource-group> --name demo-vm --show-details --query "{power:powerState,ip:publicIps}" -o jsonc
az vm deallocate --resource-group <your-resource-group> --name demo-vm
```

**👀 Expected result:** VM shows `powerState: VM running` with a public IP, then transitions to deallocated (stopped, not billed for compute) after the last command.

**✅ Checkpoint:** After `az vm deallocate`, does `az vm get-instance-view` report `PowerState/deallocated`?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r2"></a>
# 2. 🌐 Managed Application Platforms

> 🟦 **What it is:** Managed PaaS removes most OS operations for web apps, APIs, event-driven functions, static sites, application configuration and isolated hosting environments.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **App Service** | Managed web/API hosting. |
| **App Service Plan** | Compute/SKU shared by apps. |
| **Deployment Slot** | Staging deployment that can swap. |
| **App Service Environment** | Isolated/dedicated App Service hosting environment. |
| **Azure Functions** | Event-driven FaaS. |
| **Function hosting plan** | Controls scaling/networking/cost characteristics. |
| **Static Web Apps** | Static frontend + integrated deployment/auth/API patterns. |
| **App Configuration** | Central application configuration/feature flags. |

## ✅ Use when
- Standard web/API hosting without OS management.
- Event-driven functions and timers.
- Static SPA/web hosting.
- Centralized non-secret configuration and feature flags.

## ⚠️ Engineering watch-outs
- App Service VNet Integration is outbound; Private Endpoint is inbound.
- Deployment slots are not DR.
- Function networking differs by hosting plan.
- Do not put secrets in App Configuration when Key Vault is appropriate.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/app-service/

https://learn.microsoft.com/azure/azure-functions/

https://learn.microsoft.com/azure/azure-app-configuration/

## 🧪 Try it yourself

**Goal:** Deploy a free-tier App Service plan and web app, then confirm it serves traffic.

```bash
az group create --name <your-resource-group> --location eastus
az appservice plan create --name demo-plan --resource-group <your-resource-group> --sku F1 --is-linux
az webapp create --name <unique-app-name> --resource-group <your-resource-group> --plan demo-plan --runtime "NODE:20-lts"
az webapp show --name <unique-app-name> --resource-group <your-resource-group> --query defaultHostName -o tsv
```

**👀 Expected result:** A hostname like `<unique-app-name>.azurewebsites.net` is printed; browsing it returns the default Node.js container welcome page (HTTP 200).

**✅ Checkpoint:** Does `curl -I https://<hostname>` return `HTTP/2 200`?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r3"></a>
# 3. ☸️ Containers & Kubernetes

> 🟦 **What it is:** Azure offers multiple container levels: Container Apps for managed container applications, AKS for Kubernetes, ACI for simple container groups, ACR for images/artifacts, and specialized services around Kubernetes/fleet/storage.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Container Apps** | Managed container apps, revisions, autoscale, jobs. |
| **Container Apps Environment** | Network/observability boundary. |
| **Container Apps Jobs** | Run-to-completion container workload. |
| **AKS** | Managed Kubernetes. |
| **AKS Node Pool** | Worker-node group. |
| **AKS Workload Identity** | OIDC-based pod-to-Azure identity. |
| **Kubernetes Fleet Manager** | Multi-cluster fleet scenarios. |
| **ACI** | Simple container groups. |
| **ACR** | Private OCI registry. |
| **Azure Container Storage** | Container-oriented block storage capability. |
| **Azure Red Hat OpenShift** | Managed OpenShift platform. |

## ✅ Use when
- Container Apps when you want containers without operating Kubernetes.
- AKS when Kubernetes APIs/operators/CRDs are actual requirements.
- ACI for simple isolated/burst containers.
- ACR for private image/artifact storage.

## ⚠️ Engineering watch-outs
- Do not choose AKS just because the app has a Dockerfile.
- AKS IP planning and upgrade strategy are production-critical.
- Use workload identity rather than shared pod secrets.
- Use immutable image versions/digests for production.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/container-apps/

https://learn.microsoft.com/azure/aks/

https://learn.microsoft.com/azure/container-registry/

## 🧪 Try it yourself

**Goal:** Run the smallest real container workload — a single Azure Container Instance — without standing up AKS.

```bash
az group create --name <your-resource-group> --location eastus
az container create --resource-group <your-resource-group> --name demo-aci --image mcr.microsoft.com/azuredocs/aci-helloworld --cpu 1 --memory 1 --ports 80 --ip-address Public
az container show --resource-group <your-resource-group> --name demo-aci --query "{ip:ipAddress.ip,state:instanceView.state}" -o jsonc
```

**👀 Expected result:** `state: Running` with a public IP; browsing `http://<ip>` shows "Welcome to Azure Container Instances!".

**✅ Checkpoint:** Does `curl http://<ip>` return the hello-world HTML?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART II — 🌐 NETWORKING

<a id="r4"></a>
# 4. 🌐 Network Foundations

> 🟦 **What it is:** The VNet/subnet model provides private IP space; NSGs filter traffic, route tables steer it, peering connects VNets, Private Link privately exposes PaaS services, and NAT Gateway controls outbound SNAT.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **VNet** | Regional private IP network. |
| **Subnet** | Segment of a VNet. |
| **NIC** | Network interface for VM/compute resources. |
| **Public IP** | Managed public IP resource. |
| **NSG** | Stateful L3/L4 rules. |
| **ASG** | Logical grouping used in NSG rules. |
| **Route Table / UDR** | Custom routing. |
| **VNet Peering** | Private VNet-to-VNet connectivity. |
| **Private Link** | Private-access technology for supported services. |
| **Private Endpoint** | Private IP/NIC representing target PaaS service. |
| **Service Endpoint** | VNet identity to supported public PaaS endpoint. |
| **NAT Gateway** | Predictable scalable outbound public IP. |

## ✅ Use when
- Private application networks.
- Hub-spoke architectures.
- Private PaaS access.
- Predictable outbound connectivity.

## ⚠️ Engineering watch-outs
- Avoid overlapping CIDRs.
- Peering is not inherently transitive.
- Private Endpoint requires DNS planning.
- Routing is not authorization.
- NSGs are not WAFs.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/virtual-network/

https://learn.microsoft.com/azure/private-link/

https://learn.microsoft.com/azure/nat-gateway/

## 🧪 Try it yourself

**Goal:** Create a minimal VNet/subnet and inspect its address space.

```bash
az group create --name <your-resource-group> --location eastus
az network vnet create --resource-group <your-resource-group> --name demo-vnet --address-prefix 10.10.0.0/16 --subnet-name demo-subnet --subnet-prefix 10.10.1.0/24
az network vnet subnet show --resource-group <your-resource-group> --vnet-name demo-vnet --name demo-subnet --query addressPrefix -o tsv
```

**👀 Expected result:** `10.10.1.0/24` is printed, confirming the subnet was carved out of the VNet's `/16`.

**✅ Checkpoint:** Does `az network vnet subnet list` show exactly one subnet in `demo-vnet`?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r5"></a>
# 5. 🌍 DNS

> 🟦 **What it is:** Azure DNS hosts public DNS, Private DNS Zones provide VNet-visible namespaces, and DNS Private Resolver provides managed hybrid DNS forwarding.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure DNS** | Authoritative public DNS zones. |
| **Private DNS Zone** | Private VNet DNS namespace. |
| **VNet Link** | Links a private zone to a VNet. |
| **Private DNS Zone Group** | Associates Private Endpoint with recommended zones. |
| **DNS Private Resolver** | Managed inbound/outbound DNS forwarding. |
| **Forwarding Ruleset** | Domain-specific DNS forwarding rules. |

## ✅ Use when
- Private Endpoint name resolution.
- Hybrid Azure/on-prem DNS.
- Hosting public DNS zones in Azure.

## ⚠️ Engineering watch-outs
- Do not create forwarding loops.
- Private Endpoint clients normally keep using the service FQDN; DNS maps it to private IP.
- Link the right zones to the right VNets.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/dns/

https://learn.microsoft.com/azure/dns/dns-private-resolver-overview

## 🧪 Try it yourself

**Goal:** Create a Private DNS zone, link it to a VNet, and add a record.

```bash
az group create --name <your-resource-group> --location eastus
az network private-dns zone create --resource-group <your-resource-group> --name demo.internal
az network private-dns link vnet create --resource-group <your-resource-group> --zone-name demo.internal --name demo-link --virtual-network <your-vnet-name> --registration-enabled false
az network private-dns record-set a add-record --resource-group <your-resource-group> --zone-name demo.internal --record-set-name app --ipv4-address 10.10.1.4
```

**👀 Expected result:** The zone, VNet link, and A record `app.demo.internal -> 10.10.1.4` are created.

**✅ Checkpoint:** From a VM inside the linked VNet, does `nslookup app.demo.internal` resolve to `10.10.1.4`?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r6"></a>
# 6. 🔌 Hybrid & Global Connectivity

> 🟦 **What it is:** VPN Gateway provides encrypted internet-based tunnels; ExpressRoute provides private provider connectivity; Virtual WAN centralizes managed transit; Route Server exchanges BGP routes with appliances; newer multicloud interconnect options should be verified against current availability.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **VPN Gateway** | S2S/P2S/VNet encrypted VPN. |
| **Local Network Gateway** | Represents on-prem prefixes/gateway. |
| **Virtual Network Gateway** | Azure VPN/ER gateway object. |
| **ExpressRoute Circuit** | Private provider circuit. |
| **ExpressRoute Gateway** | Connects VNet to ER. |
| **Virtual WAN** | Global managed transit umbrella. |
| **Virtual Hub** | Regional managed WAN hub. |
| **Route Server** | BGP exchange with NVAs. |
| **Azure multicloud interconnect** | Emerging connectivity options; verify current service docs. |

## ✅ Use when
- VPN for encrypted hybrid connectivity over internet.
- ExpressRoute for enterprise private connectivity.
- Virtual WAN for large branch/global transit estates.

## ⚠️ Engineering watch-outs
- Plan redundant paths for critical hybrid workloads.
- BGP/routes can create large blast radius.
- Private connectivity does not replace app authentication or encryption requirements.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/vpn-gateway/

https://learn.microsoft.com/azure/expressroute/

https://learn.microsoft.com/azure/virtual-wan/

## 🧪 Try it yourself

**Goal:** Inspect available ExpressRoute providers and any existing gateways without provisioning costly hybrid infrastructure.

```bash
az network express-route list-service-providers --output table
az network vnet-gateway list --resource-group <your-resource-group> --output table
az network vpn-gateway list --output table
```

**👀 Expected result:** A table of ExpressRoute service providers and peering locations; gateway lists are empty unless you already have one deployed.

**✅ Checkpoint:** Which ExpressRoute providers/bandwidths are available at your nearest peering location?

**🧹 Clean up:**
Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r7"></a>
# 7. ⚖️ Application Delivery & Load Balancing

> 🟦 **What it is:** Azure separates Layer-4 regional load balancing, Layer-7 regional web ingress/WAF, global edge HTTP delivery, and DNS-based global routing.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Load Balancer** | Regional TCP/UDP L4. |
| **Application Gateway** | Regional HTTP/S L7 reverse proxy. |
| **WAF** | Web attack protection on Application Gateway/Front Door. |
| **Front Door Standard/Premium** | Global edge HTTP/S acceleration, routing, WAF, failover. |
| **Traffic Manager** | DNS-based global endpoint selection. |

## ✅ Use when
- Load Balancer for VM/VMSS TCP/UDP.
- Application Gateway for regional HTTP/S/WAF/private ingress.
- Front Door for global web/API edge.
- Traffic Manager when DNS-based routing is enough.

## ⚠️ Engineering watch-outs
- Health probes must represent real readiness.
- Traffic Manager does not proxy traffic.
- Do not build new designs on Front Door classic.
- Cache settings can leak/stale authenticated content if misconfigured.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/load-balancer/

https://learn.microsoft.com/azure/application-gateway/

https://learn.microsoft.com/azure/frontdoor/

## 🧪 Try it yourself

**Goal:** Create a minimal public Basic Load Balancer and inspect its frontend configuration.

```bash
az group create --name <your-resource-group> --location eastus
az network lb create --resource-group <your-resource-group> --name demo-lb --sku Basic --public-ip-address demo-pip
az network lb show --resource-group <your-resource-group> --name demo-lb --query "frontendIPConfigurations[].publicIPAddress.id" -o tsv
```

**👀 Expected result:** The resource ID of `demo-pip` is printed, confirming the LB frontend is bound to the public IP.

**✅ Checkpoint:** Does `az network lb probe list --resource-group <your-resource-group> --lb-name demo-lb` return an empty list until a backend pool and probe are added?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r8"></a>
# 8. 🔥 Network Security & Management

> 🟦 **What it is:** Azure Firewall centralizes network/application filtering; WAF protects HTTP; DDoS adds enhanced protection; Bastion protects VM management; Network Watcher and Virtual Network Manager help diagnose/manage large estates.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure Firewall** | Managed stateful firewall. |
| **Firewall Policy** | Reusable centralized firewall policy. |
| **WAF** | HTTP/S attack filtering. |
| **DDoS Protection** | Enhanced DDoS plan. |
| **Bastion** | Private VM RDP/SSH access. |
| **Network Watcher** | Connectivity/route/packet diagnostics. |
| **Connection Monitor** | Continuous network-path monitoring. |
| **Virtual Network Manager** | Central connectivity/security management across VNets. |

## ✅ Use when
- Central inspection/hub-spoke.
- Web perimeter protection.
- Privileged VM administration without public management ports.
- Large-estate network governance.

## ⚠️ Engineering watch-outs
- Firewall does nothing if routes bypass it.
- WAF needs tuning.
- Bastion does not grant OS credentials.
- Start troubleshooting with DNS/routes/NSGs before packet capture.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/firewall/

https://learn.microsoft.com/azure/bastion/

https://learn.microsoft.com/azure/network-watcher/

## 🧪 Try it yourself

**Goal:** Create an NSG with a custom deny-all-inbound rule and compare it against the built-in default rules.

```bash
az group create --name <your-resource-group> --location eastus
az network nsg create --resource-group <your-resource-group> --name demo-nsg
az network nsg rule create --resource-group <your-resource-group> --nsg-name demo-nsg --name DenyAllInbound --priority 4096 --direction Inbound --access Deny --protocol "*" --source-address-prefixes "*" --destination-address-prefixes "*" --source-port-ranges "*" --destination-port-ranges "*"
az network nsg rule list --resource-group <your-resource-group> --nsg-name demo-nsg --output table
```

**👀 Expected result:** `DenyAllInbound` appears at priority 4096, below the auto-created `AllowVnetInBound` (65000) and `DenyAllInBound` (65500) default rules.

**✅ Checkpoint:** What priority do the implicit default rules use compared to your custom rule, and which one wins?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART III — 💾 STORAGE

<a id="r9"></a>
# 9. 🗃️ Azure Storage Account

> 🟦 **What it is:** Storage Account is the top-level namespace/security/networking boundary for Blob, Files, Queue and Table capabilities depending on account type. Redundancy, performance tier, networking and authentication are account-level design choices.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **General-purpose v2** | Default broad storage account type. |
| **Premium account types** | Workload-specific higher performance. |
| **LRS/ZRS/GRS/GZRS families** | Durability/geo redundancy choices. |
| **Firewall/Public access** | Network exposure controls. |
| **Private Endpoint** | Private access per storage subresource. |
| **Entra RBAC/SAS/Keys** | Authentication methods. |
| **Encryption** | Platform-managed keys by default; CMK optional where needed. |

## ✅ Use when
- Blob/File/Queue/Table storage.
- Central Azure storage boundary with deliberate isolation.

## ⚠️ Engineering watch-outs
- Do not share account keys broadly.
- Different subresources use different private DNS zones/endpoints.
- Geo redundancy is not application backup.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/storage/common/storage-account-overview

## 🧪 Try it yourself

**Goal:** Create a minimal Standard LRS storage account and inspect its default security settings.

```bash
az group create --name <your-resource-group> --location eastus
az storage account create --resource-group <your-resource-group> --name <unique-storage-acct> --sku Standard_LRS --kind StorageV2
az storage account show --resource-group <your-resource-group> --name <unique-storage-acct> --query "{sku:sku.name,kind:kind,https:enableHttpsTrafficOnly}" -o jsonc
```

**👀 Expected result:** JSON showing `sku: Standard_LRS`, `kind: StorageV2`, `https: true`.

**✅ Checkpoint:** Is `enableHttpsTrafficOnly` true by default, and what happens if you try an `http://` request to the blob endpoint?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r10"></a>
# 10. 🌊 Object & Data Lake Storage

> 🟦 **What it is:** Blob Storage handles object data; ADLS Gen2 adds hierarchical namespace/file-system semantics for analytics. Lifecycle management, immutability, access tiers and private access are key operational features.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Blob Container** | Logical object grouping. |
| **Block Blob** | Typical object/file type. |
| **Append Blob** | Append-oriented scenarios. |
| **Page Blob** | Random-page storage scenarios. |
| **Hot/Cool/Cold/Archive** | Access tiers. |
| **Lifecycle Management** | Automatic tier/delete policies. |
| **Immutable Blob Storage** | WORM/retention scenarios. |
| **ADLS Gen2** | Blob + hierarchical namespace. |
| **ACLs** | POSIX-like directory/file permissions for ADLS. |

## ✅ Use when
- Objects, documents, logs, backups, media.
- Analytics lake files and Parquet/Delta datasets.

## ⚠️ Engineering watch-outs
- Avoid millions of tiny analytics files.
- Private ADLS often needs both `blob` and `dfs` awareness.
- Archive tier has rehydration latency.
- RBAC and ADLS ACLs can both affect access.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/storage/blobs/

https://learn.microsoft.com/azure/storage/blobs/data-lake-storage-introduction

## 🧪 Try it yourself

**Goal:** Create a blob container, upload a test blob, and list it back.

```bash
az storage container create --account-name <unique-storage-acct> --name demo-container --auth-mode login
az storage blob upload --account-name <unique-storage-acct> --container-name demo-container --name hello.txt --data "hello azure" --auth-mode login
az storage blob list --account-name <unique-storage-acct> --container-name demo-container --auth-mode login --output table
```

**👀 Expected result:** A table listing `hello.txt` with its size, access tier and last-modified timestamp.

**✅ Checkpoint:** What access tier does `hello.txt` show (Hot by default), and does it match the storage account's default tier?

**🧹 Clean up:**
```bash
az storage container delete --account-name <unique-storage-acct> --name demo-container --auth-mode login
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r11"></a>
# 11. 📁 File Storage

> 🟦 **What it is:** Azure Files provides managed SMB/NFS shares and hybrid File Sync; Azure NetApp Files targets premium enterprise NAS workloads; Managed Lustre targets specialized high-performance file workloads.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure Files** | Managed SMB/NFS share. |
| **File Share** | Share namespace. |
| **Azure File Sync** | Hybrid Windows server caching/sync. |
| **Azure NetApp Files** | High-performance enterprise NFS/SMB. |
| **Azure Managed Lustre** | High-performance parallel file system for specialized workloads. |

## ✅ Use when
- Lift-and-shift apps that require file shares.
- User/profile/shared-file scenarios.
- Enterprise/HPC workloads requiring premium NAS/file systems.

## ⚠️ Engineering watch-outs
- SMB requires network reachability/ports and correct identity.
- Snapshots/replication are not a complete backup strategy.
- Premium services need workload/TCO justification.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/storage/files/

https://learn.microsoft.com/azure/azure-netapp-files/

## 🧪 Try it yourself

**Goal:** Create a minimal Azure Files share and inspect its quota/protocol.

```bash
az storage share-rm create --resource-group <your-resource-group> --storage-account <unique-storage-acct> --name demo-share --quota 5
az storage share-rm show --resource-group <your-resource-group> --storage-account <unique-storage-acct> --name demo-share --query "{quota:shareQuota,protocol:enabledProtocols}" -o jsonc
```

**👀 Expected result:** JSON showing `quota: 5` (GiB) and `protocol: SMB`.

**✅ Checkpoint:** What mount command does `az storage share-rm` guidance suggest for a Linux client versus a Windows client?

**🧹 Clean up:**
```bash
az storage share-rm delete --resource-group <your-resource-group> --storage-account <unique-storage-acct> --name demo-share --yes
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r12"></a>
# 12. 💿 Block & SAN Storage

> 🟦 **What it is:** Managed Disks provide VM block storage. Disk SKUs trade cost/performance. Shared Disks support specific clustered scenarios. Elastic SAN provides centrally managed SAN-style block storage. Container Storage targets container workloads.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Managed Disk** | VM OS/data block disk. |
| **Standard HDD/SSD** | Cost-oriented tiers. |
| **Premium SSD / v2** | Production-performance tiers. |
| **Ultra Disk** | Very high configurable performance. |
| **Shared Disk** | Multi-attach clustered workload support. |
| **Elastic SAN** | Managed SAN/iSCSI volumes. |
| **Container Storage** | Storage service for Kubernetes/container scenarios. |

## ✅ Use when
- VM persistent disks.
- Clustered block-storage workloads.
- Central SAN-style provisioning.

## ⚠️ Engineering watch-outs
- VM SKU throughput may cap a fast disk.
- Provisioned performance can cost even when idle.
- SAN/iSCSI requires host/network multipath/resilience planning.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/virtual-machines/managed-disks-overview

https://learn.microsoft.com/azure/storage/elastic-san/

## 🧪 Try it yourself

**Goal:** Create a small standalone managed disk and confirm it is unattached.

```bash
az group create --name <your-resource-group> --location eastus
az disk create --resource-group <your-resource-group> --name demo-disk --size-gb 4 --sku Standard_LRS
az disk show --resource-group <your-resource-group> --name demo-disk --query "{sku:sku.name,sizeGb:diskSizeGb,state:diskState}" -o jsonc
```

**👀 Expected result:** JSON showing `sku: Standard_LRS`, `sizeGb: 4`, `state: Unattached`.

**✅ Checkpoint:** Why does `diskState` stay `Unattached` until a VM's NIC/config references this disk?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r13"></a>
# 13. 🚚 Storage Data Movement & Management

> 🟦 **What it is:** Azure provides online managed movers, offline Data Box appliances, policy-driven Storage Actions, and inventory/discovery capabilities for large storage estates.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Data Box** | Offline physical bulk transfer. |
| **Storage Mover** | Managed online migration into Azure Storage. |
| **Storage Actions** | Policy/automation across storage data. |
| **Storage Discovery** | Estate visibility/inventory capabilities; verify current availability. |

## ✅ Use when
- Large migrations.
- Offline transfer when WAN is impractical.
- Estate-scale storage management.

## ⚠️ Engineering watch-outs
- Plan delta synchronization after a bulk seed.
- Validate source/target ACLs and metadata.
- Check preview/region status for newer storage-management services.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/databox/

https://learn.microsoft.com/azure/storage-mover/

## 🧪 Try it yourself

**Goal:** Check Data Box availability and SKUs for your region before planning a bulk migration.

```bash
az provider show --namespace Microsoft.DataBox --query "resourceTypes[].resourceType" -o table
az databox available-skus --resource-group <your-resource-group> --location eastus --country US --transfer-type ImportToAzure --output table
```

**👀 Expected result:** A table of supported Data Box SKUs (for example `DataBox`, `DataBoxDisk`) available in `eastus`.

**✅ Checkpoint:** Is `DataBoxHeavy` listed as available in your target region?

**🧹 Clean up:**
Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

# PART IV — 🗄️ DATABASES & CACHING

<a id="r14"></a>
# 14. 🟦 Microsoft SQL on Azure

> 🟦 **What it is:** Azure SQL Database is database-level PaaS; Managed Instance offers broader instance compatibility; SQL Server on Azure VM gives full OS/SQL control. Elastic pools, Hyperscale and serverless are deployment/capacity patterns within Azure SQL Database.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure SQL Database** | Managed SQL database PaaS. |
| **Logical SQL Server** | Management/network namespace. |
| **Elastic Pool** | Shared compute across databases. |
| **Hyperscale** | Scale architecture for large databases. |
| **Serverless** | Auto-scaling/auto-pause model where supported. |
| **SQL Managed Instance** | Managed instance-style PaaS. |
| **SQL Server on VM** | IaaS SQL Server with OS control. |

## ✅ Use when
- Azure SQL Database for new SQL Server-compatible cloud apps.
- Managed Instance for instance-level compatibility/migration.
- SQL VM when OS/full engine control is required.

## ⚠️ Engineering watch-outs
- Private DNS matters with Private Endpoint.
- Use Entra/managed identity where practical.
- Test geo-failover and transient-fault retry.
- Check tier/zone/backup capabilities live.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-sql/

## 🧪 Try it yourself

**Goal:** Create a minimal serverless Azure SQL Database and confirm it's online.

```bash
az group create --name <your-resource-group> --location eastus
az sql server create --resource-group <your-resource-group> --name <unique-sql-server> --admin-user sqladmin --admin-password '<StrongP@ssw0rd!>'
az sql db create --resource-group <your-resource-group> --server <unique-sql-server> --name demo-db --edition GeneralPurpose --family Gen5 --capacity 1 --compute-model Serverless
az sql db show --resource-group <your-resource-group> --server <unique-sql-server> --name demo-db --query "{status:status,sku:currentSku.name}" -o jsonc
```

**👀 Expected result:** JSON showing `status: Online` and a serverless General Purpose SKU.

**✅ Checkpoint:** Does `az sql server firewall-rule list` show any rules allowing your client IP by default?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r15"></a>
# 15. 🐘 Open-Source Relational Databases

> 🟦 **What it is:** Azure Database for PostgreSQL Flexible Server and MySQL Flexible Server are managed open-source relational services with compute, storage, backup, HA and networking choices.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **PostgreSQL Flexible Server** | Managed PostgreSQL. |
| **MySQL Flexible Server** | Managed MySQL. |
| **Compute tier** | Cost/performance choice. |
| **Storage/IOPS** | Capacity/performance dimension. |
| **HA** | Redundant server configuration where supported. |
| **Read Replica** | Read scaling / DR tool depending on service. |

## ✅ Use when
- Apps requiring PostgreSQL/MySQL without managing DB VMs.
- Managed backup/patching/HA are preferred.

## ⚠️ Engineering watch-outs
- Check extension/plugin compatibility before migration.
- Use connection pooling.
- Storage/IO can bottleneck before CPU.
- Test restores and major-version upgrades.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/postgresql/flexible-server/

https://learn.microsoft.com/azure/mysql/flexible-server/

## 🧪 Try it yourself

**Goal:** Create a minimal Burstable-tier PostgreSQL Flexible Server with public access disabled.

```bash
az group create --name <your-resource-group> --location eastus
az postgres flexible-server create --resource-group <your-resource-group> --name <unique-pg-server> --sku-name Standard_B1ms --tier Burstable --storage-size 32 --admin-user pgadmin --admin-password '<StrongP@ssw0rd!>' --public-access None
az postgres flexible-server show --resource-group <your-resource-group> --name <unique-pg-server> --query "{state:state,sku:sku.name,version:version}" -o jsonc
```

**👀 Expected result:** JSON showing `state: Ready`, `sku: Standard_B1ms`, and the server version.

**✅ Checkpoint:** Does `--public-access None` leave the server reachable only via private networking or allowed firewall rules?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r16"></a>
# 16. 🌌 NoSQL & Distributed Databases

> 🟦 **What it is:** Cosmos DB is Azure's globally distributed NoSQL family with partitioning, configurable consistency, multiple APIs and change-feed capabilities. Additional distributed/partner database offerings should be evaluated by workload and current GA status.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Cosmos DB Account** | Top-level global resource. |
| **Database** | Logical grouping. |
| **Container** | Main scale/partition boundary. |
| **Partition Key** | Data/request distribution. |
| **Consistency** | Freshness/availability trade-off. |
| **RU/s / current throughput model** | Request capacity for relevant offerings. |
| **Change Feed** | Stream of data changes. |
| **Cosmos DB APIs** | Document/key-value/graph/table-compatible API choices. |
| **Managed Cassandra / other distributed offerings** | Specialized compatibility; verify current service docs. |

## ✅ Use when
- Globally distributed low-latency NoSQL.
- Massive horizontal scale with clear partitioning.

## ⚠️ Engineering watch-outs
- Bad partition key creates hot partitions.
- 429 is throttling/backpressure.
- Cross-partition queries can be expensive.
- Do not force relational workloads into NoSQL.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/cosmos-db/

## 🧪 Try it yourself

**Goal:** Create a serverless Cosmos DB account with a database/container and inspect its default consistency.

```bash
az group create --name <your-resource-group> --location eastus
az cosmosdb create --resource-group <your-resource-group> --name <unique-cosmos-account> --locations regionName=eastus --capabilities EnableServerless
az cosmosdb sql database create --resource-group <your-resource-group> --account-name <unique-cosmos-account> --name demo-db
az cosmosdb sql container create --resource-group <your-resource-group> --account-name <unique-cosmos-account> --database-name demo-db --name demo-container --partition-key-path "/pk"
```

**👀 Expected result:** The container is created with partition key `/pk`; `az cosmosdb sql container show` confirms it.

**✅ Checkpoint:** What default consistency level does `az cosmosdb show --query consistencyPolicy` report (Session)?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r17"></a>
# 17. ⚡ Caching

> 🟦 **What it is:** Azure Managed Redis is the strategic managed Redis offering for Azure. Redis is typically a performance/cache component, not the primary system of record.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure Managed Redis** | Managed Redis Enterprise-based service. |
| **Clustering** | Horizontal shard/scale behavior. |
| **Persistence** | Optional durability features depending on tier. |
| **Geo features** | Replication/distribution options depending on current offering. |
| **TTL/Eviction** | Cache lifecycle behavior. |
| **Cache-aside** | Common application pattern. |

## ✅ Use when
- Reduce latency/load on databases/APIs.
- Sessions, rate limits, leaderboards, hot data.

## ⚠️ Engineering watch-outs
- Design for cache loss and stampede protection.
- Do not make cache authoritative accidentally.
- Monitor evictions, memory and connection count.
- Verify migration from Azure Cache for Redis.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/redis/

## 🧪 Try it yourself

**Goal:** Check available Redis SKUs, then create the smallest Basic-tier cache.

```bash
az redis list-skus --location eastus --output table
az group create --name <your-resource-group> --location eastus
az redis create --resource-group <your-resource-group> --name <unique-redis-name> --location eastus --sku Basic --vm-size c0
az redis show --resource-group <your-resource-group> --name <unique-redis-name> --query "{sku:sku.name,hostName:hostName,port:sslPort}" -o jsonc
```

**👀 Expected result:** JSON showing `sku: Basic`, a `hostName`, and `port: 6380` once provisioning completes.

**✅ Checkpoint:** While creating, what does `az redis show --query provisioningState` report before it reaches `Succeeded`?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r18"></a>
# 18. 🧬 Specialized / Partner Databases

> 🟦 **What it is:** Azure also exposes specialized first-party and partner database offerings. These change more frequently than the core relational/NoSQL catalog and should be selected only when compatibility or vendor requirements justify them.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Oracle Database@Azure / Oracle AI Database@Azure** | Oracle database services colocated/integrated with Azure; naming/offers evolve. |
| **MongoDB Atlas on Azure** | Partner-managed MongoDB service on Azure. |
| **Managed Cassandra offerings** | Specialized wide-column compatibility. |
| **Preview/emerging DB services** | Treat lifecycle/region/API as volatile. |

## ✅ Use when
- Vendor compatibility is a hard requirement.
- Migration risk is lower with vendor-native engine semantics.

## ⚠️ Engineering watch-outs
- Partner billing/support model may differ from native Azure PaaS.
- Do not copy preview names into long-lived architecture standards without verification.

## 📚 Official Microsoft docs
https://azure.microsoft.com/products/category/databases/

## 🧪 Try it yourself

**Goal:** Discover whether partner database resource providers (Oracle, MongoDB Atlas) are registered/available in your subscription and region.

```bash
az provider list --query "[?contains(namespace,'Oracle') || contains(namespace,'MongoDB')].namespace" --output table
az vm image list-publishers --location eastus --query "[?contains(name,'oracle')]" --output table
```

**👀 Expected result:** A list of partner namespaces (if registered) and Oracle-related VM image publishers available in `eastus`.

**✅ Checkpoint:** Is a partner namespace (for example `Microsoft.MongoDB` or an Oracle offer) already registered in your subscription?

**🧹 Clean up:**
Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

# PART V — 📨 MESSAGING, EVENTS & INTEGRATION

<a id="r19"></a>
# 19. 📬 Azure Service Bus

> 🟦 **What it is:** Enterprise message broker for reliable queues and topic/subscription publish-subscribe patterns. Advanced broker features include sessions, DLQs, duplicate detection and transactions depending on tier/configuration.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Namespace** | Top-level messaging boundary. |
| **Queue** | Point-to-point competing-consumer work stream. |
| **Topic** | Publish endpoint. |
| **Subscription** | Independent topic consumer stream. |
| **Dead-letter Queue** | Failed/unprocessable messages. |
| **Session** | Ordered/grouped handling. |
| **Peek-lock** | Receive without delete until completion. |
| **Duplicate Detection** | Broker feature to reduce duplicate enqueue. |

## ✅ Use when
- Business commands/jobs.
- Reliable async decoupling.
- Pub/sub with independent subscriptions.

## ⚠️ Engineering watch-outs
- Make consumers idempotent.
- Monitor DLQs.
- Lock duration matters for long processing.
- Prefer Entra/RBAC over shared SAS keys.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/service-bus-messaging/

## 🧪 Try it yourself

**Goal:** Create a Basic Service Bus namespace and queue, then check its message count.

```bash
az group create --name <your-resource-group> --location eastus
az servicebus namespace create --name <your-sb-namespace> --resource-group <your-resource-group> --sku Basic
az servicebus queue create --name demo-queue --namespace-name <your-sb-namespace> --resource-group <your-resource-group>
az servicebus queue show --name demo-queue --namespace-name <your-sb-namespace> --resource-group <your-resource-group> --query messageCount
```

**👀 Expected result:** The queue is created and `messageCount` returns `0`.

**✅ Checkpoint:** Can you explain why Basic SKU does not support topics/subscriptions?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r20"></a>
# 20. ⚡ Azure Event Grid

> 🟦 **What it is:** Reactive event-routing service for discrete events. Supports system/custom topics, namespaces, event subscriptions, filters, retries and dead-letter patterns.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **System Topic** | Azure service event source representation. |
| **Custom Topic** | Application-owned event source. |
| **Namespace** | Newer event/publish/subscribe model for supported scenarios. |
| **Event Subscription** | Routing rule/destination. |
| **Filter** | Select events. |
| **CloudEvents** | Common event schema. |
| **Dead-letter** | Failed delivery destination. |

## ✅ Use when
- React to resource/business events.
- Fan-out notifications.
- CloudEvents/event routing.

## ⚠️ Engineering watch-outs
- Events can be delivered more than once; handlers must be idempotent.
- Do not use events as strict commands when processing guarantees are different.
- Monitor dead-letter/delivery failures.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/event-grid/

## 🧪 Try it yourself

**Goal:** Create a custom Event Grid topic and inspect its endpoint/keys.

```bash
az group create --name <your-resource-group> --location eastus
az eventgrid topic create --name <your-topic> --resource-group <your-resource-group> --location eastus
az eventgrid topic show --name <your-topic> --resource-group <your-resource-group> --query endpoint
az eventgrid topic key list --name <your-topic> --resource-group <your-resource-group>
```

**👀 Expected result:** A topic endpoint URL and access keys are returned.

**✅ Checkpoint:** Could you publish a CloudEvents-schema payload to this endpoint using the access key?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r21"></a>
# 21. 🌊 Azure Event Hubs

> 🟦 **What it is:** High-throughput event ingestion/streaming platform with partitions, consumer groups, retention/replay, Capture and Kafka-compatible interfaces.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Namespace** | Service boundary. |
| **Event Hub** | Named stream. |
| **Partition** | Parallel ordered shard. |
| **Consumer Group** | Independent read view/cursor. |
| **Offset/Checkpoint** | Consumer position. |
| **Capture** | Automatic stream delivery to storage/data lake. |
| **Kafka endpoint** | Kafka protocol compatibility. |

## ✅ Use when
- Telemetry/log/event streaming.
- Multiple independent stream consumers.
- High-volume ingestion.

## ⚠️ Engineering watch-outs
- Partition count affects scale and ordering.
- No global ordering across partitions.
- Consumers need checkpoint strategy.
- Do not use as a business command queue.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/event-hubs/

## 🧪 Try it yourself

**Goal:** Create an Event Hubs namespace and a 2-partition hub.

```bash
az group create --name <your-resource-group> --location eastus
az eventhubs namespace create --name <your-eh-namespace> --resource-group <your-resource-group> --sku Basic
az eventhubs eventhub create --name demo-hub --namespace-name <your-eh-namespace> --resource-group <your-resource-group> --partition-count 2
az eventhubs eventhub show --name demo-hub --namespace-name <your-eh-namespace> --resource-group <your-resource-group> --query partitionCount
```

**👀 Expected result:** `partitionCount` returns `2`.

**✅ Checkpoint:** Why can't you reduce partition count after the hub is created?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r22"></a>
# 22. 🪣 Azure Queue Storage

> 🟦 **What it is:** Simple durable queue service in Azure Storage with visibility timeout and dequeue semantics.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Queue** | Message collection. |
| **Message** | Simple work item. |
| **Visibility Timeout** | Temporarily hides in-flight message. |
| **Dequeue Count** | Useful for poison detection. |
| **TTL** | Expiration. |

## ✅ Use when
- Simple low-cost work queue.
- You do not need Service Bus topics/sessions/transactions.

## ⚠️ Engineering watch-outs
- Design poison-message handling.
- Delivery is not exactly once.
- Prefer Entra data roles over account keys where supported.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/storage/queues/

## 🧪 Try it yourself

**Goal:** Create a storage queue, enqueue a message, and view queue stats.

```bash
az storage account create --name <yourstorageacct> --resource-group <your-resource-group> --location eastus --sku Standard_LRS
az storage queue create --name demo-queue --account-name <yourstorageacct> --auth-mode login
az storage message put --queue-name demo-queue --account-name <yourstorageacct> --content "hello" --auth-mode login
az storage queue stats --account-name <yourstorageacct> --auth-mode login
```

**👀 Expected result:** The message is enqueued and stats show replication/geo status.

**✅ Checkpoint:** What happens to the message's visibility if a consumer reads it but never deletes it?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r23"></a>
# 23. 🔁 Workflow & Integration

> 🟦 **What it is:** Logic Apps provides managed workflows/connectors with Consumption and Standard hosting models. Integration Account supports B2B/enterprise integration artifacts in relevant scenarios.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Logic App** | Workflow resource/application. |
| **Trigger** | Starts workflow. |
| **Action** | Step in workflow. |
| **Connector** | Managed/built-in integration. |
| **Consumption** | Per-action serverless-style model. |
| **Standard** | Single-tenant/app-style hosting model. |
| **Integration Account** | B2B artifacts such as schemas/maps/partners for relevant workflows. |

## ✅ Use when
- SaaS/API/system integration.
- Human-readable workflow orchestration.
- Connector-heavy business processes.

## ⚠️ Engineering watch-outs
- Connector throttling is real.
- Avoid giant opaque workflows containing all business logic.
- Networking differs by hosting model/connectors.
- Use managed identity where supported.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/logic-apps/

## 🧪 Try it yourself

**Goal:** Create a minimal (empty) Consumption Logic App workflow and check its state.

```bash
az group create --name <your-resource-group> --location eastus
az logic workflow create --resource-group <your-resource-group> --location eastus --name <your-logic-app> --definition "{\"$schema\":\"https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#\",\"contentVersion\":\"1.0.0.0\",\"triggers\":{},\"actions\":{}}"
az logic workflow show --resource-group <your-resource-group> --name <your-logic-app> --query state
```

**👀 Expected result:** `state` returns `Enabled`.

**✅ Checkpoint:** Why does this empty workflow never actually run?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r24"></a>
# 24. 🚪 API Management

> 🟦 **What it is:** Managed API gateway and governance platform with APIs/operations, products, subscriptions, policies, gateways and developer portal.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **APIM Service** | Top-level gateway/management resource. |
| **API** | Published contract. |
| **Operation** | API route/action. |
| **Product** | Package of APIs. |
| **Subscription** | Consumer access construct. |
| **Policy** | Gateway request/response logic. |
| **Gateway** | Runtime proxy. |
| **Self-hosted Gateway** | Gateway runtime outside managed Azure gateway in supported scenarios. |
| **Developer Portal** | Consumer onboarding/docs. |

## ✅ Use when
- Central API security/governance.
- JWT validation, quotas, transformations, products/portals.
- Hybrid API gateway needs.

## ⚠️ Engineering watch-outs
- Do not turn APIM policies into the application business layer.
- Networking/tier model matters greatly.
- Cache authenticated/private content carefully.
- Source-control policies.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/api-management/

## 🧪 Try it yourself

**Goal:** Inspect an existing APIM instance's gateway URL and published APIs (read-only; APIM creation takes ~30+ minutes).

```bash
az apim list --output table
az apim show --name <your-apim-instance> --resource-group <your-resource-group> --query gatewayUrl
az apim api list --service-name <your-apim-instance> --resource-group <your-resource-group> --output table
```

**👀 Expected result:** The gateway URL and a table of APIs published on that instance.

**✅ Checkpoint:** Which SKU tier is the instance running, and does it support VNet integration?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r25"></a>
# 25. 📡 Real-Time Application Services

> 🟦 **What it is:** Azure SignalR Service, Web PubSub, Communication Services and Notification Hubs cover different real-time/user communication channels.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **SignalR Service** | Managed SignalR connections/hubs. |
| **Web PubSub** | Generic WebSocket pub/sub service. |
| **Communication Services** | Voice/video/chat/SMS/email APIs. |
| **Notification Hubs** | Push notifications to mobile devices. |

## ✅ Use when
- Real-time browser/app updates.
- Programmable communications.
- Mobile push notification fanout.

## ⚠️ Engineering watch-outs
- These are not durable enterprise brokers.
- Use short-lived client access tokens.
- Design reconnect/resubscribe behavior.
- Channel delivery (SMS/push/email) is not guaranteed like a transaction.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-signalr/overview

https://learn.microsoft.com/azure/azure-web-pubsub/

https://learn.microsoft.com/azure/communication-services/

## 🧪 Try it yourself

**Goal:** Deploy a free-tier SignalR Service instance and view its hostname.

```bash
az group create --name <your-resource-group> --location eastus
az signalr create --name <your-signalr> --resource-group <your-resource-group> --sku Free_F1 --service-mode Default
az signalr show --name <your-signalr> --resource-group <your-resource-group> --query hostName
```

**👀 Expected result:** A hostname like `<your-signalr>.service.signalr.net` is returned.

**✅ Checkpoint:** Which `--service-mode` would you pick for a serverless Azure Functions backend instead of `Default`?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART VI — 👤 IDENTITY, ACCESS & SECRETS

<a id="r26"></a>
# 26. 🪪 Microsoft Entra Concepts Used by Azure Resources

> 🟦 **What it is:** Azure resources rely heavily on Microsoft Entra identities: users, groups, app registrations, enterprise applications/service principals, managed identities and workload identity federation.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Tenant** | Directory/security boundary. |
| **User** | Human identity. |
| **Group** | Collection for access assignment. |
| **App Registration** | Application identity definition. |
| **Enterprise Application** | Tenant service-principal representation/configuration. |
| **Service Principal** | Workload/app principal. |
| **System Managed Identity** | Identity tied to one Azure resource. |
| **User Managed Identity** | Reusable identity resource. |
| **Workload Identity Federation** | OIDC/federated token trust without stored client secret. |

## ✅ Use when
- Human and workload authentication to Azure.
- Secretless service-to-service authentication.
- Federated CI/CD and Kubernetes workloads.

## ⚠️ Engineering watch-outs
- Identity is separate from network reachability.
- Do not reuse one workload identity across unrelated trust boundaries.
- Prefer federation/managed identity over long-lived client secrets.

## 📚 Official Microsoft docs
https://learn.microsoft.com/entra/identity/

## 🧪 Try it yourself

**Goal:** Inspect your signed-in identity and look up an app registration's service principal (read-only).

```bash
az ad signed-in-user show --query userPrincipalName
az ad app list --display-name "<your-app-name>" --query "[].{name:displayName,appId:appId}"
az ad sp list --filter "displayName eq '<your-app-name>'" --query "[].{name:displayName,appId:appId}"
```

**👀 Expected result:** Your UPN, then the app registration and matching service principal (if any exists).

**✅ Checkpoint:** Can you explain why an app registration and its enterprise application/service principal are two distinct objects?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r27"></a>
# 27. 🎫 Azure RBAC

> 🟦 **What it is:** Authorization system based on principal + role definition + scope. Roles can contain management actions and/or data actions.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Role Definition** | Permission set. |
| **Role Assignment** | Principal + role + scope. |
| **Scope** | Management group/subscription/RG/resource. |
| **Built-in Role** | Microsoft-defined role. |
| **Custom Role** | Organization-defined role. |
| **Actions** | Management-plane permissions. |
| **DataActions** | Data-plane permissions. |
| **PIM** | Just-in-time privileged human role activation. |

## ✅ Use when
- Grant Azure management/data permissions.
- Least-privilege workload access.
- Central human access control.

## ⚠️ Engineering watch-outs
- Contributor cannot normally grant access.
- Owner is broad and should be exceptional.
- Inherited assignments matter.
- RBAC is not Azure Policy.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/role-based-access-control/overview

## 🧪 Try it yourself

**Goal:** List role assignments for a principal and inspect a built-in role definition (read-only).

```bash
az role assignment list --assignee <your-user-or-sp-id> --all --output table
az role definition list --name "Reader" --query "[].{name:roleName,id:name,dataActions:permissions[0].dataActions}"
```

**👀 Expected result:** A table of assignments across scopes, then the Reader role's permission structure.

**✅ Checkpoint:** Does the Reader role contain any `dataActions`? Why or why not?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r28"></a>
# 28. 🔑 Azure Key Vault

> 🟦 **What it is:** Managed secrets, keys and certificates with RBAC/access controls, private networking, soft delete and purge protection.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Secret** | Opaque sensitive value. |
| **Key** | Cryptographic key/operations. |
| **Certificate** | Certificate lifecycle object. |
| **Soft Delete** | Recover deleted objects during retention. |
| **Purge Protection** | Prevent permanent deletion before retention ends. |
| **Private Endpoint** | Private vault access. |
| **Key Vault Reference** | Use vault-backed values from supported application services. |

## ✅ Use when
- Central secrets/keys/certificates.
- Managed identity-based secret retrieval.
- Certificate/key lifecycle.

## ⚠️ Engineering watch-outs
- Do not call Key Vault on every hot-path request without caching strategy.
- Monitor certificate expiration.
- Private Endpoint requires correct DNS.
- Purge protection changes deletion/recovery behavior.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/key-vault/

## 🧪 Try it yourself

**Goal:** Create a Key Vault and store/retrieve a secret.

```bash
az group create --name <your-resource-group> --location eastus
az keyvault create --name <your-keyvault> --resource-group <your-resource-group> --location eastus
az keyvault secret set --vault-name <your-keyvault> --name demo-secret --value "hello-world"
az keyvault secret show --vault-name <your-keyvault> --name demo-secret --query value
```

**👀 Expected result:** The command returns `"hello-world"`.

**✅ Checkpoint:** What role/permission would your own identity need to run `secret set` if the vault used RBAC authorization instead of access policies?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r29"></a>
# 29. 🧱 Managed HSM

> 🟦 **What it is:** Dedicated managed HSM pools for high-assurance cryptographic keys and stronger separation than general Key Vault.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Managed HSM** | Dedicated HSM pool. |
| **Security Domain** | Critical ownership/recovery artifact. |
| **Key** | HSM-protected cryptographic key. |
| **Local RBAC** | HSM data-plane access model. |
| **Backup/Restore** | Protected HSM recovery operations. |

## ✅ Use when
- Regulatory/high-value cryptographic keys require dedicated managed HSMs.

## ⚠️ Engineering watch-outs
- Security-domain custody is critical.
- Use only when Key Vault does not meet requirements.
- Separate key administration from application use.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/key-vault/managed-hsm/

## 🧪 Try it yourself

**Goal:** Inspect existing Managed HSM pools in your subscription (read-only; HSM pools are costly and slow to provision).

```bash
az keyvault list --resource-type hsm --output table
az keyvault show --hsm-name <your-managed-hsm> --query "{state:properties.provisioningState,sd:properties.securityDomainProperties}"
```

**👀 Expected result:** A table of HSM pools, then provisioning state and security-domain status for one.

**✅ Checkpoint:** Who holds the security-domain recovery material for this HSM, and is it backed up outside Azure?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

# PART VII — 📊 OBSERVABILITY & OPERATIONS

<a id="r30"></a>
# 30. 📡 Azure Monitor

> 🟦 **What it is:** Unified monitoring platform for metrics, logs, alerts, data collection and dashboards/workbooks across Azure workloads.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Metrics** | Numeric time series. |
| **Resource Logs** | Service diagnostic events. |
| **Activity Log** | Subscription management-plane events. |
| **Diagnostic Settings** | Routes supported logs/metrics. |
| **Data Collection Rule** | Configures supported telemetry pipelines. |
| **Azure Monitor Agent** | Agent for supported machine telemetry. |

## ✅ Use when
- All production Azure workloads need an intentional monitoring design.

## ⚠️ Engineering watch-outs
- Do not enable every log forever without retention/cost strategy.
- Alert on user/business impact, not every raw symptom.
- Monitoring data can be sensitive.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-monitor/

## 🧪 Try it yourself

**Goal:** List metrics and diagnostic settings for an existing resource (read-only).

```bash
az monitor metrics list --resource <your-resource-id> --metric "Percentage CPU" --output table
az monitor diagnostic-settings list --resource <your-resource-id>
```

**👀 Expected result:** A time series of CPU percentage, then any configured diagnostic routing destinations.

**✅ Checkpoint:** If the diagnostic settings list is empty, where is this resource's telemetry currently going?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r31"></a>
# 31. 🧾 Log Analytics

> 🟦 **What it is:** Azure Monitor Logs workspace stores/query logs using KQL and configurable retention/table plans.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Workspace** | Log data/RBAC/retention boundary. |
| **Table** | Structured log dataset. |
| **KQL** | Query language. |
| **Retention** | Hot/archive data retention. |
| **Analytics/Basic/Auxiliary table models** | Cost/query behavior depends on current table plan. |

## ✅ Use when
- Central searchable logs.
- Sentinel/Azure Monitor/VM/container/app telemetry.

## ⚠️ Engineering watch-outs
- One giant workspace may violate ownership/residency boundaries.
- Noisy ingestion gets expensive.
- Use time/table filters in KQL.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-workspace-overview

## 🧪 Try it yourself

**Goal:** Create a Log Analytics workspace and verify provisioning.

```bash
az group create --name <your-resource-group> --location eastus
az monitor log-analytics workspace create --resource-group <your-resource-group> --workspace-name <your-law> --location eastus
az monitor log-analytics workspace show --resource-group <your-resource-group> --workspace-name <your-law> --query provisioningState
```

**👀 Expected result:** `provisioningState` returns `Succeeded`.

**✅ Checkpoint:** Which table plan (Analytics/Basic/Auxiliary) would you choose for high-volume, rarely-queried logs, and why?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r32"></a>
# 32. 🔭 Application Insights

> 🟦 **What it is:** APM capability in Azure Monitor for requests, dependencies, exceptions, traces, availability and distributed tracing, with OpenTelemetry-based instrumentation recommended for many modern workloads.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Request** | Inbound operation. |
| **Dependency** | Outbound call. |
| **Exception** | Captured error. |
| **Trace** | Application telemetry/log. |
| **Operation/Trace ID** | Distributed correlation. |
| **Availability Test** | Synthetic endpoint test. |
| **OpenTelemetry** | Vendor-neutral instrumentation standard used by current Azure Monitor SDK strategy. |

## ✅ Use when
- Web/API/service performance and failure analysis.
- Distributed tracing across dependencies.

## ⚠️ Engineering watch-outs
- Do not log secrets/PII.
- Sampling/cardinality control matters.
- Propagate trace context across queues/services.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-monitor/app/app-insights-overview

## 🧪 Try it yourself

**Goal:** Create an Application Insights component and retrieve its instrumentation/connection key.

```bash
az group create --name <your-resource-group> --location eastus
az monitor app-insights component create --app <your-appinsights> --resource-group <your-resource-group> --location eastus --kind web --application-type web
az monitor app-insights component show --app <your-appinsights> --resource-group <your-resource-group> --query connectionString
```

**👀 Expected result:** A connection string containing an InstrumentationKey and IngestionEndpoint is returned.

**✅ Checkpoint:** Why is OpenTelemetry + connection string now preferred over the legacy instrumentation key alone?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r33"></a>
# 33. 🚨 Alerts & Visualization

> 🟦 **What it is:** Alert rules evaluate metric/log/activity signals; Action Groups notify or automate; Workbooks and Managed Grafana visualize operational data.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Metric Alert** | Low-latency metric condition. |
| **Log Alert** | Scheduled KQL condition. |
| **Activity Log Alert** | Management-plane event condition. |
| **Action Group** | Notification/action target. |
| **Workbook** | Interactive Azure Monitor visualization. |
| **Azure Managed Grafana** | Managed Grafana dashboards for supported data sources. |

## ✅ Use when
- Proactive incident detection.
- Dashboards for operational review.

## ⚠️ Engineering watch-outs
- Every alert needs owner + action/runbook.
- Test Action Groups.
- Prevent alert storms and duplicate symptoms.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-overview

## 🧪 Try it yourself

**Goal:** Create an Action Group (notification target) and confirm it registered correctly.

```bash
az group create --name <your-resource-group> --location eastus
az monitor action-group create --resource-group <your-resource-group> --name <your-action-group> --short-name demoag
az monitor action-group show --resource-group <your-resource-group> --name <your-action-group> --query "{name:name,enabled:enabled}"
```

**👀 Expected result:** `enabled` returns `true` for the newly created Action Group.

**✅ Checkpoint:** How would you attach an email or webhook receiver to this Action Group so an alert rule can notify someone?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r34"></a>
# 34. 🩺 Health & Recommendations

> 🟦 **What it is:** Azure Status gives broad public status; Service Health gives personalized service/region incidents and maintenance; Resource Health gives individual resource health; Advisor gives optimization recommendations.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure Status** | Broad public platform status. |
| **Service Health** | Personalized incidents/maintenance/advisories. |
| **Resource Health** | Specific resource-instance health. |
| **Azure Advisor** | Cost/reliability/security/performance/operational recommendations. |

## ✅ Use when
- Incident triage and platform-awareness.
- Subscription-specific maintenance/health alerts.
- Optimization reviews.

## ⚠️ Engineering watch-outs
- Do not rely only on Azure Status.
- Advisor is guidance, not automatic truth for your workload.
- Service Health should have alerting for critical subscriptions.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/service-health/overview

https://learn.microsoft.com/azure/advisor/

## 🧪 Try it yourself

**Goal:** List current Azure Advisor recommendations for your subscription (read-only).

```bash
az advisor recommendation list --query "[].{category:category,impact:impact,problem:shortDescription.problem}" --output table
```

**👀 Expected result:** A table of cost/reliability/security/performance recommendations, if any exist.

**✅ Checkpoint:** Pick one high-impact recommendation — what is the remediation action it suggests?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r35"></a>
# 35. 🤖 Automation & Maintenance

> 🟦 **What it is:** Azure Automation, runbooks, Update Manager and Maintenance Configurations provide operational automation/patching/control windows for supported workloads.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Automation Account** | Container for runbooks/assets/identities. |
| **Runbook** | Automation workflow/script. |
| **Update Manager** | Patch assessment/orchestration for supported machines. |
| **Maintenance Configuration** | Control maintenance windows for supported resource types. |

## ✅ Use when
- Repeatable operational tasks.
- Patch governance.
- Controlled maintenance windows.

## ⚠️ Engineering watch-outs
- Automation identities are privileged—use least privilege.
- Do not create hidden production logic in ad-hoc runbooks without source control/testing.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/automation/

https://learn.microsoft.com/azure/update-manager/

## 🧪 Try it yourself

**Goal:** Create an Automation Account and verify it is active.

```bash
az group create --name <your-resource-group> --location eastus
az automation account create --name <your-automation-account> --resource-group <your-resource-group> --location eastus
az automation account show --name <your-automation-account> --resource-group <your-resource-group> --query state
```

**👀 Expected result:** `state` returns `Ok`.

**✅ Checkpoint:** What identity would you assign to this account so its runbooks can manage other Azure resources without stored credentials?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART VIII — 🛡️ SECURITY

<a id="r36"></a>
# 36. 🛡️ Microsoft Defender for Cloud

> 🟦 **What it is:** Cloud security posture management plus workload-protection plans for supported Azure/hybrid/multicloud resources.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **CSPM** | Posture/compliance recommendations. |
| **Secure Score** | Posture indicator. |
| **Defender Plans** | Workload-specific protection. |
| **Regulatory Compliance** | Mapped compliance controls. |
| **DevSecOps** | Security posture across code/pipeline integrations where supported. |

## ✅ Use when
- Cloud posture and workload threat protection.
- Security/compliance teams need centralized visibility.

## ⚠️ Engineering watch-outs
- Buying a plan without a remediation process does not improve risk.
- Prioritize business risk, not only score.
- Check agent/extension prerequisites.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/defender-for-cloud/

## 🧪 Try it yourself

**Goal:** Check which Defender for Cloud plans are enabled for your subscription (read-only).

```bash
az security pricing list --query "value[].{plan:name,tier:pricingTier}" --output table
az security secure-scores list --output table
```

**👀 Expected result:** A table listing each Defender plan's pricing tier (Free/Standard), and the subscription's current secure score.

**✅ Checkpoint:** Which plans are still on the `Free` tier, and is that acceptable for your workload's risk level?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r37"></a>
# 37. 🕵️ Microsoft Sentinel

> 🟦 **What it is:** Cloud-native SIEM/SOAR using data connectors, analytics rules, incidents, automation rules and playbooks over Log Analytics-backed security data.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Workspace** | Security data store. |
| **Data Connector** | Ingests security source. |
| **Analytics Rule** | Detection logic. |
| **Incident** | Investigation/case unit. |
| **Automation Rule** | Incident workflow. |
| **Playbook** | Logic Apps-based response automation. |

## ✅ Use when
- Security operations/detection/response across cloud and enterprise sources.

## ⚠️ Engineering watch-outs
- Security telemetry cost can be significant.
- Tune detections; do not create thousands of noisy alerts.
- Playbooks need tightly scoped permissions.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/sentinel/

## 🧪 Try it yourself

**Goal:** List Sentinel incidents and analytics rules on an existing Log Analytics workspace (read-only; requires the `sentinel` CLI extension).

```bash
az extension add --name sentinel --upgrade
az sentinel incident list --resource-group <your-resource-group> --workspace-name <your-law> --output table
az sentinel alert-rule list --resource-group <your-resource-group> --workspace-name <your-law> --output table
```

**👀 Expected result:** Tables of open/closed incidents and configured analytics rules, if Sentinel is enabled on the workspace.

**✅ Checkpoint:** For an open incident, what automation rule or playbook (if any) is attached to it?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r38"></a>
# 38. 🔥 Network Security Resources

> 🟦 **What it is:** NSG, Azure Firewall, WAF, DDoS Protection and Bastion form different layers of network/security control.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **NSG** | Stateful L3/L4 subnet/NIC filter. |
| **Azure Firewall** | Central managed firewall. |
| **WAF** | HTTP/S web attack protection. |
| **DDoS Protection** | Enhanced DDoS protection plan. |
| **Bastion** | Private RDP/SSH administration. |

## ✅ Use when
- Layered network security.
- Centralized egress/ingress control.
- Protect public web workloads and privileged administration.

## ⚠️ Engineering watch-outs
- Do not treat NSG as WAF.
- Firewall needs routes through it.
- WAF needs tuning.
- No public RDP/SSH just because Bastion exists.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/firewall/

https://learn.microsoft.com/azure/web-application-firewall/

https://learn.microsoft.com/azure/ddos-protection/

## 🧪 Try it yourself

**Goal:** Create an NSG with a rule that denies inbound RDP.

```bash
az group create --name <your-resource-group> --location eastus
az network nsg create --resource-group <your-resource-group> --name <your-nsg>
az network nsg rule create --resource-group <your-resource-group> --nsg-name <your-nsg> --name deny-rdp --priority 100 --direction Inbound --access Deny --protocol Tcp --destination-port-ranges 3389
az network nsg rule list --resource-group <your-resource-group> --nsg-name <your-nsg> --output table
```

**👀 Expected result:** The rule list shows `deny-rdp` with `Deny` access at priority `100`.

**✅ Checkpoint:** Why does this NSG rule alone not protect you if Azure Firewall/WAF rules are misconfigured elsewhere?

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r39"></a>
# 39. 🔐 Confidential Computing

> 🟦 **What it is:** Confidential computing protects data while in use using hardware-backed trusted execution environments for supported VMs, containers and enclave-style workloads.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Confidential VM** | VM with hardware-backed memory/data-in-use protection. |
| **Confidential Containers** | Container scenarios using confidential-computing infrastructure. |
| **Enclave capabilities** | Application-isolated trusted execution features where supported. |

## ✅ Use when
- Regulated/high-value data needs protection in use.
- Threat model includes cloud/admin/hypervisor exposure beyond standard controls.

## ⚠️ Engineering watch-outs
- Confidential computing does not replace encryption, identity or secure code.
- Supported regions/SKUs/OS/features must be verified live.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/confidential-computing/

## 🧪 Try it yourself

**Goal:** List available confidential-computing VM SKUs (DCsv3/DCasv5 families) in a region (read-only).

```bash
az vm list-skus --location eastus --size Standard_DC --output table
az vm list-skus --location eastus --size Standard_EC --output table
```

**👀 Expected result:** A table of confidential-computing VM sizes with their restrictions/capabilities for your region.

**✅ Checkpoint:** Which of these SKUs support confidential VMs vs. SGX enclave-only application isolation?

**🧹 Clean up:** Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

# PART IX — 🧯 BACKUP, RECOVERY & RESILIENCE

<a id="r40"></a>
# 40. 💾 Azure Backup

> 🟦 **What it is:** Policy-driven managed backup for supported Azure/hybrid workloads using Recovery Services Vaults and Backup Vaults depending on workload.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Recovery Services Vault** | Backup/ASR vault for supported classic/current workloads. |
| **Backup Vault** | Data Protection backup vault for supported newer workload types. |
| **Backup Policy** | Schedule + retention. |
| **Restore Point** | Recoverable backup state. |
| **VM/Disk/Files/Blob/DB/AKS backup** | Supported workload-specific backup types. |

## ✅ Use when
- Protect against deletion/corruption/historical recovery.
- Centralize policy/retention for supported workloads.

## ⚠️ Engineering watch-outs
- Restore testing is mandatory.
- Backup admin separation improves ransomware resilience.
- Replication/snapshot is not automatically backup.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/backup/

## 🧪 Try it yourself

**Goal:** create a Recovery Services Vault and enable backup policy inspection (no VM required to see the mechanics).

```bash
az backup vault create --resource-group <your-resource-group> --name demo-rsv --location eastus
az backup policy list --resource-group <your-resource-group> --vault-name demo-rsv
```

**👀 Expected result:** the vault is created, and the policy list shows the built-in default backup policies available for assignment.

**✅ Checkpoint:** can you name the two things a backup policy controls (schedule and retention)?

**🧹 Clean up:**
```bash
az backup vault delete --resource-group <your-resource-group> --name demo-rsv --yes
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r41"></a>
# 41. 🌍 Azure Site Recovery

> 🟦 **What it is:** Replication/orchestration service for supported VM/site disaster-recovery scenarios, including recovery plans, test failover, failover and failback.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Recovery Services Vault** | DR management boundary. |
| **Replication Policy** | Replication/RPO behavior. |
| **Protected Item** | Replicated workload. |
| **Recovery Plan** | Ordered failover workflow. |
| **Test Failover** | Non-disruptive DR validation. |
| **Failback** | Return workload after disaster/recovery. |

## ✅ Use when
- VM/site-level DR needs orchestrated recovery.

## ⚠️ Engineering watch-outs
- Replication healthy does not prove the application works after failover.
- Target DNS/network/dependencies must exist.
- Test failover regularly.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/site-recovery/

## 🧪 Try it yourself

**Goal:** inspect what a Recovery Services Vault exposes for Site Recovery without needing a full replicated VM.

```bash
az backup vault create --resource-group <your-resource-group> --name demo-asr-vault --location eastus
az resource show --ids $(az backup vault show --resource-group <your-resource-group> --name demo-asr-vault --query id -o tsv) --query "properties"
```

**👀 Expected result:** the vault's properties are returned, confirming it is a valid Site Recovery/backup management boundary.

**✅ Checkpoint:** explain in one sentence why "replication healthy" does not prove the application works after failover.

**🧹 Clean up:**
```bash
az backup vault delete --resource-group <your-resource-group> --name demo-asr-vault --yes
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r42"></a>
# 42. 💥 Azure Chaos Studio

> 🟦 **What it is:** Controlled fault-injection experiments against supported Azure resources to validate resilience assumptions.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Experiment** | Fault workflow. |
| **Target** | Resource enabled for chaos. |
| **Capability** | Supported fault capability. |
| **Fault** | Injected failure. |

## ✅ Use when
- Mature teams need repeatable resilience/game-day testing.

## ⚠️ Engineering watch-outs
- Define steady-state hypothesis and stop conditions.
- Limit blast radius.
- Chaos permissions are powerful.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/chaos-studio/

## 🧪 Try it yourself

**Goal:** discover which fault capabilities Chaos Studio currently supports, without running a destructive experiment.

```bash
az provider show --namespace Microsoft.Chaos --query "resourceTypes[].resourceType" -o table
```

**👀 Expected result:** a list of Chaos Studio resource types (e.g. `experiments`, `targets`) confirming the provider is available in your subscription.

**✅ Checkpoint:** name the two things every chaos experiment must define before it runs (steady-state hypothesis and stop conditions).

**🧹 Clean up:** nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

# PART X — 🏛️ GOVERNANCE & RESOURCE MANAGEMENT

<a id="r43"></a>
# 43. 🏗️ Azure Resource Manager

> 🟦 **What it is:** ARM is Azure's management/control plane. ARM templates, Bicep, Deployment Stacks and Template Specs build on it.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Resource Provider** | Service namespace. |
| **Resource Type** | ARM-manageable object. |
| **Deployment** | Declarative change set. |
| **ARM Template** | JSON template format. |
| **Bicep** | Concise Azure-native IaC language. |
| **Deployment Stack** | Resource lifecycle collection. |
| **Template Spec** | Versioned ARM template artifact in Azure. |

## ✅ Use when
- All Azure resource management.
- Repeatable IaC deployments.

## ⚠️ Engineering watch-outs
- API version matters.
- Control-plane success does not prove data-plane connectivity.
- Deployment Stack unmanage/delete behavior must be understood.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-resource-manager/

## 🧪 Try it yourself

**Goal:** Deploy a minimal resource group via an ARM/Bicep-style declarative deployment and inspect the deployment history.

```bash
az group create --name <your-resource-group> --location eastus
az deployment group create --resource-group <your-resource-group> --name demo-deploy \
  --template-file <(echo '{"$schema":"https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#","contentVersion":"1.0.0.0","resources":[]}')
az deployment group list --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The deployment named `demo-deploy` shows `ProvisioningState: Succeeded` in the list output.

**✅ Checkpoint:** Run `az deployment group show --resource-group <your-resource-group> --name demo-deploy` and confirm the `properties.provisioningState` is `Succeeded`.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r44"></a>
# 44. 📏 Azure Policy

> 🟦 **What it is:** Governance engine for auditing/denying/modifying/deploying resource configuration standards at scope.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Policy Definition** | Rule + effect. |
| **Initiative** | Policy collection. |
| **Assignment** | Applies policy at scope. |
| **Effect** | Audit/Deny/Modify/DeployIfNotExists/etc. |
| **Exemption** | Approved exception. |
| **Remediation Task** | Corrects supported noncompliance. |

## ✅ Use when
- Organization-wide standards/compliance.
- Allowed regions/SKUs/tags/security/diagnostics enforcement.

## ⚠️ Engineering watch-outs
- Start risky policies in Audit before Deny.
- Policy is not RBAC.
- Need exception ownership/process.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/governance/policy/overview

## 🧪 Try it yourself

**Goal:** Assign a built-in audit policy (no Deny risk) to a resource group and check compliance.

```bash
az group create --name <your-resource-group> --location eastus
az policy assignment create --name audit-tag-rg \
  --scope $(az group show --name <your-resource-group> --query id -o tsv) \
  --policy "96670d01-0a4d-4649-9c89-2d3abc0a5025"
az policy state list --resource-group <your-resource-group> -o table
```

**👀 Expected result:** A policy assignment named `audit-tag-rg` is created, and `az policy state list` shows a compliance record for the resource group.

**✅ Checkpoint:** Run `az policy assignment show --name audit-tag-rg` and confirm the `enforcementMode` is `Default` (audit, not deny).

**🧹 Clean up:**
```bash
az policy assignment delete --name audit-tag-rg
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r45"></a>
# 45. 🏢 Management Groups

> 🟦 **What it is:** Hierarchy above subscriptions for inherited RBAC/Policy and enterprise subscription organization.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Management Group** | Container for subscriptions/child MGs. |
| **Hierarchy** | Inheritance tree. |
| **RBAC Inheritance** | Assignments flow down scopes. |
| **Policy Inheritance** | Policy assignments flow down scopes. |

## ✅ Use when
- Enterprise-scale governance across subscriptions.
- Platform vs landing-zone subscription separation.

## ⚠️ Engineering watch-outs
- Top-level assignments have huge blast radius.
- Avoid designing hierarchy around transient org chart only.
- Test inherited policies before production rollout.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/governance/management-groups/overview

## 🧪 Try it yourself

**Goal:** Create a small management group hierarchy and list it.

```bash
az account management-group create --name demo-mg --display-name "Demo MG"
az account management-group list -o table
az account management-group show --name demo-mg --expand --recurse
```

**👀 Expected result:** `demo-mg` appears in the management group list, and `show --expand` returns its (empty) children array.

**✅ Checkpoint:** Confirm `az account management-group show --name demo-mg` returns `properties.displayName` = `Demo MG`.

**🧹 Clean up:**
```bash
az account management-group delete --name demo-mg
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r46"></a>
# 46. 🔎 Azure Resource Graph

> 🟦 **What it is:** Fast cross-subscription query service for ARM resource metadata and change/inventory analysis using a KQL-like query language.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Resources** | Primary resource metadata table. |
| **ResourceContainers** | Subscriptions/resource groups. |
| **Query** | KQL-like estate query. |
| **Change Analysis** | Resource-change visibility where supported. |

## ✅ Use when
- Inventory, governance, retirement impact, estate reporting.

## ⚠️ Engineering watch-outs
- Not a replacement for Azure Monitor Logs.
- Results are limited to resources caller can see.
- Treat near-real-time metadata as eventually consistent for some changes.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/governance/resource-graph/

## 🧪 Try it yourself

**Goal:** Query all resources in your subscription grouped by type using Resource Graph.

```bash
az extension add --name resource-graph --only-show-errors
az graph query -q "Resources | summarize count() by type | order by count_ desc"
```

**👀 Expected result:** A table listing resource types in your subscription and how many of each exist.

**✅ Checkpoint:** Identify which resource type has the highest count in your subscription.

**🧹 Clean up:**
Nothing to clean up — read-only query.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r47"></a>
# 47. 💰 Cost Management

> 🟦 **What it is:** Cost Management, budgets, reservations and savings plans support visibility/optimization of Azure spend.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Cost Analysis** | Explore actual/forecast spend. |
| **Budget** | Threshold/alert configuration. |
| **Cost Alert** | Notification about spend/budget/anomaly scenarios. |
| **Reservation** | Capacity commitment for specific resource categories. |
| **Savings Plan** | Eligible compute spend commitment. |

## ✅ Use when
- FinOps visibility and control.
- Production budget/forecast reviews.

## ⚠️ Engineering watch-outs
- Tags are useful for allocation but not always inherited automatically.
- Reservation/Savings Plan decisions need usage data.
- Monitoring and egress can be major hidden costs.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/cost-management-billing/

## 🧪 Try it yourself

**Goal:** Query actual cost for your subscription over the last 7 days.

```bash
az costmanagement query --type ActualCost \
  --timeframe MonthToDate \
  --scope "/subscriptions/$(az account show --query id -o tsv)" \
  --dataset-aggregation '{"totalCost":{"name":"PreTaxCost","function":"Sum"}}' \
  --dataset-grouping name="ResourceGroup" type="Dimension"
```

**👀 Expected result:** A JSON result with cost rows grouped by resource group for the current month.

**✅ Checkpoint:** Identify which resource group is incurring the highest cost so far this month.

**🧹 Clean up:**
Nothing to clean up — read-only query.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r48"></a>
# 48. 🔒 Resource Locks

> 🟦 **What it is:** Management-plane protection against accidental delete or write at supported scopes.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **CanNotDelete** | Blocks deletion while allowing updates. |
| **ReadOnly** | Blocks management-plane writes/deletes. |
| **Inheritance** | Locks at parent scope can affect children. |

## ✅ Use when
- Protect critical shared resources from accidental portal/automation changes.

## ⚠️ Engineering watch-outs
- Locks do not replace RBAC.
- ReadOnly locks can break operations that internally need management writes.
- Document break-glass/unlock process.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-resource-manager/management/lock-resources

## 🧪 Try it yourself

**Goal:** Lock a resource group against deletion, verify it blocks delete, then remove the lock.

```bash
az group create --name <your-resource-group> --location eastus
az lock create --name no-delete --resource-group <your-resource-group> --lock-type CanNotDelete
az group delete --name <your-resource-group> --yes --no-wait
az lock list --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The `az group delete` command fails with a `ScopeLocked` error because of the `CanNotDelete` lock.

**✅ Checkpoint:** Confirm `az lock list` shows the `no-delete` lock, then remove it with `az lock delete --name no-delete --resource-group <your-resource-group>` before retrying delete.

**🧹 Clean up:**
```bash
az lock delete --name no-delete --resource-group <your-resource-group>
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART XI — 📈 DATA & ANALYTICS

<a id="r49"></a>
# 49. 🏭 Azure Data Factory

> 🟦 **What it is:** Managed data-integration/orchestration platform with pipelines, activities, linked services, datasets, integration runtimes and triggers.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Factory** | Top-level resource. |
| **Pipeline** | Workflow. |
| **Activity** | Step. |
| **Dataset** | Data location/shape reference. |
| **Linked Service** | Connection definition. |
| **Integration Runtime** | Execution/connectivity infrastructure. |
| **Trigger** | Schedule/event start. |
| **Mapping Data Flow** | Visual Spark-based transformation feature. |

## ✅ Use when
- ETL/ELT orchestration and data movement.
- Hybrid data movement using self-hosted IR.

## ⚠️ Engineering watch-outs
- Connector/source throttling.
- Secrets should use Key Vault/managed identity.
- Self-hosted IR needs HA if critical.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/data-factory/

## 🧪 Try it yourself

**Goal:** Deploy the smallest possible Data Factory instance and confirm it is provisioned.

```bash
az group create --name <your-resource-group> --location eastus
az datafactory create --resource-group <your-resource-group> --factory-name demo-adf-$RANDOM
az datafactory list --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The factory shows `provisioningState: Succeeded` in the list output, with no pipelines defined yet.

**✅ Checkpoint:** Run `az datafactory show --resource-group <your-resource-group> --factory-name <name>` and confirm the factory exists.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r50"></a>
# 50. 🧱 Azure Databricks

> 🟦 **What it is:** Managed Azure integration of Databricks for Spark/lakehouse/data engineering/ML, with workspaces, compute, jobs and Unity Catalog governance.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Workspace** | Collaboration/control boundary. |
| **Compute** | Interactive/job/serverless compute depending on offering. |
| **Job** | Production workflow. |
| **Unity Catalog** | Data/AI governance layer. |
| **Delta Lake** | Transactional lakehouse storage format. |

## ✅ Use when
- Spark/lakehouse workloads.
- Large-scale data engineering and collaborative data science.

## ⚠️ Engineering watch-outs
- Interactive compute left running is expensive.
- Millions of tiny files hurt performance.
- Production notebooks need CI/CD/testing discipline.
- Network architecture should be chosen early.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/databricks/

## 🧪 Try it yourself

**Goal:** Deploy a minimal Databricks workspace (standard tier, lowest cost).

```bash
az group create --name <your-resource-group> --location eastus
az databricks workspace create --resource-group <your-resource-group> \
  --name demo-dbx --location eastus --sku standard
az databricks workspace show --resource-group <your-resource-group> --name demo-dbx -o table
```

**👀 Expected result:** The workspace shows `provisioningState: Succeeded` with a generated `workspaceUrl`.

**✅ Checkpoint:** Open the `workspaceUrl` value and confirm you can sign in to the Databricks workspace UI.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r51"></a>
# 51. ⚡ Azure Data Explorer

> 🟦 **What it is:** High-performance analytics service for telemetry/log/time-series data using KQL.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Cluster** | Compute boundary. |
| **Database** | Data grouping. |
| **Table** | Schema. |
| **Ingestion** | Batch/stream data input. |
| **KQL** | Primary query language. |
| **Materialized View** | Precomputed aggregation/view. |

## ✅ Use when
- Huge telemetry/log/time-series datasets.
- Near-real-time analytical queries.

## ⚠️ Engineering watch-outs
- Not OLTP.
- Bound KQL time ranges and columns.
- Monitor ingestion failures and hot cache behavior.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/data-explorer/

## 🧪 Try it yourself

**Goal:** Deploy the smallest Azure Data Explorer (Kusto) cluster and create a database.

```bash
az group create --name <your-resource-group> --location eastus
az kusto cluster create --resource-group <your-resource-group> --name demoadx$RANDOM \
  --sku name="Dev(No SLA)_Standard_D11_v2" tier="Basic" --location eastus
az kusto database create --resource-group <your-resource-group> --cluster-name <cluster-name> \
  --database-name demo-db --read-write-database location=eastus soft-delete-period=P7D
```

**👀 Expected result:** The cluster provisions in dev/test SKU (no SLA) and the database `demo-db` appears under it.

**✅ Checkpoint:** Run `az kusto database list --resource-group <your-resource-group> --cluster-name <cluster-name>` and confirm `demo-db` is listed.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r52"></a>
# 52. 🌐 Azure Synapse Analytics

> 🟦 **What it is:** Integrated Azure analytics workspace spanning dedicated/serverless SQL, Spark and pipelines.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Synapse Workspace** | Top-level analytics workspace. |
| **Dedicated SQL Pool** | Provisioned MPP warehouse. |
| **Serverless SQL** | On-demand SQL over lake files. |
| **Spark Pool** | Managed Spark. |
| **Pipelines** | Data orchestration. |

## ✅ Use when
- Existing/strategic Synapse analytics estates.
- Integrated SQL/Spark/pipeline use cases.

## ⚠️ Engineering watch-outs
- Evaluate current Microsoft Fabric direction for new analytics strategy.
- Dedicated SQL table distribution design matters.
- Private networking/dependencies are complex.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/synapse-analytics/

## 🧪 Try it yourself

**Goal:** Deploy a Synapse workspace with serverless SQL only (no dedicated SQL pool cost).

```bash
az group create --name <your-resource-group> --location eastus
az storage account create --name demosynstg$RANDOM --resource-group <your-resource-group> \
  --sku Standard_LRS --kind StorageV2 --enable-hierarchical-namespace true
az synapse workspace create --name demo-synapse$RANDOM --resource-group <your-resource-group> \
  --storage-account <storage-account-name> --file-system synapsefs \
  --sql-admin-login-user sqladminuser --sql-admin-login-password '<StrongP@ssw0rd!>' --location eastus
```

**👀 Expected result:** The workspace provisions successfully; only the built-in serverless SQL endpoint is available (no dedicated pool created).

**✅ Checkpoint:** Run `az synapse workspace show --name <workspace-name> --resource-group <your-resource-group>` and confirm `provisioningState: Succeeded`.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r53"></a>
# 53. 🌊 Azure Stream Analytics

> 🟦 **What it is:** Managed SQL-like real-time stream processing with inputs, queries and outputs.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Streaming Job** | Processing resource. |
| **Input** | Event Hub/IoT/reference source. |
| **Query** | SQL-like streaming transform. |
| **Output** | Destination. |
| **Streaming Unit** | Capacity unit. |

## ✅ Use when
- Simple managed real-time window/filter/aggregate processing.

## ⚠️ Engineering watch-outs
- Understand event time, late/out-of-order events and partitioning.
- Monitor watermark/backlog.
- Use managed identity for supported endpoints.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/stream-analytics/

## 🧪 Try it yourself

**Goal:** Deploy a Stream Analytics job definition (no input/output wired yet) and inspect its default state.

```bash
az group create --name <your-resource-group> --location eastus
az stream-analytics job create --resource-group <your-resource-group> \
  --name demo-asa-job --location eastus \
  --output-error-policy Drop --out-of-order-policy Drop --order-max-delay 5 --arrival-max-delay 16
az stream-analytics job show --resource-group <your-resource-group> --name demo-asa-job -o table
```

**👀 Expected result:** The job is created with `jobState: Created` (not yet started, since no input/output is configured).

**✅ Checkpoint:** Confirm `jobState` is `Created` and `provisioningState` is `Succeeded` in the show output.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r54"></a>
# 54. 🧵 Microsoft Fabric Context

> 🟦 **What it is:** Microsoft Fabric is a related SaaS analytics platform with OneLake and multiple workloads. Not every Fabric object is an ordinary Azure ARM resource, so do not model it as a simple resource-provider subtree.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Fabric Capacity** | Compute/capacity concept. |
| **Workspace** | Collaboration boundary. |
| **OneLake** | Unified data lake abstraction. |
| **Lakehouse/Warehouse/etc.** | Fabric workloads rather than ordinary Azure resources. |

## ✅ Use when
- Organization adopts Fabric as unified SaaS analytics platform.

## ⚠️ Engineering watch-outs
- Keep Azure ARM governance concepts separate from Fabric workspace/item governance.
- Licensing/capacity model differs from normal Azure resource pricing.

## 📚 Official Microsoft docs
https://learn.microsoft.com/fabric/

## 🧪 Try it yourself

**Goal:** Fabric capacities aren't plain ARM resources everywhere yet — inspect which Fabric-related resource providers/types are registered in your subscription.

```bash
az provider show --namespace Microsoft.Fabric --query "resourceTypes[].resourceType" -o tsv
az provider list --query "[?contains(namespace,'Fabric')].{namespace:namespace, state:registrationState}" -o table
```

**👀 Expected result:** A list of Fabric-related resource types (if the provider is registered) or an empty/unregistered result if Fabric hasn't been onboarded in this subscription.

**✅ Checkpoint:** Note whether `Microsoft.Fabric` shows `Registered` — if not, you'd need `az provider register --namespace Microsoft.Fabric` before using ARM-visible Fabric capacities.

**🧹 Clean up:**
Nothing to clean up — read-only command.

[⬆️ Back to resource TOC](#resource-toc)

---

# PART XII — 🤖 AI & MACHINE LEARNING

<a id="r55"></a>
# 55. 🤖 Microsoft Foundry

> 🟦 **What it is:** Current Microsoft Azure AI platform unifying agents, models, tools and enterprise controls such as RBAC, networking, tracing, monitoring and evaluations.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Foundry Resource / Project** | Management/development boundary. |
| **Foundry Models** | Foundation/model catalog and deployments. |
| **Foundry Agent Service** | Managed agent runtime/configuration. |
| **Tools** | Callable capabilities/data integrations. |
| **Connections** | External/Azure resource connections. |
| **Tracing/Evaluation** | Quality and observability capabilities. |
| **MCP integrations** | Tool interoperability where supported/current. |

## ✅ Use when
- Enterprise generative-AI and agent applications.
- Managed model/tool/agent development with Azure governance.

## ⚠️ Engineering watch-outs
- Prompt injection is an authorization/tool-safety issue.
- Use managed identities/RBAC.
- Model/agent quotas and feature availability are volatile—verify live.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/ai-foundry/what-is-azure-ai-foundry

## 🧪 Try it yourself

**Goal:** Create a minimal Foundry resource/project and confirm it's provisioned.

```bash
az group create --name <your-resource-group> --location eastus
az cognitiveservices account create --name demo-foundry --resource-group <your-resource-group> \
  --kind AIServices --sku S0 --location eastus --yes
az cognitiveservices account show --name demo-foundry --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The account shows `provisioningState: Succeeded` and `kind: AIServices`.

**✅ Checkpoint:** Confirm the Foundry resource appears at https://ai.azure.com under your subscription/resource group.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r56"></a>
# 56. 🧠 Azure OpenAI / Foundry Models

> 🟦 **What it is:** Azure-hosted foundation model deployments exposed through Foundry/Azure AI resource models, with deployment types, quotas, content filtering and enterprise networking/authentication.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Model** | Underlying foundation model/version. |
| **Deployment** | Named callable endpoint/capacity allocation. |
| **Deployment Type** | Provisioning/throughput model. |
| **Quota** | Regional/model capacity. |
| **Content Filtering** | Safety policy layer. |
| **Private Networking** | Private endpoints/managed network patterns depending on resource model. |

## ✅ Use when
- LLM/embedding/multimodal inference on Azure.

## ⚠️ Engineering watch-outs
- Do not hard-code model versions/capacity assumptions.
- Handle 429/5xx with backoff.
- Prefer Entra/managed identity over keys.
- Model cost/token budgets need monitoring.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/ai-services/openai/

## 🧪 Try it yourself

**Goal:** Deploy an Azure OpenAI resource and list available model deployments.

```bash
az group create --name <your-resource-group> --location eastus
az cognitiveservices account create --name demo-aoai --resource-group <your-resource-group> \
  --kind OpenAI --sku S0 --location eastus --yes
az cognitiveservices account deployment list --name demo-aoai --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The account is created successfully; the deployment list is empty until you add a model deployment.

**✅ Checkpoint:** Run `az cognitiveservices account list-models --name demo-aoai --resource-group <your-resource-group>` and confirm it returns available model names for your region.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r57"></a>
# 57. 🔎 Azure AI Search

> 🟦 **What it is:** Managed search platform for full-text, vector, hybrid and semantic search; common in RAG systems.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Search Service** | Capacity/security boundary. |
| **Index** | Searchable schema/data. |
| **Indexer** | Pull ingestion process. |
| **Data Source** | Indexer source. |
| **Skillset** | AI enrichment pipeline. |
| **Vector Search** | Embedding-based retrieval. |
| **Hybrid Search** | Text + vector. |
| **Semantic Ranker** | Semantic re-ranking. |

## ✅ Use when
- RAG retrieval.
- Search/faceting/filtering over documents/content.

## ⚠️ Engineering watch-outs
- Do not expose admin keys in clients.
- RAG needs access-control trimming/filtering.
- Index/chunking changes need reindex strategy.
- Replicas and partitions drive capacity/cost.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/search/

## 🧪 Try it yourself

**Goal:** Deploy the smallest AI Search service (Free tier) and confirm it responds.

```bash
az group create --name <your-resource-group> --location eastus
az search service create --name demo-search$RANDOM --resource-group <your-resource-group> \
  --sku free --location eastus
az search service show --name <search-name> --resource-group <your-resource-group> --query status -o tsv
```

**👀 Expected result:** The service `status` returns `running`.

**✅ Checkpoint:** Run `az search admin-key show --service-name <search-name> --resource-group <your-resource-group>` and confirm an admin key is returned.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r58"></a>
# 58. 🧪 Azure Machine Learning

> 🟦 **What it is:** Managed ML platform for workspaces, compute, environments, data/model assets, pipelines and online/batch endpoints.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Workspace** | ML collaboration/governance boundary. |
| **Compute Instance** | Interactive development. |
| **Compute Cluster** | Elastic training/batch compute. |
| **Environment** | Reproducible runtime. |
| **Data Asset** | Versioned data reference. |
| **Model** | Registered model artifact. |
| **Endpoint** | Inference entry. |
| **Deployment** | Model version/runtime behind endpoint. |
| **Pipeline** | Repeatable ML workflow. |

## ✅ Use when
- Train/deploy custom ML models.
- MLOps/experiment/asset governance.

## ⚠️ Engineering watch-outs
- Stop idle compute.
- Make environments reproducible.
- Private dependencies/networking matter.
- Model quality/drift monitoring is part of production.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/machine-learning/

## 🧪 Try it yourself

**Goal:** Deploy a minimal Azure Machine Learning workspace (no compute started yet).

```bash
az group create --name <your-resource-group> --location eastus
az ml workspace create --name demo-mlw --resource-group <your-resource-group> --location eastus
az ml workspace show --name demo-mlw --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The workspace is created with `provisioning_state: Succeeded`; no compute instance/cluster exists yet.

**✅ Checkpoint:** Confirm `az ml compute list --workspace-name demo-mlw --resource-group <your-resource-group>` returns an empty list (no idle compute billing).

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r59"></a>
# 59. 🧰 Foundry Tools / AI Services

> 🟦 **What it is:** Specialized AI capabilities cover document understanding, speech, language, translation, vision and content safety/guardrail scenarios under the current Foundry/Azure AI tooling direction.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Content Understanding** | Multimodal content processing/extraction. |
| **Document Intelligence** | OCR/layout/structured document extraction. |
| **Speech** | Speech-to-text/text-to-speech and related speech capabilities. |
| **Language** | Text/language analysis capabilities. |
| **Translator** | Machine translation. |
| **Vision** | Image/vision capabilities where current service supports them. |
| **Content Safety / Guardrails** | Safety classification/controls. |

## ✅ Use when
- Use a specialized managed AI API instead of building/training the capability yourself.

## ⚠️ Engineering watch-outs
- AI output needs business validation.
- Sensitive documents/audio/images require data-governance review.
- Service names/endpoints are evolving—verify current Foundry docs.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/ai-services/

## 🧪 Try it yourself

**Goal:** Deploy a multi-service AI Services account and inspect its keys/endpoint.

```bash
az group create --name <your-resource-group> --location eastus
az cognitiveservices account create --name demo-aiservices --resource-group <your-resource-group> \
  --kind CognitiveServices --sku S0 --location eastus --yes
az cognitiveservices account show --name demo-aiservices --resource-group <your-resource-group> \
  --query properties.endpoint -o tsv
```

**👀 Expected result:** A single HTTPS endpoint is returned that can be used for multiple AI capabilities (vision/language/etc.) from one resource.

**✅ Checkpoint:** Run `az cognitiveservices account keys list --name demo-aiservices --resource-group <your-resource-group>` and confirm two keys are returned.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART XIII — 🌍 IoT & EDGE

<a id="r60"></a>
# 60. 📡 Azure IoT Hub

> 🟦 **What it is:** Managed IoT cloud gateway with per-device identity, telemetry, cloud-to-device messaging, twins and routing. DPS supports at-scale device provisioning.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **IoT Hub** | Device-cloud gateway. |
| **Device Identity** | Per-device auth record. |
| **Device Twin** | Desired/reported state. |
| **Module Twin** | Module-level state. |
| **D2C/C2D** | Telemetry/commands. |
| **Message Routing** | Routes device messages. |
| **DPS** | Zero-touch provisioning service. |
| **Device Update** | Managed update capability where applicable. |

## ✅ Use when
- Large device fleets requiring per-device identity and device management semantics.

## ⚠️ Engineering watch-outs
- Do not share one symmetric key across fleet.
- Design offline buffering/reconnect.
- Monitor throttling/routing failures.
- Provisioning and key/certificate rotation need lifecycle design.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/iot-hub/

https://learn.microsoft.com/azure/iot-dps/

## 🧪 Try it yourself

**Goal:** Deploy a free-tier IoT Hub and register a device identity.

```bash
az group create --name <your-resource-group> --location eastus
az iot hub create --name demo-iothub$RANDOM --resource-group <your-resource-group> --sku F1 --partition-count 2
az iot hub device-identity create --hub-name <hub-name> --device-id demo-device-01
az iot hub device-identity list --hub-name <hub-name> -o table
```

**👀 Expected result:** The hub provisions on the free F1 SKU (one per subscription) and `demo-device-01` appears in the device identity list.

**✅ Checkpoint:** Run `az iot hub device-identity show --hub-name <hub-name> --device-id demo-device-01` and confirm `status: enabled`.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r61"></a>
# 61. 🏭 Azure IoT Operations

> 🟦 **What it is:** Industrial/edge data platform running on Arc-enabled Kubernetes with MQTT/data-flow concepts and Azure cloud integration.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Arc-enabled Kubernetes** | Management foundation. |
| **MQTT Broker** | Edge messaging. |
| **Data Flows** | Edge data movement/processing. |
| **Assets/Endpoints** | Industrial resource representation. |
| **Cloud Connectors** | Integration to Azure/cloud targets. |

## ✅ Use when
- Industrial edge needs local operation plus Azure management.
- Intermittent cloud connectivity is normal.

## ⚠️ Engineering watch-outs
- Edge networking/certificates are critical.
- Design offline behavior.
- Do not treat plant networks like ordinary cloud VNets.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/iot-operations/

## 🧪 Try it yourself

**Goal:** IoT Operations needs Arc-enabled Kubernetes as a prerequisite — verify whether the required resource providers are registered before attempting a real deployment.

```bash
az provider show --namespace Microsoft.IoTOperations --query registrationState -o tsv
az provider show --namespace Microsoft.Kubernetes --query registrationState -o tsv
az provider register --namespace Microsoft.IoTOperations
```

**👀 Expected result:** Provider registration state moves to (or already shows) `Registered`, confirming your subscription can host IoT Operations extensions on an Arc-enabled cluster.

**✅ Checkpoint:** Re-run the `show` command after a minute and confirm `registrationState` reports `Registered`.

**🧹 Clean up:**
Nothing to clean up — provider registration is non-destructive and reusable.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r62"></a>
# 62. 🧬 Azure Digital Twins

> 🟦 **What it is:** Graph-based digital representation service using models, twins, relationships and event routes.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Model** | Schema describing twin type. |
| **Twin** | Instance of modeled entity. |
| **Relationship** | Graph edge. |
| **Event Route** | Sends twin/telemetry events downstream. |

## ✅ Use when
- Physical environments benefit from a connected graph model.

## ⚠️ Engineering watch-outs
- Do not model every raw sensor sample as permanent twin state.
- Version/govern models.
- Digital Twins is not the device gateway itself.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/digital-twins/

## 🧪 Try it yourself

**Goal:** Deploy a Digital Twins instance and confirm the data-plane endpoint is reachable.

```bash
az group create --name <your-resource-group> --location eastus
az dt create --name demo-dt-$RANDOM --resource-group <your-resource-group> --location eastus
az dt show --name <dt-name> --resource-group <your-resource-group> --query hostName -o tsv
```

**👀 Expected result:** A `hostName` such as `demo-dt-xxxx.api.eus.digitaltwins.azure.net` is returned.

**✅ Checkpoint:** Run `az dt model list --dt-name <dt-name>` and confirm it returns an empty list (no models uploaded yet).

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r63"></a>
# 63. 🧱 IoT Edge

> 🟦 **What it is:** IoT Edge runs containerized modules on edge devices/gateways with an edge agent/hub runtime and cloud management through IoT Hub-era patterns. Verify current strategic fit alongside IoT Operations.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **IoT Edge Runtime** | Edge module runtime. |
| **Edge Agent** | Module lifecycle manager. |
| **Edge Hub** | Local messaging broker/gateway. |
| **Module** | Containerized edge workload. |

## ✅ Use when
- Existing IoT Edge solutions and supported edge-gateway patterns.

## ⚠️ Engineering watch-outs
- For new industrial edge designs, compare current IoT Operations direction.
- Plan module/image updates and offline behavior.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/iot-edge/

## 🧪 Try it yourself

**Goal:** Register an IoT Edge-capable device identity on an IoT Hub (edge-enabled flag).

```bash
az group create --name <your-resource-group> --location eastus
az iot hub create --name demo-edgehub$RANDOM --resource-group <your-resource-group> --sku F1
az iot hub device-identity create --hub-name <hub-name> --device-id demo-edge-device --edge-enabled
az iot hub device-identity show --hub-name <hub-name> --device-id demo-edge-device --query capabilities
```

**👀 Expected result:** `capabilities.iotEdge` returns `true`, confirming the device identity is flagged for IoT Edge module hosting.

**✅ Checkpoint:** Confirm the device connection string via `az iot hub device-identity connection-string show --hub-name <hub-name> --device-id demo-edge-device`.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART XIV — 🔀 HYBRID, MULTICLOUD & MIGRATION

<a id="r64"></a>
# 64. 🌉 Azure Arc

> 🟦 **What it is:** Extends Azure control-plane management to external servers, Kubernetes and selected data/services.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Arc-enabled Servers** | External machines represented in ARM. |
| **Connected Machine Agent** | Server connection/extension platform. |
| **Arc-enabled Kubernetes** | External cluster connection. |
| **Arc-enabled Data Services** | Hybrid data service scenarios. |
| **Extensions** | Azure management capabilities on Arc resources. |

## ✅ Use when
- Hybrid/multicloud inventory, policy, monitor, security and management.

## ⚠️ Engineering watch-outs
- Arc does not migrate workloads into Azure.
- Outbound connectivity/proxy/private-link design matters.
- Local OS/Kubernetes security still matters.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-arc/

## 🧪 Try it yourself

**Goal:** List Arc-enabled resource providers and check what's already onboarded in your subscription.

```bash
az provider show --namespace Microsoft.HybridCompute --query registrationState -o tsv
az connectedmachine list -o table
az resource list --resource-type "Microsoft.HybridCompute/machines" -o table
```

**👀 Expected result:** Provider registration state shows `Registered` (or you register it), and the list shows any existing Arc-enabled servers in the subscription (empty if none onboarded yet).

**✅ Checkpoint:** Confirm whether any machines appear; if none, note that onboarding requires running the Connected Machine agent installer on a real server.

**🧹 Clean up:**
Nothing to clean up — read-only commands.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r65"></a>
# 65. 🏠 Azure Local

> 🟦 **What it is:** Azure-managed distributed infrastructure platform for customer-controlled/on-prem locations, integrated with Azure/Arc.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure Local System/Cluster** | Local infrastructure platform. |
| **Arc Integration** | Azure management/control plane. |
| **Local VMs** | Virtualized workloads. |
| **Container/Kubernetes scenarios** | Supported local container platforms depending on current release. |

## ✅ Use when
- Latency/sovereignty/disconnected requirements require local compute with Azure management.

## ⚠️ Engineering watch-outs
- You still operate physical infrastructure lifecycle.
- Do not assume full Azure region service catalog locally.
- Design spare capacity and site DR.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-local/

## 🧪 Try it yourself

**Goal:** Azure Local requires physical/registered hardware, so inspect whether any Azure Local (Stack HCI) clusters are already registered to your subscription.

```bash
az provider show --namespace Microsoft.AzureStackHCI --query registrationState -o tsv
az stack-hci cluster list -o table
```

**👀 Expected result:** Provider shows `Registered`; the cluster list is empty unless your organization already has on-prem hardware registered.

**✅ Checkpoint:** Confirm you understand that creating a real cluster requires physical/validated hardware — this lab only verifies subscription readiness.

**🧹 Clean up:**
Nothing to clean up — read-only commands.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r66"></a>
# 66. ☁️ Azure VMware Solution

> 🟦 **What it is:** Managed VMware private cloud running on dedicated Azure infrastructure, used for VMware migration/extension while preserving VMware tooling/semantics.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Private Cloud** | Dedicated VMware environment. |
| **vCenter/NSX/vSAN** | VMware stack. |
| **ExpressRoute** | Primary Azure connectivity. |
| **HCX** | Migration/mobility tooling where used. |

## ✅ Use when
- Large VMware estates need rapid migration with minimal replatforming.

## ⚠️ Engineering watch-outs
- High fixed cost requires TCO review.
- Plan IP/DNS/connectivity carefully.
- A modernization roadmap may still be needed.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-vmware/

## 🧪 Try it yourself

**Goal:** Azure VMware Solution private clouds are costly/quota-gated, so check quota/SKU availability in a region before provisioning.

```bash
az vmware location check-quota-availability --location eastus -o table
az vmware location check-trial-availability --location eastus -o table
```

**👀 Expected result:** Quota/trial availability details (including remaining host quota) for AVS node SKUs (for example `AV36`) in the chosen region.

**✅ Checkpoint:** Identify whether your subscription has any AVS host quota before planning a real private cloud deployment.

**🧹 Clean up:**
Nothing to clean up — read-only commands.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r67"></a>
# 67. 🚚 Azure Migrate

> 🟦 **What it is:** Discovery, assessment and migration hub for servers, databases and application modernization/migration scenarios.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Migrate Project** | Migration management boundary. |
| **Appliance** | Discovery/assessment component for supported sources. |
| **Assessment** | Readiness/right-sizing/cost analysis. |
| **Server Migration** | Replication/cutover workflow. |
| **Web/App modernization tools** | Assessment/migration paths for supported workloads. |

## ✅ Use when
- Inventory/assess before migration.
- VM/server migration and right-sizing.

## ⚠️ Engineering watch-outs
- Discover dependencies before cutover.
- Run test migrations.
- Lift-and-shift should be followed by optimization/modernization review.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/migrate/

## 🧪 Try it yourself

**Goal:** Inspect Azure Migrate project resources already discoverable in your subscription.

> ⚠️ **Needs verification:** The modern `az migrate` CLI extension (preview) no longer exposes a `project create`/`project show` command — project creation is currently a Portal or ARM/Bicep (`Microsoft.Migrate/migrateProjects`) operation. Confirm the current CLI surface at `az migrate --help` before scripting this.

```bash
az provider show --namespace Microsoft.Migrate --query "resourceTypes[].resourceType" -o table
az resource list --resource-type "Microsoft.Migrate/migrateProjects" -o table
```

**👀 Expected result:** The `Microsoft.Migrate` resource types available in your subscription, then any existing Azure Migrate projects (empty if none created yet via the Portal).

**✅ Checkpoint:** If you need to create a new project, confirm the current recommended path (Portal wizard or ARM/Bicep) in the official docs rather than assuming a CLI `create` subcommand exists.

**🧹 Clean up:** Nothing to clean up — read-only commands.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r68"></a>
# 68. 🗄️ Database Migration Service

> 🟦 **What it is:** Managed database migration orchestration for supported source/target combinations, including online/offline migration patterns.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **DMS Instance / Service** | Migration orchestration resource. |
| **Project/Task** | Source-target migration workflow. |
| **Online Migration** | Minimize downtime using continuous sync where supported. |
| **Offline Migration** | One-time move with outage window. |

## ✅ Use when
- Supported database engine migration needs managed orchestration.

## ⚠️ Engineering watch-outs
- Always verify current supported source/target/version matrix.
- Performance/latency/network path affects online migration.
- Test app compatibility separately from data copy.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/dms/

## 🧪 Try it yourself

**Goal:** Deploy the smallest Database Migration Service instance (no project/task wired yet).

```bash
az group create --name <your-resource-group> --location eastus
az dms create --name demo-dms --resource-group <your-resource-group> \
  --location eastus --sku-name Basic_2vCores
az dms show --name demo-dms --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The DMS instance shows `provisioningState: Succeeded`; no migration projects/tasks exist yet.

**✅ Checkpoint:** Run `az dms project list --service-name demo-dms --resource-group <your-resource-group>` and confirm an empty list.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r69"></a>
# 69. 📦 Azure Storage Mover & Data Box

> 🟦 **What it is:** Storage Mover handles managed online file/object migration into Azure Storage; Data Box handles offline physical bulk transfer.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Storage Mover** | Online managed migration. |
| **Migration Project/Job** | Mover workflow. |
| **Data Box** | Physical appliance transfer. |
| **Data Box Disk / Heavy** | Offer variants; verify current availability. |

## ✅ Use when
- Large storage migrations.
- WAN-limited migrations needing offline seed.

## ⚠️ Engineering watch-outs
- Plan delta sync after bulk transfer.
- Preserve/validate metadata/ACLs.
- Verify current Data Box offer availability by region.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/storage-mover/

https://learn.microsoft.com/azure/databox/

## 🧪 Try it yourself

**Goal:** Deploy a Storage Mover resource and confirm it's ready to host a migration project.

```bash
az group create --name <your-resource-group> --location eastus
az storage-mover create --name demo-mover --resource-group <your-resource-group> --location eastus
az storage-mover show --name demo-mover --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The Storage Mover resource is created successfully with no migration projects configured yet.

**✅ Checkpoint:** Run `az storage-mover project list --resource-group <your-resource-group> --mover-name demo-mover` and confirm an empty list.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART XV — 🖥️ VIRTUAL DESKTOP

<a id="r70"></a>
# 70. 🖥️ Azure Virtual Desktop

> 🟦 **What it is:** ARM-based desktop/application virtualization service using host pools, session hosts, application groups and workspaces. FSLogix is commonly used for profile containers.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Host Pool** | Group of session hosts. |
| **Session Host** | VM users connect to. |
| **Application Group** | Desktop/RemoteApp assignment. |
| **Workspace** | Publishes application groups. |
| **Personal vs Pooled** | Dedicated vs shared session-host models. |
| **FSLogix** | Profile-container technology. |
| **Scaling Plan** | Schedule/load-based host scaling. |

## ✅ Use when
- Remote Windows desktops/apps.
- Multi-session pooled desktops.
- Enterprise app virtualization.

## ⚠️ Engineering watch-outs
- Profile storage is often a performance/availability dependency.
- Golden images need versioning/testing.
- Do not expose session-host RDP publicly.
- AVD classic is retired; use ARM model.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/virtual-desktop/

## 🧪 Try it yourself

**Goal:** Create a pooled AVD host pool and an application group (no session host VM required to see the control-plane objects).

```bash
az group create --name <your-resource-group> --location eastus
az desktopvirtualization hostpool create --name demo-hostpool --resource-group <your-resource-group> \
  --location eastus --host-pool-type Pooled --load-balancer-type BreadthFirst --preferred-app-group-type Desktop
az desktopvirtualization hostpool show --name demo-hostpool --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The host pool is created with `hostPoolType: Pooled`; no session hosts are registered yet.

**✅ Checkpoint:** Run `az desktopvirtualization sessionhost list --host-pool-name demo-hostpool --resource-group <your-resource-group>` and confirm an empty list.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART XVI — 🧰 SPECIALIZED APPLICATION SERVICES

<a id="r71"></a>
# 71. 🗺️ Azure Maps

> 🟦 **What it is:** Geospatial APIs/services for map rendering, search, routing, geolocation and spatial scenarios.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Maps Account** | Azure management/billing/auth boundary. |
| **Search** | Place/address search. |
| **Routing** | Route calculations. |
| **Geolocation** | Location-related APIs. |
| **Authentication** | Entra/shared-key/token models depending on API/client scenario. |

## ✅ Use when
- Applications need Azure-integrated geospatial/map APIs.

## ⚠️ Engineering watch-outs
- Location data may be privacy-sensitive.
- Do not expose privileged keys in untrusted clients.
- Verify API/version/regional/data-residency requirements.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/azure-maps/

## 🧪 Try it yourself

**Goal:** Deploy an Azure Maps account and make a simple authenticated search request.

```bash
az group create --name <your-resource-group> --location eastus
az maps account create --name demo-maps --resource-group <your-resource-group> --sku G2
az maps account keys list --name demo-maps --resource-group <your-resource-group> --query primaryKey -o tsv
```

**👀 Expected result:** A primary key string is returned, usable as `subscription-key` on Azure Maps REST calls (for example a `/search/address` request).

**✅ Checkpoint:** Call `curl "https://atlas.microsoft.com/search/address/json?api-version=1.0&subscription-key=<key>&query=1 Microsoft Way Redmond"` and confirm a JSON result set is returned.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r72"></a>
# 72. ☎️ Azure Communication Services

> 🟦 **What it is:** Programmable communication APIs for voice/video, chat, SMS and email-related scenarios.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Communication Services Resource** | Service boundary. |
| **Voice/Video** | Calling capabilities. |
| **Chat** | Real-time chat. |
| **SMS** | Programmable SMS. |
| **Email** | Email communication service/resources. |
| **Client Identity/Token** | Short-lived client authorization. |

## ✅ Use when
- Apps need embedded communications.

## ⚠️ Engineering watch-outs
- Use short-lived client tokens.
- Abuse/rate controls matter.
- Channel delivery is not a transactional guarantee.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/communication-services/

## 🧪 Try it yourself

**Goal:** Deploy a Communication Services resource and issue a short-lived client access token.

```bash
az group create --name <your-resource-group> --location global
az communication create --name demo-acs --resource-group <your-resource-group> \
  --location global --data-location unitedstates
az communication identity user create --connection-string "<connection-string-from-show-command>"
```

**👀 Expected result:** The resource is created, and a new communication user identity with a GUID-style ID is returned.

**✅ Checkpoint:** Run `az communication list-key --name demo-acs --resource-group <your-resource-group>` and confirm a connection string is returned for issuing tokens.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r73"></a>
# 73. 🧪 Azure App Testing

> 🟦 **What it is:** Azure App Testing services include Load Testing and Playwright Testing for performance and browser end-to-end testing.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure Load Testing** | Managed load generation/performance testing. |
| **Test** | Load definition/run. |
| **Playwright Testing** | Managed browser execution for Playwright suites. |
| **Artifacts** | Traces/screenshots/reports. |
| **CI/CD Integration** | Automated test execution in pipelines. |

## ✅ Use when
- Performance tests and browser E2E tests in CI/CD.

## ⚠️ Engineering watch-outs
- Define safe load-test targets/abort criteria.
- Flaky browser tests need deterministic setup.
- Test credentials should be low privilege.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/app-testing/

## 🧪 Try it yourself

**Goal:** Deploy an Azure Load Testing resource and confirm it's ready to accept a test definition.

```bash
az group create --name <your-resource-group> --location eastus
az load create --name demo-loadtest --resource-group <your-resource-group> --location eastus
az load show --name demo-loadtest --resource-group <your-resource-group> -o table
```

**👀 Expected result:** The Load Testing resource is created with a data-plane endpoint; no test runs exist yet.

**✅ Checkpoint:** Run `az load test list --load-test-resource demo-loadtest --resource-group <your-resource-group>` and confirm an empty list.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r74"></a>
# 74. 🧮 Azure Batch

> 🟦 **What it is:** Managed scheduling of large numbers of parallel/HPC-style tasks across pools of compute nodes.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Batch Account** | Management boundary. |
| **Pool** | Compute nodes. |
| **Job** | Task collection. |
| **Task** | Unit of execution. |
| **AutoScale** | Pool scaling policy. |

## ✅ Use when
- Rendering, simulation, engineering/HPC and parallel batch processing.

## ⚠️ Engineering watch-outs
- Tasks should be retryable/idempotent.
- Checkpoint long expensive work.
- Quota/capacity and storage throughput matter.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/batch/

## 🧪 Try it yourself

**Goal:** Deploy a Batch account and a minimal low-priority pool for parallel task execution.

```bash
az group create --name <your-resource-group> --location eastus
az batch account create --name demobatch$RANDOM --resource-group <your-resource-group> --location eastus
az batch account login --name <batch-account-name> --resource-group <your-resource-group> --shared-key-auth
az batch pool create --id demo-pool --vm-size Standard_D2s_v3 --target-dedicated-nodes 0 \
  --target-low-priority-nodes 1 --image canonical:0001-com-ubuntu-server-jammy:22_04-lts --node-agent-sku-id "batch.node.ubuntu 22.04"
```

**👀 Expected result:** The Batch account and `demo-pool` are created; the pool allocates one low-priority node.

**✅ Checkpoint:** Run `az batch pool show --pool-id demo-pool` and confirm `allocationState` reaches `steady`.

**🧹 Clean up:**
```bash
az group delete --name <your-resource-group> --yes --no-wait
```

[⬆️ Back to resource TOC](#resource-toc)

---

# PART XVII — 🔄 LIFECYCLE & TRANSITIONS

<a id="r75"></a>
# 75. ⏳ Services in Transition / Retirement

> 🟦 **What it is:** Azure continuously retires services/features. Keep normal sections focused on current targets and put legacy products here with migration direction.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Azure Front Door (classic)** | Retires 2027-03-31 → migrate to Standard/Premium. |
| **Azure Cache for Redis Enterprise/Enterprise Flash** | Retires 2027-03-31 → Azure Managed Redis. |
| **Azure Cache for Redis Basic/Standard/Premium** | Retires 2028-09-30 → Azure Managed Redis. |
| **Azure Blueprints** | Retires 2027-01-31 → Deployment Stacks + Template Specs/Git + Policy/RBAC. |
| **Azure Spring Apps** | Retires 2028-03-31 → Container Apps or AKS. |
| **Azure Virtual Desktop classic** | Retired 2026-09-30 → ARM-based AVD. |

## ✅ Use when
- Use this section when inheriting old architecture or migration plans.

## ⚠️ Engineering watch-outs
- Always verify the official retirement page before making dates/contracts part of a plan.
- Use Service Health/Advisor/Resource Graph to locate impacted resources.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/service-health/service-retirement-alerting-guidance

## 🧪 Try it yourself

**Goal:** Run `az provider list` and check which of the retiring resource types from this section are actually in use in your subscription.

```bash
az resource list --resource-type "Microsoft.Cdn/profiles" --query "[?properties.frontDoorId!=null]" -o table
az resource list --resource-type "Microsoft.Cache/Redis" -o table
az resource list --resource-type "Microsoft.Blueprint/blueprintAssignments" -o table
```

**👀 Expected result:** Each command lists any live resources of that type in your subscription (likely empty in a fresh subscription), helping you spot retirement-impacted resources before a deadline.

**✅ Checkpoint:** For any resource found, cross-check its retirement date against the live Microsoft retirement notice before planning migration.

**🧹 Clean up:**
Nothing to clean up — read-only inventory commands.

[⬆️ Back to resource TOC](#resource-toc)

---

<a id="r76"></a>
# 76. 🧪 Preview & Emerging Resources

> 🟦 **What it is:** Preview/emerging services are useful for evaluation but have different support/SLA/change characteristics. Names, APIs and even product direction can change.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Preview Service** | Not yet fully GA; terms/support may differ. |
| **Private Preview** | Access-limited evaluation. |
| **Public Preview** | Broader pre-GA availability. |
| **GA** | Generally available production service. |
| **Feature Flag/API Version** | Preview state may appear at feature/API level rather than whole service. |

## ✅ Use when
- Prototype/evaluate with explicit risk acceptance.
- Track features that may solve future architecture needs.

## ⚠️ Engineering watch-outs
- Do not silently put preview dependencies in production standards.
- Verify SLA/support/data-residency/compliance before use.
- Document exit/migration path.

## 📚 Official Microsoft docs
https://azure.microsoft.com/updates/

## 🧪 Try it yourself

**Goal:** Run `az provider list` and find which resource providers in your subscription currently expose preview-stage API versions.

```bash
az provider list --query "[].{namespace:namespace, state:registrationState}" -o table
az provider show --namespace Microsoft.App --query "resourceTypes[].apiVersions[?contains(@,'preview')]" -o table
```

**👀 Expected result:** The first command lists all registered providers; the second shows any preview API versions (containing "preview") still exposed for a given resource type.

**✅ Checkpoint:** Pick one provider you use in production and confirm whether you are pinned to a GA API version rather than a preview one.

**🧹 Clean up:**
Nothing to clean up — read-only inventory commands.

[⬆️ Back to resource TOC](#resource-toc)

---

# PART XVIII — 📚 OFFICIAL SOURCE MAP

<a id="r77"></a>
# 77. 📚 Official Microsoft Documentation Directory

> 🟦 **What it is:** Use first-party Microsoft sources as the authority for implementation details. This reference intentionally avoids duplicating fast-changing SKU/limit/region matrices.

## 🧩 Resource map

| Resource / concept | What to remember |
|---|---|
| **Architecture Center** | Technology-choice matrices and reference architectures. |
| **Well-Architected Framework** | Reliability, Security, Cost Optimization, Operational Excellence, Performance Efficiency. |
| **ARM docs** | Resource providers/types/APIs/IaC. |
| **Reliability docs** | Region/zone/service reliability guidance. |
| **Service docs** | Resource-specific implementation details. |
| **Service Health** | Incidents, maintenance, retirements. |

## ✅ Use when
- Verify any production-critical assumption.
- Follow links from the relevant section above.

## ⚠️ Engineering watch-outs
- Search engines may surface stale Microsoft pages; prefer current Learn pages and service overview/lifecycle notes.
- For modern AI, verify current Microsoft Foundry naming/resource model.

## 📚 Official Microsoft docs
https://learn.microsoft.com/azure/architecture/guide/technology-choices/technology-choices-overview

https://learn.microsoft.com/azure/well-architected/

https://learn.microsoft.com/azure/azure-resource-manager/

## 🧪 Try it yourself

**Goal:** Run `az provider list` and find which of the resource types referenced throughout this cheat sheet are actually available/registered in your subscription.

```bash
az provider list --query "[].{namespace:namespace, state:registrationState}" -o table
az provider list --query "[?registrationState=='NotRegistered'].namespace" -o tsv
```

**👀 Expected result:** A full table of resource providers and their registration state, plus a short list of any providers not yet registered that you'd need before deploying those resource types.

**✅ Checkpoint:** Pick three providers mentioned in this document (for example `Microsoft.Storage`, `Microsoft.KeyVault`, `Microsoft.CognitiveServices`) and confirm they show `Registered`.

**🧹 Clean up:**
Nothing to clean up — read-only inventory command.

[⬆️ Back to resource TOC](#resource-toc)

---
