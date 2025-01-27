provider "aws" {
  region = "us-east-1"
}

# Create the Organization
resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

# Output the Organization Name
output "organization_name" {
  description = "The name of the AWS Organization"
  value       = var.organization_name
}

# Create Organizational Units (OUs)
resource "aws_organizations_organizational_unit" "dev" {
  name      = "Dev"
  parent_id = var.parent_id
}

resource "aws_organizations_organizational_unit" "prod" {
  name      = "Prod"
  parent_id = var.parent_id
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = var.parent_id
}

resource "aws_organizations_organizational_unit" "audit" {
  name      = "Audit"
  parent_id = var.parent_id
}

# Optionally, associate users with OUs (If needed, this may be done through AWS IAM resources or manually outside Terraform)
resource "aws_iam_user" "dev_user" {
  name = var.user_emails["dev"]
}

resource "aws_iam_user" "prod_user" {
  name = var.user_emails["prod"]
}

resource "aws_iam_user" "security_user" {
  name = var.user_emails["security"]
}

resource "aws_iam_user" "audit_user" {
  name = var.user_emails["audit"]
}

# Output the user emails for each OU
output "user_emails" {
  description = "The email IDs for each Organizational Unit"
  value = var.user_emails
}
