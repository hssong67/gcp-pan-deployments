provider "google" {
  project     = var.project 
}

module "panfw" {
  source = "../../"
  fw_bootstrap_bucket = var.bucket 
  fw_ssh_key = file(var.key_path) 
  fw_tags = ["vm-series", "egress-fw", "mgmt"]
  firewalls = {
    fw1 = {
    zone = var.zone_1,
    bucket = var.buck_instance 
    interfaces = [{
      index = "0"
      subnetwork = var.untrust_subnetwork 
      public_ip = "" 
      },
      {
      index = "1"
      subnetwork =var.trust_subnetwork 
      public_ip = "" 
      },
      {
      index = "2"
      subnetwork = var.mgmt_subnetwork
      }]
    },
    fw2-central1 = {
    zone = var.zone_2,
    interfaces = [{
      index = "0"
      subnetwork = "untrust-2"
      public_ip = ""
      },
      {
      index = "1"
      subnetwork = "mgmt-2"
      public_ip = ""
      },
      {
      index = "2"
      subnetwork = "trust-2"
      }]
    }
  }
}
