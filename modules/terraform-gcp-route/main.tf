resource "google_compute_route" "this" {
  for_each            = var.routes
  name                = each.key
  dest_range          = each.value.dest_range
  network             = each.value.network
  tags                = lookup(each.value, "tags", [])
  description         = lookup(each.value, "description", null)
  next_hop_ip         = lookup(each.value, "next_hop_ip", null)
  priority            = lookup(each.value, "priority", null)
  next_hop_gateway    = lookup(each.value, "next_hop_gateway", null) != null ? "default-internet-gateway" : null
  next_hop_instance   = lookup(each.value, "next_hop_instance", null)
  next_hop_vpn_tunnel = lookup(each.value, "next_hop_vpn_tunnel", null)
  # next_hop_ilb = lookup(each.value, "next_hop_ilb", null) //needs beta provider..`
  next_hop_instance_zone = lookup(each.value, "next_hop_instance_zone", null)
  project                = lookup(each.value, "project", null)
}
