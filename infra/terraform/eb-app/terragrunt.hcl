locals {
  # Automatically load shared level variables
  shared_vars = read_terragrunt_config("${get_env("PWD")}/../settings/shared.hcl")

  # Extract the variables we need for easy access
  backend_bucket_name = local.shared_vars.locals.backend_bucket_name
  application = local.shared_vars.locals.application
  aws_region = local.shared_vars.locals.aws_region
}


remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "${local.backend_bucket_name}"

    key = "${local.application}/${basename(get_env("PWD"))}/terraform.tfstate"
    region         = "${local.aws_region}"
    encrypt        = true
    dynamodb_table = "${local.application}-lock"
  }
}

inputs = merge(
  local.shared_vars.locals,
)