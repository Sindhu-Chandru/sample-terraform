output "organization_id" {
  description = "AWS Organization ID"
  value       = aws_organizations_organization.this.id
}

output "security_ou_id" {
  description = "ID of the Security Organizational Unit"
  value       = aws_organizations_organizational_unit.security.id
}

output "audit_log_ou_id" {
  description = "ID of the Audit Log Organizational Unit"
  value       = aws_organizations_organizational_unit.audit_log.id
}

output "s3_bucket_name" {
  description = "S3 bucket name for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}
