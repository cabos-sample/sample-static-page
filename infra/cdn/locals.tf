locals {
  role = "sample-static-page-cdn"
  name = module.naming.name
  bucket = {
    regional_domain_name = data.terraform_remote_state.storage.outputs.bucket.regional_domain_name
  }
  identify = {
    cloudfront_access_identity_path = data.terraform_remote_state.storage.outputs.identify.cloudfront_access_identity_path
  }
}