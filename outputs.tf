output "vpc3_public_ips_from_tgw_test_env" {
  description = "Public IPs of Public VPC servers in the test environment"
  value = var.build_aws_vsocket_tgw_test_env ? module.vsocket-aws-tgw[0].vpc3_public_ips_from_test_env : {}
}

output "vpc3_public_ips_from_tgw_ha_test_env" {
  description = "Public IPs of Public VPC servers in the test environment"
  value = var.build_aws_vsocket_tgw_ha_test_env ? module.build_aws_vsocket_tgw_ha_module[0].vpc3_public_ips_from_test_env : {}

}