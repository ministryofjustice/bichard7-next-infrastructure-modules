output "administrator_access_role" {
  description = "The administrator access role outputs"
  value       = aws_iam_role.assume_administrator_access
}

output "readonly_access_role" {
  description = "The readonly access role outputs"
  value       = aws_iam_role.assume_readonly_access
}

output "ci_access_role" {
  description = "The ci access role outputs"
  value       = aws_iam_role.assume_ci_access
}
