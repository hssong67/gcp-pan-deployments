data "google_compute_instance_group" "default" {
  for_each = var.instance_groups
  name = each.key
  zone = each.value
}  


#-----------------------------------------------------------------------------------------------
# Create the internal load balancers
#-----------------------------------------------------------------------------------------------


resource "google_compute_region_backend_service" "this" {
  for_each      = var.ilbs
  region                = each.value.region
  provider      = google-beta
  name          = each.key
  load_balancing_scheme      = "INTERNAL"
  session_affinity  = "CLIENT_IP"
  network = each.value.network
  project = each.value.project
  timeout_sec   = 3
  connection_draining_timeout_sec = 10
  health_checks = [google_compute_health_check.this[each.key].self_link]

  dynamic "backend" {
  for_each = data.google_compute_instance_group.default 
  content {
    group = backend.value.self_link
    }
  }
}

resource "google_compute_forwarding_rule" "default" {
  for_each      = var.ilbs
  name          = each.key
  region                = each.value.region
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.this[each.key].self_link
  all_ports             = true
  network               = each.value.network
  subnetwork            = each.value.subnetwork
  ip_address            = each.value.ip_address
}


resource "google_compute_health_check" "this" {
  for_each           = var.ilbs
  name               = each.key

  timeout_sec         = 2
  check_interval_sec  = 2
  healthy_threshold   = 2
  unhealthy_threshold = 3

  tcp_health_check {
    port = each.value.health_probe_port
  }
}