variable "aws_region" {
  description = "AWS region where resources will be created"
}

variable "terraform_bucket_name" {
  description = "S3 bucket name for Terraform state storage"
}

variable "terraform_lock_table" {
  description = "DynamoDB table name for state locking"
}
