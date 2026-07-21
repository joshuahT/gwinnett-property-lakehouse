data "aws_caller_identity" "current" {}

resource "aws_iam_role" "unity_catalog" {
  name = var.role-name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DatabricksCrossAccount"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.databricks_account_id}:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = { "sts:ExternalId" = var.databricks_external_id }
        }
      },
      {
        # Unity Catalog's credential vending assumes this role from itself.
        Sid    = "SelfAssume"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role-name}"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "unity_catalog_s3_access" {
  name = "${var.role-name}-s3-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "S3BucketAccess"
      Effect = "Allow"
      Action = [
        "s3:GetObject", "s3:PutObject", "s3:DeleteObject",
        "s3:ListBucket", "s3:GetBucketLocation",
        "s3:AbortMultipartUpload", "s3:ListMultipartUploadParts",
      ]
      Resource = [var.bucket_arn, "${var.bucket_arn}/*"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "unity_catalog_attach" {
  role       = aws_iam_role.unity_catalog.name
  policy_arn = aws_iam_policy.unity_catalog_s3_access.arn
}