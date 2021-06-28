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

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}