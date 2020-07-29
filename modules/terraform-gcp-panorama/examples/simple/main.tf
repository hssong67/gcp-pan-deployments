provider "google" {
  project = "gcp-gcs-pso"
}

data "google_compute_image" "this" {
  project = "gcp-gcs-pso"
  name    = "panorama-814"
}

module "pan" {
  source = "../../"
  panoramas ={
              "test1"= {
                        tags=["test1"],
                        zone = "us-east4-a"
                        interfaces = {
                           mgmt = {
                           subnetwork = "sy-wwce-spoke1-subnet"
                           public_ip = ""
                            }
                         }
                      }
              }
  image = data.google_compute_image.this.self_link            
}
