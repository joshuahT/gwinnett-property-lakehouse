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

module "unity_catalog" {
  source = "./modules/unity_catalog"
  bucket_name = module.s3.bucket_name
  storage_credential_name = var.storage_credential_name
}
