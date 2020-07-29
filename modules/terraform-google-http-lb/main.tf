data "google_compute_instance_group" "default" {
  for_each = var.instance_groups
  name = each.key
  zone = each.value
}  

resource "google_compute_backend_service" "this" {
  for_each      = var.apps
  name          = each.key
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [google_compute_http_health_check.this[each.key].self_link]
  port_name     = each.key
  dynamic "backend" {
  for_each = data.google_compute_instance_group.default 
  content {
    group = backend.value.self_link
    }
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

  dynamic "host_rule" {
  for_each = var.url_maps
    content {
      hosts        = host_rule.value.hosts 
      path_matcher = host_rule.key 
    }
  }

  dynamic "path_matcher" {
  for_each = var.url_maps
    content {
      name            = path_matcher.key 
      default_service = google_compute_backend_service.this[path_matcher.value.default_app].self_link

      dynamic "path_rule" {
        for_each = toset(path_matcher.value.apps) 
        content {
          paths   = var.apps[path_rule.key].paths 
          service = google_compute_backend_service.this[path_rule.key].self_link
        }
      }
    }
  }
}

resource "google_compute_global_address" "this" {
  name = var.ip_address_name 
}

resource "google_compute_global_forwarding_rule" "this" {
  name       = var.lb_name
  target     = google_compute_target_http_proxy.this.self_link
  ip_address = google_compute_global_address.this.address 
  port_range = "80"
}

resource "google_compute_target_http_proxy" "this" {
  name    = var.lb_name
  url_map = google_compute_url_map.this.self_link
}
