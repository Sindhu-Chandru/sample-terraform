# Use the org_name variable in outputs or tags
resource "aws_organizations_organizational_unit" "dev" {
  name      = "Dev"
  parent_id = var.parent_id
  tags = {
    Organization = var.org_name
  }
}

resource "aws_organizations_organizational_unit" "prod" {
  name      = "Prod"
  parent_id = var.parent_id
  tags = {
    Organization = var.org_name
  }
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = var.parent_id
  tags = {
    Organization = var.org_name
  }
}

resource "aws_organizations_organizational_unit" "audit" {
  name      = "Audit"
  parent_id = var.parent_id
  tags = {
    Organization = var.org_name
  }
}

# Create IAM users from email list
resource "aws_iam_user" "users" {
  for_each = toset(var.users_email)

  name = each.value  # Use email as username (or you could split it to just use the username portion)

  tags = {
    Email        = each.value
    Organization = var.org_name  # Tag with Organization name
  }
}

# CloudTrail Setup using existing S3 bucket
resource "aws_cloudtrail" "example" {
  name                          = "genworx-cloudtrail"
  s3_bucket_name                = var.cloudtrail_s3_bucket_name  # Reference existing bucket
  is_multi_region_trail         = true
  enable_log_file_validation    = true
}

# Referencing existing S3 bucket for Terraform State
# No need to define the S3 bucket again since it's already created
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.terraform_state_bucket_name  # Referencing the existing bucket name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Referencing existing DynamoDB Table for Terraform State Lock
# No need to define the DynamoDB table again since it's already created
resource "aws_dynamodb_table" "terraform_lock" {
  name           = var.dynamodb_table_name  # Referencing the existing table name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "iam_user_names" {
  value = [for u in aws_iam_user.users : u.name]
}

output "dev_ou_id" {
  value = aws_organizations_organizational_unit.dev.id
}

output "prod_ou_id" {
  value = aws_organizations_organizational_unit.prod.id
}

output "security_ou_id" {
  value = aws_organizations_organizational_unit.security.id
}

output "audit_ou_id" {
  value = aws_organizations_organizational_unit.audit.id
}

output "cloudtrail_id" {
  value = aws_cloudtrail.example.id
}
