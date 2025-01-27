variable "organization_name" {
  description = "The name of the AWS Organization"
  type        = string
}

variable "parent_id" {
  description = "Parent ID of the AWS Organization"
  type        = string
}

variable "user_emails" {
  description = "List of user email IDs to associate with different OUs"
  type        = map(string)  # key: OU name, value: email ID
  default     = {
    "dev"      = "dev_user@example.com"
    "prod"     = "prod_user@example.com"
    "security" = "security_user@example.com"
    "audit"    = "audit_user@example.com"
  }
}
