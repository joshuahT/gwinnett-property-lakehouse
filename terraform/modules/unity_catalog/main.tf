# References the credential already created and validated manually --
# not re-created here, just pointed at.
data "databricks_storage_credential" "unity_catalog" {
  name = var.storage_credential_name
}

resource "databricks_external_location" "gwinnett_lakehouse" {
  name            = "gwinnett-lakehouse"
  url             = "s3://${var.bucket_name}/"
  credential_name = data.databricks_storage_credential.unity_catalog.name
  comment         = "Root external location for the Gwinnett property project"
}

resource "databricks_catalog" "gwinnett" {
  name         = "gwinnett"
  comment      = "Gwinnett County property value pipeline"
  storage_root = databricks_external_location.gwinnett_lakehouse.url
}

variable "schemas" {
  description = "Medallion layer schemas to create under the gwinnett catalog"
  type        = map(string)
  default = {
    bronze = "Raw landed data, one quarterly snapshot at a time"
    silver = "Cleaned data plus quarter-over-quarter parcel value history"
    gold   = "Aggregated tables for reporting and dashboards"
  }
}

resource "databricks_schema" "medallion" {
  for_each     = var.schemas
  catalog_name = databricks_catalog.gwinnett.name
  name         = each.key
  comment      = each.value
}