provider "google" {
}

data "google_billing_account" "default" {
  display_name = var.billing_account
}

data "google_organization" "default" {
  domain = var.org_id
}

module "ra-projects" {
  source = "../../"
  org_id = data.google_organization.default.org_id 
  billing_account = data.google_billing_account.default.id 
}

