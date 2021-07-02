data "terraform_remote_state" "execution" {
  backend = "s3"

  config = {
    bucket = var.state_bucket
    key    = "env:/${terraform.workspace}/state/cooperation/execution.tfstate"
    region = var.default_region
  }
}
