# Example: GCP vSocket HA with NCC + Cloud Router + BGP

This example extends the [plain NCC example](../vsocket-ha-ncc/) by enabling a **Cloud Router** in the LAN VPC with **BGP peering** to the Cato vSocket(s). It solves the **return-routing problem** (GCP → on-prem): on-prem routes advertised by the vSocket propagate through Cloud Router → LAN VPC dynamic routes → NCC Hub → client spoke VPCs.

Uses `security-bgp` site name and **10.4.x** IP ranges so this example can run alongside the plain NCC example (`security` / 10.3.x) in the same GCP project without conflicts.

---

## What this adds over the plain NCC example

| Entity | Description |
|--------|-------------|
| **Cloud Router** | Created in the LAN VPC with configurable ASN and optional custom route advertisements. |
| **NCC Router Appliance spoke** | Regional spoke that registers the vSocket VM(s) so Cloud Router can establish BGP sessions with them. |
| **BGP peers** | Primary peer (Cloud Router ↔ primary vSocket). Optional secondary peer for HA (Cloud Router ↔ secondary vSocket). |
| **Firewall rule** | Allows BGP (TCP/179) and BFD (UDP/3784-3785) between Cloud Router and vSocket. |

## Traffic flow (with BGP)

| Scenario | Path |
|----------|------|
| **On-prem → GCP VM** | On-prem → Cato SDWAN → vSocket → LAN VPC → NCC Hub → Spoke VPC → VM |
| **GCP VM → On-prem** | VM → Spoke VPC → NCC Hub → LAN VPC → (Cloud Router dynamic route) → vSocket → Cato SDWAN → On-prem |

---

## IP addressing (default)

Uses 10.4.x to avoid clashing with the plain NCC example (10.3.x):

| Subnet | CIDR | Key IPs |
|--------|------|---------|
| Mgmt | 10.4.1.0/24 | Primary .4, Secondary .5 |
| WAN | 10.4.2.8/29 | Primary .10, Secondary .11 |
| LAN | 10.4.3.0/24 | Primary .4, Secondary .5, LB .6, **CR primary .10, CR secondary .11** |

---

## Prerequisites

Everything from the [plain NCC example](../vsocket-ha-ncc/README.md) plus:

- **`primary_zone`** and **`secondary_zone`** must be set (required for Router Appliance VM references).
- Cato vSocket must be configured for BGP peering on the Cato side (ASN, route advertisements).
- A VPC can only be a spoke in **one** NCC hub. If you run both examples in the same project, use different client VPCs or remove client spokes from one example.

## Run order

Same as the [plain NCC example](../vsocket-ha-ncc/README.md#run-order). After apply, check BGP session status:

```bash
# Output includes the full command; or run manually:
gcloud compute routers get-status security-bgp-lan-router \
  --region=europe-west1 \
  --project=YOUR_SECURITY_PROJECT_ID
```

---

## Cloud Router + BGP variables

| Name | Description | Default |
|------|-------------|---------|
| `enable_cloud_router` | Create Cloud Router in LAN VPC. | `true` |
| `cloud_router_name` | Name of the Cloud Router. | `"{site_name}-lan-router"` |
| `cloud_router_asn` | Cloud Router BGP ASN. | `64520` |
| `cloud_router_advertised_ip_ranges` | Custom IP ranges to advertise to peers. | `[]` |
| `enable_bgp` | Enable BGP peering via Router Appliance. | `true` |
| `cato_bgp_asn` | Cato vSocket BGP ASN. | `64515` |
| `cloud_router_bgp_interface_ip_primary` | Cloud Router primary BGP interface IP. | `10.4.3.10` |
| `cloud_router_bgp_interface_ip_secondary` | Cloud Router secondary BGP interface IP (HA). | `10.4.3.11` |
| `advertised_route_priority` | BGP route priority (secondary = +100). | `100` |
| `enable_bfd` | Enable BFD. | `true` |
| `bfd_min_transmit_interval` | BFD min TX interval (ms). | `1000` |
| `bfd_min_receive_interval` | BFD min RX interval (ms). | `1000` |
| `bfd_multiplier` | BFD multiplier. | `5` |
| `create_bgp_firewall_rule` | Create BGP/BFD firewall rules. | `true` |

## Outputs

All outputs from the plain NCC example plus:

- **`cloud_router_id`** — Cloud Router ID.
- **`cloud_router_name`** — Cloud Router name.
- **`router_appliance_spoke_id`** — Router Appliance NCC spoke ID.
- **`bgp_peer_status_command`** — `gcloud` command to check BGP session status.
