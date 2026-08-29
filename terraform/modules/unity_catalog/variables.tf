variable "bucket_name" {
    description = "S3 bucket name, from the s3 module's output"
    type = string
}

variable "storage_credential_name" {
    description = "Name of storage credential within Databricks"
    type = string
}