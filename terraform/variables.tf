variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
   type = string 
   default = "dev"
  }

variable "databricks_host" {
  description = "Databricks workspace URL"
  type        = string
}

variable "databricks_token" {
  description = "Databricks personal access token"
  type        = string
  sensitive   = true
}

variable "databricks_account_id" {
  description = "Databricks account id for AWS"
  type = string
  sensitive = true 
}

variable "databricks_external_id" {
  description = "Databricks external ID"
  type = string
  sensitive = true 
}

