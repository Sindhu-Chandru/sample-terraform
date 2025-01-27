output "organization_name" {
  description = "The name of the AWS Organization"
  value       = var.organization_name
}

output "dev_ou_id" {
  description = "The ID of the Dev Organizational Unit"
  value       = aws_organizations_organizational_unit.dev.id
}

output "prod_ou_id" {
  description = "The ID of the Prod Organizational Unit"
  value       = aws_organizations_organizational_unit.prod.id
}

output "security_ou_id" {
  description = "The ID of the Security Organizational Unit"
  value       = aws_organizations_organizational_unit.security.id
}

output "audit_ou_id" {
  description = "The ID of the Audit Organizational Unit"
  value       = aws_organizations_organizational_unit.audit.id
}

output "user_emails" {
  description = "The email IDs for each Organizational Unit"
  value       = var.user_emails
}
