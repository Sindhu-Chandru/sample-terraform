# outputs.tf

# Output the ID of the AWS Control Tower (if applicable, depending on the module you're using)
output "control_tower_id" {
  description = "The AWS Control Tower ID"
  value       = module.aws_control_tower.control_tower_id  # Adjust as needed based on actual module output
}

# Output the ID of the "Security" Organizational Unit
output "security_ou_id" {
  description = "The ID of the Security Organizational Unit"
  value       = aws_organizations_organizational_unit.security.id  # Should reference your actual resource
}

# Output the ID of the "Audit" Organizational Unit
output "audit_ou_id" {
  description = "The ID of the Audit Organizational Unit"
  value       = aws_organizations_organizational_unit.audit.id  # Should reference your actual resource
}

# Output the name of the S3 bucket used for logs
output "log_bucket_name" {
  description = "The name of the S3 bucket for storing logs"
  value       = aws_s3_bucket.log_bucket.bucket  # This references the actual S3 resource created
}
