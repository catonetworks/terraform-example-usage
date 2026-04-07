# Example: GCP vSocket HA with NCC + Cloud Router + BGP

This example extends the [plain NCC example](../vsocket-ha-ncc/) by enabling:

- **Cloud Router + BGP** in the LAN VPC for dynamic route exchange with vSocket.
- **BGP route injection** into the NCC hub via the Router Appliance spoke, steering inter-spoke and internet traffic through the security VPC (vSocket) for SASE inspection.

Uses `security-bgp` site name and **10.4.x** IP ranges so this example can run alongside the plain NCC example (`security` / 10.3.x) in the same GCP project without conflicts.

---

## What this adds over the plain NCC example

| Entity | Description |
|--------|-------------|
| **Cloud Router** | Created in the LAN VPC with configurable ASN. Auto-advertises client CIDRs to vSocket so it knows about GCP networks. |
| **NCC Router Appliance spoke** | Regional spoke that registers vSocket VM(s) and propagates BGP-learned routes to the NCC hub (and thus to client VPCs). |
| **GCP BGP peers** | Primary peer (Cloud Router ↔ primary vSocket). Optional secondary peer for HA. |
| **Cato BGP peers** | Automatically created via the Cato API (`cato_bgp_peer`). Configures vSocket to peer with Cloud Router and advertise `0.0.0.0/0` by default. |
| **Firewall rule** | Allows BGP (TCP/179) and BFD (UDP/3784-3785) between Cloud Router and vSocket. |

## How BGP route injection works

1. Cloud Router advertises client CIDRs to vSocket via BGP (auto-derived from `ncc_client_spokes` export ranges).
2. vSocket is **automatically configured** (via `cato_bgp_peer` resource) to advertise routes back — by default `0.0.0.0/0` (default route).
3. Cloud Router learns these routes; the Router Appliance spoke propagates them to the NCC hub.
4. Client VPCs receive these BGP-learned routes and use them to reach destinations via the security LAN VPC.
5. Policy-based routes in the security LAN VPC catch client-sourced traffic → ILB → vSocket for inspection.

## Traffic flow

| Scenario | Path |
|----------|------|
| **Web VM → App VM** | Web VPC → (BGP route via Router Appliance) → Security LAN VPC → PBR → ILB → vSocket (inspection) → NCC Hub → App VPC. **Inspected.** |
| **VM → Internet** | Client VPC → (BGP default route via Router Appliance) → Security LAN VPC → PBR → ILB → vSocket → Internet. **Inspected.** |
| **On-prem → GCP VM** | On-prem → Cato SDWAN → vSocket → LAN VPC → NCC Hub → Spoke VPC → VM |
| **GCP VM → On-prem** | VM → Spoke VPC → NCC Hub → LAN VPC → (Cloud Router dynamic route) → vSocket → Cato SDWAN → On-prem |

### NCC route priority note

In MESH topology (default), VPC spoke routes are preferred over Router Appliance routes for the same prefix length. To ensure BGP-injected routes win:

- **Internet traffic**: vSocket advertises `0.0.0.0/0` — this always wins over the VPC default gateway (priority 1000).
- **Inter-spoke traffic**: vSocket should advertise prefixes that are more specific than VPC spoke subnet routes, or use `0.0.0.0/0` as a catch-all default route.

Alternatively, set `ncc_spoke_isolation = true` for STAR topology where edge spokes only see center routes (eliminates competing VPC spoke routes entirely).

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
- **Cato API credentials** must be configured (the module creates `cato_bgp_peer` resources to configure vSocket BGP automatically). Set `create_cato_bgp_peer = false` to skip and configure manually instead.
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

## Key NCC variables

| Name | Description | Default |
|------|-------------|---------|
| `ncc_spoke_isolation` | STAR topology (center/edge groups). Default is MESH with BGP route injection. | `false` |

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

## Cato BGP peer variables

| Name | Description | Default |
|------|-------------|---------|
| `create_cato_bgp_peer` | Create `cato_bgp_peer` resources via Cato API. | `true` |
| `cato_bgp_peer_default_action` | Default action for routes (ACCEPT or DROP). | `"ACCEPT"` |
| `cato_bgp_peer_advertise_default_route` | Advertise `0.0.0.0/0` from vSocket. | `true` |
| `cato_bgp_peer_advertise_all_routes` | Advertise all Cato routes. | `false` |
| `cato_bgp_peer_summary_routes` | Summary routes to advertise (list of `{route, community}`). | `[]` |
| `cato_bgp_peer_metric` | Route preference metric. | `150` |

## Outputs

All outputs from the plain NCC example plus:

- **`cloud_router_id`** — Cloud Router ID.
- **`cloud_router_name`** — Cloud Router name.
- **`router_appliance_spoke_id`** — Router Appliance NCC spoke ID.
- **`bgp_peer_status_command`** — `gcloud` command to check BGP session status.
- **`cato_bgp_peer_primary_id`** — Cato BGP peer ID (primary).
- **`cato_bgp_peer_secondary_id`** — Cato BGP peer ID (secondary/HA).
