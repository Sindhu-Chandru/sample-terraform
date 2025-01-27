output "organization_id" {
  description = "The ID of the AWS Organization"
  value       = aws_organizations_organization.this.id
}

output "security_ou_id" {
  description = "The ID of the Security organizational unit"
  value       = aws_organizations_organizational_unit.security.id
}

output "audit_log_ou_id" {
  description = "The ID of the Audit Log organizational unit"
  value       = aws_organizations_organizational_unit.audit_log.id
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket used for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}
