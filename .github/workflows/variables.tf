variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "parent_id" {
  description = "The parent AWS Organization ID"
  type        = string
}

variable "control_tower_name" {
  description = "The name for the Control Tower"
  type        = string
}

variable "terraform_bucket_name" {
  description = "The name of the S3 bucket for storing Terraform state and logs"
  type        = string
}
