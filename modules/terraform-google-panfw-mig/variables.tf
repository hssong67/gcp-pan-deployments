variable "fw_license" {
  description = "license module - accepted values are commented out"
  default     = "byol"
  #default = "bundle1"
  #deafult = "bundle2"
}

variable "fw_version" {
  description = "Code version in three digits to align with GCP URI path"
  #default = "901"
  default = "904"
  #default = "810"
  #default = "814"
  #default = "819"
}

variable "prefix" {
  default = "firewall"
}

variable "description" {
  default = "Managed Instance Group of Firewalls"
}

variable "fw_description" {
  default = "firewalls"
}

variable "fw_machine_type" {
  default = "n1-standard-4"
}

variable "labels" {
  default = {}
}
variable "fw_tags" {
  default = []
}

variable "interfaces" {
  default = [{
    index      = "0"
    subnetwork = "public"
    public_ip  = ""
    },
    {
      index      = "1"
      subnetwork = "mgmt"
      public_ip  = ""
    },
    {
      index      = "2"
      subnetwork = "private"
    }
  ]
}

variable "fw_bootstrap_bucket" {
  default = ""
}

variable "management_interface_swap" {
  description = "Setting to switch eth0 on a GCP instance with eth1 to support load balancers"
  default     = "enable"
}


variable "fw_ssh_key" {
  default = ""
}

variable "fw_scopes" {
  default = [
    "https://www.googleapis.com/auth/compute.readonly",
    "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
  ]
}

variable "region" {}

variable "size" {}

variable "instance_group_name" {
  default = "firewall-group"
}
variable "base_name" {
  default = "firewall"
}

variable "apps" {
  type = map
  default = {
    http = {
      port = 80
    }
  } 
}