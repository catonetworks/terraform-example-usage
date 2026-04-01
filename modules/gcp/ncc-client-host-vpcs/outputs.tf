output "web_vpc_id" { value = google_compute_network.web_vpc.id }
output "web_vpc_name" { value = google_compute_network.web_vpc.name }
output "web_vpc_self_link" { value = google_compute_network.web_vpc.self_link }
output "app_vpc_id" { value = google_compute_network.app_vpc.id }
output "app_vpc_name" { value = google_compute_network.app_vpc.name }
output "app_vpc_self_link" { value = google_compute_network.app_vpc.self_link }

output "web_test_vm_name" {
  value = var.create_test_vms ? google_compute_instance.web_test_vm[0].name : null
}

output "web_test_vm_internal_ip" {
  value = var.create_test_vms ? google_compute_instance.web_test_vm[0].network_interface[0].network_ip : null
}

output "web_test_vm_external_ip" {
  value = var.create_test_vms && var.test_vm_assign_public_ip ? google_compute_instance.web_test_vm[0].network_interface[0].access_config[0].nat_ip : null
}

output "app_test_vm_name" {
  value = var.create_test_vms ? google_compute_instance.app_test_vm[0].name : null
}

output "app_test_vm_internal_ip" {
  value = var.create_test_vms ? google_compute_instance.app_test_vm[0].network_interface[0].network_ip : null
}

output "app_test_vm_external_ip" {
  value = var.create_test_vms && var.test_vm_assign_public_ip ? google_compute_instance.app_test_vm[0].network_interface[0].access_config[0].nat_ip : null
}
