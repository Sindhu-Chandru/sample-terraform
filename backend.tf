terraform {
  backend "s3" {
    bucket         = "genworx-bucket"  # Your existing S3 bucket for Terraform state
    key            = "terraform/state/landing-zone.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"  # Your existing DynamoDB table for locking
    encrypt        = true
  }
}
