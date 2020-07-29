output "panoramas" {
  value = values(google_compute_instance.this)[*]
}

