resource "random_pet" "project_pet" {
  length = 1
}
  
resource "random_id" "project_id" {
  byte_length = 2
}

locals {
  project_prefix = join("-", [random_pet.project_pet.id, random_id.project_id.hex])
}

resource "google_project" "host" {
  name       = "host"
  project_id = "${local.project_prefix}-host"
  org_id     = var.org_id 
  billing_account = var.billing_account
  auto_create_network = false
}

resource "google_project" "management" {
  name       = "management"
  project_id = "${local.project_prefix}-mgmt"
  org_id     = var.org_id
  billing_account = var.billing_account
  auto_create_network = false
}

resource "google_project" "service" {
  for_each = toset(var.service_projects)
  name       = each.key 
  project_id = "${local.project_prefix}-${each.value}"  
  org_id     = var.org_id 
  billing_account = var.billing_account
  auto_create_network = false
}

resource "google_project_service" "host" {
  project = google_project.host.project_id 
  service = "compute.googleapis.com"
  disable_dependent_services = true
}
  

resource "google_project_service" "management" {
  project = google_project.management.project_id 
  service = "compute.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "service" {
  for_each = toset(var.service_projects)
  project = google_project.service[each.key].project_id 
  service = "compute.googleapis.com"
  disable_dependent_services = true
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = google_project.host.project_id 
  depends_on = [google_project_service.host]
}

resource "google_compute_shared_vpc_service_project" "service" {
  for_each = toset(var.service_projects)
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = google_project.service[each.key].project_id
  depends_on = [google_project_service.service]
}
