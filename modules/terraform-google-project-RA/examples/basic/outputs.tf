output "host_project_id" {
  description = "Host Project Id"
  value = module.ra-projects.host_project_id
}

output "management_project_id" {
  description = "Management Project Id"
  value = module.ra-projects.management_project_id
}

output "service_project_id" {
  description = "Service Project Id(s)"
  value = module.ra-projects.service_project_id
}
