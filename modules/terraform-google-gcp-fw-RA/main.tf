resource "google_compute_firewall" "private_mgmt_allow" {
  for_each = toset(var.mgmt_network)
  name    = "${each.key}-allow-private"
  network = each.key 
  enable_logging = var.priv_mgmt_logging
  source_ranges  = var.priv_mgmt_src_ips
  priority = 999 
  allow {
    protocol = "all"
  }
  target_tags = var.mgmt_tags 
}

resource "google_compute_firewall" "public_mgmt_allow" {
  for_each = toset(var.mgmt_network)
  name    = "${each.key}-allow-public"
  network = each.key 
  enable_logging = var.pub_mgmt_logging
  source_ranges  = var.pub_mgmt_src_ips
  priority = 1001

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["443", "22"]
  }

  target_tags = var.mgmt_tags 
}

resource "google_compute_firewall" "private_allow" {
  for_each = toset(var.private_network)
  name    = "${each.key}-allow-private"
  network = each.key 
  enable_logging = var.priv_logging
  source_ranges  = var.priv_src_ips
  priority = 1002 
  allow {
    protocol = "all"
  }
  target_tags = var.private_tags 
}

resource "google_compute_firewall" "public_allow" {
  for_each = toset(var.public_network)
  name    = "${each.key}-allow-public"
  network = each.key 
  enable_logging = var.pub_logging
  source_ranges  = var.pub_src_ips
  priority = 1003

  allow {
    protocol = "all"
  }

  target_tags = var.public_tags 
}
