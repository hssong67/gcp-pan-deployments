output "host_project_id" {
  description = "Host Project Id"
  value = google_project.host.project_id
}

output "management_project_id" {
  description = "Management Project Id"
  value = google_project.management.project_id
}

output "service_project_id" {
  description = "Service Project Id(s)"
  value = {for service in google_project.service : service.name => service.project_id}
}
