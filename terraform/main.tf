module "s3" {
  source = "./modules/s3"
  environment = var.environment
}

module "iam" {
  source = "./modules/iam"
  bucket_arn = module.s3.bucket_arn
  databricks_account_id= var.databricks_account_id
  databricks_external_id = var.databricks_external_id
}