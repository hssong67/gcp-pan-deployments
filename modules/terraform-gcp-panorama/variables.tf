variable "panoramas" {
  description = "map of panoramas Name of the instance"
  #default = []
  #example ={ 
  #  "test1"= { 
  #           tags=["test1"], 
  #           interfaces = {
  #                         mgmt = {
  #                         subnetwork = "mgmt-0",
  #                         private_ip = "1.1.1.1",
  #                         public_ip = "2.2.2.2"}
  #                        }
  #  }
}

variable "fw_machine_type" {
  default = "n1-standard-4"
}

variable "fw_ssh_key" {
  default = ""
}

variable "fw_scopes" {
  default = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]
}

variable "image" {
}
variable "fw_tags" {
  default = []
}

variable "pan_image" {
  default = null
}
