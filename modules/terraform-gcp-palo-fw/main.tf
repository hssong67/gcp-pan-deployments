data "google_compute_image" "this" {
  project = "paloaltonetworksgcp-public"
  name    = "vmseries-${var.fw_license}-${var.fw_version}"
}
resource "google_compute_instance" "this" {
  for_each                  = var.firewalls
  name                      = each.key
  machine_type              = var.fw_machine_type
  zone                      = each.value.zone
  can_ip_forward            = true
  allow_stopping_for_update = true
  tags                      = concat(lookup(each.value, "tags", []), var.fw_tags)
  metadata = {
    vmseries-bootstrap-gce-storagebucket = lookup(each.value, "bucket", var.fw_bootstrap_bucket)
    serial-port-enable                   = true
    mgmt-interface-swap                  = var.management_interface_swap
    ssh-keys                             = join(":", ["admin", var.fw_ssh_key])
  }

  service_account {
    scopes = var.fw_scopes
  }

  dynamic "network_interface" {
    for_each = { for interface in each.value.interfaces : interface.index => interface }
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

  boot_disk {
    initialize_params {
      image = var.custom_image != null ? var.custom_image : data.google_compute_image.this.self_link
    }
  }
}

