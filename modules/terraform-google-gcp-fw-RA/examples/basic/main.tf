provider "google" {
  project = var.project
}

module "fw-gcp-RA" {
  source = "../../"
  mgmt_network = var.mgmt_network
  private_network = var.private_network
  public_network = var.public_network
}
