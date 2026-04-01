# Client-created: Host Project VPCs (web-tier, app-tier) for NCC

Creates the **client** side of the NCC diagram:

- **Web-tier**: VPC `web-vpc-1` with subnets subnet-prod (10.1.0.0/20), subnet-dev (10.1.16.0/20), subnet-test (10.1.32.0/20).
- **App-tier**: VPC `app-vpc-1` with subnets subnet-prod (10.2.0.0/20), subnet-dev (10.2.16.0/20), subnet-test (10.2.32.0/20).
- **Custom static routes** (only when `create_ilb_next_hop_routes = true` and `load_balancer_self_link` is set):
  - Web-tier: 10.2.0.0/16 → Internal LB (Security VPC), priority `inter_tier_route_priority` (default 100).
  - Web-tier: 0.0.0.0/0 → Internal LB (Security VPC), priority `inspection_default_route_priority` (default 5).
  - App-tier: 10.1.0.0/16 → Internal LB (Security VPC), priority `inter_tier_route_priority` (default 100).
  - App-tier: 0.0.0.0/0 → Internal LB (Security VPC), priority `inspection_default_route_priority` (default 5).
- **Optional test VMs** (enabled by default):
  - Ubuntu VM in `web-vpc-1` `subnet-prod` (`10.1.0.0/20`)
  - Ubuntu VM in `app-vpc-1` `subnet-prod` (`10.2.0.0/20`)
  - Minimal test firewall rules for SSH and cross-tier ICMP/TCP (`22/80/443`) between `10.1.0.0/16` and `10.2.0.0/16`.

Run this **before** the NCC example so the VPCs exist for the NCC spokes.

> Important: in the NCC multi-VPC architecture, `next_hop_ilb` routes from web/app VPCs to an ILB in the security VPC are not supported by GCP Compute Routes (`Next hop Ilb is not on the route's network`). Keep `create_ilb_next_hop_routes = false` unless the ILB is in the same VPC network.

Required variables: `web_tier_project_id`, `app_tier_project_id`, `region`.
Optional: `load_balancer_self_link`, `create_ilb_next_hop_routes`, `inter_tier_route_priority`, `inspection_default_route_priority`, `create_test_vms`, `test_vm_machine_type`, `test_vm_assign_public_ip`, `test_vm_ssh_source_ranges`.

## Connectivity test quickstart

1. Apply this module and capture outputs `web_test_vm_internal_ip` and `app_test_vm_internal_ip`.
2. SSH to the web VM (external IP output, or IAP if you disable public IPs).
3. From web VM, test app path:
   - `ping <app_test_vm_internal_ip>`
   - `nc -vz <app_test_vm_internal_ip> 22`
4. Repeat from app VM to web VM.

This gives a simple end-to-end validation that web↔app routing and filtering are working in your NCC/vSocket setup.
