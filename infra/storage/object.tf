resource "aws_s3_bucket_object" "object" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "index.html"
  source       = "template/index.html"
  content_type = "text/html"

  etag = filemd5("template/index.html")
}