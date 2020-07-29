resource "google_compute_instance_group_manager" "this" {
  name = var.instance_group_name
  version {
    name              = "base_fw"
    instance_template = var.instance_template
  }
  base_instance_name = var.base_name
  zone               = var.zone
  target_size        = var.size

  dynamic "named_port" {
    for_each = var.apps
    content {
      name = named_port.key
      port = named_port.value.port
    }
  }
}

resource "google_compute_backend_service" "this" {
  for_each      = var.apps
  name          = each.key
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [google_compute_http_health_check.this[each.key].self_link]
  port_name     = each.key
  backend {
    group = google_compute_instance_group_manager.this.instance_group
  }
}

resource "google_compute_http_health_check" "this" {
  for_each           = var.apps
  name               = each.key
  request_path       = "/"
  port               = each.value.port
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_url_map" "this" {
  name            = var.lb_name
  default_service = google_compute_backend_service.this[var.default_app].self_link
  host_rule {
    hosts        = var.hosts
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.this[var.default_app].self_link

    dynamic "path_rule" {
      for_each = var.apps
      content {
        paths   = path_rule.value.paths
        service = google_compute_backend_service.this[path_rule.key].self_link
      }
    }
  }
}

resource "google_compute_global_forwarding_rule" "this" {
  name       = var.lb_name
  target     = google_compute_target_http_proxy.this.self_link
  ip_address = var.ip
  port_range = "80"
}

resource "google_compute_target_http_proxy" "this" {
  name    = var.lb_name
  url_map = google_compute_url_map.this.self_link
}
