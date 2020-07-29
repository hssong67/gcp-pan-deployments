variable "private_network" {
  description = "Name of the private network."
  type = list(string)
}

variable "private_tags" {
  description = "Tags to apply to private network rules"
  type = list(string)
  default = ["fw-private"]
}

variable "public_network" {
  description = "Name of the public network."
  type = list(string)
}

variable "public_tags" {
  description = "Tags to apply to public network rules"
  type = list(string)
  default = ["fw-public"]
}

variable "mgmt_network" {
  description = "Name of the Palo Alto management network."
  type = list(string)
}

variable "mgmt_tags" {
  description = "Tags to apply to managment network rules"
  type = list(string)
  default = ["mgmt"]
}


variable "pub_mgmt_logging" {
  description = "Enable if you want public mgmt firewall rule to log to StackDriver."
  type = bool
  default = false
}

variable "pub_mgmt_src_ips" {
  description = "List of public source IPs allowed to connect to management interface on ports 22/443 . Each entry is required to be valid CIDR"
  type = list(string)
  default = null
}

variable "priv_mgmt_logging" {
  description = "Enable if you want private mgmt firewall rule to log to StackDriver."
  type = bool
  default = false
}

variable "priv_mgmt_src_ips" {
  description = "List of private IPs allowed to connec to management interface. Each entry is required to be valid CIDR"
  type = list(string)
  default = ["10.0.0.0/8"]
}

variable "pub_logging" {
  description = "Enable if you want public mgmt firewall rule to log to StackDriver."
  type = bool
  default = false
}

variable "pub_src_ips" {
  description = "List of public source IPs allowed to connect to management interface on ports 22/443 . Each entry is required to be valid CIDR"
  type = list(string)
  default = null
}

variable "priv_logging" {
  description = "Enable if you want private mgmt firewall rule to log to StackDriver."
  type = bool
  default = false
}

variable "priv_src_ips" {
  description = "List of private IPs allowed to connec to management interface. Each entry is required to be valid CIDR"
  type = list(string)
  default = ["10.0.0.0/8"]
}
