# Example: GCP vSocket HA with NCC (diagram-based)

This example replicates the architecture from the **NCC Hub with vSocket SASE** diagram:

- **NCC Hub** as the central component.
- **Security project**: Security VPC with vSockets, Internal LB, connected to the NCC Hub as a spoke. Client internet and east-west traffic (web-tier ↔ app-tier) are routed via the Security VPC for inspection.
- **Host Project web-tier**: Shared VPC `web-vpc-1` with subnets prod/dev/test (10.1.0.0/20, 10.1.16.0/20, 10.1.32.0/20), attached to the NCC Hub as a spoke.
- **Host Project app-tier**: Shared VPC `app-vpc-1` with subnets prod/dev/test (10.2.0.0/20, 10.2.16.0/20, 10.2.32.0/20), attached to the NCC Hub as a spoke.
- **Custom static routes** in web-tier and app-tier: traffic to the other tier and to the internet (0.0.0.0/0) is sent to the Internal LB in the Security VPC.

---

## What is created by the **NCC module** (this example + `terraform-cato-vsocket-gcp-ha-ncc`)

| Entity | Description |
|--------|-------------|
| **Security project** (default provider project) | GCP project where Terraform runs (you set this via provider / `security_project_id`). |
| **Security VPC** | Mgmt, WAN, LAN VPCs and subnets (e.g. 10.3.1.0/24 mgmt, 10.3.2.8/29 wan, 10.3.3.0/24 lan). |
| **vSockets** | Two vSocket instances (HA), Internal LB, policy-based routes (LAN → ILB, skip-socket for vSocket egress). |
| **NCC Hub** | One NCC hub in the security project. |
| **NCC Security spoke** | LAN VPC attached to the hub; exports 0.0.0.0/0 and LAN range so client traffic goes via vSocket (SASE). |
| **NCC Client spokes** | Spokes created **in** the web-tier and app-tier projects, attaching `web-vpc-1` and `app-vpc-1` to the hub. |
| **Policy-based routes (security LAN)** | Traffic from client CIDRs (10.1.0.0/16, 10.2.0.0/16) with dest 0.0.0.0/0 → Internal LB → vSocket. |

---

## What is **expected to be created by the client**

| Entity | Description |
|--------|-------------|
| **GCP projects** | Security project, Host Project web-tier, Host Project app-tier (and optionally service projects). Created manually or via your own Terraform. |
| **Host Project web-tier** | Project that will contain `web-vpc-1`. |
| **Host Project app-tier** | Project that will contain `app-vpc-1`. |
| **Shared VPCs and subnets** | Use the **client** module `modules/gcp/ncc-client-host-vpcs` to create `web-vpc-1` and `app-vpc-1` with subnets (prod/dev/test). Run this **before** the NCC example so the VPCs exist for the NCC spokes. |
| **Custom static routes** | Routes in web-tier (10.2.0.0/16 and 0.0.0.0/0 → Internal LB) and app-tier (10.1.0.0/16 and 0.0.0.0/0 → Internal LB). The client module `ncc-client-host-vpcs` can create these when you pass `load_balancer_self_link` (from this example’s output). |
| **Service projects** (optional) | e.g. Project_A (dev-testing, app-testing), Project_B (web-build, app-dev). Attach to the Shared VPC host projects. |
| **VMs** (optional) | VM A, VM B in each service project; diagram shows these as examples. |
| **NCC Gateway** (optional) | If you use an NCC Gateway for internet/B2B/SaaS, create and attach it outside this example. |

---

## Provider configuration

When running Terraform from this module directory, configure the **Google provider** so that the default project is the **security project** (e.g. `export GOOGLE_PROJECT=YOUR_SECURITY_PROJECT_ID` or use a `provider "google" { project = var.security_project_id }` in a root wrapper). The Cato provider is required for the vSocket site.

## Run order

1. **Create GCP projects** (security, web-tier, app-tier) if they do not exist.
2. **Create client VPCs and subnets**  
   Run `modules/gcp/ncc-client-host-vpcs` with `load_balancer_self_link = ""` so only VPCs and subnets are created. Use the same `web_tier_project_id`, `app_tier_project_id`, `web_vpc_name`, `app_vpc_name` you will pass to the NCC example.
3. **Run this NCC example** (`modules/cato/gcp/vsocket-ha-ncc`) in the **security project** (provider project = security). This creates vSocket HA, NCC hub, security spoke, and client spokes (web-tier, app-tier). Note `load_balancer_self_link` from outputs.
4. **Add client routes**  
   Re-run `modules/gcp/ncc-client-host-vpcs` with `load_balancer_self_link` set to the value from step 3 so the custom static routes to the Internal LB are created.

---

## Missing input parameters to run the example

You must supply (e.g. in a `terraform.tfvars` or environment):

### GCP

- **`security_project_id`** — GCP project ID of the security project (where vSocket and NCC run).
- **`region`** — e.g. `us-central1` (same region for security and client VPCs).
- **`web_tier_project_id`** — GCP project ID for Host Project / web-tier (must exist; VPC `web-vpc-1` will be created there by the client module).
- **`app_tier_project_id`** — GCP project ID for Host Project / app-tier (must exist; VPC `app-vpc-1` will be created there by the client module).

### Cato

- **`token`** — Cato Networks API token (sensitive).
- **`account_id`** — Cato Networks account ID (number).

### Optional / defaults

- **`baseurl`** — Cato API base URL (default: `https://api.catonetworks.com/api/v1/graphql2`).
- **`license_id`** / **`license_bw`** — If you use Cato licensing.
- **`vsocket_ha_ncc_module_source`** — Path or registry source for `terraform-cato-vsocket-gcp-ha-ncc` (default: `../../../../../terraform-cato-vsocket-gcp-ha-ncc`).

### Permissions

- Security project: identity needs permissions to create vSocket resources, VPCs, NCC hub/spokes, and policy-based routes.
- Web-tier and app-tier projects: identity needs `roles/networkconnectivity.spokeAdmin` (for NCC spokes created by the module) and `roles/compute.networkAdmin` (for the client module: VPCs, subnets, routes).
- Enable APIs: `compute.googleapis.com`, `networkconnectivity.googleapis.com` in all three projects.

### Not in this example (you add as needed)

- **NCC Gateway** (for internet/B2B/SaaS) — create and attach separately if required.
- **Service projects** and **VMs** (Project_A, Project_B, VM A/B) — create in your own Terraform or console.
- **Billing account** and **organization** IDs if you create projects via Terraform.
- **vSocket image**, **machine type**, **health check** tuning — use module defaults or override in the NCC module source.
