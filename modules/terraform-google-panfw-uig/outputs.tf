output "instance_id" {
  value = values(google_compute_instance.this)[*].id
}

output "instance_self_link" {
  value = values(google_compute_instance.this)[*].self_link
}

output "instance_groups" {
  value = google_compute_instance_group.this
}
