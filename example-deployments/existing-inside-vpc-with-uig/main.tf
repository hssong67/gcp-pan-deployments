provider google {
  project = "my-project" 
  }

data "google_compute_network" "existing_trust" {
  name = "my-trust-network"
}


module "vpc" {
  source = "../../modules/terraform-gcp-vpc"
  vpcs = {
          "my-mgmt-network" = {},
          "my-untrust-network" = {}
         }
  subnets = { 
            "my-mgmt-network-0" = {"ip_cidr_range" = "10.10.0.0/24", "network" = "my-mgmt-network", "region" = "us-west3"},
            "my-untrust-network-0" = {"ip_cidr_range" = "10.30.0.0/24", "network" = "my-untrust-network", "region" = "us-west3"},
            }
  peers = {Peer1 =  {net_a="my-mgmt-network", net_b = "my-trust-network", net_b_exists = "true"}}

  existing_vpc = data.google_compute_network.existing_trust.self_link
}

data "google_compute_image" "panorama" {
  project = "my-project"
  name    = "panorama-9-1-2"
}

module "panorama" {
  source = "../../modules/terraform-gcp-panorama"
  panoramas ={
              "my-panorama"= {
                        tags=["my-panorama-tag"],
                        zone = "us-west3-a"
                        interfaces = {
                           mgmt = {
                            subnetwork = "my-trust-network-0"
                            public_ip = ""
                            }
                         }
                      }
              }
  fw_ssh_key = var.fw_ssh_key
  image = data.google_compute_image.panorama.self_link            
}

# ----------------------------------------------------------
# update init config in bootstrap bucket
# ----------------------------------------------------------
data "template_file" "initconfig" {
  for_each = var.bootstrap_environments
  template = file("bootstrap_templates/init-cfg.txt.tpl")

  vars = {
    vm_auth_key           = var.vm_auth_key
    pan_device_group_name = each.value.pan_device_group_name
    pan_template_name = each.value.pan_template_name
    panorama1_ip           = var.panorama1_ip
    panorama2_ip           = var.panorama2_ip
  }
}

// we have to use sensitive_content in local_file to prevent stuff from appearing in the plan
resource "local_file" "initconfig-render-file" {
  for_each = var.bootstrap_environments
  sensitive_content = data.template_file.initconfig[each.key].rendered
  filename          = "${path.root}/bootstrap_files/${each.key}/config/init-cfg.txt"
}

# ----------------------------------------------------------
# update bootstrap.xml config in bootstrap bucket
# ----------------------------------------------------------
data "template_file" "bootstrapxml" {
  template = file("bootstrap_templates/bootstrap.xml.tpl")

  vars = {
    bootstrap_phash           = var.bootstrap_phash
  }
}

// we have to use sensitive_content in local_file to prevent stuff from appearing in the plan
resource "local_file" "bootstrap-render-file" {
  for_each = var.bootstrap_environments
  sensitive_content = data.template_file.bootstrapxml.rendered
  filename          = "${path.root}/bootstrap_files/${each.key}/config/bootstrap.xml"
}


// we have to use sensitive_content in local_file to prevent stuff from appearing in the plan
resource "local_file" "authcodes-render-file" {
  for_each = var.bootstrap_environments
  sensitive_content = var.pan_authcode
  filename          = "${path.root}/bootstrap_files/${each.key}/license/authcodes"
}

// Make a separate call to bootstrap module for each environment defined in bootstrap_environments

module "bootstrap-bucket-0" {
  source = "../../modules/terraform-gcp-palo-fw_bootstrap"

  bucket_labels = {
    env = "my-label""
  }
  // TODO - fix this...keys was putting them in lex order
  bootstrap_folder = "bootstrap_files/${keys(var.bootstrap_environments)[0]}"
  #bootstrap_folder = "bootstrap_files/utah-test-egress-us-west3"
  service_account = "my-service-account@developer.gserviceaccount.com"

}


# module "managed_instance_group-0" {
#   source = "../../modules/terraform-google-panfw-mig"
#   fw_ssh_key = var.fw_ssh_key
#   region = "us-east4"
#   size = "2"
#   fw_version = "913"
#   fw_bootstrap_bucket = module.bootstrap-bucket-0.bucket["name"]
#   prefix = "pan-test-east4"
#   base_name = "pan-test-east4"
#   fw_tags = ["sy-pan-egress"]

#   interfaces = [{
#     index = "0"
#     subnetwork = "my-untrust-network-0"
#     public_ip = "" 
#     },
#     {
#     index = "1"
#     subnetwork = "my-mgmt-network-0"
#     public_ip = "" 
#     },
#     {
#     index = "2"
#     subnetwork = "my-trust-network-0"
#     }]
# }

module "panfw" {
  source = "../../modules/terraform-google-panfw-uig"
  fw_tags = ["pan-egress"]
  fw_version = "913"
  fw_ssh_key = var.fw_ssh_key
  fw_machine_type = "n1-standard-4"
  management_interface_swap = "enable"
  firewalls = {
    fw1 = {
    instance_group = "pan-egress-uig-west3-a"
    zone = "us-west3-a" 
    bucket = module.bootstrap-bucket-0.bucket["name"]
    interfaces = [{
      index = "0"
      subnetwork = "my-untrust-network-0" 
      public_ip = "" 
      },
      {
      index = "1"
      subnetwork = "my-mgmt-network-0"
      public_ip = "" 
      },
      {
      index = "2"
      subnetwork = "my-trust-network-0" 
      }]
    },
    fw2 = {
    instance_group = "pan-egress-uig-west3-b"
    zone = "us-west3-b",
    bucket = module.bootstrap-bucket-0.bucket["name"]
    interfaces = [{
      index = "0"
      subnetwork = "my-untrust-network-0"
      public_ip = ""
      },
      {
      index = "1"
      subnetwork = "my-mgmt-network-0"
      public_ip = ""
      },
      {
      index = "2"
      subnetwork = "my-trust-network-0"
      }]
    }
  }
}

module "internal_ilbs" {
  source = "../../modules/terraform-google-ilb"
  ilbs = { pan-egress-us-west3 = { 
                      region = "us-west3", 
                      health_probe_port = "22",
                      network = "my-trust-network",
                      project = "my-project"
                      subnetwork = "my-trust-network-0",
                      ip_address = "192.168.100.10"
                    }   
  }
  instance_groups = {"pan-egress-uig-west3-a" = "us-west3-a",
                      "pan-egress-uig-west3-b" = "us-west3-b"}

} 


module "routes" {
  source = "../../modules/terraform-gcp-route"
  routes = {
    default-untrust = {
     dest_range = "0.0.0.0/0",
     network = "my-untrust-network",
     next_hop_gateway = "",
     priority = "900"
     tags = ["pan-egress"]
     description = "PAN FW untrust network direct internet"
     }
    default-mgmt = {
     dest_range = "0.0.0.0/0",
     network = "my-mgmt-network",
     next_hop_gateway = "",
     priority = "900"
     tags = ["pan-egress"]
     description = "PAN FW mgmt network direct internet"
     }
  }
} 