variable "org_id" {
  description = "Organization ID"
  type = string
}

variable "billing_account" {
  description = "Billing Account"
  type = string
}

variable "service_projects" {
  description = "Service Projects"
  type = list(string)
  default = ["web-project"]
}
