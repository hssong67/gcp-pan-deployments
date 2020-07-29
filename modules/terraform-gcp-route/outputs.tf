output "routes_per_network" {
  value = { for route in google_compute_route.this : route.network => route... }
  # value = values(google_compute_route.this)[*]
}
