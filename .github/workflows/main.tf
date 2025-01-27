provider "aws" {
  region = var.aws_region
}

module "aws_control_tower" {
  source = "terraform-aws-modules/control-tower/aws"

  aws_region        = var.aws_region
  parent_id         = var.parent_id
  control_tower_name = var.control_tower_name
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = var.parent_id
}

resource "aws_organizations_organizational_unit" "audit" {
  name      = "Audit"
  parent_id = var.parent_id
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = var.terraform_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = var.terraform_bucket_name
    target_prefix = "log/"
  }
}

output "control_tower_id" {
  description = "The Control Tower ID"
  value       = module.aws_control_tower.control_tower_id
}

output "security_ou_id" {
  description = "The ID of the Security OU"
  value       = aws_organizations_organizational_unit.security.id
}

output "audit_ou_id" {
  description = "The ID of the Audit OU"
  value       = aws_organizations_organizational_unit.audit.id
}

output "log_bucket_name" {
  description = "The S3 Bucket for logging"
  value       = aws_s3_bucket.log_bucket.bucket
}
