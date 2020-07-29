output "ids" {
  value = module.panfw.instance_id
}

output "self_links" {
  value = module.panfw.instance_self_link
}

output "ips" {
  value = module.panfw.external_ip_0
}  

