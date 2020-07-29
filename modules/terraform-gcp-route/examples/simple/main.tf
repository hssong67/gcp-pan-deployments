provider "google" {
  project = "gcp-gcs-pso"
}

module "routes" {
  source = "../../"
  routes = {
    default = {
     dest_range = "0.0.0.0/0",
     network = "bbb-untrust",
     next_hop_gateway = "",
     description = "untrust outbound"
     }
  }
 } 
