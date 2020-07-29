provider "google" {
  project = var.project
}


module "load_balancer" {
  source = "../../"
  apps = var.apps
  lb_name = var.lb_name
  url_maps = var.url_maps
  instance_groups = var.instance_groups
  default_app = var.default_app
  ip_address_name = var.ip_address_name
} 
