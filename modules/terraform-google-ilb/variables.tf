variable "instance_groups" {
  description = "List of instance groups"
  type = map(any)
}

variable "ilbs" {
  description = "Map of ilbs to create"
  type = map(any)
}
