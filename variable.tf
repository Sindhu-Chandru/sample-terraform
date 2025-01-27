variable "org_name" {
  description = "The name of the organization."
  type        = string
}

variable "organization_name" {
  description = "The name of the organization."
  type        = string
}

variable "parent_id" {
  description = "The parent ID for the organizational units."
  type        = string
}

variable "users_email" {
  description = "A map of email addresses for creating IAM users."
  type        = map(string)
}
