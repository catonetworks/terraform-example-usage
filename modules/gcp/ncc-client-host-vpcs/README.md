# Client-created: Host Project VPCs (web-tier, app-tier) for NCC

Creates the **client** side of the NCC diagram:

- **Web-tier**: VPC `web-vpc-1` with subnets subnet-prod (10.1.0.0/20), subnet-dev (10.1.16.0/20), subnet-test (10.1.32.0/20).
- **App-tier**: VPC `app-vpc-1` with subnets subnet-prod (10.2.0.0/20), subnet-dev (10.2.16.0/20), subnet-test (10.2.32.0/20).
- **Custom static routes** (when `load_balancer_self_link` is set):
  - Web-tier: 10.2.0.0/16 and 0.0.0.0/0 → Internal LB (Security VPC).
  - App-tier: 10.1.0.0/16 and 0.0.0.0/0 → Internal LB (Security VPC).

Run this **before** the NCC example so the VPCs exist for the NCC spokes. Run again with `load_balancer_self_link` after the NCC example to create the routes.

Required variables: `web_tier_project_id`, `app_tier_project_id`, `region`. Optional: `load_balancer_self_link` (set after NCC is up).
