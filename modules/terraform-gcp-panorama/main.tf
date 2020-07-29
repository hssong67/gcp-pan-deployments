
resource "google_compute_instance" "this" {
  for_each     = var.panoramas
  name         = each.key
  machine_type = var.fw_machine_type
  zone         = each.value.zone
  tags         = concat(lookup(each.value, "tags", []), var.fw_tags)
  metadata = {
    serial-port-enable = true
    ssh-keys           = join(":", ["admin", var.fw_ssh_key])
  }

  service_account {
    scopes = var.fw_scopes
  }

  dynamic "network_interface" {
    for_each = each.value.interfaces
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
      image = var.image
    }
  }
}
