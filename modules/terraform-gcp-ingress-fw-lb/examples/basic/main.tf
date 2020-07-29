provider "google" {
  project = "gcp-gcs-pso"
  region = "us-central1"
}  

module "pan" {
  prefix = "module-test"
  source = "git::https://spring.paloaltonetworks.com/tdugan/terraform-gcp-panfw-managed-ig?ref=v0.1.0"
  fw_ssh_key = file("~/.ssh/test.pub") 
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

resource "google_compute_global_address" "ip_address" {
  name = "my-address"
}

module "ingress" {
 source = "../../"
 zone = "us-central1-a"
 instance_template = module.pan.instance_template
 size = 2
 default_app = "app1"
 lb_name =  "test"
 hosts = [google_compute_global_address.ip_address.address]
 ip = google_compute_global_address.ip_address.address 
 apps = { app1 = {
                  port = "90"
                  paths = ["/"]
                  },
          app2 = {
                  port = "99"
                  paths = ["/app2/"]
                  }
        }
}
