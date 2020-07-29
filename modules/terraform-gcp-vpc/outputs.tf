output "vpc" {
  value = values(google_compute_network.this)[*]
}

output "subnets" {
  value = { for subnet in google_compute_subnetwork.this : subnet.network => subnet... }
}
