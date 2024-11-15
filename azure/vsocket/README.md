# Cato Networks Azure vSocket Terraform Module

The Cato vSocket modules creates a Resource group and deploys a vSocket instance to connect the Resource group to the Cato Cloud.

# Pre-reqs
- Install the Azure CLI
`brew update && brew install azure-cli`
- Run the following to configure the Azure CLI
`$ az login`


This module deploys the following resources
- 1 Resource Group
- 1 vSocket aws instance with 3 network interfaces (lan/wan/mgmt)
- 2 Elastic IPs (wan/mgmt)
- 1 internet gateway
- 3 routing tables with default routes (lan/wan/mgmt)
- 2 security groups (external/internal)
- 3 subnets (lan/wan/mgmt)

