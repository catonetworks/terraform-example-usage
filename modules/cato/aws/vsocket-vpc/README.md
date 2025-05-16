# Cato Networks AWS vSocket Terraform Module

The Cato vSocket modules creates a VPC and deploys a vSocket instnace to connect the VPC to the Cato Cloud.

This module deploys the following resources
- 1 VPC
- 1 vSocket aws instance with 3 network interfaces (lan/wan/mgmt)
- 2 Elastic IPs (wan/mgmt)
- 1 internet gateway
- 3 routing tables with default routes (lan/wan/mgmt)
- 2 security groups (external/internal)
- 3 subnets (lan/wan/mgmt)

