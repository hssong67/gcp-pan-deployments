variable "pan_authcode" {
  type = string
}

variable "vm_auth_key" {
  type = string
}

variable "panorama1_ip" {
  type        = string
  description = "IP of primary Panorama"
  default = ""
}

variable "panorama2_ip" {
  type        = string
  description = "IP of secondary ha Panorama"
  default = ""
}

variable "bootstrap_environments" {
  type        = map
  description = "list of each separate bootstrap package to generate"
}

variable "bootstrap_phash" {
  type        = string
  description = "Hashed password to set in bootstrap.xml for initial admin credentials"
}

variable "fw_ssh_key" {
    type = string
    description = "Pub SSH Key to use to launch VMs"
}