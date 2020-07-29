provider google {
  project = "gcp-gcs-pso" 
  }


module "vpc" {
  source = "../../"
  vpcs = {
          "vpc-test-mgmt" = {},
          "vpc-test-untrust" = {},
          "vpc-test-trust" = {}
         }
  subnets = { 
            "mgmt-0" = {"ip_cidr_range" = "10.16.0.0/24", "network" = "vpc-test-mgmt", "region" = "us-east4"},
            "mgmt-1" = {"ip_cidr_range" = "10.15.0.0/24", "network" = "vpc-test-mgmt", "region" = "us-west1"},
            "trust-0" = {"ip_cidr_range" = "10.17.0.0/24", "network" = "vpc-test-trust", "region" = "us-west1"},
            "untrust-0" = {"ip_cidr_range" = "10.18.0.0/24", "network" = "vpc-test-untrust", "region" = "us-central1"}
            }
peers = { peer1 = {net_a ="vpc-test-mgmt", net_b = "vpc-test-untrust"}}
}
