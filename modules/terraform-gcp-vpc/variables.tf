variable "vpcs" {
  description = "map of VPCS to Project"
  # example = {"network_name" { "project" = "project", "descrption" = # "descrption"}}
}

variable "subnets" {
  description = "map of subnets to create"
  # example = { "client-2" = {"ip_cidr_range" = "10.8.2.0/24", "network" = "client", "region" = "us-central1", "project" = "bbb-service-demo"}
}

variable "peers" {
  description = "list of Map of peers"
  # example = {Peer1 =  {net_a="trust", net_b = "untrust"}}
}


variable "existing_vpc" {
  type = string
  description = "(optional) Pass to module if peering with existing VPC"
  default = ""
}