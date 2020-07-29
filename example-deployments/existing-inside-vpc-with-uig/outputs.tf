output "vpc" {
  value = module.vpc.vpc
}

output "subnets" {
  value = module.vpc.subnets
}


output "bucket-0" {
  description = "Boostrap bucket"
  value       = module.bootstrap-bucket-0.bucket
}