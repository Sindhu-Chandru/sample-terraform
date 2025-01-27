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
