output "vpc3_public_ips_from_test_env" {
  description = "Public IPs of VPC 3 servers in the test_env module"
  value       = length(module.test_env_ha) > 0 ? module.test_env_ha[0].vpc3_public_ips : {}
}