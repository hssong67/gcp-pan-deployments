variable "org_id" {
  description = "Organization ID"
  type = string
}

variable "billing_account" { 
  description = "Billing account"
  type = string
  default = null
}

variable "service_projects" {
  description = "Service Projects"
  type = list(string)
  default = null
}
