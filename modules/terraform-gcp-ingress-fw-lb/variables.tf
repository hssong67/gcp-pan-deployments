variable "zone" {}

variable "size" {}

variable "default_app" {}

variable "lb_name" {}

variable "hosts" {}

variable "ip" {}

variable "instance_template" {}

variable "instance_group_name" {
  default = "firewall-group"
}

variable "base_name" {
  default = "firewall"
}

variable "apps" {
  # appname = {
  #            port = 81
  #            paths = ['/']
  #           } 
}


