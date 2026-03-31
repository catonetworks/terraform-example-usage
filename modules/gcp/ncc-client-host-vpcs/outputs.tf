output "web_vpc_id"          { value = google_compute_network.web_vpc.id }
output "web_vpc_name"       { value = google_compute_network.web_vpc.name }
output "web_vpc_self_link"  { value = google_compute_network.web_vpc.self_link }
output "app_vpc_id"         { value = google_compute_network.app_vpc.id }
output "app_vpc_name"       { value = google_compute_network.app_vpc.name }
output "app_vpc_self_link"  { value = google_compute_network.app_vpc.self_link }
