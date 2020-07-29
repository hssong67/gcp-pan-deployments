provider "google" {
  project     = "bbb-host-1" 
  credentials = "/Users/tdugan/code/palo/projects/BBB-Demo/bbb-host-1-66f4413d5d19.json"
}

module "panfw" {
  source = "../../"
  fw_tags = ["vm-series", "egress-fw", "mgmt"]
  firewalls = {
    fw1 = {
    instance_group = "foxtrot"
    zone = "us-east4-a" 
    interfaces = [{
      index = "0"
      subnetwork = "untrust-0t" 
      public_ip = "" 
      },
      {
      index = "1"
      subnetwork = "mgmt-0"
      public_ip = "" 
      },
      {
      index = "2"
      subnetwork = "trust-0p" 
      }]
    },
    fw2 = {
    zone = "us-east4-a",
    instance_group = "foxtrot"
    interfaces = [{
      index = "0"
      subnetwork = "untrust-0t"
      public_ip = ""
      },
      {
      index = "1"
      subnetwork = "mgmt-0"
      public_ip = ""
      },
      {
      index = "2"
      subnetwork = "trust-0t"
      }]
    }
  }
}
