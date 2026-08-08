output "bucket_name" {
  value = module.s3.bucket_name
}
output "iam_role_arn" {
  value = module.iam.role_arn
}