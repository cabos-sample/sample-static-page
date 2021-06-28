output "bucket" {
  value = {
    regional_domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
  }
}

output "identify" {
  value = {
    cloudfront_access_identity_path = aws_cloudfront_origin_access_identity.identify.cloudfront_access_identity_path
  }
}