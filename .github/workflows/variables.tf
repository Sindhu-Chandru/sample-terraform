# variables.tf

# AWS Region
variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"
}

# Parent ID for the Organizational Units (OU)
variable "parent_id" {
  description = "The parent ID for the organizational units (OU)."
  type        = string
}

# S3 Bucket Name for Terraform State
variable "terraform_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state."
  type        = string
}

# DynamoDB Table Name for Terraform State Locking
variable "terraform_lock_table" {
  description = "The name of the DynamoDB table for state locking."
  type        = string
}

# Tags for Resources
variable "environment_tags" {
  description = "A map of tags to apply to resources."
  type        = map(string)
  default     = {
    "Environment" = "Production"
    "Owner"       = "Terraform"
  }
}
