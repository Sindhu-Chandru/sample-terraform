provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.terraform_state.bucket
    key            = "terraform/state/organizations.tfstate"
    region         = var.aws_region
    dynamodb_table = aws_dynamodb_table.terraform_locks.name
    encrypt        = true
  }
}
