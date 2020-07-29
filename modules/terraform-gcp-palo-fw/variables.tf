########################
#  REQUIRED VARIABLES  #
#######################
variable "firewalls" {
  description = "list  of firealls Name of the instance"
  #example = {
  # name = "test1" = { 
  #         tags=["test1"], 
  #         bucket="specific_bucket", 
  #         interfaces = [{
  #           name = "mgmt",
  #           subnetwork = "mgmt-0",
  #           private_ip = "1.1.1.1",
  #           public_ip = "2.2.2.2"}]
  #}
}

############################
#  CONFIGURABLE VARIABLES  # 
############################

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

variable "fw_machine_type" {
  default = "n1-standard-4"
}


variable "fw_bootstrap_bucket" {
  default = ""
}

variable "management_interface_swap" {
  description = "Setting to switch eth0 on a GCP instance with eth1 to support load balancers"
  default     = "disable"
}


variable "fw_ssh_key" {
  default = ""
}

variable "fw_scopes" {
  default = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]
}

variable "custom_image" {
  default = null
}
variable "fw_tags" {
  default = null
}
