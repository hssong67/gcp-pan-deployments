provider "google" {
  project = "gcp-gcs-pso"
}

module "instance" {
  source = "../../"
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
