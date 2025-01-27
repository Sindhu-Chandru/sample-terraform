variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "parent_id" {
  description = "The ID of the parent organizational unit or root"
  type        = string
  sensitive   = true
}

variable "terraform_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "terraform_bucket_key" {
  description = "Key prefix for the Terraform state file"
  type        = string
}

variable "terraform_bucket_region" {
  description = "Region for the Terraform state S3 bucket"
  type        = string
}

variable "terraform_lock_table" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}

variable "environment_tags" {
  description = "Tags for all resources"
  type        = map(string)
  default     = {
    Environment = "Production"
    Owner       = "DevOps"
  }
}

