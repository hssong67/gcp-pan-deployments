variable "instance_groups" {
  description = "List of instance groups"
  type = map(any)
}

variable "apps" {
  description = "Map of apps"
  type = map(any)
}

variable "lb_name" {
  description = "name of load balancer"
  type = string
}

variable "default_app" {
  description =  "list of hosts"
}

variable "url_maps" {
  description = "Map of url rules "
  type = map(any)
}

variable "ip_address_name" {
  description = "Name of the Ip address for reference"
  type = string
}
