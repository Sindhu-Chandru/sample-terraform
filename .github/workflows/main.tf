# Provider Configuration
provider "aws" {
  region = var.aws_region
}

# AWS Organizations
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

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = var.parent_id

  tags = {
    Environment = "Production"
    Purpose     = "Security"
  }
}

resource "aws_organizations_organizational_unit" "audit_log" {
  name      = "Audit Log"
  parent_id = var.parent_id

  tags = {
    Environment = "Production"
    Purpose     = "Audit"
  }
}

# S3 Bucket for Terraform State
resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.terraform_bucket_name
  acl           = "private"
  force_destroy = true

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

  tags = var.environment_tags
}

# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.terraform_lock_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.environment_tags
}

# IAM Role for Terraform State Access
resource "aws_iam_role" "terraform_state_role" {
  name = "terraform-state-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.environment_tags
}

# IAM Policy for Terraform S3 and DynamoDB Access
resource "aws_iam_policy" "terraform_policy" {
  name        = "terraform-policy"
  description = "Policy for Terraform to access S3 and DynamoDB for state management"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = [
          "${aws_s3_bucket.terraform_state.arn}/*",
          aws_s3_bucket.terraform_state.arn
        ]
      },
      {
        Action   = ["dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:Scan"]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.terraform_locks.arn
      }
    ]
  })

  tags = var.environment_tags
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "terraform_role_attachment" {
  role       = aws_iam_role.terraform_state_role.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}

# Outputs
output "organization_id" {
  value = aws_organizations_organization.this.id
}

output "security_ou_id" {
  value = aws_organizations_organizational_unit.security.id
}

output "audit_log_ou_id" {
  value = aws_organizations_organizational_unit.audit_log.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.terraform_locks.arn
}

output "terraform_role_arn" {
  value = aws_iam_role.terraform_state_role.arn
}

output "terraform_policy_arn" {
  value = aws_iam_policy.terraform_policy.arn
}
