# 📦 Azure Resources Cheatsheet
### A deep, resource-by-resource reference for real production work

> **Edition:** 2026-10-02
> **Audience:** Complete Azure beginners through senior cloud/platform engineers and solution architects.
> **Companion document:** [`azure_cheatsheet.md`](./azure_cheatsheet.md) explains **how Azure fits together as a whole** (hierarchy, identity, networking, architecture patterns, governance, learning roadmap). **This document** explains **each individual Azure resource in depth** — what it is, why it exists, how it works, how to secure and scale it, and how to use it from the CLI, Bicep, and C#.
>
> Use the two documents together:
> - Read `azure_cheatsheet.md` first to build the mental model.
> - Come to this document when you need to actually **create, configure, secure, or troubleshoot** a specific resource.

> [!IMPORTANT]
> Azure changes frequently. Names, SKUs, limits, and retirement dates shift. This document explains durable concepts and links to Microsoft Learn for anything that changes often (limits, pricing, quotas, preview status). Where something recently changed (retirements, renames, new tiers), it is called out explicitly with a verification note.

---

## 📚 Table of Contents

0. Azure resource fundamentals (read this first if you are new to Azure)
1. **Compute** — Virtual Machines, VMSS, App Service, Azure Functions, Container Apps, ACI, AKS, ACR, Azure Batch
2. **Networking** — VNet, Subnet, NIC, Public IP, NSG, ASG, Route Table, NAT Gateway, Private Endpoint/Link, Service Endpoints, VNet Peering, VPN Gateway, ExpressRoute, Azure Firewall, Application Gateway, WAF, Load Balancer, Front Door, Traffic Manager, Bastion, DNS (public/private/resolver)
3. **Storage** — Storage Account, Blob, Azure Files, Queue Storage, Table Storage, Managed Disks, Data Lake Storage Gen2
4. **Databases and caching** — Azure SQL Database, Azure SQL Managed Instance, SQL Server on Azure VM, PostgreSQL Flexible Server, MySQL Flexible Server, Cosmos DB, Azure Managed Redis
5. **Messaging and integration** — Service Bus, Event Grid, Event Hubs, Storage Queue, Logic Apps, API Management, SignalR Service, Web PubSub
6. **Identity and security** — Microsoft Entra ID, App Registration, Enterprise Application, Service Principal, Managed Identity, Key Vault, Managed HSM, Defender for Cloud, Microsoft Sentinel
7. **Monitoring and operations** — Azure Monitor, Application Insights, Log Analytics Workspace, Alerts, Action Groups, Service Health, Resource Health, Azure Advisor
8. **DevOps and deployment** — Azure Resource Manager, Bicep, ARM templates, Deployment Stacks, Azure DevOps, GitHub Actions
9. **Data and analytics** — Data Factory, Synapse Analytics, Azure Databricks, Azure Data Explorer
10. **AI** — Microsoft Foundry, Azure OpenAI, Azure AI Search, Azure Machine Learning, Document Intelligence, Speech, Language, Vision
10.5. **Additional important services** — Azure CDN, Azure Static Web Apps, Azure AI Bot Service, Azure Automation, Azure IoT Hub, plus notes on "Docker" and "API Gateway" terminology
11. Big comparison tables (decision matrices)
12. Interview / knowledge-check question bank
13. End-to-end deployment scenarios (Docker→ACR→ACI/Container Apps/AKS, VM lift-and-shift, PaaS web app + DB + Key Vault, serverless event-driven, RAG/AI app)
14. Official documentation directory

---

# 0. 🧱 Azure Resource Fundamentals

If you have never touched Azure before, start here. Every section below assumes you understand these ten ideas.

## What is an Azure "resource"?

A **resource** is a single manageable thing in Azure: one virtual machine, one storage account, one database, one virtual network. Everything you create in Azure is a resource. Azure Resource Manager (ARM) is the API layer that creates, updates, and deletes every resource — whether you use the Azure Portal, CLI, PowerShell, Bicep, Terraform, or the REST API directly; they all ultimately call the same ARM API.

## Subscription

A **subscription** is a billing and access-management boundary. It is the container that holds your resource groups. Quotas, cost, and many security boundaries are scoped per subscription. A company might have multiple subscriptions for production, non-production, and sandbox environments.

## Resource Group

A **resource group** is a logical folder inside a subscription that holds related resources (for example, everything belonging to one application). Rules to know:

- A resource group lives in a region (metadata location), but the resources inside it can be in different regions.
- Deleting a resource group deletes everything inside it — a common, dangerous mistake.
- Most RBAC role assignments and many deployments happen at resource-group scope.

## Region

A **region** is a physical Azure datacenter location (for example, `westeurope`, `eastus2`, `swedencentral`). Not every service or SKU is available in every region. Some resources are **global** (Microsoft Entra ID, Front Door, Traffic Manager); most are **regional**.

## SKU / Tier

**SKU** (stock keeping unit) describes which "version"/size/tier of a resource you are deploying — for example `Standard_D2s_v5` for a VM, or `Premium` vs `Standard` for Service Bus. SKU choice drives capability, performance, SLA, and cost. Many production mistakes come from picking the cheapest SKU without checking what capability it lacks (e.g., Basic SKUs historically lacked Availability Zone support, and some Basic SKUs are now retired entirely — see the Networking section).

## Control plane vs data plane

```text
Control plane = managing the resource itself
   "create a storage account", "change its SKU", "assign RBAC roles"
   → always goes through Azure Resource Manager (ARM)
   → secured by Azure RBAC

Data plane = using the resource's actual functionality
   "upload a blob", "send a message", "run a SQL query"
   → goes directly to the resource's own endpoint/API
   → secured by the resource's own auth model (keys, Entra ID data-plane roles, SQL auth, etc.)
```

This distinction matters constantly: having `Owner` RBAC (control plane) does **not** automatically mean you can read blob data (data plane) — Storage uses separate data-plane RBAC roles (or keys/SAS) for that reason.

## Public vs private access

Most Azure PaaS resources default to having a **public endpoint** (a public DNS name/IP). You control exposure with:

- **Firewall rules / IP allow-lists** on the resource itself (coarse-grained, still public).
- **Private Endpoint** — gives the resource a private IP address inside your VNet; traffic never touches the public internet (fine-grained, the modern recommended pattern for production).
- **Service Endpoints** — an older mechanism that routes traffic over the Azure backbone but the resource still has a public IP and endpoint.
- **Disabling public network access entirely** once private connectivity is configured.

## Managed Identity

An Azure-managed identity lets a resource (a VM, Function App, App Service, Container App, etc.) **authenticate to other Azure services without storing any secret or connection string**. Azure manages the credential rotation for you. This is the single most important modern Azure security pattern — prefer it over keys/connection strings/service principals with stored secrets whenever the workload runs inside Azure.

## RBAC (Role-Based Access Control)

Azure RBAC answers "who can do what, on which resource, at which scope." A **role assignment** = **security principal** (user, group, managed identity, service principal) + **role definition** (what actions are allowed, e.g. `Reader`, `Contributor`, `Storage Blob Data Contributor`) + **scope** (management group, subscription, resource group, or single resource).

## Tags

**Tags** are key/value metadata attached to resources (e.g., `environment=prod`, `costCenter=1234`, `owner=team-payments`). Used for cost reporting, automation, and governance — not for security (tags are not an access-control mechanism).

## Diagnostic settings

A **diagnostic setting** tells a resource where to send its logs and metrics: a Log Analytics workspace, a Storage Account (archival), or an Event Hub (streaming to a SIEM/third party). Without a diagnostic setting configured, most resource-level logs are not retained anywhere queryable.

## Resource dependencies

Resources are rarely standalone. A Virtual Machine depends on a NIC, which depends on a Subnet, which depends on a VNet. An App Service with a Private Endpoint depends on a Private DNS Zone being linked to the consuming VNet, or name resolution breaks. Understanding the **dependency chain** of a resource is often the key to debugging connectivity and deployment failures — each resource section below includes a dependency diagram for exactly this reason.

---

# 1. 🖥️ Compute

## Virtual Machines (VMs)

### 1. What is it?
An Azure Virtual Machine is a full computer running in Microsoft's datacenters — you get an operating system (Windows or Linux), CPU, memory, and disks, and you install and manage whatever software you want on it, just like a physical server.

### 2. Why does it exist?
Before cloud computing, running a server meant buying hardware, racking it, and maintaining it physically. VMs give you the same flexibility (full OS control) without owning hardware — you rent compute capacity by the minute/second.

### 3. Simple real-world analogy
Renting a fully furnished apartment: you control everything inside it (what you install, how you configure it), but the landlord (Azure) owns and maintains the building (physical hardware, power, cooling, host patching).

### 4. When should I use it?
- You need full OS-level control (custom drivers, specific OS versions, legacy software).
- Lift-and-shift migration of an existing on-prem server.
- Software that cannot run on PaaS/containers (certain licensed enterprise software, specialized agents).
- You need to run a VM-based product Azure doesn't offer as PaaS (e.g., SQL Server with OS-level access, Windows Server AD Domain Controllers).

### 5. When should I NOT use it?
- You are building a new web app/API with no special OS requirement → use **App Service**, **Container Apps**, or **Functions** instead; less operational burden.
- You want Azure to patch the OS/runtime for you — VMs make **you** responsible for OS patching, antivirus, and most security hardening.
- `BAD`: deploying a VM to run a simple stateless web API that could run on App Service with zero OS management.

### 6. Common use cases
- Legacy application migration ("lift and shift").
- SQL Server / specialized database engines requiring OS access.
- Custom network appliances (NVAs), jump boxes/bastion hosts (though prefer Azure Bastion), build agents.

### 7. How it works
```text
You choose:
  OS image (Windows/Linux, Marketplace or custom)
      ↓
  VM size (vCPU, RAM, disk/network throughput limits)
      ↓
  Azure provisions compute on a physical host, attaches disks over the storage network,
  and attaches a NIC into your chosen subnet.
      ↓
  You connect via RDP/SSH (ideally through Azure Bastion, not a public IP).
```

### 8. Important concepts
- **VM size** — the SKU (e.g., `Standard_D4s_v5`) that defines vCPU, memory, max disks, max network throughput.
- **Image** — the OS template (Marketplace, Azure Compute Gallery, or custom).
- **OS disk** — the disk holding the operating system; by default a Managed Disk.
- **Data disk** — additional attached Managed Disks for application data.
- **NIC (network interface)** — connects the VM to a subnet; carries the private IP (and optionally a Public IP).
- **Availability Set** — groups VMs across fault domains/update domains inside one datacenter (older mechanism; Availability Zones are now preferred where supported).
- **Availability Zone** — places the VM in one of several physically separate zones within a region for higher resilience.
- **VMSS (Virtual Machine Scale Set)** — a group of identical, autoscaling VMs (see below).
- **Managed Identity** — lets the VM authenticate to other Azure services without stored credentials.
- **Extensions** — small agents installed post-provisioning (e.g., Custom Script Extension, Azure Monitor Agent, antimalware).
- **Boot diagnostics** — captures console output/screenshots to diagnose boot failures.

### 9. Resource hierarchy / dependencies
```text
Subscription
└── Resource Group
    ├── Virtual Network
    │   └── Subnet
    │       └── NIC
    │           └── Virtual Machine
    ├── NSG (attached to subnet or NIC)
    ├── Public IP (optional, Standard SKU)
    └── Managed Disk(s) (OS + data)
```

### 10. Networking
- A VM's NIC lives in a subnet; its private IP comes from that subnet's address range.
- Public IP is optional and should be avoided for direct management access — use **Azure Bastion** or a VPN/ExpressRoute path instead.
- Inbound/outbound traffic is filtered by **NSGs** attached to the subnet and/or NIC.
- For outbound internet access without a public IP, use a **NAT Gateway** (recommended) rather than relying on default outbound access (default outbound access is being phased out as a reliable pattern and should not be assumed for new designs — verify current guidance).

### 11. Identity and security
- Prefer **Managed Identity** (system- or user-assigned) for the VM to call other Azure services (Key Vault, Storage) instead of embedding credentials.
- Disk encryption: Managed Disks are encrypted at rest by default (platform-managed keys); use **customer-managed keys** in Key Vault for stricter compliance needs.
- Patch management: use **Azure Update Manager** rather than manual patching.
- Avoid public RDP/SSH exposure — a top real-world breach cause.

### 12. Scaling
- **Vertical scaling**: resize the VM to a bigger/smaller SKU (requires a restart).
- **Horizontal scaling**: not native to a single VM — use a **VMSS** for that.

### 13. High availability and disaster recovery
- Single VM: no built-in redundancy — a host failure causes downtime.
- Use **Availability Zones** (deploy across 2–3 zones) or **Availability Sets** for higher resilience within a region.
- **Azure Backup** for VM-level backup/restore.
- **Azure Site Recovery** for VM-level disaster recovery/replication to a secondary region.

### 14. Monitoring and troubleshooting
- **Boot diagnostics** for startup failures.
- **Azure Monitor** VM insights, guest-level metrics via the Azure Monitor Agent.
- Common issues: NSG blocking traffic, wrong subnet route, disk full, agent/extension failures, accidental reliance on a now-retired default-outbound-access pattern.

### 15. Cost model
```text
VM cost depends mainly on:

VM size (vCPU/RAM tier)
+ running time (stop/deallocate when idle to avoid compute charges)
+ disk type and size
+ network egress
+ backup storage
+ monitoring agent data ingestion
+ Windows/SQL licensing (if applicable)
```
Use **Spot VMs** for interruptible, non-critical workloads at a lower cost; use **Azure Hybrid Benefit**/Reserved Instances/Savings Plans for predictable long-running workloads.

### 16. Common mistakes
- Leaving a public IP with RDP/SSH open to the internet.
- Forgetting to deallocate (not just "stop" in the OS) idle VMs — stopping inside the guest OS still bills compute.
- Treating a VM as "set and forget" with no patch/backup strategy.
- Using Availability Sets and Availability Zones together incorrectly (they are mutually exclusive per VM).

### 17. Production recommendations
- No public management ports; use Azure Bastion.
- Use Availability Zones where the region supports them.
- Enable Azure Backup and (for critical workloads) Site Recovery.
- Use Managed Identity, not stored credentials.
- Patch via Update Manager; monitor via Azure Monitor + Log Analytics.
- Prefer VMSS over hand-managed single VMs for anything needing scale or resilience.

### 18. Developer example
Reading a secret from Key Vault using the VM's managed identity (C#, Azure SDK):
```csharp
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;

var client = new SecretClient(
    new Uri("https://my-keyvault.vault.azure.net/"),
    new DefaultAzureCredential());

KeyVaultSecret secret = await client.GetSecretAsync("ConnectionString");
string connectionString = secret.Value;
```
`DefaultAzureCredential` automatically uses the VM's managed identity when running on Azure — no secret ever lives in your code or configuration.

### 19. Azure CLI example
```bash
az vm create \
  --resource-group my-rg \
  --name my-vm \
  --image Ubuntu2404 \
  --size Standard_D2s_v5 \
  --vnet-name my-vnet \
  --subnet my-subnet \
  --admin-username azureuser \
  --generate-ssh-keys \
  --assign-identity \
  --public-ip-address ""   # no public IP; use Bastion instead
```

### 20. Bicep example
```bicep
resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: 'my-vm'
  location: resourceGroup().location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v5'
    }
    osProfile: {
      computerName: 'my-vm'
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        { id: nic.id }
      ]
    }
  }
}
```

### 21. Comparison with similar Azure resources
See [Compute decision table](#application-hosting-decision-table) in section 11.

### 22. Interview / knowledge-check questions
- When would you choose a VM over App Service?
- How do you give a VM access to Key Vault without storing a secret?
- What is the difference between stopping and deallocating a VM?
- How do Availability Sets differ from Availability Zones?
- How do you expose SSH/RDP access safely in production?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-machines/
- https://learn.microsoft.com/azure/virtual-machines/sizes

---

## Virtual Machine Scale Sets (VMSS)

### 1. What is it?
A VMSS is a group of **identical** virtual machines that Azure creates, scales, and manages as a single unit, based on a shared configuration ("the model").

### 2. Why does it exist?
Running many identical VMs by hand (clone one-by-one, keep them in sync, manually add/remove instances) does not scale operationally. VMSS automates creation, scaling, and upgrades of a fleet of VMs.

### 3. Simple real-world analogy
A restaurant chain using one standard blueprint to open or close individual restaurant locations based on customer demand, instead of designing every location from scratch.

### 4. When should I use it?
- Stateless, horizontally scalable compute built directly on VMs (not containers).
- Custom/legacy workloads that need VM-level control but still need elastic scale.
- Backing pool for a Load Balancer or Application Gateway.

### 5. When should I NOT use it?
- If your workload is containerized — Container Apps or AKS usually give you equivalent elasticity with less VM-level operational overhead.
- `AVOID WHEN`: you need rapid, fine-grained autoscaling of application-level units rather than whole VMs — containers scale faster.

### 6. Common use cases
- Scalable web server farms behind Application Gateway.
- Stateless API tiers.
- Big compute/batch-style fleets.

### 7. How it works
```text
Scale Set "model" (VM size, image, extensions, networking)
      ↓
Azure creates N instances from the model
      ↓
Autoscale rules (CPU, memory, custom metric, schedule) add/remove instances
      ↓
Instances register behind a Load Balancer / Application Gateway backend pool
```

### 8. Important concepts
- **Instance** — one VM created from the scale set model.
- **Scaling policy** — rule-based (metric threshold) or schedule-based autoscale.
- **Upgrade policy** — Automatic, Rolling, or Manual instance updates when the model changes.
- **Flexible orchestration mode** — modern mode allowing mixed VM sizes/Availability Zones and closer parity with standalone VM features (generally recommended for new deployments).
- **Uniform orchestration mode** — older mode, identical instances, more limited flexibility.

### 9–20. Shared with Virtual Machines
Networking, identity/security, HA/DR, monitoring, cost, and CLI/Bicep patterns are the same as standalone VMs (above), applied per-instance, plus:
- **Scaling**: true horizontal autoscaling is the entire point of VMSS — define min/max instance counts and scale triggers (CPU%, custom metrics, queue length via autoscale custom metrics, or schedule-based).
- **HA/DR**: spread instances across Availability Zones for zone resilience; combine with Load Balancer health probes so unhealthy instances stop receiving traffic.

### 19. Azure CLI example
```bash
az vmss create -g my-rg -n my-vmss --image Ubuntu2204 \
  --vm-sku Standard_D2s_v5 --instance-count 3 \
  --orchestration-mode Flexible --upgrade-policy-mode Automatic \
  --admin-username azureuser --generate-ssh-keys \
  --load-balancer my-lb --backend-pool-name backend
az monitor autoscale create -g my-rg --resource my-vmss \
  --resource-type Microsoft.Compute/virtualMachineScaleSets \
  --name autoscale-cpu --min-count 2 --max-count 10 --count 3
az monitor autoscale rule create -g my-rg --autoscale-name autoscale-cpu \
  --condition "Percentage CPU > 70 avg 5m" --scale out 2
```

### 20. Bicep example
```bicep
resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2024-07-01' = {
  name: 'my-vmss'
  location: resourceGroup().location
  sku: { name: 'Standard_D2s_v5', tier: 'Standard', capacity: 3 }
  properties: {
    orchestrationMode: 'Flexible'
    upgradePolicy: { mode: 'Automatic' }
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: 'vmss'
        adminUsername: 'azureuser'
        linuxConfiguration: { disablePasswordAuthentication: true }
      }
      storageProfile: {
        imageReference: {
          publisher: 'Canonical', offer: '0001-com-ubuntu-server-jammy'
          sku: '22_04-lts', version: 'latest'
        }
      }
      networkProfile: {
        networkInterfaceConfigurations: [{
          name: 'nic1'
          properties: {
            primary: true
            ipConfigurations: [{
              name: 'ipconfig1'
              properties: { subnet: { id: subnetId } }
            }]
          }
        }]
      }
    }
  }
}

resource autoscaleSetting 'Microsoft.Insights/autoscalesettings@2022-10-01' = {
  name: 'autoscale-cpu'
  location: resourceGroup().location
  properties: {
    targetResourceUri: vmss.id
    enabled: true
    profiles: [{
      name: 'default'
      capacity: { minimum: '2', maximum: '10', default: '3' }
      rules: [{
        metricTrigger: {
          metricName: 'Percentage CPU'
          metricResourceUri: vmss.id
          timeGrain: 'PT1M', statistic: 'Average', timeWindow: 'PT5M'
          timeAggregation: 'Average', operator: 'GreaterThan', threshold: 70
        }
        scaleAction: { direction: 'Increase', type: 'ChangeCount', value: '2', cooldown: 'PT5M' }
      }]
    }]
  }
}
```

### 21. Comparison with similar Azure resources
| Requirement | VMSS | Container Apps | AKS |
|---|---|---|---|
| Full OS control | Yes | No | Partial (node level only) |
| Fastest scale-out | Minutes (VM boot time) | Seconds | Seconds (pod), minutes (node) |
| Operational overhead | Medium-high (OS patching) | Low | High |

### 22. Interview / knowledge-check questions
- How does Flexible orchestration mode differ from Uniform?
- What triggers scale-out in a VMSS?
- How would you safely roll out an OS image update across a scale set?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-machine-scale-sets/

---

## App Service

### 1. What is it?
Azure App Service is a fully managed platform for hosting web apps, REST APIs, and mobile backends. You deploy your code (or container), and Azure handles the OS, runtime patching, load balancing, and scaling infrastructure.

### 2. Why does it exist?
Most web applications don't need VM-level control — they need their code to run reliably, scale, and be reachable over HTTPS. App Service removes the OS/infrastructure management burden entirely.

### 3. Simple real-world analogy
Renting a serviced office: you bring your business (code), and the building manager (Azure) handles power, cleaning, security, and maintenance (OS patching, infrastructure).

### 4. When should I use it?
- Standard web apps/APIs (ASP.NET Core, Node.js, Java, Python, PHP, or custom containers).
- You want built-in deployment slots, easy custom domains/TLS, and autoscaling without managing servers.

### 5. When should I NOT use it?
- Short-lived, event-triggered workloads with sporadic traffic → **Functions** is usually cheaper.
- You need full container orchestration (sidecars, custom networking inside the pod, operators) → **Container Apps** or **AKS**.
- `AVOID WHEN`: the workload needs no HTTP endpoint at all (pure background processing) — consider Functions, Container Apps jobs, or Batch.

### 6. Common use cases
- Line-of-business web apps and APIs.
- Static + API backend combos (App Service for API, Static Web Apps for a SPA frontend).
- Multi-slot blue/green deployments.

### 7. How it works
```text
Internet
   ↓
App Service (public or private endpoint)
   ↓
App Service Plan (the underlying compute: VM size + instance count)
   ↓
Your code/container runs on that shared or dedicated compute
```

### 8. Important concepts
- **App Service Plan** — the compute tier (SKU) and instance count that hosts one or more Apps; determines cost, scaling limits, and available features (e.g., VNet integration requires at least a Basic/Standard+ plan tier for some features, Premium for others — verify current tier feature matrix).
- **Deployment slots** — separate staging environments (e.g., `staging`) that can be swapped into production with near-zero downtime; available on Standard tier and above.
- **Always On** — keeps the app warm, preventing idle unload (needed for background/webjobs and to avoid cold starts).
- **Easy Auth (App Service Authentication)** — built-in authentication middleware for Entra ID and other identity providers without writing auth code.
- **VNet Integration (outbound)** — lets the app reach resources inside a VNet.
- **Private Endpoint (inbound)** — gives the app itself a private IP, removing public inbound exposure.

### 9. Resource hierarchy / dependencies
```text
Subscription
└── Resource Group
    └── App Service Plan
        └── App Service (Web App)
            ├── Custom domain + managed certificate
            ├── VNet Integration (outbound)
            ├── Private Endpoint (inbound, optional)
            └── Managed Identity
```

### 10. Networking
- Public by default; lock down with **access restrictions**, **Private Endpoint**, or put it behind **Front Door/Application Gateway** with public access disabled directly on the app.
- **VNet Integration** (outbound only) lets the app call private resources (databases, internal APIs) inside a VNet.
- Private Endpoint (inbound) requires a Private DNS Zone (`privatelink.azurewebsites.net`) linked to consuming VNets.

### 11. Identity and security
- Use **Managed Identity** to call Key Vault, Storage, SQL, etc.
- Store secrets in Key Vault, referenced via Key Vault references in app settings — not hardcoded connection strings.
- Enforce HTTPS-only and a minimum TLS version.

### 12. Scaling
- **Vertical**: change the App Service Plan SKU.
- **Horizontal**: increase instance count manually or via autoscale rules (CPU, memory, schedule) — all apps on the same plan scale together.

### 13. High availability and disaster recovery
- Deploy the plan across **Availability Zones** (zone-redundant, requires Premium v3/compatible SKUs and multiple instances).
- Multi-region: deploy a second App Service in another region behind Front Door/Traffic Manager for regional failover.
- Use deployment slots for safe rollout, not for DR.

### 14. Monitoring and troubleshooting
- **Application Insights** for request/dependency/exception telemetry.
- **Log stream** / `az webapp log tail` for live logs.
- Common issues: missing app settings, cold start after idle (if Always On is off), outbound dependency timeouts, TLS/cert mismatches on custom domains.

### 15. Cost model
```text
App Service cost depends mainly on:

App Service Plan SKU and instance count (this is what you actually pay for;
multiple apps can share one plan at no extra compute cost)
+ scale-out instance count
+ outbound bandwidth
+ custom domain/cert extras (usually free via managed certificates)
+ Application Insights ingestion
```

### 16. Common mistakes
- Putting one app per plan when several low-traffic apps could share a plan.
- Forgetting "Always On," causing idle unload and cold starts.
- Storing secrets in plain app settings instead of Key Vault references.
- Assuming deployment slots provide disaster recovery (they don't — same region, same plan).

### 17. Production recommendations
- Use deployment slots for blue/green releases.
- Use Managed Identity + Key Vault references for all secrets.
- Enable zone redundancy for production-critical apps.
- Put Application Insights in front of every app.
- Restrict public access with Private Endpoint or Front Door-only access patterns.

### 18. Developer example
`Program.cs` using Managed Identity to read a Key Vault secret and connect to Azure SQL with Entra authentication:
```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Configuration.AddAzureKeyVault(
    new Uri("https://my-keyvault.vault.azure.net/"),
    new DefaultAzureCredential());

builder.Services.AddDbContext<OrdersContext>(options =>
    options.UseSqlServer(builder.Configuration["SqlConnectionString"]));

var app = builder.Build();
app.MapGet("/health", () => Results.Ok("healthy"));
app.Run();
```

### 19. Azure CLI example
```bash
az appservice plan create -g my-rg -n my-plan --sku P1v3 --is-linux
az webapp create -g my-rg -p my-plan -n my-app --runtime "DOTNETCORE:9.0"
az webapp identity assign -g my-rg -n my-app
az webapp deployment slot create -g my-rg -n my-app -s staging
```

### 20. Bicep example
```bicep
resource plan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'my-plan'
  location: resourceGroup().location
  sku: {
    name: 'P1v3'
    tier: 'PremiumV3'
  }
}

resource app 'Microsoft.Web/sites@2023-12-01' = {
  name: 'my-app'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
      netFrameworkVersion: 'v9.0'
    }
  }
}
```

### 21. Comparison with similar Azure resources
See [Application hosting decision table](#application-hosting-decision-table).

### 22. Interview / knowledge-check questions
- How do deployment slots reduce deployment risk?
- How does an App Service call Key Vault securely?
- What's the difference between VNet Integration and Private Endpoint on App Service?
- When would zone redundancy matter for App Service?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/app-service/

---

## App Service Plan

### 1–3. What/why/analogy
The App Service Plan is the **compute container** behind one or more App Service apps — think of it as the apartment building; each app is an apartment. You don't pay per app, you pay for the building (the plan's SKU and instance count).

### 4–6. When to use / not use / use cases
Always required with App Service — you cannot create an App Service without one. The decision is **which SKU/tier** (Free/Shared for dev-test only, Basic for light dev/test, Standard for slots+autoscale, Premium v3 for production, Isolated v2 for dedicated/App Service Environment network isolation).

### 8. Important concepts
- **Tier** determines: custom domains, deployment slots, autoscale, VNet integration, zone redundancy availability.
- Multiple apps on one plan **share** its compute/instances — a noisy app can starve others on the same plan.
- **App Service Environment (ASE) / Isolated v2** — a dedicated, fully isolated deployment of App Service inside your own VNet, for the strictest network isolation requirements.

### 12–17. Scaling, HA, cost, mistakes, production
- Scaling and zone redundancy are configured on the plan, not the individual app.
- Common mistake: co-locating a bursty/noisy app on the same plan as a latency-sensitive production app.
- Production: size the plan for peak load of **all** apps hosted on it combined, and monitor plan-level CPU/memory, not just one app's metrics.

### 20. Bicep example
```bicep
resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'my-asp'
  location: resourceGroup().location
  sku: { name: 'P1v3', tier: 'PremiumV3', capacity: 1 }
  properties: { reserved: true } // true = Linux
  // Zone redundancy for production:
  // properties: { reserved: true, zoneRedundant: true }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/app-service/overview-hosting-plans

---

## Azure Functions

### 1. What is it?
Azure Functions is Azure's serverless compute service: you write small, focused pieces of code ("functions") that run **in response to an event** — an HTTP call, a new message in a queue, a new blob, a timer — and Azure runs, scales, and bills them automatically.

### 2. Why does it exist?
Many workloads are **event-driven and bursty**, not constantly running web servers. Functions lets you pay only when code actually executes and lets Azure handle all scaling, without you provisioning servers or containers up front.

### 3. Simple real-world analogy
A vending machine: it does nothing until someone presses a button (an event/trigger), then it performs one action and goes idle again — you don't pay rent on it sitting idle (on the Consumption plan).

### 4. When should I use it?
- Event-triggered processing: a file lands in Blob Storage, a message arrives on a Service Bus queue, a schedule fires.
- Lightweight APIs with spiky, unpredictable traffic.
- Gluing Azure services together (e.g., Event Grid → Function → Cosmos DB).

### 5. When should I NOT use it?
- Long-running, constantly-busy backend services with steady load → App Service or Container Apps are usually more cost-effective and avoid execution-time limits.
- Workloads needing full control over the runtime/container (custom network sidecars, non-HTTP long-lived protocols) → Container Apps/AKS.
- `AVOID WHEN`: you need guaranteed low-latency with zero cold start on the cheapest plan — use Premium/Flex Consumption with always-ready instances, or another hosting model.

### 6. Common use cases
- Image/file processing pipelines (Blob trigger).
- Scheduled cleanup/reporting jobs (Timer trigger).
- API backends for lightweight, bursty traffic (HTTP trigger).
- Event-driven integration glue (Event Grid/Service Bus/Event Hubs triggers).
- Durable Functions for multi-step orchestration (approvals, long-running workflows).

### 7. How it works
```text
Event source (HTTP call / queue message / blob / timer / Event Grid)
      ↓
Trigger fires → Functions host allocates an instance (if needed)
      ↓
Your function code runs
      ↓
Output binding (optional) writes a result (e.g., to a queue, Cosmos DB, blob)
```

### 8. Important concepts
- **Function App** — the deployable unit; hosts one or more individual functions and shares one hosting plan/runtime/configuration.
- **Function** — a single unit of code triggered by one event source.
- **Trigger** — what starts the execution (exactly one per function).
- **Input binding** — declarative way to receive additional data without writing SDK boilerplate.
- **Output binding** — declarative way to send a result somewhere (queue, Cosmos DB, blob) without writing SDK boilerplate.
- **Hosting plan** — Consumption, Flex Consumption, Premium, Dedicated, or Container Apps-hosted (see table below).
- **Cold start** — the latency penalty when a new instance must start from zero because none were warm; mainly affects Consumption plan.
- **Durable Functions** — an extension for stateful orchestration across multiple function calls (chaining, fan-out/fan-in, human interaction, long-running workflows) with automatic checkpointing.
- **Managed Identity** — used by the Function App to call Key Vault/Storage/SQL securely.

### Hosting plans (detail)
| Plan | Scale speed | Cold start | VNet | Max execution time | Best for |
|---|---|---|---|---|---|
| Consumption | Event-driven | Possible | Limited | Bounded (minutes-scale) | Lowest cost, spiky/low-volume |
| Flex Consumption | Fast, per-instance concurrency | Reduced | Yes | Longer than classic Consumption | Modern default for most new serverless apps |
| Premium | Pre-warmed + elastic | Minimal | Yes | Long-running supported | Steady + VNet + no cold start |
| Dedicated (App Service plan) | Manual/autoscale | None (always on) | Yes | Unbounded | Predictable load, shared plan |

> Verify current execution-time limits and regional availability for Flex Consumption on Microsoft Learn before committing to a design — these details change.

### 9. Resource hierarchy / dependencies
```text
Subscription
└── Resource Group
    ├── Storage Account (required — Functions runtime state/triggers)
    ├── Hosting plan (Consumption / Flex Consumption / Premium / App Service Plan)
    └── Function App
        ├── Individual functions (HTTP, Timer, Queue, Blob, Service Bus, ...)
        ├── Managed Identity
        └── Application Insights (recommended)
```

### 10. Networking
- Consumption plan has limited VNet integration support; Premium/Flex Consumption/Dedicated support full VNet integration for outbound calls to private resources.
- Inbound Private Endpoint is supported on Premium/Dedicated/ASE-hosted plans (verify current Flex Consumption support).
- Public HTTP trigger endpoints should be restricted via Private Endpoint, API Management, Front Door, or IP restrictions in production.

### 11. Identity and security
- Use **Managed Identity** for all downstream Azure calls.
- Protect HTTP-triggered functions with function keys (legacy), Entra ID auth (Easy Auth), or front them with API Management — avoid relying on function keys alone for production-grade security.
- Store all connection strings/secrets in Key Vault.

### 12. Scaling
- Consumption/Flex Consumption scale automatically based on the rate of incoming events, from zero to many instances.
- Premium/Dedicated scale via configured min/max instance counts and autoscale rules.
- Scaling is **per Function App**, not per individual function.

### 13. High availability and disaster recovery
- Deploy across Availability Zones where the plan/region supports it (Premium plan zone redundancy).
- For DR, deploy a second Function App in another region behind a routing layer (Front Door/Traffic Manager) for critical workloads.

### 14. Monitoring and troubleshooting
- **Application Insights** is the primary tool — live metrics, invocation traces, exceptions, dependency calls.
- Common issues: missing/incorrect bindings configuration, storage account connectivity problems, cold-start latency misdiagnosed as a bug, retry/duplicate execution issues from at-least-once trigger semantics.

### 15. Cost model
```text
Functions cost depends mainly on:

Plan type (Consumption = pay per execution + GB-seconds;
Premium/Dedicated = pay for allocated instances regardless of invocation count)
+ number of executions (Consumption/Flex Consumption)
+ execution duration × memory
+ storage account transactions
+ Application Insights ingestion
```

### 16. Common mistakes
- Not designing triggers to be **idempotent** — triggers can redeliver/retry, causing duplicate processing.
- Ignoring **cold start** in latency-sensitive HTTP APIs on Consumption plan.
- Using Functions for long-running synchronous processes that exceed plan execution-time limits.
- Not using Durable Functions for genuinely multi-step stateful workflows, leading to fragile hand-rolled orchestration.

### 17. Production recommendations
- Design every trigger handler to be idempotent (duplicate-safe).
- Use Managed Identity + Key Vault for all secrets.
- Use Application Insights with alerting on failure rate and duration.
- Choose Premium or Flex Consumption when you need VNet integration or predictable latency.
- Use Durable Functions for orchestration instead of chaining functions manually via queues when state/retries must be tracked.

### 18. Developer example
An HTTP-triggered function (isolated worker model, .NET) that reads a Service Bus message and writes a result via output binding:
```csharp
public class OrderFunctions
{
    private readonly ILogger<OrderFunctions> _logger;
    public OrderFunctions(ILogger<OrderFunctions> logger) => _logger = logger;

    [Function("ProcessOrder")]
    [ServiceBusOutput("processed-orders", Connection = "ServiceBusConnection")]
    public string Run(
        [ServiceBusTrigger("orders", Connection = "ServiceBusConnection")] string message)
    {
        _logger.LogInformation("Processing order: {Message}", message);
        return message; // written to the "processed-orders" queue via the output binding
    }
}
```

### 19. Azure CLI example
```bash
az storage account create -g my-rg -n myfuncstorage --sku Standard_LRS
az functionapp create -g my-rg -n my-func-app \
  --storage-account myfuncstorage \
  --consumption-plan-location westeurope \
  --runtime dotnet-isolated --functions-version 4
az functionapp identity assign -g my-rg -n my-func-app
```

### 20. Bicep example
```bicep
resource funcApp 'Microsoft.Web/sites@2023-12-01' = {
  name: 'my-func-app'
  location: resourceGroup().location
  kind: 'functionapp'
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      appSettings: [
        { name: 'FUNCTIONS_WORKER_RUNTIME', value: 'dotnet-isolated' }
        { name: 'AzureWebJobsStorage__accountName', value: storageAccount.name }
      ]
    }
  }
}
```

### 21. Comparison with similar Azure resources
See [Functions vs Logic Apps](#functions-vs-logic-apps) and [Functions vs Container Apps](#functions-vs-container-apps) below.

### 22. Interview / knowledge-check questions
- What is the difference between a trigger and a binding?
- Why must event-handling functions be idempotent?
- When would you choose Durable Functions over chaining functions with queues?
- What causes cold start, and how do you mitigate it?
- When would Premium or Flex Consumption be required over Consumption?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-functions/
- https://learn.microsoft.com/azure/azure-functions/flex-consumption-plan
- https://learn.microsoft.com/azure/azure-functions/durable/

---

## Azure Container Registry (ACR)

### 1. What is it?
A private registry for storing and distributing container images (and OCI artifacts like Helm charts) inside Azure, similar to a private Docker Hub.

### 2. Why does it exist?
You need a trusted, private, fast place to push images your pipelines build and your compute (AKS, Container Apps, App Service, ACI) pulls from — public registries are unsuitable for private/production images.

### 4. When should I use it?
Any time you deploy containers in Azure — ACR is almost always the registry backing AKS, Container Apps, ACI, or App Service for Containers.

### 5. When should I NOT use it?
If organizational policy mandates a different registry (e.g., GitHub Container Registry, Docker Hub Business) — ACR still integrates, but isn't required.

### 8. Important concepts
- **Repository** — a named collection of image tags (e.g., `myapp`).
- **SKU** — Basic/Standard/Premium; Premium adds geo-replication, higher throughput, Private Endpoint support, and content trust.
- **Geo-replication** (Premium) — a single registry resource replicated across multiple regions for low-latency pulls and resilience.
- **Tasks / ACR Tasks** — can build images in Azure on a git push or base-image update.
- **Managed Identity pull** — AKS/Container Apps/App Service can pull images using managed identity instead of registry admin credentials.

### 10. Networking
Public by default; use **Private Endpoint** (Premium SKU) to restrict pulls/pushes to a VNet for production.

### 11. Identity and security
- Disable the admin account; use **Microsoft Entra**-based / managed-identity authentication (`AcrPull`/`AcrPush` roles) instead.
- Enable **Microsoft Defender for Containers** vulnerability scanning on pushed images.

### 15. Cost model
```text
ACR cost depends mainly on:
SKU tier + storage used + geo-replication regions + build minutes (ACR Tasks)
```

### 16. Common mistakes
- Leaving the legacy admin account enabled and sharing its credentials.
- Not scanning images for vulnerabilities before deployment.

### 19. Azure CLI example
```bash
az acr create -g my-rg -n myregistry --sku Premium
az acr login --name myregistry
az aks update -g my-rg -n my-cluster --attach-acr myregistry
```

### 20. Bicep example
```bicep
resource acr 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: 'myregistry'
  location: resourceGroup().location
  sku: { name: 'Premium' }
  properties: {
    adminUserEnabled: false
    publicNetworkAccess: 'Disabled' // Premium SKU required for Private Endpoint use
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/container-registry/

---

## Azure Container Instances (ACI)

### 1. What is it?
ACI runs a single container (or a small group of containers) directly on Azure, with no VM and no orchestrator to manage — the fastest way to run "just a container" in Azure.

### 2. Why does it exist?
Sometimes you need a container to run for a short task (a batch job, a CI/CD build step, a one-off script) without standing up a cluster or app platform.

### 3. Simple real-world analogy
A taxi vs owning a car and a parking garage (AKS): you get a single ride (one container's worth of compute) exactly when you need it, with none of the fleet-management overhead.

### 4. When should I use it?
- Simple burst compute: a single container, short-lived job, CI/CD agent, or a sidecar used by another Azure service (e.g., Logic Apps container actions).
- Prototyping container workloads before investing in Container Apps/AKS.

### 5. When should I NOT use it?
- Multi-container applications needing service discovery, scaling policies, revisions, or ingress — use **Container Apps** instead.
- `AVOID WHEN`: you need autoscaling based on HTTP/queue load — ACI has no built-in autoscaler.

### 8. Important concepts
- **Container group** — one or more containers scheduled together on the same host, sharing network/storage (similar to a Kubernetes pod).
- **Restart policy** — Always / Never / OnFailure.

### 12. Scaling
No native autoscaling — you create/delete container groups programmatically if you need "scale."

### 15. Cost model
```text
ACI cost depends mainly on:
vCPU + memory allocated × running duration (per-second billing)
```

### 19. Azure CLI example
```bash
az container create -g my-rg -n my-container \
  --image myregistry.azurecr.io/myapp:1.0 \
  --registry-login-server myregistry.azurecr.io \
  --assign-identity --cpu 1 --memory 1.5 \
  --ports 80 --ip-address Public --restart-policy OnFailure
```

### 20. Bicep example
```bicep
resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: 'my-container'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
  properties: {
    osType: 'Linux'
    restartPolicy: 'OnFailure'
    imageRegistryCredentials: [] // omitted when using managed identity + AcrPull role
    containers: [{
      name: 'my-app'
      properties: {
        image: 'myregistry.azurecr.io/myapp:1.0'
        ports: [{ port: 80 }]
        resources: { requests: { cpu: 1, memoryInGB: 1 } }
      }
    }]
    ipAddress: { type: 'Public', ports: [{ protocol: 'Tcp', port: 80 }] }
  }
}
```

### 21. Comparison with similar Azure resources
| Requirement | ACI | Container Apps | AKS |
|---|---|---|---|
| Orchestration features (scaling, revisions, ingress) | No | Yes | Yes (full) |
| Setup complexity | Lowest | Low | Highest |
| Best for | One-off/short container tasks | Microservices, event-driven apps | Complex, large-scale container platforms |

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/container-instances/

---

## Azure Container Apps (and Container Apps Environment)

### 1. What is it?
Azure Container Apps is a fully managed serverless container platform built on Kubernetes, KEDA, Dapr, and Envoy — but you never see or manage the underlying Kubernetes API. You deploy a container image and get autoscaling (including scale-to-zero), revisions, and HTTP/event-driven scaling out of the box.

### 2. Why does it exist?
Many teams want the benefits of containers and Kubernetes-style scaling (event-driven autoscale, microservices, Dapr sidecars) **without** operating a Kubernetes cluster. Container Apps fills the gap between App Service (no containers-native orchestration) and AKS (full control, full operational burden).

### 3. Simple real-world analogy
A serviced, modular office suite built on top of a skyscraper's shared infrastructure: you get elevators, power, and security (the underlying platform) without owning or managing the building.

### 4. When should I use it?
- Microservices and event-driven APIs that need to scale on HTTP traffic, queue depth, or custom KEDA scalers.
- Background processing jobs packaged as containers.
- Teams that want containers without Kubernetes YAML/operational burden.

### 5. When should I NOT use it?
- You need direct Kubernetes API access, custom operators/CRDs, or very fine-grained node/network control → **AKS**.
- `AVOID WHEN`: the workload has no container packaging and a simple code deploy to App Service/Functions would be simpler.

### 6. Common use cases
- Event-driven microservices (Service Bus/Event Hubs consumers that scale with KEDA).
- Internal APIs and background workers sharing one Container Apps Environment.
- Dapr-based service-to-service communication, pub/sub, and state management without writing that plumbing yourself.

### 7. How it works
```text
Container Apps Environment (shared, secure boundary: networking, logging, Dapr)
      ↓
Container App (your image + scaling rules + revisions)
      ↓
Ingress (HTTP) or event trigger (KEDA scaler) determines instance count,
including scaling down to zero when idle
```

### 8. Important concepts
- **Container Apps Environment** — the secure boundary (like a mini invisible Kubernetes cluster) multiple Container Apps share: one VNet, one Log Analytics workspace, one Dapr configuration.
- **Revision** — an immutable snapshot of a Container App's configuration; supports blue/green and traffic-splitting between revisions.
- **Scale rule** — HTTP concurrency, CPU/memory, or KEDA-based custom scalers (queue length, Event Hubs, etc.), including **scale to zero**.
- **Dapr integration** — optional sidecar providing service invocation, state management, pub/sub, bindings, without you writing that infrastructure code.
- **Workload profiles** — Consumption (serverless, pay-per-use) vs Dedicated (reserved VM-backed compute) profiles within the same environment, letting you mix serverless and dedicated workloads.
- **Jobs** — run-to-completion container executions (manual, scheduled, or event-driven), distinct from long-running apps.

### 9. Resource hierarchy / dependencies
```text
Subscription
└── Resource Group
    └── Container Apps Environment
        ├── VNet integration (subnet)
        ├── Log Analytics workspace
        └── Container App(s)
            ├── Revisions
            ├── Scale rules
            └── Managed Identity
```

### 10. Networking
- The Environment can be deployed into your own VNet subnet for private networking and to reach internal resources.
- Ingress can be external (public) or internal-only (VNet-only).
- Private Endpoint can further restrict the Environment's own inbound access in internal-ingress scenarios.

### 11. Identity and security
- Managed Identity (system or user-assigned) per Container App for calling Key Vault/Storage/databases.
- Secrets can be stored as Container Apps secrets (environment-scoped) or, preferably, referenced from Key Vault.

### 12. Scaling
- **Scale-to-zero** is a defining feature for Consumption workload profile apps — you pay nothing when there is no traffic/events.
- Scale rules can combine HTTP concurrency and custom KEDA scalers (e.g., Service Bus queue length).

### 13. High availability and disaster recovery
- Spread the Environment's workload profiles across Availability Zones where supported.
- For DR, deploy a second Environment in another region behind Front Door/Traffic Manager.

### 14. Monitoring and troubleshooting
- Logs/metrics flow to the Environment's Log Analytics workspace by default.
- Use `az containerapp logs show` or the portal's Log stream; check revision-level traffic split if a bad revision is receiving traffic.

### 15. Cost model
```text
Container Apps cost depends mainly on:
vCPU-seconds and GiB-seconds actually consumed (Consumption profile)
+ reserved compute (Dedicated workload profiles)
+ Log Analytics ingestion
```

### 16. Common mistakes
- Treating one Container Apps Environment as a hard multi-tenant security boundary without verifying current isolation guarantees for your compliance needs.
- Forgetting that scale-to-zero means the **first** request after idle pays a cold-start cost.
- Not using Dapr when it would eliminate significant hand-written retry/pub-sub code.

### 17. Production recommendations
- Use separate Container Apps Environments for clearly separated trust boundaries (e.g., prod vs non-prod).
- Use revisions + traffic splitting for safe rollouts.
- Combine KEDA scalers with Service Bus/Event Hubs for true event-driven elastic workloads.

### 18. Developer example
A minimal ASP.NET Core container `Program.cs` exposing a health endpoint, deployed as a Container App image:
```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => "Hello from Container Apps");
app.MapGet("/health", () => Results.Ok());
app.Run();
```

### 19. Azure CLI example
```bash
az containerapp env create -g my-rg -n my-env --location westeurope
az containerapp create -g my-rg -n my-app \
  --environment my-env \
  --image myregistry.azurecr.io/my-app:latest \
  --ingress external --target-port 8080 \
  --min-replicas 0 --max-replicas 10
```

### 20. Bicep example
```bicep
resource env 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: 'my-env'
  location: resourceGroup().location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalytics.properties.customerId
        sharedKey: logAnalytics.listKeys().primarySharedKey
      }
    }
  }
}

resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: 'my-app'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
  properties: {
    managedEnvironmentId: env.id
    configuration: {
      ingress: { external: true, targetPort: 8080 }
    }
    template: {
      containers: [
        { name: 'app', image: 'myregistry.azurecr.io/my-app:latest' }
      ]
      scale: { minReplicas: 0, maxReplicas: 10 }
    }
  }
}
```

### 21. Comparison with similar Azure resources
See [AKS vs Container Apps](#aks-vs-container-apps) below.

### 22. Interview / knowledge-check questions
- What problem does Container Apps solve that App Service cannot?
- What is a Container Apps Environment, and what do Container Apps inside it share?
- How does scale-to-zero affect latency for the first request?
- When would you choose AKS over Container Apps?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/container-apps/

---

## Azure Kubernetes Service (AKS)

### 1. What is it?
AKS is Azure's managed Kubernetes service: Azure runs and patches the Kubernetes control plane for you, while you manage (or let AKS Automatic manage) the worker nodes that run your containerized workloads.

### 2. Why does it exist?
Kubernetes is the industry-standard container orchestrator, but operating the control plane (etcd, API server, scheduler) yourself is complex. AKS removes that burden while giving you the full Kubernetes API and ecosystem.

### 3. Simple real-world analogy
Leasing an entire, fully-equipped industrial facility where you still decide the production lines, machines, and schedules (Kubernetes objects), but the landlord (Azure) maintains the building's core infrastructure (control plane).

### 4. When should I use it?
- You genuinely need the Kubernetes API/ecosystem: Helm charts, operators, CRDs, service meshes, complex multi-team multi-tenant platforms.
- You are standardizing on Kubernetes across clouds/on-prem for portability.
- You need fine-grained control over networking, node pools, and scheduling that Container Apps does not expose.

### 5. When should I NOT use it?
- Your team doesn't want to own Kubernetes operational complexity (upgrades, node pools, networking, RBAC) → **Container Apps** usually solves the same business problem with far less overhead.
- `AVOID WHEN`: you are choosing AKS "because it's the default enterprise choice" rather than because you need its specific capabilities.

### 6. Common use cases
- Large-scale microservice platforms with many teams/namespaces.
- Workloads requiring custom controllers/operators or service mesh.
- Machine learning/GPU workloads scheduled via Kubernetes-native tooling.

### 7. How it works
```text
Azure-managed control plane (API server, etcd, scheduler) — you don't manage this
      ↓
Node pool(s) (VMs or VMSS running the kubelet) — you (or AKS Automatic) manage these
      ↓
Pods scheduled onto nodes, grouped by Deployments/Services/Ingress
      ↓
Cluster networking (Azure CNI/kubenet/Overlay) connects pods to the VNet
```

### 8. Important concepts
- **Node pool** — a group of VMs (nodes) of the same size/config running your pods; you can have multiple pools (e.g., system pool + GPU pool).
- **AKS Automatic** — a newer cluster SKU where Microsoft manages node provisioning, scaling, security defaults, and networking choices for you, reducing day-2 operational burden; recommended as the default starting point unless you need Standard's full control.
- **AKS Standard (Base)** — the traditional model where you fully control node pools, networking, and most add-ons.
- **Pod** — the smallest deployable unit (one or more tightly coupled containers).
- **Deployment / Service / Ingress** — standard Kubernetes objects for rollout, stable networking, and external HTTP routing.
- **Cluster Autoscaler** — adds/removes **nodes** based on pending pod demand.
- **Horizontal Pod Autoscaler (HPA)** — adds/removes **pods** based on CPU/memory/custom metrics.
- **Managed identity (kubelet identity / workload identity)** — lets pods and the cluster authenticate to Azure services without stored secrets (workload identity federation is the modern pattern, replacing the older pod-identity preview feature).
- **Container Insights** — AKS-specific monitoring built on Azure Monitor/Log Analytics.

### 9. Resource hierarchy / dependencies
```text
Subscription
└── Resource Group
    └── AKS Cluster
        ├── System node pool (required)
        ├── User node pool(s) (optional, workload-specific)
        ├── VNet/subnet (Azure CNI) or managed networking (kubenet/Overlay)
        ├── Azure Container Registry (attached for image pulls)
        └── Log Analytics workspace (Container Insights)
```

### 10. Networking
- **Azure CNI Overlay** (modern default) assigns pod IPs from an overlay space, conserving VNet address space versus classic Azure CNI.
- **kubenet** (legacy) uses NAT for pod traffic; generally superseded by Overlay for new designs — verify current recommendation.
- **Private cluster** mode hides the Kubernetes API server behind a private endpoint instead of a public IP.
- Ingress controllers (NGINX, Application Gateway Ingress Controller/AGIC, or Istio-based) handle external HTTP(S) traffic into the cluster.

### 11. Identity and security
- Use **Microsoft Entra Workload Identity** so pods authenticate to Azure resources (Key Vault, Storage, databases) without secrets.
- Use **Azure RBAC for Kubernetes Authorization** to manage `kubectl`-level access via Entra ID groups instead of local Kubernetes RBAC alone.
- Enable **Microsoft Defender for Containers** for runtime threat detection.

### 12. Scaling
- **Cluster Autoscaler** scales nodes; **HPA**/**KEDA** scale pods; AKS Automatic can automate much of this end-to-end.
- Use **node pool taints/tolerations** to dedicate specific pools to specific workloads (e.g., GPU).

### 13. High availability and disaster recovery
- Spread node pools across **Availability Zones**.
- Use the **Uptime SLA** (or AKS Automatic's built-in guarantees) for a financially backed control-plane SLA.
- Multi-region DR requires a second cluster and application-level/data-level replication — AKS itself does not replicate across regions.

### 14. Monitoring and troubleshooting
- **Container Insights** for pod/node metrics and logs.
- `kubectl describe`/`kubectl logs`/`kubectl get events` for in-cluster troubleshooting.
- Common issues: image pull failures (ACR auth/network), pending pods (no node capacity → check Cluster Autoscaler/quota), CrashLoopBackOff (app misconfiguration), DNS resolution issues (CoreDNS), network policy blocking traffic.

### 15. Cost model
```text
AKS cost depends mainly on:
Node pool VM sizes × node count × running time
+ Uptime SLA tier (if selected)
+ Load Balancer/Application Gateway
+ Log Analytics ingestion (Container Insights)
(the managed control plane itself is typically free or low-cost — verify current pricing)
```

### 16. Common mistakes
- Treating AKS as "just set up and forget" — cluster/node OS upgrades are an ongoing operational responsibility (less so with AKS Automatic).
- Running everything in the default namespace with no RBAC/network policy boundaries.
- Not setting resource requests/limits, leading to noisy-neighbor pod scheduling problems.
- Choosing AKS when Container Apps would have solved the requirement with far less operational burden.

### 17. Production recommendations
- Start with **AKS Automatic** unless you have a specific reason for full Standard control.
- Use Workload Identity, not stored secrets, in every pod.
- Separate workloads by namespace + Network Policy + RBAC.
- Set resource requests/limits on every deployment.
- Plan and test cluster/node upgrades; don't let them pile up.

### 18. Developer example
A minimal Kubernetes Deployment manifest for a .NET container, using workload identity annotation:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: orders-api
spec:
  replicas: 3
  selector:
    matchLabels: { app: orders-api }
  template:
    metadata:
      labels: { app: orders-api, azure.workload.identity/use: "true" }
    spec:
      serviceAccountName: orders-api-sa
      containers:
        - name: orders-api
          image: myregistry.azurecr.io/orders-api:latest
          resources:
            requests: { cpu: "250m", memory: "256Mi" }
            limits: { cpu: "500m", memory: "512Mi" }
```

### 19. Azure CLI example
```bash
az aks create -g my-rg -n my-cluster \
  --enable-managed-identity \
  --node-count 3 \
  --network-plugin azure --network-plugin-mode overlay \
  --enable-addons monitoring \
  --generate-ssh-keys
az aks get-credentials -g my-rg -n my-cluster
```

### 20. Bicep example
```bicep
resource aks 'Microsoft.ContainerService/managedClusters@2024-03-02-preview' = {
  name: 'my-cluster'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
  properties: {
    dnsPrefix: 'my-cluster'
    agentPoolProfiles: [
      {
        name: 'system'
        count: 3
        vmSize: 'Standard_D4s_v5'
        mode: 'System'
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      networkPluginMode: 'overlay'
    }
  }
}
```

### 21. Comparison with similar Azure resources
See [AKS vs Container Apps](#aks-vs-container-apps) below.

### 22. Interview / knowledge-check questions
- What does AKS manage for you, and what do you still manage yourself?
- How does AKS Automatic differ from AKS Standard?
- What's the difference between the Cluster Autoscaler and the Horizontal Pod Autoscaler?
- How does a pod authenticate to Key Vault without a stored secret?
- Why might you choose Container Apps instead of AKS?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/aks/
- https://learn.microsoft.com/azure/aks/intro-aks-automatic

---

## Azure Batch

### 1. What is it?
Azure Batch runs large-scale parallel and high-performance computing (HPC) batch jobs across a managed pool of VMs — think "run this workload across hundreds of machines, then shut them down."

### 2. Why does it exist?
Some workloads (rendering, simulation, large data processing) need massive, short-lived parallel compute that doesn't fit the always-on model of AKS/VMs, and doesn't fit the lightweight event model of Functions.

### 4. When should I use it?
- Embarrassingly parallel compute: rendering frames, Monte Carlo simulations, genomics processing, large-scale testing.

### 5. When should I NOT use it?
- Everyday application workloads — this is a specialized HPC/batch tool, not a general app host.

### 8. Important concepts
- **Pool** — the set of VMs Batch provisions to run jobs.
- **Job** — a collection of tasks run against a pool.
- **Task** — a single unit of work (a command/application run on one node).

### 15. Cost model
```text
Batch cost = underlying VM pool compute cost (pay for what you provision/run);
Batch's scheduling itself has no separate service fee beyond the compute
```

### 19. Azure CLI example
```bash
az batch account create -g my-rg -n mybatchacct -l westeurope
az batch account set --name mybatchacct --resource-group my-rg
az batch pool create --id my-pool --vm-size Standard_D2s_v3 \
  --target-dedicated-nodes 4 \
  --image canonical:0001-com-ubuntu-server-jammy:22_04-lts \
  --node-agent-sku-id "batch.node.ubuntu 22.04"
az batch job create --id my-job --pool-id my-pool
az batch task create --job-id my-job --task-id task1 \
  --command-line "/bin/bash -c 'echo Hello World'"
```

### 20. Bicep example
```bicep
resource batchAccount 'Microsoft.Batch/batchAccounts@2024-02-01' = {
  name: 'mybatchacct'
  location: resourceGroup().location
  properties: { poolAllocationMode: 'BatchService' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/batch/

---

# 2. 🌐 Networking

Networking resources are the plumbing that connects everything else. Read this section in order — each resource builds on the previous one.

## Virtual Network (VNet)

### 1. What is it?
A Virtual Network is your own private, isolated network inside Azure — your own slice of IP address space where you place resources like VMs, databases, and private endpoints.

### 2. Why does it exist?
Cloud resources need network isolation just like an on-prem datacenter network. A VNet gives you a private, software-defined network boundary that Azure resources can join, with controllable inbound/outbound rules.

### 3. Simple real-world analogy
A gated private estate: you decide who can enter the gate (NSGs/firewalls), how the internal roads are laid out (subnets), and whether any road connects to a neighboring estate (peering).

### 4. When should I use it?
Virtually every non-trivial Azure deployment uses at least one VNet — any resource needing private connectivity, VM hosting, or Private Endpoints requires one.

### 6. Common use cases
- Hosting VMs, AKS node pools, App Service VNet integration.
- Providing a network for Private Endpoints so PaaS traffic never touches the public internet.
- Hub-spoke enterprise network topologies.

### 7. How it works
```text
VNet (address space, e.g. 10.0.0.0/16)
   └── Subnet (e.g. 10.0.1.0/24)
          └── Resources (NICs, Private Endpoints, delegated subnets for App Service/Container Apps, etc.)
```

### 8. Important concepts
- **Address space** — the VNet's overall CIDR range (must not overlap with on-prem/other peered networks).
- **Subnet** — a smaller range carved out of the VNet's address space (see below).
- **Peering** — connects two VNets so resources can reach each other privately.
- **DNS settings** — a VNet can use Azure-provided DNS or custom/Private DNS resolution.

### 9. Resource hierarchy / dependencies
```text
Subscription
└── Resource Group
    └── Virtual Network
        ├── Subnet(s)
        ├── NSG(s) attached to subnets
        ├── Route Table(s) attached to subnets
        └── Peering(s) to other VNets
```

### 13. High availability and disaster recovery
A VNet itself is a regional construct with no "HA" setting — resilience comes from how you place resources inside it (zones, redundant NAT/firewall, multi-region VNets connected via Virtual WAN/peering).

### 16. Common mistakes
- Overlapping address spaces between VNets you later need to peer or connect via VPN/ExpressRoute.
- Making the VNet/subnet too small to grow into (always leave headroom in the CIDR plan).

### 19. Azure CLI example
```bash
az network vnet create -g my-rg -n my-vnet --address-prefix 10.0.0.0/16 \
  --subnet-name app-subnet --subnet-prefix 10.0.1.0/24
```

### 20. Bicep example
```bicep
resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'my-vnet'
  location: resourceGroup().location
  properties: {
    addressSpace: { addressPrefixes: ['10.0.0.0/16'] }
    subnets: [
      { name: 'app-subnet', properties: { addressPrefix: '10.0.1.0/24' } }
    ]
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/

---

## Subnet

### 1. What is it?
A subnet is a smaller, named range of IP addresses carved out of a VNet's address space — the boundary at which NSGs, route tables, service delegation, and Private Endpoints are actually applied.

### 4. When should I use it?
Always — a VNet with no subnets cannot host anything. Typical designs separate subnets by purpose: `app-subnet`, `data-subnet`, `AzureBastionSubnet`, `GatewaySubnet` (reserved names for specific services).

### 8. Important concepts
- **Delegated subnet** — a subnet dedicated to a specific PaaS service (e.g., App Service VNet Integration, Container Apps Environment) that needs exclusive control of that subnet.
- **Reserved subnet names** — `GatewaySubnet` (VPN/ExpressRoute Gateway), `AzureBastionSubnet` (Bastion), `AzureFirewallSubnet` (Azure Firewall) — Azure requires these exact names for those services.
- Azure reserves **5 IP addresses** in every subnet for internal use, reducing the usable address count.

### 16. Common mistakes
- Forgetting the 5 reserved addresses per subnet when sizing a CIDR block.
- Putting unrelated resources in one large subnet instead of segmenting by security/function.

### 20. Bicep example
```bicep
resource appSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: virtualNetwork
  name: 'app-subnet'
  properties: {
    addressPrefix: '10.0.1.0/24'
    networkSecurityGroup: { id: nsg.id }
    delegations: [{
      name: 'delegation'
      properties: { serviceName: 'Microsoft.Web/serverFarms' }
    }]
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/concepts-and-best-practices

---

## Network Interface (NIC)

### 1. What is it?
A NIC is the virtual network card that connects a VM to a subnet; it holds the VM's private IP (and optional Public IP association).

### 8. Important concepts
- A VM can have multiple NICs (multi-homed) for advanced networking scenarios.
- **Accelerated Networking** — a performance feature reducing latency/CPU overhead for supported VM sizes.

### 19. Azure CLI example
```bash
az network nic create -g my-rg -n my-nic --vnet-name my-vnet \
  --subnet app-subnet --network-security-group my-nsg --accelerated-networking true
```

### 20. Bicep example
```bicep
resource nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: 'my-nic'
  location: resourceGroup().location
  properties: {
    enableAcceleratedNetworking: true
    ipConfigurations: [{
      name: 'ipconfig1'
      properties: {
        subnet: { id: subnetId }
        privateIPAllocationMethod: 'Dynamic'
      }
    }]
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/virtual-network-network-interface

---

## Public IP

### 1. What is it?
A Public IP is an internet-routable IP address you can attach to a resource (VM NIC, Load Balancer, Application Gateway, VPN Gateway, etc.) to make it reachable from the internet.

### 8. Important concepts
- **SKU: Standard** is the only current option for new deployments — **Basic Public IP retired September 30, 2025**. Standard SKU is secure-by-default (denies inbound unless explicitly allowed by NSG) and supports Availability Zones.
- **Static vs Dynamic allocation** — Standard SKU Public IPs are always static.

### 16. Common mistakes
- Attaching a Public IP directly to a VM for RDP/SSH management access instead of using Azure Bastion.

### 19. Azure CLI example
```bash
az network public-ip create -g my-rg -n my-pip --sku Standard --zone 1 2 3
```

### 20. Bicep example
```bicep
resource publicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: 'my-pip'
  location: resourceGroup().location
  sku: { name: 'Standard' }
  zones: ['1', '2', '3']
  properties: { publicIPAllocationMethod: 'Static' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/ip-services/public-ip-addresses

---

## Network Security Group (NSG)

### 1. What is it?
An NSG is a stateful, software-defined firewall with allow/deny rules, attached to a subnet and/or a NIC, that filters inbound and outbound traffic based on source/destination IP, port, and protocol.

### 2. Why does it exist?
You need to control which traffic can reach your resources (and where your resources can send traffic) without deploying a dedicated appliance for simple allow/deny rules.

### 3. Simple real-world analogy
A security guard with a simple checklist: "traffic from this address on this port — allowed or denied."

### 4. When should I use it?
On every subnet, as a baseline control, in virtually every VNet design.

### 5. When should I NOT use it?
NSGs are not a substitute for **Azure Firewall** or a **WAF** when you need deep packet inspection, FQDN filtering, or application-layer (L7) protection — NSGs only understand IP/port/protocol (L3/L4).

### 7. How it works
```text
Traffic → evaluated against NSG rules in priority order (lowest number first)
       → first matching rule wins (allow or deny)
       → default rules deny all inbound from internet, allow VNet-internal and Azure Load Balancer traffic
```

### 8. Important concepts
- **Rule priority** — lower number = evaluated first.
- **Service tags** (e.g., `Internet`, `VirtualNetwork`, `AzureLoadBalancer`, `Storage`) — predefined groups of IP ranges you can reference instead of hardcoding IPs.
- **Application Security Groups (ASGs)** — let you group VMs/NICs logically (e.g., "WebTier") and write NSG rules against the group name instead of individual IPs.
- NSGs are **stateful**: an allowed inbound connection's return traffic is automatically allowed outbound (and vice versa).

### 16. Common mistakes
- Writing rules against literal IPs instead of service tags/ASGs, making rules brittle as infrastructure changes.
- Assuming an NSG alone provides L7/application protection — it does not inspect HTTP payloads.
- Forgetting default rules already allow intra-VNet traffic, then adding redundant/conflicting rules.

### 19. Azure CLI example
```bash
az network nsg create -g my-rg -n my-nsg
az network nsg rule create -g my-rg --nsg-name my-nsg -n AllowHttpsInbound \
  --priority 100 --access Allow --direction Inbound --protocol Tcp \
  --destination-port-ranges 443 --source-address-prefixes Internet
```

### 20. Bicep example
```bicep
resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: 'my-nsg'
  location: resourceGroup().location
  properties: {
    securityRules: [{
      name: 'AllowHttpsInbound'
      properties: {
        priority: 100
        access: 'Allow'
        direction: 'Inbound'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '443'
        sourceAddressPrefix: 'Internet'
        destinationAddressPrefix: '*'
      }
    }]
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/network-security-groups-overview

---

## Application Security Groups (ASG)

### 1. What is it?
An ASG is a logical grouping mechanism for NICs/VMs (e.g., "WebTier", "DbTier") that you reference inside NSG rules instead of hardcoding IP addresses.

### 4. When should I use it?
Whenever you have tiers of VMs that need consistent NSG rules and you want those rules to automatically apply as VMs are added/removed from the tier.

### 16. Common mistakes
Using raw IP addresses in NSG rules when an ASG would make the rule self-maintaining as the fleet changes.

### 19. Azure CLI example
```bash
az network asg create -g my-rg -n web-tier-asg
az network nic ip-config update -g my-rg --nic-name my-nic -n ipconfig1 \
  --application-security-groups web-tier-asg
```

### 20. Bicep example
```bicep
resource asg 'Microsoft.Network/applicationSecurityGroups@2024-05-01' = {
  name: 'web-tier-asg'
  location: resourceGroup().location
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/application-security-groups

---

## Route Table (User Defined Routes)

### 1. What is it?
A Route Table lets you override Azure's default routing behavior for a subnet — for example, forcing all outbound traffic through a firewall/NVA instead of going directly to the internet.

### 4. When should I use it?
Hub-spoke architectures where spoke traffic must be inspected by a central Azure Firewall/NVA before leaving the VNet ("forced tunneling").

### 8. Important concepts
- **User Defined Route (UDR)** — a manual route entry (e.g., `0.0.0.0/0 → Azure Firewall private IP`).
- Azure's **default system routes** already handle intra-VNet and VNet-to-internet routing; UDRs only need to override specific cases.

### 16. Common mistakes
- Creating a UDR that unintentionally black-holes traffic (e.g., routing `0.0.0.0/0` to an appliance that isn't actually running).

### 19. Azure CLI example
```bash
az network route-table create -g my-rg -n my-route-table
az network route-table route create -g my-rg --route-table-name my-route-table \
  -n default-via-firewall --address-prefix 0.0.0.0/0 \
  --next-hop-type VirtualAppliance --next-hop-ip-address 10.0.0.4
```

### 20. Bicep example
```bicep
resource routeTable 'Microsoft.Network/routeTables@2024-05-01' = {
  name: 'my-route-table'
  location: resourceGroup().location
  properties: {
    routes: [{
      name: 'default-via-firewall'
      properties: {
        addressPrefix: '0.0.0.0/0'
        nextHopType: 'VirtualAppliance'
        nextHopIpAddress: '10.0.0.4'
      }
    }]
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/virtual-networks-udr-overview

---

## NAT Gateway

### 1. What is it?
NAT Gateway gives a subnet a stable, scalable, shared outbound public IP (or IP prefix) for internet-bound traffic, without placing a public IP on individual VMs.

### 2. Why does it exist?
VMs/VMSS without their own public IP still sometimes need outbound internet access (e.g., to call an external API or download updates); NAT Gateway provides this cleanly and at scale, avoiding the older, less reliable "default outbound access" behavior.

### 4. When should I use it?
Any subnet with VMs/AKS nodes/Container instances that need outbound internet access but should not have individual public IPs.

### 5. When should I NOT use it?
If outbound traffic must go through a centralized firewall for inspection — use Azure Firewall with UDRs instead (NAT Gateway doesn't inspect traffic, only translates addresses).

### 16. Common mistakes
- Relying on Azure's default outbound access instead of explicit NAT Gateway/Firewall/Load Balancer outbound rules for production workloads — this is an unreliable, legacy pattern.

### 19. Azure CLI example
```bash
az network public-ip create -g my-rg -n nat-pip --sku Standard
az network nat gateway create -g my-rg -n my-nat-gw --public-ip-addresses nat-pip
az network vnet subnet update -g my-rg --vnet-name my-vnet -n app-subnet \
  --nat-gateway my-nat-gw
```

### 20. Bicep example
```bicep
resource natGwPip 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: 'nat-pip'
  location: resourceGroup().location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

resource natGateway 'Microsoft.Network/natGateways@2024-05-01' = {
  name: 'my-nat-gw'
  location: resourceGroup().location
  sku: { name: 'Standard' }
  properties: { publicIpAddresses: [{ id: natGwPip.id }] }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/nat-gateway/

---

## Private Endpoint and Private Link

### 1. What is it?
A **Private Endpoint** is a network interface with a private IP address, placed inside your VNet, that connects privately to a specific PaaS resource (a Storage Account, SQL Server, Key Vault, etc.) using **Azure Private Link** technology — so traffic to that resource never traverses the public internet.

### 2. Why does it exist?
By default, most PaaS services expose a public endpoint. Many organizations require that sensitive data paths (database connections, Key Vault secret reads, storage access) never cross the public internet, even if authenticated — Private Endpoint solves this.

### 3. Simple real-world analogy
A private, dedicated phone line directly between your office and a specific vendor, instead of calling them over the public phone network.

### 4. When should I use it?
Production workloads accessing PaaS data services (Storage, SQL, Cosmos DB, Key Vault, Service Bus, etc.) where network isolation is required or mandated by compliance.

### 5. When should I NOT use it?
Simple dev/test scenarios where the operational overhead of Private DNS management isn't justified — but even then, consider it a default-good-practice, not an edge case.

### 7. How it works
```text
Your VNet
   └── Private Endpoint (private IP, e.g. 10.0.1.5)
          ↓ Private Link connection
   PaaS resource's private endpoint connection (approved by resource owner)
          ↓
   Private DNS Zone (privatelink.<service>.<suffix>) resolves the
   resource's public name to the Private Endpoint's private IP
```

### 8. Important concepts
- **Private Link service** — the underlying technology that makes Private Endpoint connections possible; can also expose *your own* service privately to other VNets/tenants.
- **Private DNS Zone** — required so that the resource's normal DNS name resolves to the private IP instead of the public IP once a Private Endpoint exists (e.g., `privatelink.blob.core.windows.net`).
- **Approval workflow** — the resource owner must approve a Private Endpoint connection request (auto-approved if you own both sides).

### 10. Networking
Every Private Endpoint needs its matching Private DNS Zone **linked to every VNet** that must resolve the private IP — a very common source of "works from one VNet, not another" bugs.

### 16. Common mistakes
- Creating the Private Endpoint but forgetting to link the Private DNS Zone to the consuming VNet (or a peered VNet), so clients still resolve the public IP or fail to resolve at all.
- Assuming Private Endpoint + public access disabled is automatically done — you must explicitly disable public network access on the resource.

### 19. Azure CLI example
```bash
az network private-endpoint create -g my-rg -n my-pe \
  --vnet-name my-vnet --subnet app-subnet \
  --private-connection-resource-id <storage-account-id> \
  --group-id blob --connection-name my-pe-connection
```

### 20. Bicep example
```bicep
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2024-05-01' = {
  name: 'my-pe'
  location: resourceGroup().location
  properties: {
    subnet: { id: subnetId }
    privateLinkServiceConnections: [{
      name: 'my-pe-connection'
      properties: {
        privateLinkServiceId: storageAccountId
        groupIds: ['blob']
      }
    }]
  }
}

resource peDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-05-01' = {
  parent: privateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [{
      name: 'blob-config'
      properties: { privateDnsZoneId: privateDnsZoneId }
    }]
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/private-link/

---

## Service Endpoints

### 1. What is it?
A Service Endpoint extends your VNet's identity onto Azure's backbone network for a specific subnet, so traffic to a supported PaaS service stays on the Azure backbone instead of the public internet — but the target resource keeps its **public IP** (unlike Private Endpoint, which gives the resource a private IP).

### 5. When should I NOT use it?
When you need true network isolation, DNS-based private resolution, or on-prem access via VPN/ExpressRoute to reach the resource privately — Private Endpoint is the modern, more complete answer for those needs.

### 19. Azure CLI example
```bash
az network vnet subnet update -g my-rg --vnet-name my-vnet -n app-subnet \
  --service-endpoints Microsoft.Storage Microsoft.Sql
```

### 20. Bicep example
```bicep
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: 'app-subnet'
  properties: {
    addressPrefix: '10.0.1.0/24'
    serviceEndpoints: [
      { service: 'Microsoft.Storage' }
      { service: 'Microsoft.Sql' }
    ]
  }
}
```

### 21. Comparison with similar Azure resources
See [Private Endpoint vs Service Endpoint](#private-endpoint-vs-service-endpoint) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/virtual-network-service-endpoints-overview

---

## VNet Peering

### 1. What is it?
VNet Peering connects two Virtual Networks so resources in each can communicate using private IPs, as if they were in the same network.

### 4. When should I use it?
Hub-spoke designs, connecting workloads split across multiple VNets/subscriptions, or regional VNets that need to talk to each other.

### 8. Important concepts
- **Global peering** — peering across regions.
- Peering is **not transitive**: if VNet A peers with B, and B peers with C, A cannot reach C through B automatically (Virtual WAN or an NVA/hub can solve this).

### 16. Common mistakes
Assuming transitive routing through peering — it does not exist without additional routing (hub NVA, Virtual WAN).

### 19. Azure CLI example
```bash
az network vnet peering create -g my-rg -n hub-to-spoke \
  --vnet-name hub-vnet --remote-vnet spoke-vnet-resource-id \
  --allow-vnet-access true --allow-forwarded-traffic true
az network vnet peering create -g my-rg -n spoke-to-hub \
  --vnet-name spoke-vnet --remote-vnet hub-vnet-resource-id \
  --allow-vnet-access true --allow-forwarded-traffic true
```

### 20. Bicep example
```bicep
resource peeringToSpoke 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-05-01' = {
  parent: hubVnet
  name: 'hub-to-spoke'
  properties: {
    remoteVirtualNetwork: { id: spokeVnetId }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-network/virtual-network-peering-overview

---

## VPN Gateway

### 1. What is it?
A VPN Gateway is a managed service that creates an encrypted tunnel (IPsec/IKE) between your VNet and an on-premises network (Site-to-Site) or an individual device (Point-to-Site), over the public internet.

### 4. When should I use it?
Hybrid connectivity where ExpressRoute's dedicated private circuit isn't justified by cost/complexity, or as a backup path to ExpressRoute.

### 5. When should I NOT use it?
When you need guaranteed bandwidth/low-latency private connectivity at large scale — that's ExpressRoute's job.

### 8. Important concepts
- **Gateway SKU** — determines throughput and the number of tunnels/connections supported.
- Deployed into the reserved **GatewaySubnet**.

### 19. Azure CLI example
```bash
az network public-ip create -g my-rg -n vpn-gw-pip --sku Standard
az network vnet-gateway create -g my-rg -n my-vpn-gw \
  --vnet my-vnet --public-ip-address vpn-gw-pip \
  --gateway-type Vpn --vpn-type RouteBased --sku VpnGw1
az network vpn-connection create -g my-rg -n onprem-connection \
  --vnet-gateway1 my-vpn-gw --local-gateway2 my-local-gateway \
  --shared-key "<pre-shared-key>"
```

### 20. Bicep example
```bicep
resource vpnGateway 'Microsoft.Network/virtualNetworkGateways@2024-05-01' = {
  name: 'my-vpn-gw'
  location: resourceGroup().location
  properties: {
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    sku: { name: 'VpnGw1', tier: 'VpnGw1' }
    ipConfigurations: [{
      name: 'vnetGatewayConfig'
      properties: {
        subnet: { id: gatewaySubnetId } // must be named GatewaySubnet
        publicIPAddress: { id: vpnGwPipId }
      }
    }]
  }
}
```

### 21. Comparison with similar Azure resources
See [VPN Gateway vs ExpressRoute](#vpn-gateway-vs-expressroute) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/vpn-gateway/

---

## ExpressRoute

### 1. What is it?
ExpressRoute is a private, dedicated network connection between your on-premises network and Azure, provided through a connectivity partner, that does not traverse the public internet at all.

### 4. When should I use it?
Enterprises needing guaranteed bandwidth, lower latency, higher reliability, and private connectivity at a scale VPN Gateway cannot match — often mandated for large hybrid enterprises.

### 5. When should I NOT use it?
Smaller workloads/remote branch offices where the cost and lead time of provisioning a dedicated circuit isn't justified — VPN Gateway is far faster to stand up.

### 8. Important concepts
- **Peering location** — the physical meet-me location where your connectivity provider connects to Microsoft's network.
- **Circuit** — the logical connection you provision from a connectivity provider.

### 19. Azure CLI example
```bash
az network express-route create -g my-rg -n my-circuit \
  --bandwidth 1000 --provider "Equinix" --peering-location "Amsterdam" \
  --sku-family MeteredData --sku-tier Standard
```

### 20. Bicep example
```bicep
resource expressRouteCircuit 'Microsoft.Network/expressRouteCircuits@2024-05-01' = {
  name: 'my-circuit'
  location: resourceGroup().location
  sku: { name: 'Standard_MeteredData', tier: 'Standard', family: 'MeteredData' }
  properties: {
    serviceProviderProperties: {
      serviceProviderName: 'Equinix'
      peeringLocation: 'Amsterdam'
      bandwidthInMbps: 1000
    }
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/expressroute/

---

## Azure Firewall

### 1. What is it?
Azure Firewall is a managed, cloud-native network firewall appliance providing stateful L3–L7 filtering, FQDN filtering, threat intelligence, and centralized policy — typically deployed in a hub VNet to inspect traffic from multiple spokes.

### 2. Why does it exist?
NSGs only filter on IP/port; many enterprises need application-aware rules (allow outbound only to `*.github.com`), centralized logging, and threat-intel-based blocking across an entire hub-spoke estate.

### 4. When should I use it?
Centralized, policy-driven traffic inspection and filtering for a hub-spoke network, especially controlling outbound internet access from many spokes.

### 5. When should I NOT use it?
Simple single-VNet workloads where NSGs already provide sufficient control — Azure Firewall adds cost and complexity that isn't always justified.

### 8. Important concepts
- **Firewall Policy** — the rule collection (network rules, application rules, NAT rules) applied to one or more firewalls via **Firewall Manager**.
- Deployed into the reserved **AzureFirewallSubnet**.
- Traffic reaches it via **UDRs** on spoke subnets pointing at the firewall's private IP.

### 19. Azure CLI example
```bash
az network firewall create -g my-rg -n my-fw -l westeurope
az network firewall policy create -g my-rg -n my-fw-policy
az network firewall policy rule-collection-group create \
  -g my-rg --policy-name my-fw-policy -n app-rules --priority 200
az network firewall policy rule-collection-group collection add-filter-collection \
  -g my-rg --policy-name my-fw-policy --rule-collection-group-name app-rules \
  --name allow-github --collection-priority 100 --action Allow \
  --rule-name allow-github --rule-type ApplicationRule \
  --target-fqdns "*.github.com" --source-addresses "10.0.0.0/16" --protocols Https=443
```

### 20. Bicep example
```bicep
resource fwPolicy 'Microsoft.Network/firewallPolicies@2023-09-01' = {
  name: 'my-fw-policy'
  location: resourceGroup().location
}

resource firewall 'Microsoft.Network/azureFirewalls@2023-09-01' = {
  name: 'my-fw'
  location: resourceGroup().location
  properties: {
    sku: { name: 'AZFW_VNet', tier: 'Standard' }
    firewallPolicy: { id: fwPolicy.id }
    ipConfigurations: [{
      name: 'fw-ipconfig'
      properties: {
        subnet: { id: firewallSubnetId }
        publicIPAddress: { id: firewallPublicIpId }
      }
    }]
  }
}
```

### 21. Comparison with similar Azure resources
See [NSG vs Azure Firewall vs WAF](#nsg-vs-azure-firewall-vs-waf) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/firewall/

---

## Application Gateway

### 1. What is it?
Application Gateway is a regional, Layer-7 (HTTP/HTTPS) load balancer with built-in Web Application Firewall (WAF) support, path/host-based routing, and TLS termination.

### 2. Why does it exist?
Layer-4 load balancing (Azure Load Balancer) cannot route based on URL path or host header, terminate TLS with application-aware rules, or inspect HTTP for attacks — Application Gateway fills that gap at the regional level.

### 4. When should I use it?
Regional web application ingress needing WAF, path-based routing (e.g., `/api` → one backend, `/images` → another), or TLS termination/offload.

### 5. When should I NOT use it?
Global multi-region entry point — that's **Front Door**'s job; plain L4 TCP/UDP load balancing — that's **Load Balancer**'s job.

### 8. Important concepts
- **Listener** — defines the frontend IP/port/protocol it listens on.
- **Backend pool** — the set of servers (VMs, VMSS, App Service, IPs) receiving traffic.
- **HTTP settings / routing rules** — define how requests are routed and backend health-probed.
- **WAF policy** — OWASP-based rule sets for SQL injection/XSS/etc. protection, attachable to the gateway.

### 19. Azure CLI example
```bash
az network application-gateway create -g my-rg -n my-appgw \
  --sku Standard_v2 --capacity 2 \
  --vnet-name my-vnet --subnet appgw-subnet \
  --public-ip-address appgw-pip \
  --servers 10.0.1.4 10.0.1.5
```

### 20. Bicep example
```bicep
resource appGateway 'Microsoft.Network/applicationGateways@2024-05-01' = {
  name: 'my-appgw'
  location: resourceGroup().location
  properties: {
    sku: { name: 'Standard_v2', tier: 'Standard_v2', capacity: 2 }
    gatewayIPConfigurations: [{
      name: 'appGatewayIpConfig'
      properties: { subnet: { id: appGwSubnetId } }
    }]
    frontendIPConfigurations: [{
      name: 'frontend'
      properties: { publicIPAddress: { id: appGwPipId } }
    }]
    frontendPorts: [{ name: 'port80', properties: { port: 80 } }]
    backendAddressPools: [{ name: 'backend', properties: { backendAddresses: [{ ipAddress: '10.0.1.4' }] } }]
    backendHttpSettingsCollection: [{
      name: 'httpSettings'
      properties: { port: 80, protocol: 'Http', cookieBasedAffinity: 'Disabled' }
    }]
    httpListeners: [{
      name: 'listener'
      properties: {
        frontendIPConfiguration: { id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', 'my-appgw', 'frontend') }
        frontendPort: { id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', 'my-appgw', 'port80') }
        protocol: 'Http'
      }
    }]
    requestRoutingRules: [{
      name: 'rule1'
      properties: {
        ruleType: 'Basic', priority: 100
        httpListener: { id: resourceId('Microsoft.Network/applicationGateways/httpListeners', 'my-appgw', 'listener') }
        backendAddressPool: { id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', 'my-appgw', 'backend') }
        backendHttpSettings: { id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', 'my-appgw', 'httpSettings') }
      }
    }]
  }
}
```

### 21. Comparison with similar Azure resources
See [Front Door vs Application Gateway vs Load Balancer vs Traffic Manager](#front-door-vs-application-gateway-vs-load-balancer-vs-traffic-manager) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/application-gateway/

---

## Web Application Firewall (WAF)

### 1. What is it?
WAF is a feature/policy attached to Application Gateway or Front Door that inspects HTTP(S) traffic against rule sets (commonly OWASP Core Rule Set) to block common web attacks (SQL injection, XSS, etc.).

### 8. Important concepts
- **Detection mode** — logs potential violations without blocking (useful for tuning before enforcing).
- **Prevention mode** — actively blocks matched requests.
- **Custom rules** — IP allow/block lists, rate limiting, geo-filtering.

### 16. Common mistakes
Enabling WAF in Prevention mode without first testing in Detection mode — legitimate traffic can get blocked by overly broad managed rules.

### 19. Azure CLI example
```bash
az network application-gateway waf-policy create -g my-rg -n my-waf-policy
az network application-gateway waf-policy policy-setting update \
  -g my-rg --policy-name my-waf-policy --mode Prevention --state Enabled
```

### 20. Bicep example
```bicep
resource wafPolicy 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2024-05-01' = {
  name: 'my-waf-policy'
  location: resourceGroup().location
  properties: {
    policySettings: { state: 'Enabled', mode: 'Prevention' }
    managedRules: {
      managedRuleSets: [{ ruleSetType: 'OWASP', ruleSetVersion: '3.2' }]
    }
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/web-application-firewall/

---

## Azure Load Balancer

### 1. What is it?
Azure Load Balancer is a high-performance, Layer-4 (TCP/UDP) load balancer that distributes traffic across a backend pool of VMs/VMSS instances, either publicly or privately (internal load balancer).

### 4. When should I use it?
Distributing raw TCP/UDP traffic across VM/VMSS instances; as the internal load balancer tier between application layers.

### 5. When should I NOT use it?
HTTP(S)-aware routing, WAF, or TLS termination needs — use Application Gateway/Front Door instead.

### 8. Important concepts
- **SKU: Standard** is the only supported option for new deployments — **Basic Load Balancer retired September 30, 2025**.
- **Health probes** determine which backend instances receive traffic.
- **Public vs Internal** Load Balancer — internal has no internet-facing frontend.

### 16. Common mistakes
Still referencing Basic SKU in older templates/scripts — these deployments will now fail; always specify Standard SKU.

### 19. Azure CLI example
```bash
az network lb create -g my-rg -n my-lb --sku Standard \
  --public-ip-address my-lb-pip --frontend-ip-name frontend \
  --backend-pool-name backend
az network lb probe create -g my-rg --lb-name my-lb -n http-probe \
  --protocol Tcp --port 80
az network lb rule create -g my-rg --lb-name my-lb -n http-rule \
  --protocol Tcp --frontend-port 80 --backend-port 80 \
  --frontend-ip-name frontend --backend-pool-name backend \
  --probe-name http-probe
```

### 20. Bicep example
```bicep
resource lb 'Microsoft.Network/loadBalancers@2023-09-01' = {
  name: 'my-lb'
  location: resourceGroup().location
  sku: { name: 'Standard' }
  properties: {
    frontendIPConfigurations: [{
      name: 'frontend'
      properties: { publicIPAddress: { id: publicIpId } }
    }]
    backendAddressPools: [{ name: 'backend' }]
  }
}
```

### 21. Comparison with similar Azure resources
See [Front Door vs Application Gateway vs Load Balancer vs Traffic Manager](#front-door-vs-application-gateway-vs-load-balancer-vs-traffic-manager) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/load-balancer/

---

## Azure Front Door

### 1. What is it?
Front Door is Azure's global, edge-based entry point for web applications: it combines global HTTP(S) load balancing, a CDN-like edge cache/acceleration layer, WAF, and automatic failover across regions, all anchored at Microsoft's global edge network (closest to end users).

### 4. When should I use it?
Global applications/APIs needing a single public entry point with automatic regional failover, edge caching, and WAF, in front of origins in multiple regions (App Service, Storage, Application Gateway, on-prem, etc.).

### 5. When should I NOT use it?
Purely internal/regional-only applications with no need for global edge acceleration or multi-region failover — Application Gateway alone may suffice.

### 8. Important concepts
- **Origin** — the backend (App Service, Storage static website, Application Gateway, custom endpoint) Front Door routes to.
- **Origin group** — a set of origins with health probes and failover/priority rules.
- **Rules engine** — custom routing/rewrite logic at the edge.

### 19. Azure CLI example
```bash
az afd profile create -g my-rg --profile-name my-fd --sku Standard_AzureFrontDoor
az afd endpoint create -g my-rg --profile-name my-fd --endpoint-name my-endpoint
az afd origin-group create -g my-rg --profile-name my-fd --origin-group-name my-origins \
  --probe-request-type GET --probe-protocol Https --probe-path /health --probe-interval-in-seconds 30
az afd origin create -g my-rg --profile-name my-fd --origin-group-name my-origins \
  --origin-name primary --host-name myapp.azurewebsites.net --origin-host-header myapp.azurewebsites.net
az afd route create -g my-rg --profile-name my-fd --endpoint-name my-endpoint \
  --route-name default-route --origin-group my-origins --supported-protocols Https --https-redirect Enabled
```

### 20. Bicep example
```bicep
resource fdProfile 'Microsoft.Cdn/profiles@2024-02-01' = {
  name: 'my-fd'
  location: 'global'
  sku: { name: 'Standard_AzureFrontDoor' }
}

resource fdEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2024-02-01' = {
  parent: fdProfile
  name: 'my-endpoint'
  location: 'global'
  properties: { enabledState: 'Enabled' }
}

resource fdOriginGroup 'Microsoft.Cdn/profiles/originGroups@2024-02-01' = {
  parent: fdProfile
  name: 'my-origins'
  properties: {
    loadBalancingSettings: { sampleSize: 4, successfulSamplesRequired: 3 }
    healthProbeSettings: { probePath: '/health', probeRequestType: 'GET', probeProtocol: 'Https', probeIntervalInSeconds: 30 }
  }
}
```

### 21. Comparison with similar Azure resources
See [Front Door vs Application Gateway vs Load Balancer vs Traffic Manager](#front-door-vs-application-gateway-vs-load-balancer-vs-traffic-manager) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/frontdoor/

---

## Traffic Manager

### 1. What is it?
Traffic Manager is a **DNS-based** global traffic routing service — it doesn't proxy traffic itself; it answers DNS queries with the IP of the "best" endpoint based on a routing method (priority, weighted, performance/latency, geographic).

### 5. When should I NOT use it?
When you need actual edge acceleration, caching, or WAF — Traffic Manager only directs DNS resolution; it cannot inspect or modify HTTP traffic. Front Door is generally preferred for modern web-facing global routing.

### 16. Common mistakes
Expecting instant failover — DNS TTL caching means clients can take time to pick up a Traffic Manager failover, unlike Front Door's faster edge-level failover.

### 19. Azure CLI example
```bash
az network traffic-manager profile create -g my-rg -n my-tm \
  --routing-method Priority --unique-dns-name my-tm-app \
  --ttl 30 --protocol HTTPS --port 443 --path "/health"
az network traffic-manager endpoint create -g my-rg --profile-name my-tm \
  --name primary --type azureEndpoints --target-resource-id <app-service-resource-id> \
  --priority 1
az network traffic-manager endpoint create -g my-rg --profile-name my-tm \
  --name secondary --type azureEndpoints --target-resource-id <app-service-resource-id-2> \
  --priority 2
```

### 20. Bicep example
```bicep
resource tm 'Microsoft.Network/trafficManagerProfiles@2022-04-01' = {
  name: 'my-tm'
  location: 'global'
  properties: {
    profileStatus: 'Enabled'
    trafficRoutingMethod: 'Priority'
    dnsConfig: { relativeName: 'my-tm-app', ttl: 30 }
    monitorConfig: { protocol: 'HTTPS', port: 443, path: '/health' }
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/traffic-manager/

---

## Azure Bastion

### 1. What is it?
Azure Bastion provides secure RDP/SSH access to VMs directly through the Azure Portal (or native client support), over TLS, without exposing the VM's RDP/SSH port to the public internet and without needing a public IP on the VM.

### 4. When should I use it?
Any time you need to manage a VM remotely — it should be the default, not an afterthought.

### 8. Important concepts
Deployed into the reserved **AzureBastionSubnet** inside the VNet.

### 16. Common mistakes
Exposing RDP (3389)/SSH (22) directly to the internet via a VM's public IP instead of using Bastion — one of the most common real-world breach vectors.

### 19. Azure CLI example
```bash
az network public-ip create -g my-rg -n bastion-pip --sku Standard
az network bastion create -g my-rg -n my-bastion --vnet-name my-vnet \
  --public-ip-address bastion-pip --sku Standard
```

### 20. Bicep example
```bicep
resource bastion 'Microsoft.Network/bastionHosts@2024-05-01' = {
  name: 'my-bastion'
  location: resourceGroup().location
  sku: { name: 'Standard' }
  properties: {
    ipConfigurations: [{
      name: 'bastionIpConfig'
      properties: {
        subnet: { id: bastionSubnetId } // must be named AzureBastionSubnet
        publicIPAddress: { id: bastionPipId }
      }
    }]
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/bastion/

---

## Azure DNS (public zones), Private DNS Zones, and DNS Private Resolver

### Azure DNS (public zones)
Hosts public DNS zones (e.g., `contoso.com`) on Azure's global DNS infrastructure — standard authoritative DNS hosting.

### Private DNS Zones
Provide name resolution **inside a VNet** (or across linked VNets) for private names — most critically, the `privatelink.*` zones that make Private Endpoints resolve correctly. A Private DNS Zone must be explicitly **linked** to every VNet that needs to resolve it.

### Azure DNS Private Resolver
Lets on-premises systems (over VPN/ExpressRoute) resolve Azure Private DNS names, and lets Azure resolve on-prem DNS names — bridging private DNS resolution across hybrid environments without running your own DNS VMs.

### 16. Common mistakes
- Forgetting to link a Private DNS Zone to a consuming (or peered) VNet — the single most common Private Endpoint troubleshooting issue.
- Running custom DNS forwarder VMs when DNS Private Resolver would remove that operational burden.

### 19. Azure CLI example
```bash
# Public zone + record
az network dns zone create -g my-rg -n contoso.com
az network dns record-set a add-record -g my-rg -z contoso.com \
  -n www --ipv4-address 20.1.2.3

# Private zone linked to a VNet
az network private-dns zone create -g my-rg -n privatelink.blob.core.windows.net
az network private-dns link vnet create -g my-rg \
  -z privatelink.blob.core.windows.net -n my-vnet-link \
  --virtual-network my-vnet --registration-enabled false
```

### 20. Bicep example — private DNS zone + VNet link
```bicep
resource zone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.blob.core.windows.net'
  location: 'global'
}

resource link 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: zone
  name: 'my-vnet-link'
  location: 'global'
  properties: {
    virtualNetwork: { id: vnetId }
    registrationEnabled: false
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/dns/
- https://learn.microsoft.com/azure/dns/private-dns-overview
- https://learn.microsoft.com/azure/dns/dns-private-resolver-overview

---

# 3. 💾 Storage

## Storage Account

### 1. What is it?
A Storage Account is the top-level container resource that provides access to Azure's core storage services: Blob, Azure Files, Queue, and Table storage, all under one account with shared configuration (redundancy, networking, keys).

### 2. Why does it exist?
Applications need durable, scalable storage for files, unstructured data (blobs), simple queues, and simple NoSQL-style tables — the Storage Account is the umbrella resource that provisions and secures all of these consistently.

### 4. When should I use it?
Virtually every application needs at least one Storage Account — for logs, file uploads, static assets, queued background work, or Function App runtime state.

### 8. Important concepts
- **Account kind** — `StorageV2` (general purpose v2) is the standard default, supporting all services.
- **Performance tier** — Standard (HDD-backed, cheaper) vs Premium (SSD-backed, lower latency, used for Premium Blob/Files/Disks).
- **Redundancy (replication)** — see table below; determines durability against hardware/datacenter/region failure.
- **Access tier** (Blob-specific) — Hot/Cool/Cold/Archive, covered in the Blob Storage section.

### Redundancy options
| Option | What it protects against | Copies |
|---|---|---|
| **LRS** (Locally Redundant Storage) | Hardware failure in one datacenter | 3 copies, 1 datacenter |
| **ZRS** (Zone Redundant Storage) | Datacenter/zone failure within a region | 3 copies across zones |
| **GRS** (Geo-Redundant Storage) | Regional disaster | 3 copies local + 3 copies in paired region (not directly readable without failover) |
| **RA-GRS** (Read-Access GRS) | Same as GRS + read access to the secondary region | Same as GRS, secondary is readable |
| **GZRS / RA-GZRS** | Zone failure + regional disaster combined | ZRS locally + geo-replicated |

### 10. Networking
Public by default; restrict with firewall IP rules, Service Endpoints, or (recommended for production) **Private Endpoints** per sub-service (blob, file, queue, table each get their own Private Endpoint).

### 11. Identity and security
- Prefer **Microsoft Entra ID + Managed Identity with RBAC data-plane roles** (e.g., `Storage Blob Data Contributor`) over account keys or SAS tokens where possible.
- **Shared Access Signatures (SAS)** grant time-limited, scoped access — use the narrowest scope and shortest expiry practical, and prefer user-delegation SAS (backed by Entra ID) over account-key SAS.
- Encryption at rest is enabled by default (platform-managed keys); customer-managed keys (Key Vault) available for stricter compliance.

### 15. Cost model
```text
Storage Account cost depends mainly on:
data stored (GB, by tier) + redundancy option chosen
+ transactions (read/write/list operations)
+ outbound bandwidth (egress)
+ early-deletion penalties (Cool/Cold/Archive tiers)
```

### 16. Common mistakes
- Leaving account keys as the only auth mechanism (keys don't expire and grant full access).
- Choosing LRS for data that actually requires regional disaster protection.
- Using Archive tier for data that needs frequent/fast access (rehydration can take hours).

### 19. Azure CLI example
```bash
az storage account create -g my-rg -n mystorageacct \
  --sku Standard_ZRS --kind StorageV2 --min-tls-version TLS1_2
```

### 20. Bicep example
```bicep
resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'mystorageacct'
  location: resourceGroup().location
  sku: { name: 'Standard_ZRS' }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/storage/common/storage-account-overview

---

## Blob Storage

### 1. What is it?
Blob Storage stores unstructured binary data (files) — documents, images, videos, backups, logs — as "blobs" inside "containers," accessible via HTTP(S) URL.

### 3. Simple real-world analogy
A vast warehouse of labeled boxes (containers) each holding any kind of item (blobs) you can retrieve by name.

### 4. When should I use it?
File uploads, static website assets, data lake source files, backup targets, Function App storage, logs/exports.

### 6. Common use cases
- Hosting images/videos/documents for a web app.
- Staging area for data pipelines (Data Factory, Databricks).
- Static website hosting (`$web` container).

### 8. Important concepts
- **Container** — a logical grouping of blobs (similar to a folder/bucket).
- **Blob types** — Block blob (most common, for files), Append blob (log-style appends), Page blob (used by VM disks).
- **Access tiers** — Hot (frequent access), Cool (infrequent, 30+ days), Cold (rarely accessed, longer min storage duration), Archive (rare access, hours-scale retrieval/rehydration).
- **Lifecycle management policy** — automatically moves/deletes blobs between tiers based on age/rules.
- **Immutability policies (WORM)** — for compliance scenarios requiring write-once-read-many guarantees.

### 15. Cost model
```text
Blob cost depends mainly on:
GB stored × access tier price
+ transaction counts (reads/writes/lists differ in cost)
+ early-deletion fee if deleted before the tier's minimum retention
+ rehydration cost (Archive → Hot)
```

### 16. Common mistakes
- Storing frequently accessed data in Cool/Archive, incurring high transaction/retrieval costs.
- Not setting a lifecycle policy, leaving old data in Hot tier indefinitely.

### 18. Developer example
```csharp
using Azure.Identity;
using Azure.Storage.Blobs;

var client = new BlobServiceClient(
    new Uri("https://mystorageacct.blob.core.windows.net"),
    new DefaultAzureCredential());

BlobContainerClient container = client.GetBlobContainerClient("uploads");
await container.CreateIfNotExistsAsync();

BlobClient blob = container.GetBlobClient("invoice-123.pdf");
await blob.UploadAsync(fileStream, overwrite: true);
```

### 19. Azure CLI example
```bash
az storage container create --account-name mystorageacct -n uploads --auth-mode login
az storage blob upload --account-name mystorageacct -c uploads -f ./invoice.pdf -n invoice-123.pdf --auth-mode login
```

### 20. Bicep example
```bicep
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: { enabled: true, days: 7 } // soft delete
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: blobService
  name: 'uploads'
  properties: { publicAccess: 'None' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/storage/blobs/

---

## Azure Data Lake Storage Gen2

### 1. What is it?
Data Lake Storage Gen2 is Blob Storage with a **hierarchical namespace** enabled, adding true directory/folder semantics and POSIX-style ACLs, optimized for big-data analytics workloads.

### 4. When should I use it?
Analytics pipelines (Databricks, Synapse, Data Factory) that benefit from fast directory operations (rename/move) and fine-grained POSIX ACLs — the standard choice for a "data lake" in Azure.

### 5. When should I NOT use it?
Simple file storage with no analytics workload — plain Blob Storage without hierarchical namespace is simpler and perfectly adequate.

### 8. Important concepts
- **Hierarchical namespace** — the flag that upgrades a storage account from flat blob storage to a true filesystem-like structure.
- Fully interoperable with the Blob APIs — it's the *same underlying storage account* with this capability turned on at creation time (cannot be toggled after creation in most cases — verify current behavior).

### 19. Azure CLI example
```bash
az storage account create -g my-rg -n mydatalakeacct \
  --sku Standard_LRS --kind StorageV2 --hierarchical-namespace true
```

### 20. Bicep example
```bicep
resource dataLake 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'mydatalakeacct'
  location: resourceGroup().location
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: {
    isHnsEnabled: true // hierarchical namespace = Data Lake Storage Gen2
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/storage/blobs/data-lake-storage-introduction

---

## Azure Files

### 1. What is it?
Azure Files provides fully managed network file shares accessible via the standard **SMB** and **NFS** protocols — mountable from Windows, Linux, and macOS, and from on-premises via VPN/ExpressRoute.

### 4. When should I use it?
Lift-and-shift of applications expecting a traditional network file share (replacing an on-prem file server), shared configuration/content across multiple VMs or containers.

### 5. When should I NOT use it?
Application-native object storage needs (web assets, uploads) — Blob Storage is simpler and cheaper for that.

### 8. Important concepts
- **Azure File Sync** — synchronizes Azure Files with on-premises Windows Servers, enabling a hybrid cache (keep hot files local, tier cold files to the cloud).
- Supports both SMB and NFS protocol shares (NFS requires Premium tier).

### 19. Azure CLI example
```bash
az storage share create --account-name mystorageacct --name my-share --quota 100
# Mount from Linux:
#   sudo mount -t cifs //mystorageacct.file.core.windows.net/my-share /mnt/myshare \
#     -o vers=3.0,username=mystorageacct,password=<storage-key>
```

### 20. Bicep example
```bicep
resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  name: '${storageAccount.name}/default/my-share'
  properties: { shareQuota: 100 }
}
```

### 21. Comparison with similar Azure resources
See [Blob Storage vs Azure Files vs Managed Disks](#blob-storage-vs-azure-files-vs-managed-disks) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/storage/files/

---

## Queue Storage

### 1. What is it?
Storage Queues are a simple, low-cost messaging mechanism built into a Storage Account — messages up to 64 KB, stored durably, processed roughly in order (not guaranteed FIFO at scale).

### 5. When should I NOT use it?
When you need topics/subscriptions, sessions, dead-lettering, or transactional guarantees — use **Service Bus** instead (see Messaging section).

### 18. Developer example (C#)
```csharp
using Azure.Identity;
using Azure.Storage.Queues;

var queueClient = new QueueClient(
    new Uri("https://mystorageacct.queue.core.windows.net/my-queue"),
    new DefaultAzureCredential());

await queueClient.SendMessageAsync("order-created:123");
var msg = await queueClient.ReceiveMessageAsync();
await queueClient.DeleteMessageAsync(msg.Value.MessageId, msg.Value.PopReceipt);
```

### 19. Azure CLI example
```bash
az storage queue create --account-name mystorageacct --name my-queue --auth-mode login
```

### 20. Bicep example
```bicep
resource queueService 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccount
  name: 'default'
}

resource queue 'Microsoft.Storage/storageAccounts/queueServices/queues@2023-05-01' = {
  parent: queueService
  name: 'my-queue'
}
```

### 21. Comparison with similar Azure resources
See [Service Bus vs Event Grid vs Event Hubs vs Storage Queue](#service-bus-vs-event-grid-vs-event-hubs-vs-storage-queue) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/storage/queues/

---

## Table Storage

### 1. What is it?
Table Storage is a simple, schemaless NoSQL key-value store (partition key + row key + properties) built into a Storage Account, for very low-cost, high-throughput simple lookups.

### 5. When should I NOT use it?
When you need rich querying, secondary indexes, global distribution, or multiple consistency levels — **Cosmos DB** (which offers a Table API) is the modern choice for anything beyond the simplest key-value needs.

### 18. Developer example (C#, via Azure.Data.Tables)
```csharp
using Azure.Data.Tables;
using Azure.Identity;

var tableClient = new TableClient(
    new Uri("https://mystorageacct.table.core.windows.net"), "MyTable",
    new DefaultAzureCredential());

await tableClient.CreateIfNotExistsAsync();
await tableClient.AddEntityAsync(new TableEntity("customers", "cust-1")
{
    { "Name", "Contoso" }, { "Tier", "Gold" }
});
var entity = await tableClient.GetEntityAsync<TableEntity>("customers", "cust-1");
```

### 19. Azure CLI example
```bash
az storage table create --account-name mystorageacct --name MyTable --auth-mode login
```

### 20. Bicep example
```bicep
resource tableService 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccount
  name: 'default'
}

resource table 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: tableService
  name: 'MyTable'
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/storage/tables/

---

## Managed Disks

### 1. What is it?
Managed Disks are block-storage virtual hard disks attached to VMs — Azure handles the underlying storage account management, redundancy, and placement for you (hence "managed").

### 8. Important concepts
- **Disk type** — Standard HDD (cheapest, dev/test), Standard SSD (balanced), Premium SSD (production VM workloads), Premium SSD v2/Ultra Disk (highest performance, configurable IOPS/throughput independent of size).
- **OS disk vs data disk** — covered in the VM section.
- **Disk snapshot** — a point-in-time copy used for backup or creating new disks/images.

### 19. Azure CLI example
```bash
az disk create -g my-rg -n my-data-disk --size-gb 128 --sku Premium_LRS
az vm disk attach -g my-rg --vm-name my-vm --name my-data-disk
az snapshot create -g my-rg -n my-disk-snapshot --source my-data-disk
```

### 20. Bicep example
```bicep
resource dataDisk 'Microsoft.Compute/disks@2023-10-02' = {
  name: 'my-data-disk'
  location: resourceGroup().location
  sku: { name: 'Premium_LRS' }
  properties: {
    creationData: { createOption: 'Empty' }
    diskSizeGB: 128
  }
}
```

### 21. Comparison with similar Azure resources
See [Blob Storage vs Azure Files vs Managed Disks](#blob-storage-vs-azure-files-vs-managed-disks) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/virtual-machines/managed-disks-overview

---

# 4. 🗄️ Databases and Caching

## Azure SQL Database

### 1. What is it?
Azure SQL Database is a fully managed, PaaS relational database based on the SQL Server engine — you get a database (or elastic pool of databases) without managing the underlying OS, patching, or SQL Server instance.

### 2. Why does it exist?
Most applications need a relational database but shouldn't need to manage SQL Server patching, backups, or HA configuration by hand — Azure SQL Database automates all of that.

### 4. When should I use it?
New applications needing a relational database compatible with SQL Server's T-SQL, with minimal operational overhead.

### 5. When should I NOT use it?
You need full SQL Server instance-level features (cross-database transactions, SQL Agent, CLR, Linked Servers, specific instance-level configuration) → **Azure SQL Managed Instance**. You need OS-level access or a specific SQL Server version/features unavailable in PaaS → **SQL Server on Azure VM**.

### 6. Common use cases
- Application backend databases for web/mobile apps.
- Multi-tenant SaaS using elastic pools (many small databases sharing resources).

### 7. How it works
```text
Logical server (just a management/connection endpoint, not a VM)
   └── Database(s) (the actual billable, scalable unit)
          or
   └── Elastic Pool (shared resources across many databases)
```

### 8. Important concepts
- **Logical server** — a logical construct for connection/firewall/auth management; it is **not** a VM you manage.
- **DTU-based vs vCore-based purchasing model** — vCore model (recommended for new deployments) lets you independently choose compute and storage and apply Azure Hybrid Benefit for SQL licensing.
- **Serverless compute tier** — auto-pauses and auto-scales compute for intermittent workloads, billing by usage.
- **Elastic pool** — share compute/storage resources across many databases with varying/unpredictable usage patterns.
- **Geo-replication / auto-failover groups** — asynchronous replication to a secondary region with automatic failover.

### 11. Identity and security
Prefer **Microsoft Entra ID authentication** (including managed identity from the calling app) over SQL authentication (username/password) where possible; enable **Transparent Data Encryption** (on by default) and **Auditing/Advanced Threat Protection** via Defender for SQL.

### 13. High availability and disaster recovery
- **Zone-redundant configuration** (Premium/Business Critical/General Purpose with zone redundancy) spreads replicas across Availability Zones.
- **Auto-failover groups** provide regional DR with automatic endpoint failover.
- Point-in-time restore and long-term retention backups are built in.

### 15. Cost model
```text
Azure SQL Database cost depends mainly on:
service tier/compute tier (vCores or DTUs) + storage
+ backup storage beyond included amount
+ geo-replication/auto-failover group secondary database
```

### 18. Developer example
```csharp
builder.Services.AddDbContext<OrdersContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("Orders")));
```
Connection string using Entra ID authentication with a managed identity (no password):
```text
Server=tcp:my-server.database.windows.net,1433;Database=Orders;Authentication=Active Directory Managed Identity;Encrypt=True;
```

### 19. Azure CLI example
```bash
az sql server create -g my-rg -n my-sql-server --admin-user sqladmin --admin-password <pw>
az sql db create -g my-rg -s my-sql-server -n OrdersDb --service-objective S1
```

### 20. Bicep example
```bicep
resource sqlServer 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: 'my-sql-server'
  location: resourceGroup().location
  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: adminPassword
  }
}

resource sqlDb 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: sqlServer
  name: 'OrdersDb'
  sku: { name: 'S1' }
}
```

### 21. Comparison with similar Azure resources
See [Azure SQL vs SQL Managed Instance vs SQL Server VM](#azure-sql-vs-sql-managed-instance-vs-sql-server-vm) and [Azure SQL vs PostgreSQL vs Cosmos DB](#azure-sql-vs-postgresql-vs-cosmos-db) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-sql/database/

---

## Azure SQL Managed Instance

### 1. What is it?
A PaaS offering that provides near-100% SQL Server instance-level compatibility (cross-database queries, SQL Agent, CLR, Service Broker) while still being a managed service (no OS access, automated patching/backups).

### 4. When should I use it?
Migrating an existing SQL Server instance with minimal code changes, where you depend on instance-level features Azure SQL Database doesn't support.

### 5. When should I NOT use it?
New applications with no legacy instance-level dependency — Azure SQL Database is simpler and often cheaper.

### 8. Important concepts
Deployed **inside a VNet** (unlike Azure SQL Database's logical server model) — requires a dedicated subnet.

### 19. Azure CLI example
```bash
az sql mi create -g my-rg -n my-managed-instance \
  --admin-user sqladmin --admin-password <pw> \
  --subnet <subnet-resource-id> --capacity 4 --storage 32
```

### 20. Bicep example
```bicep
resource managedInstance 'Microsoft.Sql/managedInstances@2023-08-01-preview' = {
  name: 'my-managed-instance'
  location: resourceGroup().location
  sku: { name: 'GP_Gen5', tier: 'GeneralPurpose' }
  identity: { type: 'SystemAssigned' }
  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: adminPassword
    subnetId: subnetId
    vCores: 4
    storageSizeInGB: 32
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-sql/managed-instance/

---

## SQL Server on Azure VM

### 1. What is it?
Running SQL Server yourself inside an IaaS Virtual Machine — full control over the OS and SQL Server instance, same as on-premises.

### 4. When should I use it?
Legacy or highly specialized requirements needing OS-level access, unsupported PaaS features, or specific third-party agents tied to the Windows/SQL Server OS.

### 5. When should I NOT use it?
Anything that could instead run on Azure SQL Database/Managed Instance — you take on full OS/SQL patching and HA responsibility.

### 19. Azure CLI example
```bash
az vm create -g my-rg -n my-sql-vm \
  --image MicrosoftSQLServer:sql2022-ws2022:sqldev:latest \
  --admin-username azureuser --generate-ssh-keys --size Standard_D4s_v5
az sql vm create -g my-rg -n my-sql-vm --license-type PAYG
```

### 20. Bicep example — registering the VM with the SQL IaaS Agent Extension
```bicep
resource sqlVirtualMachine 'Microsoft.SqlVirtualMachine/sqlVirtualMachines@2023-10-01' = {
  name: 'my-sql-vm'
  location: resourceGroup().location
  properties: {
    virtualMachineResourceId: vmId
    sqlServerLicenseType: 'PAYG'
    autoPatchingSettings: { enable: true, dayOfWeek: 'Sunday', maintenanceWindowStartingHour: 2 }
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-sql/virtual-machines/

---

## Azure Database for PostgreSQL (Flexible Server)

### 1. What is it?
A fully managed PostgreSQL database service. **Flexible Server** is the only current deployment model — the older **Single Server** deployment model reached retirement (March 2025) and the original **Hyperscale (Citus)** model is now offered as the **Elastic Clusters** feature within Flexible Server.

### 4. When should I use it?
PostgreSQL is your team's/application's standard, or you're migrating an existing PostgreSQL workload to a managed service.

### 8. Important concepts
- **Burstable / General Purpose / Memory Optimized** compute tiers.
- **High availability (zone-redundant or same-zone)** — a configurable option, not on by default.
- **Elastic Clusters** — horizontal sharding across nodes for very large-scale PostgreSQL workloads (the modern Hyperscale/Citus successor).

### 13. High availability and disaster recovery
Enable zone-redundant HA explicitly if required; it is not automatic. Geo-redundant backup enables cross-region restore for DR.

### 19. Azure CLI example
```bash
az postgres flexible-server create -g my-rg -n my-pg-server \
  --sku-name Standard_D2ds_v5 --tier GeneralPurpose \
  --high-availability ZoneRedundant
```

### 20. Bicep example
```bicep
resource pgServer 'Microsoft.DBforPostgreSQL/flexibleServers@2023-06-01-preview' = {
  name: 'my-pg-server'
  location: resourceGroup().location
  sku: { name: 'Standard_D2ds_v5', tier: 'GeneralPurpose' }
  properties: {
    administratorLogin: 'pgadmin'
    administratorLoginPassword: adminPassword
    version: '16'
    storage: { storageSizeGB: 128 }
    highAvailability: { mode: 'ZoneRedundant' }
  }
}

resource pgDatabase 'Microsoft.DBforPostgreSQL/flexibleServers/databases@2023-06-01-preview' = {
  parent: pgServer
  name: 'ordersdb'
}
```

### 21. Comparison with similar Azure resources
See [Azure SQL vs PostgreSQL vs Cosmos DB](#azure-sql-vs-postgresql-vs-cosmos-db) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/postgresql/flexible-server/

---

## Azure Database for MySQL (Flexible Server)

### 1. What is it?
A fully managed MySQL database service. **Flexible Server** is the only current deployment model — **Single Server reached end of life on September 16, 2024** and is no longer available for new deployments.

### 4. When should I use it?
MySQL is your application's standard engine (e.g., WordPress, many open-source LAMP-stack apps) and you want a managed, patched, backed-up instance.

### 19. Azure CLI example
```bash
az mysql flexible-server create -g my-rg -n my-mysql-server \
  --sku-name Standard_D2ds_v5 --tier GeneralPurpose
```

### 20. Bicep example
```bicep
resource mysqlServer 'Microsoft.DBforMySQL/flexibleServers@2023-12-30' = {
  name: 'my-mysql-server'
  location: resourceGroup().location
  sku: { name: 'Standard_D2ds_v5', tier: 'GeneralPurpose' }
  properties: {
    administratorLogin: 'mysqladmin'
    administratorLoginPassword: adminPassword
    version: '8.0.21'
    storage: { storageSizeGB: 128 }
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/mysql/flexible-server/

---

## Cosmos DB

### 1. What is it?
Cosmos DB is Azure's globally distributed, multi-model NoSQL database service — it can emulate several different data models/APIs (SQL/Core (document), MongoDB (vCore or RU-based), Cassandra, Gremlin (graph), Table), with single-digit-millisecond latency SLAs and turnkey global replication.

### 2. Why does it exist?
Some applications need to scale far beyond a single relational server, operate across multiple regions with low latency everywhere, and tolerate flexible/schemaless data — Cosmos DB targets exactly that class of problem.

### 3. Simple real-world analogy
A chain of warehouses in every city your customers live in, each keeping local stock in sync with the others, instead of one central warehouse everyone must ship to/from.

### 4. When should I use it?
- Globally distributed applications needing low-latency reads/writes in multiple regions.
- High-scale, flexible-schema workloads (IoT telemetry, catalogs, user profiles) where relational joins aren't a core requirement.
- Workloads needing guaranteed low single-digit-millisecond latency at any scale.

### 5. When should I NOT use it?
- Workloads needing complex multi-table joins/transactions and a traditional relational model → Azure SQL/PostgreSQL.
- Small, simple applications where the partitioning design overhead and cost aren't justified.
- `AVOID WHEN`: you pick Cosmos DB "because it's NoSQL and modern" without a concrete scale/latency/distribution requirement.

### 6. Common use cases
- IoT telemetry ingestion.
- Global e-commerce catalogs/personalization.
- Gaming leaderboards/session state needing extremely low latency.

### 7. How it works
```text
Cosmos DB account (global resource, defines consistency + regions)
   └── Database
          └── Container (the scale unit — has its own throughput and partition key)
                 └── Items (documents/rows/nodes depending on API)
```

### 8. Important concepts
- **Account** — the top-level resource; defines API type (SQL/Core, MongoDB, Cassandra, Gremlin, Table) and which regions it's replicated to.
- **Database** — a logical grouping of containers.
- **Container** — the actual scale unit for throughput and storage; **partition key choice happens here and is the single most important design decision**.
- **Item** — one record (a JSON document, in the SQL/Core API).
- **Partition key** — the property used to distribute data/load across physical partitions; a poor choice causes "hot partitions" (one partition absorbing disproportionate traffic), throttling, and poor scale-out.
- **Throughput (RU/s)** — Request Units per second; the currency of "how much work" reads/writes cost; provisioned per container (or database, shared) or **autoscale**/**serverless** for variable workloads.
- **Consistency level** — Strong, Bounded Staleness, Session (default, usually the right choice), Consistent Prefix, Eventual — a spectrum trading off latency/availability for freshness guarantees.
- **Change feed** — an ordered, persistent log of changes to a container, consumed for event-driven processing (e.g., triggering a Function on every new/changed item).

### 11. Identity and security
Prefer **Microsoft Entra ID + RBAC data-plane roles** over account primary/secondary keys where possible; keys grant full account access and don't expire on their own.

### 12. Scaling
Cosmos DB scales horizontally via partitioning — more physical partitions are added automatically as data/throughput grow, assuming the partition key distributes load evenly.

### 13. High availability and disaster recovery
- **Multi-region writes** (multi-master) or single-write-region with multi-region reads, configurable per account.
- Automatic failover priority ordering across regions.
- Zone redundancy available within a region.

### 15. Cost model
```text
Cosmos DB cost depends mainly on:
provisioned or consumed RU/s (throughput)
+ storage (GB)
+ number of regions replicated to (each additional region roughly multiplies throughput cost)
```

### 16. Common mistakes
- Choosing a partition key with low cardinality or skewed access patterns (e.g., a status field with 3 possible values), causing hot partitions.
- Over-provisioning fixed RU/s for spiky workloads instead of using autoscale/serverless.
- Defaulting to Strong consistency everywhere without understanding the latency/availability cost.

### 17. Production recommendations
- Model the partition key around your actual query/write distribution **before** building the application, not after.
- Use autoscale throughput for unpredictable workloads; serverless for low/spiky traffic.
- Use the change feed instead of polling for event-driven downstream processing.

### 18. Developer example
```csharp
using Microsoft.Azure.Cosmos;
using Azure.Identity;

var client = new CosmosClient(
    "https://my-cosmos-account.documents.azure.com:443/",
    new DefaultAzureCredential());

Container container = client.GetContainer("OrdersDb", "Orders");
await container.CreateItemAsync(new Order { Id = "123", CustomerId = "cust-1" },
    new PartitionKey("cust-1"));
```

### 19. Azure CLI example
```bash
az cosmosdb create -g my-rg -n my-cosmos-account --locations regionName=westeurope
az cosmosdb sql database create -g my-rg -a my-cosmos-account -n OrdersDb
az cosmosdb sql container create -g my-rg -a my-cosmos-account -d OrdersDb \
  -n Orders --partition-key-path /customerId --throughput 400
```

### 20. Bicep example
```bicep
resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' = {
  name: 'my-cosmos-account'
  location: resourceGroup().location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      { locationName: resourceGroup().location, failoverPriority: 0 }
    ]
    consistencyPolicy: { defaultConsistencyLevel: 'Session' }
  }
}

resource cosmosDb 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-05-15' = {
  parent: cosmosAccount
  name: 'OrdersDb'
  properties: { resource: { id: 'OrdersDb' } }
}

resource cosmosContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  parent: cosmosDb
  name: 'Orders'
  properties: {
    resource: {
      id: 'Orders'
      partitionKey: { paths: ['/customerId'], kind: 'Hash' }
    }
    options: { autoscaleSettings: { maxThroughput: 4000 } }
  }
}
```

### 21. Comparison with similar Azure resources
See [Azure SQL vs PostgreSQL vs Cosmos DB](#azure-sql-vs-postgresql-vs-cosmos-db) below.

### 22. Interview / knowledge-check questions
- Why is partition key choice the most important Cosmos DB design decision?
- What's the difference between provisioned throughput and serverless/autoscale?
- When would you choose Session consistency over Strong?
- How does the change feed enable event-driven architectures?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/cosmos-db/

---

## Azure Managed Redis

### 1. What is it?
Azure Managed Redis is Microsoft's current managed Redis offering — an in-memory data store used for caching, session state, pub/sub, and leaderboards, built on the Redis engine.

### 2. Why does it exist?
Applications often need extremely fast (sub-millisecond), temporary data access that a disk-based database can't match economically — an in-memory cache solves the "read-heavy, latency-sensitive" problem and reduces load on the primary database.

> [!WARNING]
> **Azure Cache for Redis is on a retirement path.** Verify current retirement dates on Microsoft Learn before designing around it, and prefer **Azure Managed Redis** for new designs.

### 4. When should I use it?
- Cache-aside pattern in front of a database to reduce read load and latency.
- Session state storage for stateless web apps.
- Rate limiting, leaderboards, pub/sub messaging.

### 5. When should I NOT use it?
Using it as a primary system of record — Redis is an in-memory cache; treat anything stored there as disposable/reconstructable unless you've specifically enabled and validated persistence options.

### 8. Important concepts
- **Cache-aside pattern** — app checks cache first; on miss, reads from the database and populates the cache (see companion cheatsheet's architecture patterns section).
- **Eviction policy** — determines what happens when the cache is full (e.g., LRU).
- **Clustering** — partitions data across multiple shards for higher throughput/capacity.

### 15. Cost model
```text
Managed Redis cost depends mainly on:
SKU/tier + memory size + clustering shards + throughput tier
```

### 19. Azure CLI example
```bash
az redisenterprise create -g my-rg -n my-redis-cache \
  --sku Balanced_B0 --location eastus
```

### 20. Bicep example
```bicep
resource redisCache 'Microsoft.Cache/redisEnterprise@2024-09-01-preview' = {
  name: 'my-redis-cache'
  location: resourceGroup().location
  sku: { name: 'Balanced_B0' }
}

resource redisDb 'Microsoft.Cache/redisEnterprise/databases@2024-09-01-preview' = {
  parent: redisCache
  name: 'default'
  properties: {
    clusteringPolicy: 'EnterpriseCluster'
    evictionPolicy: 'NoEviction'
  }
}
```

### 21. Comparison with similar Azure resources
See [Azure SQL vs PostgreSQL vs Cosmos DB](#azure-sql-vs-postgresql-vs-cosmos-db) and the companion cheatsheet's cache-aside pattern.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/redis/

---

# 5. 📨 Messaging and Integration

## Fast mental model
```text
Need reliable point-to-point/queue/topic messaging with enterprise features (sessions, dead-letter)?
   → Service Bus

Need to react to "something happened" (a blob was created, a resource changed)?
   → Event Grid

Need to ingest and process millions of events/telemetry per second (streaming)?
   → Event Hubs

Need the cheapest, simplest possible durable queue, no enterprise features?
   → Storage Queue
```

## Service Bus

### 1. What is it?
Service Bus is an enterprise message broker supporting queues (point-to-point) and topics/subscriptions (publish-subscribe), with features like sessions, transactions, dead-lettering, and duplicate detection.

### 2. Why does it exist?
Decoupling producers from consumers is essential at scale — if a consumer is slow/down, messages queue up instead of being lost or overwhelming the consumer. Service Bus adds enterprise reliability features beyond a basic queue.

### 3. Simple real-world analogy
A post office with registered mail: messages are stored safely, delivered in order where required, and nothing is lost even if the recipient is temporarily unavailable.

### 4. When should I use it?
- Order processing pipelines, financial transactions — anywhere message loss/duplication/ordering matters.
- Publish-subscribe with multiple independent consumers via topics/subscriptions.
- Workloads needing message sessions (grouped, ordered processing) or scheduled/deferred delivery.

### 5. When should I NOT use it?
- High-throughput telemetry/streaming ingestion (millions of events/sec) → **Event Hubs**.
- Simple reactive "resource changed" notifications → **Event Grid**.
- `AVOID WHEN`: you only need a trivial, low-volume queue — Storage Queue is cheaper and simpler.

### 6. Common use cases
- Order/payment processing decoupling a web frontend from backend workers.
- Competing consumers pattern (queue-based load leveling) for buffering spiky load.
- Multi-subscriber event fan-out (one topic, many subscriptions, each with its own filter).

### 7. How it works
```text
Producer → sends message → Queue (or Topic)
                                   ↓
                     Topic fans out to each Subscription
                                   ↓
                        Consumer(s) receive & complete/abandon/dead-letter the message
```

### 8. Important concepts
- **Queue** — point-to-point; one message is consumed by exactly one receiver.
- **Topic / Subscription** — publish-subscribe; each subscription gets its own copy of matching messages (with optional SQL/correlation filters).
- **Session** — groups related messages (e.g., all messages for one order) guaranteeing ordered, single-consumer processing of that group.
- **Dead-letter queue (DLQ)** — where messages go after exceeding max delivery attempts or on explicit dead-lettering, so poison messages don't block the queue forever.
- **Duplicate detection** — the broker can automatically discard duplicate sends within a configurable time window.
- **Lock duration / PeekLock** — a receiver locks a message while processing; if not completed in time, it becomes available again (at-least-once delivery — **design consumers to be idempotent**).

### 11. Identity and security
Use **Managed Identity + Entra ID RBAC** (`Azure Service Bus Data Sender`/`Receiver`) instead of shared access signature (SAS) connection strings where possible.

### 12. Scaling
- **Standard tier** — shared multi-tenant infrastructure, scales automatically.
- **Premium tier** — dedicated resources (messaging units), predictable performance, supports larger message sizes and VNet integration.

### 13. High availability and disaster recovery
- **Availability Zones** supported on Premium tier.
- **Geo-disaster recovery** (metadata-only pairing; messages are not replicated — you fail over the namespace alias, not the message backlog) — verify current behavior before relying on it for message-level DR.

### 16. Common mistakes
- Not handling duplicate delivery — Service Bus (like most brokers) provides at-least-once delivery; non-idempotent consumers cause double processing.
- Ignoring the dead-letter queue — poison messages pile up silently if nothing monitors the DLQ.
- Using Queues when you actually need fan-out to multiple independent consumers (use Topics instead).

### 18. Developer example
```csharp
await using var client = new ServiceBusClient(
    "my-namespace.servicebus.windows.net",
    new DefaultAzureCredential());

ServiceBusProcessor processor = client.CreateProcessor("orders", new ServiceBusProcessorOptions());

processor.ProcessMessageAsync += async args =>
{
    string body = args.Message.Body.ToString();
    // idempotent processing here
    await args.CompleteMessageAsync(args.Message);
};
processor.ProcessErrorAsync += args => Task.CompletedTask;

await processor.StartProcessingAsync();
```

### 19. Azure CLI example
```bash
az servicebus namespace create -g my-rg -n my-sb-namespace --sku Standard
az servicebus queue create -g my-rg --namespace-name my-sb-namespace -n orders
```

### 20. Bicep example
```bicep
resource sbNamespace 'Microsoft.ServiceBus/namespaces@2024-01-01' = {
  name: 'my-sb-namespace'
  location: resourceGroup().location
  sku: { name: 'Standard' }
}

resource queue 'Microsoft.ServiceBus/namespaces/queues@2024-01-01' = {
  parent: sbNamespace
  name: 'orders'
  properties: {
    deadLetteringOnMessageExpiration: true
  }
}
```

### 21. Comparison with similar Azure resources
See [Service Bus vs Event Grid vs Event Hubs vs Storage Queue](#service-bus-vs-event-grid-vs-event-hubs-vs-storage-queue) below.

### 22. Interview / knowledge-check questions
- What's the difference between a queue and a topic/subscription?
- Why must Service Bus consumers be idempotent?
- When would you use message sessions?
- How does the dead-letter queue help with poison messages?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/service-bus-messaging/

---

## Event Grid

### 1. What is it?
Event Grid is a fully managed **event routing** service built around the publish-subscribe model for discrete, lightweight event notifications — "something happened" (a blob was created, a resource was modified, a custom app event occurred) — routed to one or more subscribers (Functions, Logic Apps, Service Bus, webhooks, etc.).

### 3. Simple real-world analogy
A notification switchboard: the instant something happens, it immediately rings everyone who asked to be told, then forgets about it.

### 4. When should I use it?
- Reacting to Azure resource lifecycle events (blob created, resource group changed).
- Lightweight, near-real-time fan-out of discrete application events to multiple independent subscribers.

### 5. When should I NOT use it?
- High-volume telemetry/streaming ingestion → Event Hubs.
- Guaranteed ordered/session-based processing with enterprise reliability features → Service Bus.

### 8. Important concepts
- **Event** — a small JSON payload describing something that happened (not the full data itself, typically).
- **Topic** — the channel events are published to (system topics for Azure resources, custom topics for your own apps).
- **Event subscription** — a handler + optional filter attached to a topic.
- **Push delivery** — Event Grid pushes events to subscribers (unlike Event Hubs/Service Bus, which are typically pulled from).
- **Event schema** — Event Grid can emit the CloudEvents standard schema or its own native schema; prefer CloudEvents for interoperability.
- **Dead-lettering and retry policy** — failed deliveries retry with exponential backoff, then dead-letter to a Storage container if configured.

### 11. Identity and security
Use **Managed Identity** for Event Grid to deliver to secured endpoints (e.g., a Function requiring auth), and use Entra ID RBAC (`EventGrid Data Sender`) instead of topic access keys where possible.

### 18. Developer example — publishing a custom event (C#)
```csharp
using Azure.Identity;
using Azure.Messaging.EventGrid;

var client = new EventGridPublisherClient(
    new Uri("https://my-topic.westeurope-1.eventgrid.azure.net/api/events"),
    new DefaultAzureCredential());

await client.SendEventAsync(new EventGridEvent(
    subject: "orders/123",
    eventType: "Orders.OrderCreated",
    dataVersion: "1.0",
    data: new { orderId = "123", customerId = "cust-1" }));
```

### 18. Developer example — handling it in an Azure Function (Event Grid trigger)
```csharp
[Function("HandleOrderCreated")]
public void Run([EventGridTrigger] EventGridEvent orderEvent)
{
    _logger.LogInformation("Received event: {Type}, subject: {Subject}",
        orderEvent.EventType, orderEvent.Subject);
}
```

### 19. Azure CLI example
```bash
az eventgrid topic create -g my-rg -n my-topic -l westeurope
az eventgrid event-subscription create \
  --source-resource-id <topic-resource-id> \
  --name my-subscription \
  --endpoint <function-or-webhook-endpoint> \
  --endpoint-type webhook
```

### 20. Bicep example
```bicep
resource topic 'Microsoft.EventGrid/topics@2023-12-15-preview' = {
  name: 'my-topic'
  location: resourceGroup().location
  properties: {
    inputSchema: 'CloudEventSchemaV1_0'
  }
}
```

### 21. Comparison with similar Azure resources
See [Service Bus vs Event Grid vs Event Hubs vs Storage Queue](#service-bus-vs-event-grid-vs-event-hubs-vs-storage-queue) and [Event Grid vs Service Bus](#event-grid-vs-service-bus) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/event-grid/

---

## Event Hubs

### 1. What is it?
Event Hubs is a big-data streaming ingestion service capable of receiving and processing millions of events per second — think of it as Azure's equivalent to Apache Kafka (and it even offers a Kafka-compatible protocol endpoint).

### 2. Why does it exist?
Telemetry/clickstream/IoT-scale data arrives far too fast for a traditional queue to buffer message-by-message with per-message guarantees; Event Hubs is built around high-throughput, ordered-within-partition log ingestion instead, closer to a durable, replayable stream than a queue.

### 3. Simple real-world analogy
A firehose feeding a reservoir: the firehose (producers) never stops, and multiple independent outflow pipes (consumer groups) can each draw from the reservoir at their own pace without affecting each other.

### 4. When should I use it?
- Telemetry ingestion at massive scale (IoT, clickstreams, application logs).
- Feeding real-time analytics pipelines (Stream Analytics, Databricks, Data Explorer).
- Kafka-based applications migrating to Azure without rewriting the client (via the Kafka-compatible endpoint).

### 5. When should I NOT use it?
Simple discrete business events with enterprise delivery guarantees needed per-message (use Service Bus) or simple resource-change notifications (use Event Grid).

### 7. How it works
```text
Producers → Event Hub (split into partitions, e.g. 4 partitions)
                 ↓
   Partition 0 → Consumer Group "analytics" reads independently
   Partition 1 → Consumer Group "archive" reads independently (same events, own pace)
```

### 8. Important concepts
- **Partition** — Event Hubs scales by splitting the stream into partitions; consumers read from specific partitions for parallelism; events within one partition retain order.
- **Consumer group** — an independent "view" of the stream, letting multiple applications read the same events independently at their own pace (offset tracking is per consumer group).
- **Checkpointing** — consumers record how far they've read (commonly into a Storage Account via the Event Processor Client) so they can resume after a restart without reprocessing everything.
- **Capture** — automatically archives incoming events to Blob Storage/Data Lake as they arrive, with zero code.
- **Throughput Units / Processing Units** — the scale/capacity dimension you provision (Standard tier uses Throughput Units; Premium/Dedicated use Processing Units/Capacity Units).

### 11. Identity and security
Use **Managed Identity + Entra ID RBAC** (`Azure Event Hubs Data Sender`/`Receiver`) instead of SAS connection strings where possible.

### 15. Cost model
```text
Event Hubs cost depends mainly on:
tier (Basic/Standard/Premium/Dedicated) + Throughput/Processing Units provisioned
+ ingress events + Capture feature (if enabled) + storage for Capture output
```

### 16. Common mistakes
- Using too few partitions, limiting maximum parallel consumer throughput (partition count cannot be decreased later, and increasing it affects key-to-partition mapping — plan it upfront).
- Not checkpointing frequently enough, causing large reprocessing windows on restart.

### 18. Developer example — sending events (C#)
```csharp
using Azure.Identity;
using Azure.Messaging.EventHubs;
using Azure.Messaging.EventHubs.Producer;

await using var producer = new EventHubProducerClient(
    "my-namespace.servicebus.windows.net", "telemetry-hub",
    new DefaultAzureCredential());

using EventDataBatch batch = await producer.CreateBatchAsync();
batch.TryAdd(new EventData(BinaryData.FromString("{\"temp\":21.5}")));
await producer.SendAsync(batch);
```

### 18. Developer example — consuming with checkpointing (C#)
```csharp
using Azure.Messaging.EventHubs.Consumer;
using Azure.Storage.Blobs;

var storageClient = new BlobContainerClient(
    new Uri("https://mystorageacct.blob.core.windows.net/checkpoints"),
    new DefaultAzureCredential());

var processor = new EventProcessorClient(
    storageClient, EventHubConsumerClient.DefaultConsumerGroupName,
    "my-namespace.servicebus.windows.net", "telemetry-hub",
    new DefaultAzureCredential());

processor.ProcessEventAsync += async args =>
{
    Console.WriteLine(args.Data.EventBody.ToString());
    await args.UpdateCheckpointAsync();
};
processor.ProcessErrorAsync += args => Task.CompletedTask;
await processor.StartProcessingAsync();
```

### 19. Azure CLI example
```bash
az eventhubs namespace create -g my-rg -n my-eh-namespace --sku Standard
az eventhubs eventhub create -g my-rg --namespace-name my-eh-namespace \
  -n telemetry-hub --partition-count 4 --message-retention 1
```

### 20. Bicep example
```bicep
resource ehNamespace 'Microsoft.EventHub/namespaces@2024-01-01' = {
  name: 'my-eh-namespace'
  location: resourceGroup().location
  sku: { name: 'Standard', tier: 'Standard', capacity: 1 }
}

resource eventHub 'Microsoft.EventHub/namespaces/eventhubs@2024-01-01' = {
  parent: ehNamespace
  name: 'telemetry-hub'
  properties: { partitionCount: 4, messageRetentionInDays: 1 }
}
```

### 22. Interview / knowledge-check questions
- Why can't you decrease an Event Hub's partition count after creation?
- What's the purpose of a consumer group, and why can multiple consumer groups read the same data independently?
- How does checkpointing prevent reprocessing the entire stream after a consumer restarts?

### 21. Comparison with similar Azure resources
See [Service Bus vs Event Grid vs Event Hubs vs Storage Queue](#service-bus-vs-event-grid-vs-event-hubs-vs-storage-queue) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/event-hubs/

---

## Storage Queue

Covered in the Storage section above — the simplest, lowest-cost durable queue, built into a Storage Account, lacking Service Bus's enterprise features (no topics, sessions, or transactions). Use it only for simple, low-volume background work where Service Bus's extra capability isn't needed.

---

## Logic Apps

### 1. What is it?
Logic Apps is a low-code/no-code workflow orchestration service — you build workflows visually (or in JSON) by connecting triggers and hundreds of prebuilt connectors (Office 365, Salesforce, SAP, SFTP, databases, Azure services) without writing custom code for each integration.

### 2. Why does it exist?
Many integration workflows are mostly "glue" between systems (if this happens, do these five steps, calling these external APIs) — Logic Apps lets you build and maintain that glue visually instead of as custom application code.

### 3. Simple real-world analogy
An assembly line of interchangeable, pre-built stations (connectors) you snap together, versus building every machine on the line yourself (custom code).

### 4. When should I use it?
- Business process automation and system integration with many external SaaS/enterprise connectors.
- Workflows best understood/maintained visually by a broader (not purely developer) audience.

### 5. When should I NOT use it?
- Performance-critical, high-throughput data processing — Functions/Container Apps give more control and typically better throughput/cost at scale.
- Complex custom logic that's awkward to express visually — plain code is often clearer and more testable.

### 8. Important concepts
- **Consumption plan** — pay-per-execution, multi-tenant.
- **Standard plan** — single-tenant, runs on the same underlying model as Functions (App Service-like), better for VNet integration and performance predictability.
- **Connector** — a prebuilt integration to a specific system/API.
- **Trigger/Action** — same mental model as Functions (what starts it, what it does).

### 19. Azure CLI example
```bash
az logic workflow create -g my-rg -n my-workflow -l westeurope \
  --definition workflow-definition.json
```

### 20. Bicep example — simple Consumption Logic App with a recurrence trigger
```bicep
resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'my-workflow'
  location: resourceGroup().location
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      triggers: {
        Recurrence: {
          type: 'Recurrence'
          recurrence: { frequency: 'Hour', interval: 1 }
        }
      }
      actions: {}
    }
  }
}
```

### 21. Comparison with similar Azure resources
See [Functions vs Logic Apps](#functions-vs-logic-apps) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/logic-apps/

---

## API Management

> Also commonly referred to informally as "**Azure API Gateway**" — APIM *is* Azure's API gateway product; there is no separate service literally named "Azure API Gateway."

### 1. What is it?
API Management (APIM) is a gateway and management layer that sits in front of your backend APIs — providing a consistent facade, authentication/authorization enforcement, rate limiting, caching, transformation, versioning, and a developer portal, regardless of how the backend is actually implemented.

### 2. Why does it exist?
Backend services change technology, scale, and location over time; consumers need a stable contract. APIM decouples "what the API looks like to consumers" from "how it's actually implemented," while centralizing cross-cutting concerns (auth, rate limiting, logging).

### 3. Simple real-world analogy
A hotel concierge desk: guests always talk to the same desk (APIM) regardless of which department (backend) actually fulfills their request, and the desk enforces house rules (policies) consistently.

### 4. When should I use it?
- Exposing internal/microservice APIs externally with a consistent, governed contract.
- Needing centralized throttling, quota enforcement, subscription keys, or OAuth validation in front of multiple backends.
- API monetization/productization with a developer portal.

### 5. When should I NOT use it?
Internal-only, single-team APIs with no need for a gateway layer — adding APIM there is often unnecessary complexity/cost.

### 6. Common use cases
- Facade in front of multiple microservices, presenting one unified public API surface.
- Rate limiting/quota per API consumer ("subscription").
- Protocol/format transformation (e.g., SOAP backend exposed as REST/JSON).

### 7. How it works
```text
Client → APIM Gateway (auth, rate limit, transform via policies) → Backend (App Service / Functions / AKS / on-prem)
```

### 8. Important concepts
- **Product** — a bundle of APIs exposed together, governed by subscription keys/quotas.
- **Policy** — an XML-based pipeline step (inbound/outbound/backend/on-error) implementing cross-cutting logic — rate limiting, JWT validation, header rewriting, caching, mocking.
- **Developer portal** — a self-service portal where API consumers discover APIs and obtain subscription keys.
- **Named values** — reusable configuration/secret references (can integrate with Key Vault) used inside policies.

### 11. Identity and security
Validate OAuth2/JWT tokens at the gateway (`validate-jwt` policy) so backends don't each need to reimplement token validation; use Managed Identity for APIM to call Key Vault for named-value secrets.

### 18. Example policy — rate limit + JWT validation (XML)
```xml
<policies>
  <inbound>
    <rate-limit calls="100" renewal-period="60" />
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401">
      <openid-config url="https://login.microsoftonline.com/{tenant}/v2.0/.well-known/openid-configuration" />
      <audiences><audience>api://my-api</audience></audiences>
    </validate-jwt>
    <set-backend-service base-url="https://my-backend.azurewebsites.net" />
  </inbound>
</policies>
```

### 19. Azure CLI example
```bash
az apim create -g my-rg -n my-apim --publisher-email admin@contoso.com \
  --publisher-name Contoso --sku-name Developer
az apim api create -g my-rg --service-name my-apim --api-id my-api \
  --path /orders --display-name "Orders API" \
  --service-url https://my-backend.azurewebsites.net
```

### 20. Bicep example
```bicep
resource apim 'Microsoft.ApiManagement/service@2023-09-01-preview' = {
  name: 'my-apim'
  location: resourceGroup().location
  sku: { name: 'Developer', capacity: 1 }
  properties: {
    publisherEmail: 'admin@contoso.com'
    publisherName: 'Contoso'
  }
}
```

### 21. Comparison with similar Azure resources
APIM is typically placed **behind** Front Door/Application Gateway (for global/WAF concerns) and **in front of** your actual backend compute.

### 22. Interview / knowledge-check questions
- What problem does API Management solve that a single backend service cannot?
- What is a policy, and where can policies be applied in the pipeline?
- How would you enforce per-consumer rate limiting?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/api-management/

---

## SignalR Service

### 1. What is it?
Azure SignalR Service is a fully managed real-time messaging service that offloads the WebSocket/real-time connection management for ASP.NET Core SignalR applications (live chat, dashboards, notifications) so your app servers don't have to hold thousands of persistent connections themselves.

### 4. When should I use it?
Real-time push scenarios in .NET apps: live dashboards, chat, collaborative editing, notifications — especially when scaling beyond what a single app server's connection count could handle.

### 5. When should I NOT use it?
Non-.NET real-time scenarios or when you need multi-protocol/cross-platform pub/sub beyond SignalR's client model — consider **Web PubSub** instead.

### 7. How it works
Your ASP.NET Core app still writes normal SignalR hub code; instead of clients connecting directly to your app server, SignalR Service sits in between, holding the persistent WebSocket connections and forwarding messages to/from your app via a lightweight server connection — so your app server can scale stateless and handle many more logical clients than its own connection limit would allow.

### 8. Important concepts
- **Default mode** — your app handles hub logic as normal; SignalR Service just relays.
- **Serverless mode** — no persistent app server at all; Azure Functions handle events (useful with Consumption-plan Functions).
- **Unit** — the scale/capacity dimension (max concurrent connections + messages/sec).

### 18. Developer example — ASP.NET Core Program.cs
```csharp
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddSignalR().AddAzureSignalR(); // reads connection string/Managed Identity config
var app = builder.Build();
app.MapHub<ChatHub>("/chatHub");
app.Run();

public class ChatHub : Hub
{
    public async Task SendMessage(string user, string message) =>
        await Clients.All.SendAsync("ReceiveMessage", user, message);
}
```

### 19. Azure CLI example
```bash
az signalr create -g my-rg -n my-signalr --sku Standard_S1 --service-mode Default
az signalr key list -g my-rg -n my-signalr
```

### 20. Bicep example
```bicep
resource signalR 'Microsoft.SignalRService/signalR@2023-08-01-preview' = {
  name: 'my-signalr'
  location: resourceGroup().location
  sku: { name: 'Standard_S1', capacity: 1 }
  properties: { features: [ { flag: 'ServiceMode', value: 'Default' } ] }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-signalr/

---

## Web PubSub

### 1. What is it?
Azure Web PubSub is a managed WebSocket service for building real-time messaging applications using any WebSocket-capable client/language (not limited to the SignalR protocol/.NET), including a publish-subscribe model.

### 4. When should I use it?
Real-time scenarios needing raw WebSocket flexibility or non-.NET clients — IoT dashboards, cross-platform chat, general pub/sub over WebSockets.

### 18. Developer example — C# (server sends a message to all clients in a group)
```csharp
using Azure.Identity;
using Azure.Messaging.WebPubSub;

var client = new WebPubSubServiceClient(
    new Uri("https://my-webpubsub.webpubsub.azure.com"), "chat",
    new DefaultAzureCredential());

await client.SendToAllAsync("Hello everyone!");
await client.GroupExists("room-1");
```

### 19. Azure CLI example
```bash
az webpubsub create -g my-rg -n my-webpubsub --sku Standard_S1 -l westeurope
```

### 20. Bicep example
```bicep
resource webPubSub 'Microsoft.SignalRService/webPubSub@2024-03-01' = {
  name: 'my-webpubsub'
  location: resourceGroup().location
  sku: { name: 'Standard_S1', tier: 'Standard', capacity: 1 }
  properties: {
    hub: 'chat'
  }
}
```

### 21. Comparison with similar Azure resources
| Requirement | SignalR Service | Web PubSub |
|---|---|---|
| Best fit | ASP.NET Core SignalR apps | Any WebSocket client/language, general pub/sub |
| Protocol | SignalR protocol | Raw WebSocket / PubSub protocol |

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-web-pubsub/

---

# 6. 🔐 Identity and Security

## Microsoft Entra ID

### 1. What is it?
Microsoft Entra ID (formerly Azure Active Directory) is Microsoft's cloud identity platform — it stores users, groups, and application registrations, and issues the tokens (OAuth2/OpenID Connect) that prove "who is this" and "what are they allowed to do" across Azure and connected applications.

### 2. Why does it exist?
Every secure system needs a single source of truth for identity. Entra ID is that source for Azure itself (every RBAC assignment references an Entra ID identity) and for your own applications (sign-in, API protection).

### 4. When should I use it?
Always — every Azure subscription is backed by exactly one Entra ID tenant. For application development, use it whenever you need user sign-in or secured API-to-API calls.

### 8. Important concepts
- **Tenant** — your organization's dedicated, isolated instance of Entra ID.
- **User / Group** — identity objects for humans and collections of humans.
- **App Registration** — the definition of an application in Entra ID (see below).
- **Enterprise Application** — the "service principal" representation of an app in your tenant, used for assigning access/SSO (see below).
- **Conditional Access** — policy engine that can require MFA, block legacy auth, or restrict sign-in by location/device risk.

### 18. Developer example — acquiring a token and calling Microsoft Graph (C#)
```csharp
using Azure.Identity;
using Microsoft.Graph;

var credential = new DefaultAzureCredential();
var graphClient = new GraphServiceClient(credential, new[] { "https://graph.microsoft.com/.default" });

var me = await graphClient.Me.GetAsync();
Console.WriteLine(me.DisplayName);
```

### 19. Azure CLI example — everyday identity operations
```bash
az ad signed-in-user show
az ad user list --query "[].{Name:displayName, UPN:userPrincipalName}" -o table
az ad group create --display-name "App-Readers" --mail-nickname app-readers
az role assignment create --assignee <object-id> --role Reader --scope <resource-id>
```

> [!NOTE]
> **Entra ID objects are Microsoft Graph objects, not classic ARM resources.** Users, groups, app registrations, and service principals are not deployed through standard `Microsoft.*` ARM/Bicep `resource` blocks the way a VM or storage account is — they live in Microsoft Graph, not the Azure Resource Manager control plane. The practical IaC options are: (1) the Microsoft Graph CLI/PowerShell (`az ad` commands above, or `Microsoft.Graph` PowerShell module) scripted into your pipeline, (2) Terraform's `azuread` provider, or (3) the **Microsoft Graph Bicep extension**, which is in preview at the time of writing — verify its current GA status on Microsoft Learn before depending on it for production pipelines.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/entra/fundamentals/

---

## App Registration

### 1. What is it?
An App Registration is the definition of an application's identity in Entra ID — its name, redirect URIs, API permissions, and the credentials (certificate/secret) or federated identity it can use to authenticate.

### 2. Why does it exist?
Applications (not just humans) need an identity to sign users in (OAuth2/OIDC) or to call APIs on their own behalf — App Registration is how you declare "this application exists and here's how it proves who it is."

### 4. When should I use it?
Whenever you build a custom application that needs to sign in users, call a secured API, or expose its own API for other apps to call.

### 8. Important concepts
- **Application (client) ID** — the unique identifier for the app registration.
- **Redirect URI** — where Entra ID sends the user back after sign-in.
- **API permissions (scopes)** — what the app is allowed to request access to (e.g., Microsoft Graph `User.Read`).
- **Client secret / certificate** — credentials the app uses to authenticate itself (prefer certificates or federated credentials over secrets where possible).
- Creating an App Registration automatically creates a matching **Enterprise Application** (service principal) in your tenant.

### 18. Developer example — sign-in with MSAL (C#, confidential client)
```csharp
using Microsoft.Identity.Client;

var app = ConfidentialClientApplicationBuilder.Create("<client-id>")
    .WithClientSecret("<client-secret-or-use-certificate>")
    .WithAuthority(new Uri("https://login.microsoftonline.com/<tenant-id>"))
    .Build();

var result = await app.AcquireTokenForClient(new[] { "api://my-api/.default" })
    .ExecuteAsync();
```

### 19. Azure CLI example
```bash
az ad app create --display-name "my-app" \
  --web-redirect-uris "https://my-app.azurewebsites.net/signin-oidc"
az ad app credential reset --id <app-id> --append  # creates a client secret
az ad app permission add --id <app-id> \
  --api 00000003-0000-0000-c000-000000000000 \
  --api-permissions e1fe6dd8-ba31-4d61-89e7-88639da4683d=Scope  # Graph User.Read
```

### 21. Comparison with similar Azure resources
See [Managed Identity vs Service Principal](#managed-identity-vs-service-principal) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/entra/identity-platform/quickstart-register-app

---

## Enterprise Application

### 1. What is it?
The Enterprise Application object is the **service principal** representation of an application inside your specific tenant — it's where you assign users/groups access, configure SSO, and manage per-tenant settings for an app (your own, or a third-party/multi-tenant SaaS app).

### 8. Important concepts
An App Registration (the global definition, owned by the app's publisher tenant) and its Enterprise Application / service principal (the local, per-tenant instance used for access assignment) are two sides of the same application identity.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/entra/identity/enterprise-apps/

---

## Service Principal

### 1. What is it?
A service principal is the identity an **application** (not a human) uses to authenticate and be assigned permissions — the non-interactive equivalent of a user account, backed by a secret, certificate, or federated credential.

### 4. When should I use it?
When a workload running **outside Azure** (on-prem, another cloud, a CI/CD pipeline) needs to authenticate to Azure and Managed Identity isn't available (Managed Identity only works for resources running inside Azure).

### 5. When should I NOT use it?
For workloads **running inside Azure** (a VM, App Service, Function, AKS pod) — use **Managed Identity** instead; it eliminates the need to store/rotate a secret at all.

### 11. Identity and security
Prefer **workload identity federation** (e.g., a GitHub Actions OIDC token exchanged for an Azure token) over long-lived client secrets for CI/CD service principals — it removes the stored-secret risk entirely.

### 21. Comparison with similar Azure resources
See [Managed Identity vs Service Principal](#managed-identity-vs-service-principal) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/entra/identity-platform/app-objects-and-service-principals

---

## Managed Identity

### 1. What is it?
A Managed Identity is an automatically-managed Entra ID identity tied directly to an Azure resource (VM, App Service, Function App, Container App, AKS pod, etc.) — Azure handles credential issuance and rotation for you entirely; your code never sees or stores a secret.

### 2. Why does it exist?
The single biggest source of real-world cloud credential leaks is secrets stored in code, configuration, or CI/CD variables. Managed Identity removes the secret from the equation entirely for Azure-to-Azure authentication.

### 4. When should I use it?
Any workload running inside Azure that needs to call another Azure service (Key Vault, Storage, SQL, Service Bus, etc.) — this should be your **default** authentication pattern, not an exception.

### 5. When should I NOT use it?
Workloads running outside Azure — use a Service Principal with workload identity federation instead.

### 8. Important concepts
- **System-assigned** — tied to the lifecycle of exactly one resource; deleted automatically when the resource is deleted.
- **User-assigned** — a standalone Azure resource you create once and attach to one or more compute resources; survives independently and can be shared/reused.
- `DefaultAzureCredential` (Azure SDK) — automatically discovers and uses the managed identity (or developer credentials locally) without code changes between environments.

### 19. Azure CLI example
```bash
# System-assigned, enabled directly on a Web App
az webapp identity assign -g my-rg -n my-webapp

# User-assigned, created once and attached to multiple resources
az identity create -g my-rg -n my-shared-identity
az webapp identity assign -g my-rg -n my-webapp \
  --identities /subscriptions/<sub>/resourceGroups/my-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/my-shared-identity

# Grant it access to Key Vault secrets (RBAC model)
az role assignment create --assignee <principal-id> \
  --role "Key Vault Secrets User" --scope <keyvault-resource-id>
```

### 20. Bicep example — user-assigned identity attached to App Service
```bicep
resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'my-shared-identity'
  location: resourceGroup().location
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: 'my-webapp'
  location: resourceGroup().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: { '${identity.id}': {} }
  }
  properties: { serverFarmId: appServicePlanId }
}
```

### 21. Comparison with similar Azure resources
See [System-assigned vs User-assigned Managed Identity](#system-assigned-vs-user-assigned-managed-identity) below.

### 22. Interview / knowledge-check questions
- Why is Managed Identity preferred over storing a connection string?
- When would you need a user-assigned identity instead of system-assigned?
- How does `DefaultAzureCredential` behave differently locally vs. in Azure?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/overview

---

## Key Vault

### 1. What is it?
Key Vault is a managed service for securely storing and accessing secrets, encryption keys, and TLS/SSL certificates — with strict access control, auditing, and (optionally) hardware-backed key protection.

### 2. Why does it exist?
Secrets hardcoded in application config or source code are a leading cause of breaches. Key Vault centralizes secret storage with fine-grained access control and a full audit trail, and lets applications fetch secrets at runtime instead of baking them in.

### 3. Simple real-world analogy
A bank's safe deposit box system: valuables (secrets/keys/certs) are stored centrally, access is logged, and only authorized people/systems (via RBAC) can open specific boxes.

### 4. When should I use it?
Every application secret, connection string, API key, encryption key, or certificate that your application needs at runtime.

### 6. Common use cases
- Storing database connection strings/API keys referenced by App Service/Functions/Container Apps.
- Centralized TLS certificate management (including auto-renewal integration for some services).
- Customer-managed encryption keys for Storage/SQL/Disks requiring stricter compliance.

### 8. Important concepts
- **Secret** — an arbitrary string (connection string, API key, password).
- **Key** — a cryptographic key used for encrypt/decrypt/sign operations (can be software-protected or HSM-protected).
- **Certificate** — manages the full lifecycle (and can auto-generate the associated private key + secret).
- **Access policy (legacy) vs Azure RBAC (current recommended model)** — two different authorization models for Key Vault data-plane access; new vaults should use RBAC.
- **Soft delete + purge protection** — prevents immediate, permanent deletion of secrets/keys, protecting against accidental or malicious deletion.

### 10. Networking
Public by default with firewall IP rules; use **Private Endpoint** to remove public network access for production.

### 11. Identity and security
Access should be via **Managed Identity + Azure RBAC data-plane roles** (`Key Vault Secrets User`, etc.) — never via a shared master key (Key Vault has no such key by design).

### 15. Cost model
```text
Key Vault cost depends mainly on:
number of operations (get/set secret, sign, etc.)
+ HSM-protected key premium (if used)
+ Managed HSM (separate, much higher-cost dedicated HSM pool, if used)
```

### 16. Common mistakes
- Using the legacy access-policy model for new vaults instead of RBAC.
- Not enabling purge protection, risking permanent loss of keys/secrets.
- Storing non-secret configuration in Key Vault (adds latency/cost/complexity for no security benefit) instead of plain app configuration.

### 18. Developer example
```csharp
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;

var client = new SecretClient(
    new Uri("https://my-keyvault.vault.azure.net/"),
    new DefaultAzureCredential());

KeyVaultSecret secret = await client.GetSecretAsync("OrdersDbConnectionString");
```

### 19. Azure CLI example
```bash
az keyvault create -g my-rg -n my-keyvault --enable-rbac-authorization true
az role assignment create --assignee <principal-id> \
  --role "Key Vault Secrets User" --scope <keyvault-resource-id>
```

### 20. Bicep example
```bicep
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'my-keyvault'
  location: resourceGroup().location
  properties: {
    sku: { family: 'A', name: 'standard' }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
    enableSoftDelete: true
    enablePurgeProtection: true
  }
}
```

### 21. Comparison with similar Azure resources
See [Key Vault vs Managed HSM](#key-vault-vs-managed-hsm) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/key-vault/

---

## Managed HSM

### 1. What is it?
Managed HSM is a dedicated, single-tenant, FIPS 140-2 Level 3-validated hardware security module pool for the highest-assurance key management needs — compared to Key Vault's multi-tenant HSM-backed keys option.

### 4. When should I use it?
Strict regulatory/compliance requirements mandating dedicated (not shared) HSM hardware, full administrative control over the HSM security domain, or very high-throughput cryptographic operations.

### 5. When should I NOT use it?
Standard application secret/key/certificate management — Key Vault (Premium tier, with HSM-backed keys) covers the vast majority of real-world needs at much lower cost/complexity.

### 19. Azure CLI example
```bash
az keyvault create --hsm-name my-managed-hsm -g my-rg -l eastus \
  --administrators <object-id> --retention-days 90
```

### 20. Bicep example
```bicep
resource managedHsm 'Microsoft.KeyVault/managedHSMs@2023-07-01' = {
  name: 'my-managed-hsm'
  location: resourceGroup().location
  sku: { family: 'B', name: 'Standard_B1' }
  properties: {
    tenantId: subscription().tenantId
    initialAdminObjectIds: [adminObjectId]
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enablePurgeProtection: true
  }
}
```

### 21. Comparison with similar Azure resources
See [Key Vault vs Managed HSM](#key-vault-vs-managed-hsm) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/key-vault/managed-hsm/

---

## Microsoft Defender for Cloud

### 1. What is it?
Defender for Cloud is Azure's cloud security posture management (CSPM) and workload protection (CWPP) service — it continuously assesses your resources against security best practices and (with the paid Defender plans enabled) provides active threat detection per resource type (servers, containers, SQL, storage, Key Vault, etc.).

### 4. When should I use it?
Every subscription — the free tier (Foundational CSPM) gives baseline recommendations at no cost; enable specific Defender plans for workloads where active threat detection matters.

### 8. Important concepts
- **Secure score** — an aggregate measure of your security posture against recommendations.
- **Defender plans** — per-resource-type paid add-ons (Defender for Servers, Containers, SQL, Storage, Key Vault, etc.) enabling active threat detection, not just posture recommendations.

### 19. Azure CLI example
```bash
az security pricing create -n VirtualMachines --tier Standard
az security pricing create -n StorageAccounts --tier Standard
```

### 20. Bicep example
```bicep
resource defenderForServers 'Microsoft.Security/pricings@2024-01-01' = {
  name: 'VirtualMachines'
  properties: { pricingTier: 'Standard' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/defender-for-cloud/

---

## Microsoft Sentinel

### 1. What is it?
Sentinel is Azure's cloud-native SIEM (Security Information and Event Management) and SOAR (Security Orchestration, Automation, and Response) solution — it ingests security signals from Azure, other clouds, and on-prem sources, correlates them, and lets security teams investigate and automate responses.

### 4. When should I use it?
Organizations needing centralized security monitoring/incident response across a hybrid/multi-cloud estate, built on Log Analytics as its data store.

### 5. When should I NOT use it?
Small environments with no dedicated security operations function — the operational overhead of running a SIEM isn't justified without a team to act on its output.

### 19. Azure CLI example
```bash
az sentinel onboarding-state create -g my-rg --workspace-name my-law -n default
```

### 20. Bicep example
```bicep
resource sentinelOnboarding 'Microsoft.SecurityInsights/onboardingStates@2024-09-01' = {
  scope: logAnalyticsWorkspace
  name: 'default'
  properties: {}
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/sentinel/

---

# 7. 📊 Monitoring and Operations

## Azure Monitor

### 1. What is it?
Azure Monitor is the umbrella platform for collecting, analyzing, and acting on telemetry (metrics and logs) from every Azure resource — Application Insights and Log Analytics are both part of the Azure Monitor platform, not separate products.

### 8. Important concepts
- **Metrics** — lightweight, numeric, time-series data (near real-time, e.g., CPU%).
- **Logs** — structured/semi-structured event data queried with KQL, stored in a Log Analytics workspace.
- **Diagnostic settings** — the mechanism that routes a specific resource's logs/metrics into Azure Monitor (Log Analytics, Storage, or Event Hub).

### 19. Azure CLI example — wiring diagnostic settings to Log Analytics
```bash
az monitor diagnostic-settings create -g my-rg \
  --name send-to-law \
  --resource <resource-id> \
  --workspace <log-analytics-workspace-id> \
  --logs '[{"category": "AppServiceHTTPLogs", "enabled": true}]' \
  --metrics '[{"category": "AllMetrics", "enabled": true}]'
```

### 21. Comparison with similar Azure resources
See [Azure Monitor vs Application Insights](#azure-monitor-vs-application-insights) below.

### 20. Bicep example — diagnostic settings sending App Service logs to Log Analytics
```bicep
resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'send-to-law'
  scope: webApp
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [{ categoryGroup: 'allLogs', enabled: true }]
    metrics: [{ category: 'AllMetrics', enabled: true }]
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-monitor/

---

## Application Insights

### 1. What is it?
Application Insights is the **application performance monitoring (APM)** feature of Azure Monitor — it captures requests, dependencies, exceptions, custom events, and distributed traces from your running application code.

### 4. When should I use it?
Every application you deploy to Azure should send telemetry to Application Insights — it is the fastest way to answer "why is this slow/failing" in production.

### 8. Important concepts
- **Instrumentation** — can be auto-instrumented (agent-based, no code change) or SDK-based (manual, more control) depending on the platform.
- **Live Metrics** — near-real-time view of requests/failures/performance while deployed.
- **Distributed tracing** — correlates a single logical request across multiple services (frontend → API → database) using a shared operation ID.
- **Sampling** — reduces telemetry volume/cost for high-traffic apps while preserving statistically representative data.

### 18. Developer example
```csharp
builder.Services.AddApplicationInsightsTelemetry();
// Custom event:
telemetryClient.TrackEvent("OrderPlaced", new Dictionary<string, string> { ["OrderId"] = orderId });
// Custom dependency timing:
using var operation = telemetryClient.StartOperation<DependencyTelemetry>("CallPaymentApi");
```

### 19. Azure CLI example
```bash
az monitor app-insights component create -g my-rg -a my-app-insights \
  -l westeurope --application-type web --workspace <log-analytics-workspace-id>
az monitor app-insights component show -g my-rg -a my-app-insights \
  --query connectionString
```

### 20. Bicep example — workspace-based Application Insights
```bicep
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'my-app-insights'
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}
```

### 21. Comparison with similar Azure resources
See [Application Insights vs Log Analytics](#application-insights-vs-log-analytics) and [Azure Monitor vs Application Insights](#azure-monitor-vs-application-insights) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-monitor/app/app-insights-overview

---

## Log Analytics Workspace

### 1. What is it?
A Log Analytics workspace is the data store (and KQL query engine) underlying Azure Monitor Logs — the destination most diagnostic settings, Application Insights data, and Container Insights data flow into.

### 8. Important concepts
- **Table** — a schema within the workspace (e.g., `AppExceptions`, `AzureDiagnostics`, `ContainerLogV2`).
- **Retention** — configurable per workspace/table; affects both cost and how far back you can query/alert.
- **Workspace-based Application Insights** — the modern model where Application Insights data is stored directly in a Log Analytics workspace (rather than its own classic store).

### 18. Example KQL query — failed requests in the last 24 hours
```kusto
requests
| where timestamp > ago(24h)
| where success == "False"
| summarize FailureCount = count() by resultCode, operation_Name
| order by FailureCount desc
```

### 19. Azure CLI example
```bash
az monitor log-analytics workspace create -g my-rg -n my-law -l westeurope
az monitor log-analytics query -w <workspace-id> \
  --analytics-query "requests | where success == 'False' | take 10"
```

### 20. Bicep example
```bicep
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'my-law'
  location: resourceGroup().location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
  }
}
```

### 21. Comparison with similar Azure resources
See [Application Insights vs Log Analytics](#application-insights-vs-log-analytics) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-workspace-overview

---

## Alerts and Action Groups

### 1. What is it?
An **Alert rule** evaluates a signal (metric threshold, log query, activity log event) on a schedule/condition and fires when the condition is met; an **Action Group** defines what happens next (email, SMS, webhook, Function, Logic App, ITSM ticket).

### 16. Common mistakes
- Alerting on every metric without tuning thresholds, causing alert fatigue and ignored notifications.
- No action group configured — an alert that fires but notifies no one is worthless.

### 19. Azure CLI example
```bash
az monitor action-group create -g my-rg -n ops-team \
  --action email oncall ops@contoso.com
az monitor metrics alert create -g my-rg -n high-cpu-alert \
  --scopes <vm-resource-id> \
  --condition "avg Percentage CPU > 85" \
  --window-size 5m --evaluation-frequency 1m \
  --action ops-team
```

### 20. Bicep example — log-query alert
```bicep
resource alertRule 'Microsoft.Insights/scheduledQueryRules@2023-03-15-preview' = {
  name: 'failed-requests-alert'
  location: resourceGroup().location
  properties: {
    severity: 2
    enabled: true
    scopes: [ appInsights.id ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [{
        query: 'requests | where success == "False"'
        timeAggregation: 'Count'
        operator: 'GreaterThan'
        threshold: 10
      }]
    }
    actions: { actionGroups: [ actionGroup.id ] }
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-overview

---

## Service Health and Resource Health

### 1. What is it?
**Service Health** reports Azure-wide/region-wide incidents and planned maintenance affecting the services you use. **Resource Health** reports the health of your **specific** resource instance (e.g., "this one VM is unavailable due to a host issue").

### 16. Common mistakes
Troubleshooting application code first without checking Service Health/Resource Health for an ongoing platform issue.

### 19. Azure CLI example — create a Service Health alert
```bash
az monitor action-group create -g my-rg -n sh-notify --action email oncall ops@contoso.com
az monitor activity-log alert create -g my-rg -n service-health-alert \
  --condition category=ServiceHealth \
  --action-group sh-notify \
  --scope /subscriptions/<sub-id>
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/service-health/

---

## Azure Advisor

### 1. What is it?
Advisor is a free, built-in recommendation engine that analyzes your resource configuration/usage and suggests improvements across cost, reliability, security, operational excellence, and performance.

### 19. Azure CLI example
```bash
az advisor recommendation list --output table
az advisor recommendation list --category Cost --output table
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/advisor/

---

# 8. 🚀 DevOps and Deployment

## Azure Resource Manager (ARM)

### 1. What is it?
ARM is the management layer/API that every tool (Portal, CLI, PowerShell, Bicep, Terraform) ultimately calls to create, update, and delete Azure resources — it provides consistent authentication, RBAC enforcement, tagging, and deployment orchestration.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-resource-manager/management/overview

---

## Bicep

### 1. What is it?
Bicep is Microsoft's domain-specific language (DSL) for deploying Azure resources declaratively — it compiles down to ARM JSON templates but is far more concise and readable than hand-written ARM JSON.

### 4. When should I use it?
The default choice for Azure-native Infrastructure as Code when your team is Azure-only (not multi-cloud).

### 5. When should I NOT use it?
Multi-cloud infrastructure — Terraform is the more common choice there since it supports multiple cloud providers with one tool/language.

### 8. Important concepts
- **Module** — a reusable Bicep file referenced from another, enabling composition.
- **What-if** — a dry-run showing exactly what a deployment would change before applying it.
- **Deployment Stacks** — a newer ARM feature that tracks a deployment as a single managed unit, enabling clean deletion of everything it created (including detecting/removing resources no longer in the template) — more complete lifecycle management than a plain deployment.

### 19. Azure CLI example
```bash
az deployment group what-if -g my-rg -f main.bicep
az deployment group create -g my-rg -f main.bicep
```

### 21. Comparison with similar Azure resources
See [Bicep vs ARM vs Terraform](#bicep-vs-arm-vs-terraform) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-resource-manager/bicep/

---

## ARM Templates

### 1. What is it?
The original JSON-based declarative template format for Azure deployments — still the format Bicep compiles to under the hood, and still directly usable.

### 5. When should I NOT use it?
For new authoring — write Bicep instead and let the tooling generate ARM JSON when needed; hand-writing ARM JSON is verbose and error-prone by comparison.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-resource-manager/templates/overview

---

## Deployment Stacks

### 1. What is it?
A Deployment Stack groups a set of deployed resources under one managed ARM entity, enabling "delete everything this stack created, including resources removed from the template since" (`--delete-all`/`--action-on-unmanage`), and locking managed resources against accidental out-of-band changes.

### 4. When should I use it?
Replacing manual resource-group deletion or home-grown cleanup scripts when you need reliable, complete teardown of everything an IaC deployment created — including things later removed from the template (a gap plain ARM/Bicep deployments have historically had).

### 19. Azure CLI example
```bash
az stack group create -g my-rg -n my-stack \
  --template-file main.bicep --deny-settings-mode none \
  --action-on-unmanage deleteAll
```
> [!NOTE]
> A Deployment Stack is a **deployment-time construct**, not a `resource` block you declare inside a Bicep file — you create it by wrapping an existing Bicep/ARM template with `az stack` (or the equivalent portal/PowerShell flow), so there is no separate "Bicep example" for the stack itself.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/azure-resource-manager/bicep/deployment-stacks

---

## Azure DevOps and GitHub Actions (Azure integration)

### 1. What is it?
Both are CI/CD platforms with first-class Azure deployment support: **Azure Pipelines** (Azure DevOps) and **GitHub Actions** both have official Azure tasks/actions (`azure/login`, `AzureWebApp@1`, etc.) for authenticating and deploying to Azure resources.

### 11. Identity and security
Prefer **OpenID Connect (OIDC) federated credentials** (workload identity federation) over long-lived service principal secrets for pipeline authentication to Azure — eliminates a stored secret in your CI/CD system entirely.

### 19. Example — GitHub Actions OIDC login
```yaml
- uses: azure/login@v2
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
  # no client secret needed — uses GitHub's OIDC token
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/developer/github/connect-from-azure
- https://learn.microsoft.com/azure/devops/pipelines/

---

# 9. 📊 Data and Analytics

## Azure Data Factory

### 1. What is it?
Data Factory is a managed, serverless data integration (ETL/ELT) service for building pipelines that move and transform data between sources (databases, SaaS apps, files) and destinations (data lakes, warehouses).

### 4. When should I use it?
Orchestrating scheduled or event-driven data movement/transformation pipelines across many heterogeneous sources, without managing the underlying compute.

### 8. Important concepts
- **Pipeline** — an orchestrated sequence of activities.
- **Dataset** — a reference to a specific piece of data in a data store.
- **Linked service** — the connection configuration to a data store or compute.
- **Integration Runtime** — the compute that actually executes activities (Azure-hosted, or Self-hosted for on-prem/private-network sources).

### 19. Azure CLI example
```bash
az datafactory create -g my-rg -n my-data-factory -l eastus
```

### 20. Bicep example
```bicep
resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'my-data-factory'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/data-factory/

---

## Azure Synapse Analytics

### 1. What is it?
Synapse Analytics is an integrated analytics platform combining big-data (Spark) processing, enterprise data warehousing (dedicated SQL pools), serverless SQL querying over a data lake, and pipeline orchestration (Data Factory-equivalent) in one workspace.

### 4. When should I use it?
Enterprise-scale analytics requiring both data warehousing and big-data processing in one governed workspace.

### 5. When should I NOT use it?
Simple ETL-only needs — Data Factory alone may suffice without the full Synapse workspace. Consider whether **Microsoft Fabric** (Microsoft's newer unified analytics SaaS platform) is now the better fit for new builds — verify current product direction/guidance before committing.

### 19. Azure CLI example
```bash
az synapse workspace create -g my-rg -n my-synapse-ws \
  --storage-account mydatalakeacct --file-system synapsefs \
  --sql-admin-login-user sqladmin --sql-admin-login-password <pw>
```

### 20. Bicep example
```bicep
resource synapseWorkspace 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: 'my-synapse-ws'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
  properties: {
    defaultDataLakeStorage: {
      accountUrl: 'https://mydatalakeacct.dfs.core.windows.net'
      filesystem: 'synapsefs'
    }
    sqlAdministratorLogin: 'sqladmin'
    sqlAdministratorLoginPassword: adminPassword
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/synapse-analytics/

---

## Azure Databricks

### 1. What is it?
Azure Databricks is a managed Apache Spark-based analytics platform (a first-party Azure service built in partnership with Databricks) for large-scale data engineering, data science, and machine learning workloads using notebooks.

### 4. When should I use it?
Teams already standardized on Spark/Databricks workflows, large-scale data engineering/ML pipelines, or needing Delta Lake-based lakehouse architecture.

### 19. Azure CLI example
```bash
az databricks workspace create -g my-rg -n my-databricks-ws \
  --location eastus --sku standard
```

### 20. Bicep example
```bicep
resource databricksWorkspace 'Microsoft.Databricks/workspaces@2024-05-01' = {
  name: 'my-databricks-ws'
  location: resourceGroup().location
  sku: { name: 'standard' }
  properties: {
    managedResourceGroupId: '${subscription().id}/resourceGroups/databricks-managed-rg'
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/databricks/

---

## Azure Data Explorer

### 1. What is it?
Azure Data Explorer (Kusto/ADX) is a fast, fully managed analytics service purpose-built for log and time-series data at massive scale, queried with KQL (the same query language used across Azure Monitor/Sentinel).

### 4. When should I use it?
High-volume telemetry/log analytics scenarios (IoT, application telemetry, security logs) needing fast ad-hoc querying over huge datasets — often fed by Event Hubs.

### 19. Azure CLI example
```bash
az kusto cluster create -g my-rg -n my-adx-cluster -l eastus \
  --sku name="Standard_D11_v2" tier="Standard"
az kusto database create -g my-rg --cluster-name my-adx-cluster -n Telemetry \
  --read-write-database location=eastus soft-delete-period=P365D
```

### 20. Bicep example
```bicep
resource adxCluster 'Microsoft.Kusto/clusters@2023-08-15' = {
  name: 'my-adx-cluster'
  location: resourceGroup().location
  sku: { name: 'Standard_D11_v2', tier: 'Standard', capacity: 2 }
}

resource adxDatabase 'Microsoft.Kusto/clusters/databases@2023-08-15' = {
  parent: adxCluster
  name: 'Telemetry'
  location: resourceGroup().location
  kind: 'ReadWrite'
  properties: { softDeletePeriod: 'P365D' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/data-explorer/

---

# 10. 🧠 AI

## Microsoft Foundry

### 1. What is it?
Microsoft Foundry (formerly Azure AI Foundry) is Microsoft's unified platform/portal for building, evaluating, and deploying AI applications and agents — bringing together Azure OpenAI models, other model catalogs, AI Search (for RAG), and tooling for prompt engineering, evaluation, and safety.

### 5. When should I NOT use it?
Verify current product naming/scope on Microsoft Learn before documenting it deeply in your own materials — this is one of the fastest-moving areas of Azure's portfolio.

### 19. Azure CLI example
```bash
az cognitiveservices account create -g my-rg -n my-foundry-hub \
  --kind AIServices --sku S0 -l eastus --yes
```

### 20. Bicep example
> [!NOTE]
> The Bicep resource provider/`kind` naming for Foundry hubs and projects has changed as the product evolved (Azure AI Studio → Azure AI Foundry → Microsoft Foundry); verify the exact current API version and `kind` value on Microsoft Learn before using this in production.
```bicep
resource foundryAccount 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: 'my-foundry-hub'
  location: resourceGroup().location
  kind: 'AIServices'
  sku: { name: 'S0' }
  identity: { type: 'SystemAssigned' }
  properties: { customSubDomainName: 'my-foundry-hub' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/ai-foundry/

---

## Azure OpenAI

### 1. What is it?
Azure OpenAI provides access to OpenAI's models (GPT-family, embeddings, etc.) hosted inside Azure, with Azure's enterprise security, networking, RBAC, and compliance wrapped around them.

### 4. When should I use it?
Building generative AI features (chat, summarization, content generation, embeddings for search/RAG) where you need Azure's identity/networking/compliance posture around the model calls.

### 8. Important concepts
- **Deployment** — a named, provisioned instance of a specific model version inside your Azure OpenAI resource — you call your *deployment name*, not the raw model name, from your application.
- **RAG (Retrieval-Augmented Generation)** — combining a search index (commonly Azure AI Search) with the model so answers are grounded in your own data instead of relying solely on the model's trained knowledge.
- **Content filtering** — built-in safety filtering on prompts/completions.

### 11. Identity and security
Use **Managed Identity + Entra ID RBAC** (`Cognitive Services OpenAI User`, etc.) over API keys where possible.

### 18. Developer example
```csharp
using Azure.AI.OpenAI;
using Azure.Identity;

var client = new AzureOpenAIClient(
    new Uri("https://my-openai-resource.openai.azure.com/"),
    new DefaultAzureCredential());

var chatClient = client.GetChatClient("my-gpt-deployment");
var response = await chatClient.CompleteChatAsync("Summarize this order in one sentence.");
```

### 21. Comparison with similar Azure resources
See [Azure OpenAI vs Azure Machine Learning](#azure-openai-vs-azure-machine-learning) below.

### 19. Azure CLI example
```bash
az cognitiveservices account create -g my-rg -n my-openai-resource \
  --kind OpenAI --sku S0 -l eastus --custom-domain my-openai-resource
az cognitiveservices account deployment create -g my-rg -n my-openai-resource \
  --deployment-name my-gpt-deployment --model-name gpt-4o --model-version "2024-08-06" \
  --model-format OpenAI --sku-capacity 10 --sku-name Standard
```

### 20. Bicep example
```bicep
resource openAiAccount 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: 'my-openai-resource'
  location: resourceGroup().location
  kind: 'OpenAI'
  sku: { name: 'S0' }
  identity: { type: 'SystemAssigned' }
  properties: { customSubDomainName: 'my-openai-resource' }
}

resource gptDeployment 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  parent: openAiAccount
  name: 'my-gpt-deployment'
  sku: { name: 'Standard', capacity: 10 }
  properties: {
    model: { format: 'OpenAI', name: 'gpt-4o', version: '2024-08-06' }
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/ai-services/openai/

---

## Azure AI Search

### 1. What is it?
Azure AI Search (formerly Azure Cognitive Search) is a managed search-as-a-service offering full-text, vector, and hybrid search over your own data — the standard "retrieval" half of a RAG architecture with Azure OpenAI.

### 8. Important concepts
- **Index** — the searchable schema/data structure.
- **Vector search** — similarity search over embeddings, enabling semantic (meaning-based) rather than purely keyword-based retrieval.
- **Hybrid search** — combining keyword and vector search for better relevance.
- **Indexer** — automatically pulls/refreshes data from a source (Blob, SQL, Cosmos DB) into the index.
- **Semantic ranker** — an optional re-ranking layer that improves relevance ordering using language understanding.

### 18. Developer example — querying an index (C#)
```csharp
using Azure.Identity;
using Azure.Search.Documents;

var searchClient = new SearchClient(
    new Uri("https://my-search.search.windows.net"), "my-index",
    new DefaultAzureCredential());

var results = await searchClient.SearchAsync<SearchDocument>("coffee maker",
    new SearchOptions { Size = 5 });
await foreach (var result in results.Value.GetResultsAsync())
    Console.WriteLine(result.Document["title"]);
```

### 19. Azure CLI example
```bash
az search service create -g my-rg -n my-search --sku basic -l westeurope
az search service update -g my-rg -n my-search --identity-type SystemAssigned
```

### 20. Bicep example
```bicep
resource searchService 'Microsoft.Search/searchServices@2024-06-01-preview' = {
  name: 'my-search'
  location: resourceGroup().location
  sku: { name: 'basic' }
  properties: { replicaCount: 1, partitionCount: 1 }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/search/

---

## Azure Machine Learning

### 1. What is it?
Azure Machine Learning (Azure ML) is a platform for the full custom ML lifecycle — training, tracking experiments, managing models, and deploying custom models (not just calling pre-built foundation models like Azure OpenAI).

### 4. When should I use it?
Training/fine-tuning your own custom models, managing ML experiment lifecycle/MLOps, or deploying models with full control over compute and serving infrastructure.

### 5. When should I NOT use it?
You just need to call a pre-built generative model (chat, embeddings) — Azure OpenAI is simpler and purpose-built for that.

### 8. Important concepts
- **Workspace** — the top-level Azure ML resource containing experiments, models, endpoints, and compute.
- **Compute instance/cluster** — managed VMs for development (instance) or scalable training jobs (cluster).
- **Model registry** — versioned storage for trained models.
- **Managed online endpoint** — a hosted, scalable HTTP endpoint for real-time model inference.

### 19. Azure CLI example (`az ml` extension)
```bash
az ml workspace create -g my-rg -n my-ml-workspace
az ml compute create -g my-rg -w my-ml-workspace \
  --name cpu-cluster --type AmlCompute --min-instances 0 --max-instances 4 \
  --size Standard_DS3_v2
az ml job create -g my-rg -w my-ml-workspace --file train-job.yml
az ml online-endpoint create -g my-rg -w my-ml-workspace --name my-endpoint
```

### 20. Bicep example
```bicep
resource mlWorkspace 'Microsoft.MachineLearningServices/workspaces@2024-04-01' = {
  name: 'my-ml-workspace'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
  properties: {
    friendlyName: 'My ML Workspace'
    storageAccount: storageAccount.id
    keyVault: keyVault.id
    applicationInsights: appInsights.id
  }
}
```

### 21. Comparison with similar Azure resources
See [Azure OpenAI vs Azure Machine Learning](#azure-openai-vs-azure-machine-learning) below.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/machine-learning/

---

## Document Intelligence

### 1. What is it?
Document Intelligence (formerly Form Recognizer) extracts structured data (fields, tables, key-value pairs) from documents (invoices, receipts, IDs, forms) using prebuilt or custom-trained models — essentially OCR plus structured understanding.

### 4. When should I use it?
Automating data extraction from semi-structured business documents (invoices, receipts, IDs) instead of writing brittle manual OCR/regex parsing.

### 18. Developer example — prebuilt invoice model (C#)
```csharp
using Azure.AI.DocumentIntelligence;
using Azure.Identity;

var client = new DocumentIntelligenceClient(
    new Uri("https://my-doc-intel.cognitiveservices.azure.com/"),
    new DefaultAzureCredential());

var operation = await client.AnalyzeDocumentAsync(
    WaitUntil.Completed, "prebuilt-invoice", BinaryData.FromStream(invoiceStream));

foreach (var field in operation.Value.Documents[0].Fields)
    Console.WriteLine($"{field.Key}: {field.Value.Content}");
```

### 19. Azure CLI example
```bash
az cognitiveservices account create -g my-rg -n my-doc-intel \
  --kind FormRecognizer --sku S0 -l westeurope --yes
```

### 20. Bicep example
```bicep
resource docIntelAccount 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: 'my-doc-intel'
  location: resourceGroup().location
  kind: 'FormRecognizer'
  sku: { name: 'S0' }
  identity: { type: 'SystemAssigned' }
  properties: { customSubDomainName: 'my-doc-intel' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/ai-services/document-intelligence/

---

## Speech

### 1. What is it?
The Speech service provides speech-to-text, text-to-speech, speech translation, and speaker recognition as a managed API.

### 18. Developer example — text-to-speech (C#)
```csharp
using Microsoft.CognitiveServices.Speech;

var config = SpeechConfig.FromSubscription("<key>", "westeurope");
config.SpeechSynthesisVoiceName = "en-US-JennyNeural";
using var synthesizer = new SpeechSynthesizer(config);
await synthesizer.SpeakTextAsync("Hello, your order has shipped.");
```

### 19. Azure CLI example
```bash
az cognitiveservices account create -g my-rg -n my-speech \
  --kind SpeechServices --sku S0 -l westeurope --yes
```

### 20. Bicep example
```bicep
resource speechAccount 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: 'my-speech'
  location: resourceGroup().location
  kind: 'SpeechServices'
  sku: { name: 'S0' }
  identity: { type: 'SystemAssigned' }
  properties: { customSubDomainName: 'my-speech' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/ai-services/speech-service/

---

## Language

### 1. What is it?
The Language service provides natural-language-processing capabilities — sentiment analysis, key phrase extraction, named entity recognition, summarization, and custom text classification — without building/training your own NLP models.

### 18. Developer example — sentiment analysis (C#)
```csharp
using Azure.AI.TextAnalytics;
using Azure.Identity;

var client = new TextAnalyticsClient(
    new Uri("https://my-language.cognitiveservices.azure.com/"),
    new DefaultAzureCredential());

var result = await client.AnalyzeSentimentAsync("The product broke after one day, very disappointing.");
Console.WriteLine(result.Value.Sentiment); // Negative
```

### 19. Azure CLI example
```bash
az cognitiveservices account create -g my-rg -n my-language \
  --kind TextAnalytics --sku S0 -l westeurope --yes
```

### 20. Bicep example
```bicep
resource languageAccount 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: 'my-language'
  location: resourceGroup().location
  kind: 'TextAnalytics'
  sku: { name: 'S0' }
  identity: { type: 'SystemAssigned' }
  properties: { customSubDomainName: 'my-language' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/ai-services/language-service/

---

## Vision

### 1. What is it?
The Vision service provides image analysis — object detection, OCR, image captioning, and face detection (subject to responsible-AI gating for sensitive capabilities) — as a managed API.

### 18. Developer example — image analysis (C#)
```csharp
using Azure.AI.Vision.ImageAnalysis;
using Azure.Identity;

var client = new ImageAnalysisClient(
    new Uri("https://my-vision.cognitiveservices.azure.com/"),
    new DefaultAzureCredential());

var result = client.Analyze(
    BinaryData.FromStream(imageStream),
    VisualFeatures.Caption | VisualFeatures.Tags);

Console.WriteLine(result.Value.Caption.Text);
```

### 19. Azure CLI example
```bash
az cognitiveservices account create -g my-rg -n my-vision \
  --kind ComputerVision --sku S1 -l westeurope --yes
```

### 20. Bicep example
```bicep
resource visionAccount 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: 'my-vision'
  location: resourceGroup().location
  kind: 'ComputerVision'
  sku: { name: 'S1' }
  identity: { type: 'SystemAssigned' }
  properties: { customSubDomainName: 'my-vision' }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/ai-services/computer-vision/

---

# 10.5 🧩 Additional Important Services

This section covers services explicitly worth knowing even though they didn't fit neatly into the sections above: a global CDN, a zero-ops static-site host, a conversational-bot platform, cloud automation/runbooks, and IoT device connectivity — plus a short clarifying note on "Docker" and "API Gateway," two terms people often expect to find as standalone Azure resources.

## Azure CDN

### 1. What is it?
Azure Content Delivery Network (CDN) caches static content (images, scripts, video, downloads) at edge points-of-presence around the world, close to end users, so requests don't have to travel all the way back to your origin for every request.

### 2. Why does it exist?
Latency is physics: a user in Singapore requesting a file from a US-only origin pays a round-trip-time penalty on every request. A CDN puts a cached copy physically closer to the user.

### 3. Simple real-world analogy
Local warehouses (edge nodes) stocking popular items near customers, instead of shipping every single order from one central factory (origin).

### 4. When should I use it?
- Serving static assets (images, CSS/JS, downloads, video) to a geographically distributed audience.
- Offloading repeated-read traffic from your origin (Storage, App Service, custom server) to reduce origin load and egress cost.

### 5. When should I NOT use it?
- You need WAF, URL-based routing to multiple backends, and global failover together with caching — **Azure Front Door** is the more modern, consolidated choice (it includes CDN-like caching plus Layer-7 routing and WAF) and is Microsoft's recommended default for most new global web workloads.
- Fully dynamic/personalized content with no cacheable component.

### 6. Common use cases
- Static website/media/content distribution.
- Software/package/update download distribution.
- Offloading image/video traffic from an origin web app.

### 8. Important concepts
- **Origin** — where the CDN fetches uncached content from (Storage account, App Service, any public endpoint).
- **Endpoint** — the CDN-facing hostname clients hit.
- **Caching rules** — control cache-control/TTL behavior, query-string handling, compression.
- **Product lines** — Azure offers CDN through partner-backed tiers (e.g., "Azure CDN Standard from Microsoft/Akamai/Edgio" naming has changed over time); **for new projects, Microsoft recommends Azure Front Door**, which has absorbed most CDN use cases into one product.

### 16. Common mistakes
Building new global caching architecture on classic CDN product lines without first checking whether Front Door is now the better/consolidated fit — verify current product guidance on Microsoft Learn, since this area has consolidated significantly.

### 19. Azure CLI example
```bash
az cdn profile create -g my-rg -n my-cdn-profile --sku Standard_Microsoft
az cdn endpoint create -g my-rg --profile-name my-cdn-profile \
  -n my-cdn-endpoint --origin mystorageacct.blob.core.windows.net
```

### 20. Bicep example
```bicep
resource cdnProfile 'Microsoft.Cdn/profiles@2024-02-01' = {
  name: 'my-cdn-profile'
  location: 'global'
  sku: { name: 'Standard_Microsoft' }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2024-02-01' = {
  parent: cdnProfile
  name: 'my-cdn-endpoint'
  location: 'global'
  properties: {
    origins: [{ name: 'origin1', properties: { hostName: 'mystorageacct.blob.core.windows.net' } }]
  }
}
```

### 21. Comparison with similar Azure resources
See [Front Door vs Application Gateway vs Load Balancer vs Traffic Manager](#front-door-vs-application-gateway-vs-load-balancer-vs-traffic-manager) — Front Door is the modern superset for most new global-caching + routing scenarios.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/cdn/

---

## Azure Static Web Apps

### 1. What is it?
Azure Static Web Apps is a fully managed hosting service purpose-built for modern front-end frameworks (React, Angular, Vue, plain HTML/JS) with an **integrated serverless API** (backed by Azure Functions), free global CDN distribution, and automatic CI/CD from a GitHub/Azure DevOps repository.

### 2. Why does it exist?
Modern front-end apps are typically static build output (HTML/CSS/JS bundles) plus a thin API — App Service/VMs are too heavyweight (and too costly) for hosting what is fundamentally a set of static files, and setting up CDN + CI/CD + API hosting + auth separately is needless assembly work.

### 3. Simple real-world analogy
A pre-wired storefront: push your built website to a repo, and the platform assembles hosting, global distribution, a backend API slot, and authentication automatically — no manual wiring.

### 4. When should I use it?
- SPA/JAMstack front ends (React/Angular/Vue/Svelte/plain static sites) with a lightweight API.
- Projects wanting zero-config CI/CD straight from a GitHub/Azure DevOps repo, including automatic PR preview environments.

### 5. When should I NOT use it?
- Server-rendered apps needing a full, always-on backend with complex server-side logic — use App Service or Container Apps instead.
- APIs with heavy compute/long-running needs beyond what the integrated Functions API slot is meant for (you can still point a Static Web App at an external API/App Service instead).

### 6. Common use cases
- Documentation sites, marketing sites, SPAs, internal tools with a thin API.
- Portfolio/demo sites needing free/low-cost hosting with built-in CDN.

### 7. How it works
```text
git push → GitHub Actions / Azure Pipelines (auto-generated workflow)
   → builds static front end + optional /api Functions project
   → deploys both behind a single global CDN-backed URL
   → pull requests automatically get their own staging preview URL
```

### 8. Important concepts
- **Free tier** — generous for small/personal sites (custom domains, free SSL, PR previews).
- **Standard tier** — adds larger apps, more custom domains, private endpoints, bigger API backends, and SLA.
- **Integrated authentication** — built-in support for Entra ID, GitHub, and other providers without extra wiring.
- **Staging environments** — every pull request can automatically get its own live preview URL.

### 11. Identity and security
Built-in auth/authorization via `staticwebapp.config.json` (`routes` + `allowedRoles`) is simpler than wiring App Service Authentication manually, but is less feature-rich than a full Entra ID app registration for complex enterprise scenarios.

### 16. Common mistakes
Assuming the integrated API can handle arbitrary heavy backend workloads — it's an Azure Functions app under the hood and inherits Functions' execution model and limits.

### 18. Developer example — `staticwebapp.config.json` (route protection)
```json
{
  "routes": [
    { "route": "/admin/*", "allowedRoles": ["administrator"] }
  ],
  "responseOverrides": {
    "401": { "redirect": "/login", "statusCode": 302 }
  }
}
```

### 19. Azure CLI example
```bash
az staticwebapp create -g my-rg -n my-static-app -l westeurope \
  --source https://github.com/my-org/my-repo --branch main \
  --app-location "/app" --api-location "/api" --output-location "dist" \
  --login-with-github
```

### 20. Bicep example
```bicep
resource staticWebApp 'Microsoft.Web/staticSites@2023-12-01' = {
  name: 'my-static-app'
  location: resourceGroup().location
  sku: { name: 'Standard', tier: 'Standard' }
  properties: {
    repositoryUrl: 'https://github.com/my-org/my-repo'
    branch: 'main'
    buildProperties: {
      appLocation: '/app'
      apiLocation: '/api'
      outputLocation: 'dist'
    }
  }
}
```

### 21. Comparison with similar Azure resources
See [App Service vs Container Apps](#app-service-vs-container-apps) — Static Web Apps is the better default specifically for static-front-end + thin-API architectures that neither of those two is optimized for.

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/static-web-apps/

---

## Azure AI Bot Service

### 1. What is it?
Azure AI Bot Service (previously "Azure Bot Service"/"Bot Framework Service") is the managed hosting/channel-connection layer for conversational bots — it connects a bot's logic (built with the Bot Framework SDK or, increasingly, the newer Microsoft 365 Agents SDK) to channels like Microsoft Teams, web chat, Slack, and more.

### 2. Why does it exist?
Building a chatbot that works consistently across many channels (Teams, web, SMS, Slack) requires normalizing very different channel protocols into one conversational model — Bot Service provides that channel abstraction plus managed registration/hosting glue.

### 4. When should I use it?
Building a custom conversational bot that needs to be reachable from multiple channels (especially Microsoft Teams) with centralized registration and channel management.

### 5. When should I NOT use it?
- Low-code/no-code bot building for business users — **Microsoft Copilot Studio** is now the recommended low-code path for many scenarios.
- Simple single-channel request/response automation with no real conversational state — a plain API/Function may be simpler.

### 6. Common use cases
- Microsoft Teams bots/apps for internal productivity.
- Customer-support chat bots integrated with Azure OpenAI for generative responses (RAG-grounded via Azure AI Search).

### 8. Important concepts
- **Bot channel registration** — the Azure resource connecting your bot's messaging endpoint to one or more channels.
- **Bot Framework SDK / Microsoft 365 Agents SDK** — the code frameworks for implementing bot logic; Microsoft has been evolving tooling in this space, so verify the current recommended SDK on Microsoft Learn before starting new projects.
- **Channels** — Teams, Web Chat, Direct Line, Slack, etc. — each with its own nuances for rich cards/attachments.

### 16. Common mistakes
Starting a brand-new bot project on legacy Bot Framework v3/early v4 samples without checking the current (Microsoft 365 Agents SDK / Copilot Studio) guidance — this area has moved fast, and official docs should be checked for the current recommended starting point.

### 19. Azure CLI example
```bash
az bot create -g my-rg -n my-bot --kind registration \
  --endpoint https://my-bot.azurewebsites.net/api/messages \
  --appid <app-registration-client-id> -l global
az bot webchat show -g my-rg -n my-bot
```

### 20. Bicep example
```bicep
resource botService 'Microsoft.BotService/botServices@2023-09-15-preview' = {
  name: 'my-bot'
  location: 'global'
  sku: { name: 'F0' }
  kind: 'azurebot'
  properties: {
    displayName: 'my-bot'
    endpoint: 'https://my-bot.azurewebsites.net/api/messages'
    msaAppId: appRegistrationClientId
  }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/bot-service/
- https://learn.microsoft.com/microsoft-365/agents-sdk/ (current recommended SDK for building agents/bots — verify before use, this area evolves quickly)

---

## Azure Automation

### 1. What is it?
Azure Automation provides process automation (PowerShell/Python **runbooks**), configuration management (State Configuration), and **Update Management** for patching VMs — a managed way to run operational scripts on a schedule, in response to a trigger, or on demand, without maintaining your own scheduler/server for it.

### 2. Why does it exist?
Operational tasks (stop/start VMs on a schedule, rotate a credential, clean up old resources, apply OS patches) need something that runs reliably even when no engineer is online — Automation provides a managed execution host plus scheduling/webhook triggers for exactly that.

### 3. Simple real-world analogy
A building's automated systems (timers for lights, scheduled HVAC cycles) — routine operational tasks happening on a schedule without a person flipping switches.

### 4. When should I use it?
- Scheduled operational tasks: start/stop dev VMs outside business hours, nightly cleanup jobs, scheduled reports.
- Patch management/update orchestration across VM fleets.
- Runbooks triggered by webhooks/alerts (e.g., auto-remediate a flagged resource).

### 5. When should I NOT use it?
- Application-level business logic/event processing — use Functions/Logic Apps, which have richer triggers, bindings, and a more modern developer experience.
- Kubernetes-native scheduled jobs — use a Kubernetes CronJob inside AKS instead.

### 6. Common use cases
- Start/stop VMs or scale sets on a schedule to save cost in non-production environments.
- Rotate Key Vault secrets/certificates on a schedule via runbook.
- Fleet-wide OS patch compliance via Update Management.

### 8. Important concepts
- **Runbook** — the unit of automation logic (PowerShell, PowerShell Workflow, Python).
- **Automation Account** — the top-level resource containing runbooks, schedules, credentials, and variables.
- **Hybrid Runbook Worker** — lets runbooks execute against on-premises/non-Azure machines, not just Azure resources.
- **Managed Identity** — the modern, recommended way for runbooks to authenticate to Azure resources (instead of stored "Run As" account credentials, which are retired).

### 11. Identity and security
Use the Automation Account's **Managed Identity** for runbook authentication; avoid the legacy "Run As" account model (retired by Microsoft in favor of Managed Identity).

### 16. Common mistakes
Still referencing the deprecated "Run As account" pattern from older tutorials — new Automation Accounts should use Managed Identity exclusively.

### 18. Developer example — simple PowerShell runbook using Managed Identity
```powershell
# Runbook: Stop-DevVMs.ps1
Connect-AzAccount -Identity
$vms = Get-AzVM -ResourceGroupName "dev-rg"
foreach ($vm in $vms) {
    Stop-AzVM -ResourceGroupName "dev-rg" -Name $vm.Name -Force
}
```

### 19. Azure CLI example
```bash
az automation account create -g my-rg -n my-automation-account -l westeurope
az automation runbook create -g my-rg --automation-account-name my-automation-account \
  --name Stop-DevVMs --type PowerShell
az automation schedule create -g my-rg --automation-account-name my-automation-account \
  --name nightly --frequency Day --interval 1 --start-time "2026-01-01T20:00:00+00:00"
```

### 20. Bicep example
```bicep
resource automationAccount 'Microsoft.Automation/automationAccounts@2023-11-01' = {
  name: 'my-automation-account'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
  properties: { sku: { name: 'Basic' } }
}
```

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/automation/

---

## Azure IoT Hub

### 1. What is it?
IoT Hub is a managed, bi-directional messaging hub for connecting, monitoring, and managing large fleets of IoT devices — handling device-to-cloud telemetry ingestion and cloud-to-device commands, with per-device identity and security built in.

### 2. Why does it exist?
IoT fleets involve huge numbers of constrained, often-offline, geographically dispersed devices needing per-device authentication, reliable telemetry ingestion, and a way to push commands/configuration back down — generic messaging services (Event Hubs) don't provide per-device identity, device twins, or device management primitives.

### 3. Simple real-world analogy
A dedicated phone exchange built specifically for machines: every device gets its own verified "phone line" (identity), can "call in" with status updates, and can receive calls back with instructions.

### 4. When should I use it?
- Telemetry ingestion from a large, managed fleet of IoT devices (sensors, industrial equipment, connected products) needing per-device identity/auth.
- Sending commands/configuration/firmware-update instructions down to devices (cloud-to-device messaging).
- Device state synchronization via **device twins** (desired vs reported state).

### 5. When should I NOT use it?
- Pure high-throughput event streaming without device-management needs (per-device identity, twins, direct methods) — plain **Event Hubs** is simpler/cheaper.
- Small numbers of devices/simple telemetry with no need for device provisioning/management — a simpler message queue may suffice.

### 6. Common use cases
- Industrial IoT/manufacturing telemetry and remote control.
- Smart building/connected-product fleets needing remote configuration and firmware updates.
- Fleet management combined with **Device Provisioning Service (DPS)** for zero-touch device onboarding at scale.

### 7. How it works
```text
Device (per-device identity/credential)
   → IoT Hub (telemetry ingestion, built-in Event-Hub-compatible endpoint)
        → downstream: Stream Analytics / Event Hubs-compatible consumers / Azure Functions
IoT Hub → Device (cloud-to-device commands, direct methods, device twin desired-property updates)
```

### 8. Important concepts
- **Device identity** — each device gets its own managed identity/credential in the IoT Hub identity registry (X.509 certs or SAS tokens).
- **Device twin** — a JSON document per device tracking desired (cloud-set) vs reported (device-set) state, enabling async configuration sync even when a device is offline.
- **Direct method** — a synchronous, request-response command invoked on an online device.
- **Device Provisioning Service (DPS)** — automates zero-touch, secure device registration/assignment to an IoT Hub at scale.
- **Message routing** — routes incoming telemetry to different endpoints (Storage, Event Hubs, Service Bus) based on message properties/body.

### 11. Identity and security
Prefer **X.509 certificate-based device authentication** over shared access signature (SAS) tokens for production fleets; use DPS for secure, scalable zero-touch provisioning rather than embedding long-lived credentials at manufacturing time.

### 15. Cost model
```text
IoT Hub cost depends mainly on:
tier (Free/Basic/Standard) + number of provisioned units
+ messages/day included in the tier (overage is blocked, not billed extra, on some tiers — check current tier limits)
```

### 16. Common mistakes
- Treating IoT Hub as "just a bigger Event Hub" and missing out on device twins/direct methods that solve real device-management problems.
- Embedding one shared device credential across an entire fleet instead of per-device identity — a single compromised device then compromises the whole fleet's trust.

### 18. Developer example — sending device-to-cloud telemetry (C#)
```csharp
using Microsoft.Azure.Devices.Client;

await using var deviceClient = DeviceClient.CreateFromConnectionString(
    "<device-connection-string>", TransportType.Mqtt);

var message = new Message(Encoding.UTF8.GetBytes("{\"temperature\":22.5}"));
await deviceClient.SendEventAsync(message);
```

### 18. Developer example — reading a device twin and updating desired properties (C#, service side)
```csharp
using Microsoft.Azure.Devices;

var registryManager = RegistryManager.CreateFromConnectionString("<iothub-connection-string>");
var twin = await registryManager.GetTwinAsync("device-001");
twin.Properties.Desired["firmwareVersion"] = "2.1.0";
await registryManager.UpdateTwinAsync("device-001", twin, twin.ETag);
```

### 19. Azure CLI example
```bash
az iot hub create -g my-rg -n my-iot-hub --sku S1 --unit 1
az iot hub device-identity create -n my-iot-hub --device-id device-001
az iot hub device-identity connection-string show -n my-iot-hub --device-id device-001
```

### 20. Bicep example
```bicep
resource iotHub 'Microsoft.Devices/IotHubs@2023-06-30' = {
  name: 'my-iot-hub'
  location: resourceGroup().location
  sku: { name: 'S1', capacity: 1 }
}
```

### 22. Interview / knowledge-check questions
- What problem does a device twin solve that a plain telemetry message can't?
- Why is IoT Hub preferred over Event Hubs for a large, managed device fleet?
- How does Device Provisioning Service improve on embedding static credentials at manufacturing time?

### 23. Official Microsoft documentation
- https://learn.microsoft.com/azure/iot-hub/
- https://learn.microsoft.com/azure/iot-dps/

---

## A note on "Azure Docker" and containers

There is no Azure product literally named "Azure Docker." Docker is the open-source container runtime/image format; here is how each of the common "Docker ___" terms maps to the actual Azure product:

| Term you may be looking for | What it actually means | Azure product |
|---|---|---|
| **Docker** | The container runtime/tooling (`docker build`, `docker push`, `docker run`) used on your own machine or build agent | Not an Azure product — it's the client-side/CI tool you use *before* anything reaches Azure |
| **Docker Image** | A packaged, versioned snapshot of your app + its dependencies (the thing `docker build` produces) | Stored in **Azure Container Registry (ACR)**; *run* by ACI / Container Apps / AKS / App Service (container mode) |
| **Docker Registry** | Where images are stored and pulled from (`docker push`/`docker pull` target) | **Azure Container Registry (ACR)** — see the [Azure Container Registry (ACR)](#azure-container-registry-acr) section above for full CLI/Bicep |
| **Docker Instance** (not an official Docker term — usually means "a single running container") | One running container, no orchestration | **Azure Container Instances (ACI)** — see the [Azure Container Instances (ACI)](#azure-container-instances-aci) section above |
| "Run my container at scale/production" | Orchestrated, auto-scaling container hosting | **Azure Container Apps** (serverless, easiest) or **AKS** (full Kubernetes control) — see [Application hosting decision table](#application-hosting-decision-table) below |

The complete journey — build the image, push it to the registry, then run it three different ways — is walked through step-by-step in **Scenario A** (Docker → Container Registry → ACI / Container Apps / AKS) in Section 13, "End-to-End Deployment Scenarios."

```bash
# Build locally, push to ACR, the universal starting point before any Azure container compute:
docker build -t myapp:1.0 .
az acr login --name myacr
docker tag myapp:1.0 myacr.azurecr.io/myapp:1.0
docker push myacr.azurecr.io/myapp:1.0
```

## A note on "Azure API Gateway"

There is no separate Azure product named "Azure API Gateway" — this is a generic architecture-pattern term. In Azure, **API Management (APIM)** *is* the API gateway product (see the [API Management](#api-management) section above for full depth, policies, CLI, and Bicep examples).

---

# 11. 🎯 Big Comparison Tables

These are the comparisons engineers get asked about constantly — in design reviews, in interviews, and when choosing a service for a new project. Each table explains **why**, not just **what**.

## Application hosting decision table

| Requirement | VM | App Service | Functions | Container Apps | AKS |
|---|---|---|---|---|---|
| OS-level control needed | ✅ | ❌ | ❌ | ❌ | Partial (nodes only) |
| Event-driven/bursty workload, pay-per-use | ❌ | ❌ | ✅ | ✅ | ❌ |
| Full container orchestration/Kubernetes API | ❌ | ❌ | ❌ | Partial | ✅ |
| Lowest operational overhead | ❌ | ✅ | ✅ | ✅ | ❌ |
| Scale to zero | ❌ | ❌ | ✅ | ✅ | ❌ |

**Why:** start from the top of your actual requirement, not from familiarity. Most new web apps/APIs should default to App Service or Container Apps; reach for Functions when the workload is genuinely event-driven; reach for AKS only when you need Kubernetes-specific capabilities Container Apps doesn't expose; reach for a VM only when you need OS-level control PaaS can't give you.

## App Service vs Container Apps

| | App Service | Container Apps |
|---|---|---|
| Deployment unit | Code or single container | Container(s), with Dapr/KEDA built in |
| Scale to zero | No | Yes (Consumption profile) |
| Multi-container/sidecar patterns | Limited | Native |
| Best for | Traditional web apps/APIs | Microservices, event-driven apps, Dapr-based systems |

## Functions vs Logic Apps

| | Functions | Logic Apps |
|---|---|---|
| Authoring | Code (C#, Python, etc.) | Low-code/visual designer |
| Best for | Custom logic, performance-sensitive processing | Connector-heavy business process automation |
| Audience | Developers | Developers and integration/business analysts |

## Functions vs Container Apps

| | Functions | Container Apps |
|---|---|---|
| Packaging | Function code (or container) | Any container |
| Trigger model | Built-in bindings/triggers | KEDA scalers + HTTP ingress |
| Best for | Single-purpose event handlers | Full microservices/multi-container apps |

## AKS vs Container Apps

| | Container Apps | AKS |
|---|---|---|
| You manage Kubernetes API/nodes | No | Yes (or partially, with AKS Automatic) |
| Operational overhead | Low | Medium (Automatic) to high (Standard) |
| Custom operators/CRDs/service mesh | No | Yes |
| Best for | Most container workloads without special K8s needs | Platforms genuinely needing the Kubernetes ecosystem |

**Why:** choose AKS only when you can name the specific Kubernetes capability you need that Container Apps lacks.

## Service Bus vs Event Grid vs Event Hubs vs Storage Queue

| | Service Bus | Event Grid | Event Hubs | Storage Queue |
|---|---|---|---|---|
| Model | Queue / Pub-sub | Pub-sub (push) | Streaming ingestion | Simple queue |
| Delivery guarantee | At-least-once, sessions, dead-letter | At-least-once, retries | At-least-once (consumer-managed offsets) | At-least-once |
| Scale target | Enterprise messaging | Discrete event notifications | Millions of events/sec | Low-volume simple jobs |
| Best for | Order processing, financial transactions | "Resource changed" reactions | Telemetry/streaming analytics | Cheapest simple background queue |

## Front Door vs Application Gateway vs Load Balancer vs Traffic Manager

| | Front Door | Application Gateway | Load Balancer | Traffic Manager |
|---|---|---|---|---|
| Layer | L7, global edge | L7, regional | L4, regional | DNS |
| WAF | Yes | Yes | No | No |
| Scope | Global | Regional | Regional | Global (DNS-based) |
| Best for | Global web entry point, CDN-like acceleration | Regional web ingress, path routing | Raw TCP/UDP distribution | DNS-level routing where no proxy/edge layer is wanted |

## Private Endpoint vs Service Endpoint

| | Private Endpoint | Service Endpoint |
|---|---|---|
| Target gets a private IP | Yes | No (still public IP) |
| Traffic path | Fully private | Azure backbone, but target still publicly addressable |
| DNS changes needed | Yes (Private DNS Zone) | No |
| Recommended for new designs | ✅ | Legacy/simpler cases only |

## VPN Gateway vs ExpressRoute

| | VPN Gateway | ExpressRoute |
|---|---|---|
| Connectivity | Encrypted tunnel over public internet | Dedicated private circuit via provider |
| Bandwidth/latency consistency | Variable (internet-dependent) | Guaranteed, low-latency |
| Setup time/cost | Fast, lower cost | Slower provisioning, higher cost |
| Best for | Smaller/branch connectivity, DR backup path | Large enterprise hybrid connectivity |

## Azure SQL vs SQL Managed Instance vs SQL Server VM

| | Azure SQL Database | SQL Managed Instance | SQL Server on VM |
|---|---|---|---|
| Instance-level features (SQL Agent, cross-DB, CLR) | No | Yes | Yes |
| OS access | No | No | Yes |
| Operational overhead | Lowest | Low-medium | Highest (you patch everything) |
| Best for | New cloud-native apps | Lift-and-shift needing instance features | Legacy/specialized OS-level requirements |

## Azure SQL vs PostgreSQL vs Cosmos DB

| | Azure SQL | PostgreSQL Flexible Server | Cosmos DB |
|---|---|---|---|
| Model | Relational (T-SQL) | Relational (PostgreSQL) | Multi-model NoSQL |
| Global distribution | Limited (geo-replication) | Limited | Native, turnkey multi-region |
| Best for | SQL Server ecosystem apps | PostgreSQL-standardized apps | Global scale, flexible schema, extreme low-latency needs |

## Blob Storage vs Azure Files vs Managed Disks

| | Blob Storage | Azure Files | Managed Disks |
|---|---|---|---|
| Access pattern | HTTP(S) API (objects) | SMB/NFS file share | Block storage attached to one VM |
| Shared across machines | Yes (via API) | Yes (native file share) | No (one disk, one VM at a time typically) |
| Best for | Unstructured files/objects, data lake | Lift-and-shift file shares | VM OS/data disks |

## NSG vs Azure Firewall vs WAF

| | NSG | Azure Firewall | WAF |
|---|---|---|---|
| Layer | L3/L4 (IP/port) | L3–L7 (+ FQDN filtering) | L7 (HTTP-specific) |
| Scope | Subnet/NIC | Hub VNet, centralized | Attached to App Gateway/Front Door |
| Best for | Basic allow/deny per subnet | Centralized outbound/inbound policy across many VNets | Blocking web application attacks (SQLi, XSS) |

## Managed Identity vs Service Principal

| | Managed Identity | Service Principal |
|---|---|---|
| Where it runs | Inside Azure only | Anywhere (Azure, on-prem, other clouds, CI/CD) |
| Credential management | Automatic, by Azure | You manage (prefer federated credentials over secrets) |
| Best for | Azure resource calling another Azure resource | External systems/CI/CD authenticating to Azure |

## System-assigned vs User-assigned Managed Identity

| | System-assigned | User-assigned |
|---|---|---|
| Lifecycle | Tied to the resource; deleted with it | Independent Azure resource; you manage its lifecycle |
| Reusable across resources | No (1:1) | Yes (attach to many resources) |
| Best for | Simple single-resource scenarios | Shared identity across multiple resources, or identity needed before the resource exists |

## Application Insights vs Log Analytics

| | Application Insights | Log Analytics |
|---|---|---|
| Focus | Application-level telemetry (requests, dependencies, exceptions) | General-purpose log/metric store + KQL querying for any resource type |
| Relationship | Stores its data inside a Log Analytics workspace (modern model) | The underlying data platform |

## Azure Monitor vs Application Insights

| | Azure Monitor | Application Insights |
|---|---|---|
| Scope | The entire monitoring platform (metrics, logs, alerts, all resource types) | The application-performance-monitoring feature within Azure Monitor |

## Key Vault vs Managed HSM

| | Key Vault | Managed HSM |
|---|---|---|
| Tenancy | Multi-tenant (HSM-backed keys optional) | Single-tenant, dedicated HSM pool |
| Compliance level | High | Highest (FIPS 140-2 Level 3, dedicated) |
| Cost | Lower | Much higher |
| Best for | The vast majority of applications | Strict regulatory mandates requiring dedicated HSM hardware |

## Bicep vs ARM vs Terraform

| | Bicep | ARM (JSON) | Terraform |
|---|---|---|---|
| Multi-cloud | No (Azure only) | No (Azure only) | Yes |
| Readability | High | Low (verbose JSON) | High |
| Azure feature currency | Immediate (compiles to ARM) | Immediate (native) | Slight lag behind brand-new features sometimes |
| Best for | Azure-only teams | Legacy templates, low-level needs | Multi-cloud teams/existing Terraform investment |

## Azure OpenAI vs Azure Machine Learning

| | Azure OpenAI | Azure Machine Learning |
|---|---|---|
| Use case | Call pre-built generative models (chat, embeddings) | Train/deploy your own custom models |
| Best for | Generative AI features, RAG, chatbots | Custom ML pipelines, MLOps, proprietary models |

## Event Grid vs Service Bus

| | Event Grid | Service Bus |
|---|---|---|
| Delivery model | Push, fire-and-forget notifications | Pull-based, enterprise messaging guarantees |
| Ordering/sessions | No | Yes |
| Best for | "Something happened" fan-out | Reliable transactional business messaging |

## App Service Plan vs Function hosting plans

| | App Service Plan (Dedicated) | Functions Consumption/Flex Consumption | Functions Premium |
|---|---|---|---|
| Billing | Always-on instance cost | Pay-per-execution | Pay for allocated pre-warmed instances |
| Cold start | None | Possible (less on Flex Consumption) | Minimal |
| Best for | Steady-load apps, shared hosting | Spiky/event-driven workloads | VNet + no cold start + steady-ish event workloads |

---

# 12. 🎓 Interview / Knowledge-Check Question Bank

Use these to test your own understanding or prepare for architecture discussions and interviews.

**Fundamentals**
- What is the difference between control plane and data plane access?
- What is the difference between a resource group and a subscription?
- Why does Managed Identity remove an entire class of security risk compared to connection strings?

**Compute**
- When would you choose a VM over App Service, and vice versa?
- What's the real difference between Container Apps and AKS, beyond "one is simpler"?
- Why must Functions triggers be designed to be idempotent?
- What is AKS Automatic, and why might you default to it?

**Networking**
- Why is Private Endpoint generally preferred over Service Endpoint for new designs?
- What problem does NAT Gateway solve that a VM's own public IP doesn't?
- Why was Basic Load Balancer/Public IP retired, and what should replace it?
- What's the difference between Front Door and Application Gateway, and when would you use both together?

**Data**
- Why is Cosmos DB partition key selection considered an architecture decision, not an implementation detail?
- When would you choose SQL Managed Instance instead of Azure SQL Database?
- Why is Azure Managed Redis not a system of record?

**Messaging**
- Why does Service Bus require idempotent consumers despite having PeekLock semantics?
- When would you choose Event Grid over Service Bus for the same "notify other systems" requirement?

**Security**
- How does Managed Identity differ from a Service Principal, precisely?
- Why is RBAC-based Key Vault access preferred over the legacy access-policy model?
- What does a Private DNS Zone actually solve, and what happens if you forget to link it?

**Operations**
- What's the practical difference between Azure Monitor, Log Analytics, and Application Insights?
- Why do many production incidents trace back to a missing diagnostic setting?

---

# 13. 🧭 End-to-End Deployment Scenarios

Every resource above is explained in isolation. This section ties them together into complete, realistic developer journeys — "I have code, how does it actually end up running in Azure, step by step?" Each scenario names every resource used, shows the CLI flow, and includes a Bicep snippet for the core resources (full definitions are in the sections above — follow the cross-references).

## Scenario A — Containerized web API: Docker → Container Registry → ACI / Container Apps / AKS

**Goal:** build one container image once, then show the three most common places to run it, from "quick smoke test" to "production at scale."

```text
Developer machine
   │  docker build
   ▼
Dockerfile → container image (my-api:1.0)
   │  docker push (after az acr login)
   ▼
Azure Container Registry (ACR)  ──┬── pulled by ──▶ Azure Container Instances (ACI)       [fastest, single container, dev/test or batch jobs]
                                   ├── pulled by ──▶ Azure Container Apps (Consumption)     [production, auto-scale-to-zero, Dapr/KEDA, no cluster to manage]
                                   └── pulled by ──▶ Azure Kubernetes Service (AKS)          [production, full Kubernetes control, multi-team/complex topologies]
```

### Step 1 — Build and push the image
```bash
# Build locally
docker build -t my-api:1.0 .

# Create the registry (see "Azure Container Registry (ACR)" section for the full Bicep)
az acr create -g my-rg -n myacrregistry --sku Premium --admin-enabled false

# Authenticate Docker to ACR using your own Azure identity (no admin password)
az acr login -n myacrregistry

# Tag and push
docker tag my-api:1.0 myacrregistry.azurecr.io/my-api:1.0
docker push myacrregistry.azurecr.io/my-api:1.0
```

### Step 2a — Run it fastest: Azure Container Instances (dev/test, one-off jobs)
```bash
# Give ACI's managed identity permission to pull from ACR first (AcrPull role) — see ACI section for full example
az container create -g my-rg -n my-api-aci \
  --image myacrregistry.azurecr.io/my-api:1.0 \
  --acr-identity [system] \
  --ports 80 --ip-address Public --cpu 1 --memory 1.5
```
No orchestration, no scaling, no restart policy beyond basic — good for a demo, a one-off batch job, or local integration testing against a real Azure-hosted container. Not meant for production web traffic.

### Step 2b — Run it for production, serverless: Azure Container Apps
```bash
az containerapp env create -g my-rg -n my-aca-env -l eastus
az containerapp create -g my-rg -n my-api-aca \
  --environment my-aca-env \
  --image myacrregistry.azurecr.io/my-api:1.0 \
  --registry-server myacrregistry.azurecr.io \
  --registry-identity system \
  --target-port 80 --ingress external \
  --min-replicas 0 --max-replicas 10
```
Scales to zero when idle (pay-per-use), scales out automatically under load, gets a free HTTPS endpoint — the default choice for "I just need this API running reliably without managing a cluster."

### Step 2c — Run it at full Kubernetes scale: AKS
```bash
az aks create -g my-rg -n my-aks --node-count 3 \
  --generate-ssh-keys --attach-acr myacrregistry --network-plugin azure
az aks get-credentials -g my-rg -n my-aks

kubectl create deployment my-api --image=myacrregistry.azurecr.io/my-api:1.0
kubectl expose deployment my-api --port=80 --type=LoadBalancer
```
`--attach-acr` grants the AKS cluster's identity `AcrPull` on the registry automatically — no manual role assignment or stored credential needed. Choose AKS when you need custom Kubernetes controllers, multiple teams sharing one cluster with namespace isolation, service mesh, or workloads that don't fit the simpler Container Apps model.

### Core Bicep tying the registry and one compute target together
```bicep
resource acr 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: 'myacrregistry'
  location: resourceGroup().location
  sku: { name: 'Premium' }
  properties: { adminUserEnabled: false, publicNetworkAccess: 'Disabled' }
}

resource acaEnv 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: 'my-aca-env'
  location: resourceGroup().location
}

resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: 'my-api-aca'
  location: resourceGroup().location
  identity: { type: 'SystemAssigned' }
  properties: {
    managedEnvironmentId: acaEnv.id
    configuration: {
      ingress: { external: true, targetPort: 80 }
      registries: [{ server: acr.properties.loginServer, identity: 'system' }]
    }
    template: {
      containers: [{ name: 'my-api', image: '${acr.properties.loginServer}/my-api:1.0' }]
      scale: { minReplicas: 0, maxReplicas: 10 }
    }
  }
}

resource acrPullRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(acr.id, containerApp.id, 'AcrPull')
  scope: acr
  properties: {
    principalId: containerApp.identity.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d') // AcrPull
  }
}
```

## Scenario B — Classic lift-and-shift: VM, VNet, and scale-out

**Goal:** move an existing on-premises application to Azure with minimal rework, then scale it out.

```text
VNet (10.0.0.0/16)
 └── app-subnet (10.0.1.0/24)
       ├── NSG (allow 443 in, deny everything else by default)
       ├── VM (custom script extension installs/starts the app on boot)
       │     └── Public IP (or, better, placed behind a Load Balancer/App Gateway)
       └── later: Virtual Machine Scale Set replacing the single VM for HA + autoscale
```

```bash
az network vnet create -g my-rg -n my-vnet --address-prefix 10.0.0.0/16 \
  --subnet-name app-subnet --subnet-prefix 10.0.1.0/24
az network nsg create -g my-rg -n app-nsg
az network nsg rule create -g my-rg --nsg-name app-nsg -n AllowHttps \
  --priority 100 --destination-port-ranges 443 --access Allow --protocol Tcp

az vm create -g my-rg -n my-app-vm --image Ubuntu2204 \
  --vnet-name my-vnet --subnet app-subnet --nsg app-nsg \
  --admin-username azureuser --generate-ssh-keys \
  --custom-data cloud-init.yaml   # installs/starts the app on first boot

# Once validated, replace the single VM with a scale set for HA + autoscale (see VMSS section)
az vmss create -g my-rg -n my-app-vmss --image Ubuntu2204 \
  --vnet-name my-vnet --subnet app-subnet \
  --custom-data cloud-init.yaml --instance-count 2 --upgrade-policy-mode Automatic
```
Put a **Load Balancer** (or **Application Gateway** if you need Layer-7/WAF features) in front of the VMSS instead of exposing individual VM public IPs, and use **Azure Bastion** for admin access instead of opening RDP/SSH publicly — see those sections for the Bicep.

## Scenario C — PaaS web app with a database and secrets (no servers to patch)

**Goal:** the most common "normal business web app" shape — App Service + a managed database + Key Vault for secrets, with no passwords in config.

```text
GitHub Actions (OIDC, no stored secret)
   │  az webapp deploy
   ▼
App Service Plan (P1v3) → App Service (system-assigned managed identity)
   │                          │
   │                          ├── reads connection info from ──▶ Key Vault (RBAC: "Key Vault Secrets User")
   │                          └── connects via Managed Identity ──▶ Azure SQL Database (Entra ID auth, no password)
   └── Application Insights (auto-instrumented) ── diagnostic settings ──▶ Log Analytics Workspace
```

```bash
az appservice plan create -g my-rg -n my-plan --sku P1v3 --is-linux
az webapp create -g my-rg -p my-plan -n my-webapp --runtime "DOTNETCORE:8.0"
az webapp identity assign -g my-rg -n my-webapp

az keyvault create -g my-rg -n my-kv --enable-rbac-authorization true
az role assignment create --assignee <webapp-principal-id> \
  --role "Key Vault Secrets User" --scope <keyvault-resource-id>

az sql server create -g my-rg -n my-sql-server --enable-ad-only-auth \
  --external-admin-principal-type User --external-admin-name <your-entra-user>
az sql db create -g my-rg -s my-sql-server -n OrdersDb --service-objective S1
# Grant the Web App's managed identity a SQL login via a one-time T-SQL script:
#   CREATE USER [my-webapp] FROM EXTERNAL PROVIDER;
#   ALTER ROLE db_datareader ADD MEMBER [my-webapp];
```
The web app's connection string uses `Authentication=Active Directory Managed Identity` (shown in the Azure SQL Database section) — **no password is stored anywhere**. Deployment itself runs via GitHub Actions `azure/login@v2` using OIDC federated credentials (see the DevOps section) instead of a stored service-principal secret.

## Scenario D — Serverless event-driven pipeline (no always-on compute)

**Goal:** react to a file upload, process it, and notify downstream systems — paying only for actual executions.

```text
Blob Storage (container: "uploads")
   │  blob created event
   ▼
Event Grid (system topic on the storage account)
   │  subscription
   ▼
Azure Function (Blob-triggered or Event Grid-triggered, Consumption plan)
   │  processes file, writes result
   ├──▶ Cosmos DB (stores processed result)
   └──▶ Service Bus queue (notifies another downstream service to continue the workflow)
```

```bash
az storage account create -g my-rg -n myuploadsacct --sku Standard_LRS
az eventgrid system-topic create -g my-rg -n uploads-topic \
  --source <storage-account-resource-id> --topic-type Microsoft.Storage.StorageAccounts

az functionapp create -g my-rg -n my-file-processor \
  --storage-account myuploadsacct --consumption-plan-location eastus \
  --runtime dotnet-isolated --functions-version 4
az functionapp identity assign -g my-rg -n my-file-processor

az eventgrid system-topic event-subscription create -g my-rg \
  --system-topic-name uploads-topic -n to-function \
  --endpoint <function-resource-id>/functions/ProcessUpload \
  --endpoint-type azurefunction \
  --included-event-types Microsoft.Storage.BlobCreated
```
No VM, no App Service Plan running 24/7 — cost is purely "per file processed." This is the pattern to reach for whenever the workload is naturally event-driven and bursty rather than constantly busy.

## Scenario E — Grounded generative AI (RAG) app

**Goal:** a chat application that answers questions using your own documents, not just the model's general training data.

```text
Documents (PDFs, etc.) → Blob Storage
                             │  indexer (scheduled/on-demand)
                             ▼
                        Azure AI Search index (vector + keyword hybrid search)
                             ▲
                             │  retrieve top-k relevant chunks
App Service (chat UI/API) ───┤
                             │  send question + retrieved chunks as grounding context
                             ▼
                        Azure OpenAI (chat deployment, e.g., gpt-4o)
```

```bash
az storage account create -g my-rg -n mydocsacct --sku Standard_LRS
az search service create -g my-rg -n my-search --sku basic
az cognitiveservices account create -g my-rg -n my-openai-resource \
  --kind OpenAI --sku S0 -l eastus --custom-domain my-openai-resource
az cognitiveservices account deployment create -g my-rg -n my-openai-resource \
  --deployment-name chat-gpt4o --model-name gpt-4o --model-version "2024-08-06" \
  --model-format OpenAI --sku-capacity 10 --sku-name Standard

az appservice plan create -g my-rg -n my-plan --sku P1v3 --is-linux
az webapp create -g my-rg -p my-plan -n my-rag-app --runtime "DOTNETCORE:8.0"
az webapp identity assign -g my-rg -n my-rag-app
# Grant the Web App's identity "Cognitive Services OpenAI User" on the OpenAI resource
# and "Search Index Data Reader" on the search service (RBAC, no API keys stored).
```
The App Service calls Azure AI Search first to retrieve relevant document chunks (hybrid/vector search), then sends those chunks plus the user's question to the Azure OpenAI chat deployment — the model answers **grounded in your data** instead of guessing. All service-to-service calls use managed identity + RBAC, not API keys.

---

# 14. 🔗 Official Documentation Directory

- Resource fundamentals: https://learn.microsoft.com/azure/azure-resource-manager/management/overview
- Virtual Machines: https://learn.microsoft.com/azure/virtual-machines/
- App Service: https://learn.microsoft.com/azure/app-service/
- Azure Functions: https://learn.microsoft.com/azure/azure-functions/
- Container Apps: https://learn.microsoft.com/azure/container-apps/
- AKS: https://learn.microsoft.com/azure/aks/
- Container Registry: https://learn.microsoft.com/azure/container-registry/
- Virtual Network: https://learn.microsoft.com/azure/virtual-network/
- Private Link: https://learn.microsoft.com/azure/private-link/
- Load Balancer: https://learn.microsoft.com/azure/load-balancer/
- Application Gateway: https://learn.microsoft.com/azure/application-gateway/
- Front Door: https://learn.microsoft.com/azure/frontdoor/
- Azure Firewall: https://learn.microsoft.com/azure/firewall/
- Storage: https://learn.microsoft.com/azure/storage/
- Azure SQL: https://learn.microsoft.com/azure/azure-sql/
- Cosmos DB: https://learn.microsoft.com/azure/cosmos-db/
- Azure Managed Redis: https://learn.microsoft.com/azure/redis/
- Service Bus: https://learn.microsoft.com/azure/service-bus-messaging/
- Event Grid: https://learn.microsoft.com/azure/event-grid/
- Event Hubs: https://learn.microsoft.com/azure/event-hubs/
- API Management: https://learn.microsoft.com/azure/api-management/
- Microsoft Entra ID: https://learn.microsoft.com/entra/fundamentals/
- Managed identities: https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/overview
- Key Vault: https://learn.microsoft.com/azure/key-vault/
- Defender for Cloud: https://learn.microsoft.com/azure/defender-for-cloud/
- Microsoft Sentinel: https://learn.microsoft.com/azure/sentinel/
- Azure Monitor: https://learn.microsoft.com/azure/azure-monitor/
- Bicep: https://learn.microsoft.com/azure/azure-resource-manager/bicep/
- Data Factory: https://learn.microsoft.com/azure/data-factory/
- Synapse Analytics: https://learn.microsoft.com/azure/synapse-analytics/
- Databricks: https://learn.microsoft.com/azure/databricks/
- Data Explorer: https://learn.microsoft.com/azure/data-explorer/
- Microsoft Foundry / Azure AI services: https://learn.microsoft.com/azure/ai-foundry/
- Azure OpenAI: https://learn.microsoft.com/azure/ai-services/openai/
- Azure AI Search: https://learn.microsoft.com/azure/search/
- Azure Machine Learning: https://learn.microsoft.com/azure/machine-learning/

---

> **Companion document:** [`azure_cheatsheet.md`](./azure_cheatsheet.md) — the broad architecture/engineering reference. Use both together.

