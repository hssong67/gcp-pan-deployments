provider "google" {
  project     = "gcp-gcs-pso"
}

module "example" {
  source = "../../"

  bucket_labels = {
    test = "best"
  }

  service_account = "647166153151-compute@developer.gserviceaccount.com"

}

module "exampl2" {
  source = "../../"
  bootstrap_folder = "bootstrap2"
  bucket_labels = {
    test = "test"
  }
  service_account = "647166153151-compute@developer.gserviceaccount.com"
}


