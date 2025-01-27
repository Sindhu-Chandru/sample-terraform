provider "aws" {
  region = "us-east-1"  # You can keep region as a variable or hard-code it here.
}

# You do not need the backend block here
# Terraform will use the S3 and DynamoDB resources for state after they are created
