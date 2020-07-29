resource "google_compute_network" "this" {
  for_each                        = var.vpcs
  project                         = lookup(each.value, "project", null)
  name                            = each.key
  description                     = lookup(each.value, "description", null)
  delete_default_routes_on_create = true
  auto_create_subnetworks         = false
}

resource "google_compute_subnetwork" "this" {
  for_each      = var.subnets
  name          = each.key
  ip_cidr_range = each.value.ip_cidr_range
  network       = google_compute_network.this["${each.value.network}"].self_link
  region        = lookup(each.value, "region", "")
  project       = lookup(each.value, "project", "")
}


# Added option for peering with existing VPC
resource "google_compute_network_peering" "net_a-net_b" {
  for_each     = var.peers
  name         = "${each.value.net_a}-${each.value.net_b}"
  network      = google_compute_network.this["${each.value.net_a}"].self_link
  peer_network = lookup(each.value, "net_b_exists", null) ? var.existing_vpc : google_compute_network.this["${each.value.net_b}"].self_link
}

resource "google_compute_network_peering" "net_b-net_a" {
  for_each     = var.peers
  name         = "${each.value.net_b}-${each.value.net_a}"
  network      = lookup(each.value, "net_b_exists", null) ? var.existing_vpc : google_compute_network.this["${each.value.net_b}"].self_link
  peer_network = google_compute_network.this["${each.value.net_a}"].self_link
}

