locals {
  role               = "cooperation-assumption"
  execution_role_arn = data.terraform_remote_state.execution.outputs.role.arn
}