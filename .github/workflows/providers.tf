# provider.tf

provider "aws" {
  region  = var.aws_region   # The region to deploy AWS resources, taken from the variable
  profile = "default"        # Optional: specify if using a specific AWS profile
}

# Terraform backend to store state remotely in S3 with DynamoDB for locking
terraform {
  backend "s3" {
    bucket = var.terraform_bucket_name  # S3 bucket to store the Terraform state
    key    = "terraform/state/terraform.tfstate"  # Path within the bucket
    region = var.aws_region  # AWS region for the backend
    encrypt = true  # Encrypt the state file
    dynamodb_table = var.terraform_lock_table  # DynamoDB table for state locking
  }
}
