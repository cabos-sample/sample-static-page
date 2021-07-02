locals {
  role                = "sample-static-page-storage"
  force_destroy       = false
  versioning          = true
  execution_role_name = data.terraform_remote_state.execution.outputs.role.name
}