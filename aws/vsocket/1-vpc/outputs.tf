## The following attributes are exported:
output "internet_gateway_id" { value = aws_internet_gateway.internet_gateway.id }
output "project_name" { value = var.project_name }
output "sg_internal" { value = aws_security_group.internal_sg.id }
output "sg_external" { value = aws_security_group.external_sg.id }
output "mgmt_eni_id" { value = aws_network_interface.mgmteni.id }
output "wan_eni_id" { value = aws_network_interface.waneni.id }
output "lan_eni_id" { value = aws_network_interface.laneni.id }
output "lan_subnet_id" { value = aws_subnet.lan_subnet.id }
output "vpc_id" { value = aws_vpc.cato-lab.id }
