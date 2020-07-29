output "instance_id" {
  value = values(google_compute_instance.this)[*].id
}

output "instance_self_link" {
  value = values(google_compute_instance.this)[*].self_link
}

output "external_ip_0" {
  value = values(google_compute_instance.this)[*].network_interface.0.access_config.0.nat_ip
}

output "external_ip_1" {
  value = values(google_compute_instance.this)[*].network_interface.1.access_config.0.nat_ip
}
