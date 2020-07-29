variable "bucket_labels" {
  description = "label la bucket"
  default     = {}
}
variable "force_destroy" {
  description = "Set to protect bootstrap bucket from accidental deletion"
  default     = true
  type        = bool
}

variable "bootstrap_folder" {
  description = "folder where the bootstraps are"
  default     = "boostrap"
  type        = string
}

variable "service_account" {
  description = "service account fw's will talk to the gcs with"
  type        = string
}


