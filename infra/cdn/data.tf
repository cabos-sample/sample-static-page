
data "terraform_remote_state" "storage" {
  backend = "s3"

  config = {
    bucket = var.state_bucket
    key    = "env:/${terraform.workspace}/state/storage.tfstate"
    region = var.default_region
  }
}
