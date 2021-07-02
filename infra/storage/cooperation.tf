data "aws_iam_policy_document" "cooperation_policy_document" {
  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "cooperation_policy" {
  name   = "${module.naming.name}-cooperation"
  policy = data.aws_iam_policy_document.cooperation_policy_document.json
}

resource "aws_iam_role_policy_attachment" "cooperation_policy_attachment" {
  role       = local.execution_role_name
  policy_arn = aws_iam_policy.cooperation_policy.arn
}