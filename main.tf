# Provider Configuration
provider "aws" {
  region  = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Create S3 Bucket for Terraform State
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.terraform_bucket_name

  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Environment = "Production"
    Purpose     = "Terraform State Storage"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Create DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.terraform_lock_table
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"

  tags = {
    Environment = "Production"
    Purpose     = "Terraform State Locking"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Create the AWS Organization
resource "aws_organizations_organization" "this" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com",
    "controltower.amazonaws.com",
  ]

  feature_set = "ALL"

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
}

# Create the Security Organizational Unit
resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = aws_organizations_organization.this.roots[0].id

  tags = {
    Environment = "Production"
    Purpose     = "Security"
  }
}

# Create the Audit Log Organizational Unit
resource "aws_organizations_organizational_unit" "audit_log" {
  name      = "Audit Log"
  parent_id = aws_organizations_organization.this.roots[0].id

  tags = {
    Environment = "Production"
    Purpose     = "Audit"
  }
}
