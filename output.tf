output "organization_name" {
  description = "The name of the AWS Organization"
  value       = var.organization_name
}

output "user_email" {
  description = "The email IDs for each Organizational Unit"
  value       = var.users_email
}
