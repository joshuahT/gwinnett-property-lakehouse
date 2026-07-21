variable "databricks_account_id" {
    description = "Databricks aws account"
    type = string
}

variable "databricks_external_id" {
    description = "External ID"
    type = string
}

variable "role-name" {
    description = " IAM Role for Unity Catalog"
    type = string
    default = "unity-catalog-gwinnett-role"
}

variable "bucket-arn" {
    description = "ARN lakehouse S3 bucket" 
    type = string 
}