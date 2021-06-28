terraform {
  backend "s3" {
  }
}

provider "aws" {
  region = var.default_region
}

module "naming" {
  source = "../_module/naming"
  role   = local.role
}


resource "aws_s3_bucket" "bucket" {
  bucket = module.naming.name

  force_destroy = local.force_destroy
  versioning {
    enabled = local.versioning
  }

  tags = module.naming.tags
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.bucket
  policy = data.aws_iam_policy_document.document.json
}

data "aws_iam_policy_document" "document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*"]
    effect    = "Allow"
    principals {
      identifiers = [aws_cloudfront_origin_access_identity.identify.iam_arn]
      type        = "AWS"
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "identify" {
  comment = "CDN Identify"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}