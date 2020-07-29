data "google_compute_image" "this" {
  project = "paloaltonetworksgcp-public"
  name    = "vmseries-${var.fw_license}-${var.fw_version}"
}

resource "google_compute_instance_template" "this" {
  name_prefix          = var.prefix
  region = var.region
  description          = var.description
  tags                 = var.fw_tags
  labels               = var.labels
  instance_description = var.fw_description
  machine_type         = var.fw_machine_type
  can_ip_forward       = true
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = data.google_compute_image.this.self_link
  }

  lifecycle {
    create_before_destroy = true
  }

  dynamic "network_interface" {
    for_each = { for interface in var.interfaces : interface.index => interface }
    content {
      subnetwork = network_interface.value.subnetwork
      network_ip = lookup(network_interface.value, "private_ip", "")
      dynamic "access_config" {
        for_each = contains(keys(network_interface.value), "public_ip") ? [{}] : []
        content {
          nat_ip = lookup(network_interface.value, "public_ip", "")
        }
      }
    }
  }

  metadata = {
    vmseries-bootstrap-gce-storagebucket = var.fw_bootstrap_bucket
    serial-port-enable                   = true
    mgmt-interface-swap                  = var.management_interface_swap
    ssh-keys                             = join(":", ["admin", var.fw_ssh_key])
  }

  service_account {
    scopes = var.fw_scopes
  }
}

resource "google_compute_region_instance_group_manager" "this" {
  name = var.prefix
  version {
    name              = "base_fw"
    instance_template = google_compute_instance_template.this.self_link
  }
  base_instance_name = var.base_name
  region               = var.region
  target_size        = var.size

  # update_policy {
  #   type                  = "OPPORTUNISTIC"
  #   minimal_action        = "RESTART"
  # }
  
  dynamic "named_port" {
    for_each = var.apps
    content {
      name = named_port.key
      port = named_port.value.port
    }
  }
}