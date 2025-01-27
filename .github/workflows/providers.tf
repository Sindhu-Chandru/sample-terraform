terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = var.terraform_bucket_name
    key            = var.terraform_bucket_key
    region         = var.terraform_bucket_region
    dynamodb_table = var.terraform_lock_table
    encrypt        = true
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
