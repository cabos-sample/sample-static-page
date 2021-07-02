terraform {
  backend "s3" {
  }
}

provider "aws" {
  region = var.default_region
}

module "naming" {
  source = "../../_module/naming"
  role   = local.role
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole", "sts:TagSession"]
    resources = [local.execution_role_arn]
  }
}

resource "aws_iam_policy" "policy" {
  name   = module.naming.name
  policy = data.aws_iam_policy_document.policy_document.json
}