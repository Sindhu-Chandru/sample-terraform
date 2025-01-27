variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "parent_id" {
  description = "The parent ID for the organizational units"
  type        = string
}

variable "terraform_bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  type        = string
}

variable "terraform_lock_table" {
  description = "The name of the DynamoDB table for Terraform state locking"
  type        = string
}

variable "environment_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Environment = "Production"
    Owner       = "DevOps"
  }
}
