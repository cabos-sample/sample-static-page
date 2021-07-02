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

data "aws_iam_policy_document" "assume_policy_document" {
  statement {
    actions = ["sts:AssumeRole", "sts:TagSession"]
    principals {
      type        = "AWS"
      identifiers = ["806488921245"]
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "role" {
  name               = module.naming.name
  assume_role_policy = data.aws_iam_policy_document.assume_policy_document.json
  tags               = module.naming.tags
}