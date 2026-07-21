output "role_arn" {
  value       = aws_iam_role.unity_catalog.arn
  description = "Paste this back into the Databricks storage credential screen"
}