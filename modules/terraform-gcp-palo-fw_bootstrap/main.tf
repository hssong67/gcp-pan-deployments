locals {
  folders = ["license", "content", "software", "config"]
}

resource "random_string" "bootstrap" {
  length  = 8
  upper   = false
  special = false
}
resource "google_storage_bucket" "this" {
  name          = join("", ["panfw-gcp-boot-", random_string.bootstrap.result])
  force_destroy = var.force_destroy
  labels        = var.bucket_labels
}
resource "google_storage_bucket_object" "folders" {
  for_each = toset(local.folders)
  name     = "${each.key}/"
  bucket   = google_storage_bucket.this.name
  content  = each.key
}
resource "google_storage_bucket_object" "license" {
  for_each = fileset("${path.root}/${var.bootstrap_folder}", "/license/*")
  name     = each.key
  source   = "${path.root}/${var.bootstrap_folder}/${each.key}"
  bucket   = google_storage_bucket.this.name
}
resource "google_storage_bucket_object" "content" {
  for_each = fileset("${path.root}/${var.bootstrap_folder}", "/content/*")
  name     = each.key
  source   = "${path.root}/${var.bootstrap_folder}/${each.key}"
  bucket   = google_storage_bucket.this.name
}
resource "google_storage_bucket_object" "software" {
  for_each = fileset("${path.root}/${var.bootstrap_folder}", "/software/*")
  name     = each.key
  source   = "${path.root}/${var.bootstrap_folder}/${each.key}"
  bucket   = google_storage_bucket.this.name
}
resource "google_storage_bucket_object" "config" {
  for_each = fileset("${path.root}/${var.bootstrap_folder}", "/config/*")
  name     = each.key
  source   = "${path.root}/${var.bootstrap_folder}/${each.key}"
  bucket   = google_storage_bucket.this.name
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.service_account}"
}
