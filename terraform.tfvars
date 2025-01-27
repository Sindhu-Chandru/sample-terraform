aws_region            = "us-east-1"
parent_id             = "r-1p5x"
terraform_bucket_name = "example-terraform-state"
terraform_lock_table  = "example-terraform-locks"

environment_tags = {
  Environment = "Production"
  Owner       = "DevOps"
}
