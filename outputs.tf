output "vpc3_public_ips_from_tgw_test_env" {
  description = "Public IPs of VPC 3 servers in the test_env module"
  value = var.build_aws_vsocket_tgw_test_env ? module.vsocket-aws-tgw[0].vpc3_public_ips_from_test_env : {}
}

output "vpc3_public_ips_from_tgw_ha_test_env" {
  description = "Public IPs of VPC 3 servers in the test_env module"
  value = var.build_aws_vsocket_tgw_ha_test_env ? module.build_aws_vsocket_tgw_ha_module[0].vpc3_public_ips_from_test_env : {}

}