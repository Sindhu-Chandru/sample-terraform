# backend.tf (static values, no variables)

terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"  # Replace with your bucket name
    region         = "us-east-1"  # Replace with your region
    key            = "terraform/state.tfstate"
    dynamodb_table = "your-dynamodb-lock-table"  # Replace with your DynamoDB table name
    encrypt        = true
  }
}
