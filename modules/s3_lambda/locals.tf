locals {
  vpc_config            = var.vpc_config[*]
  environment_variables = var.environment_variables[*]
  function_name         = (var.override_function_name == true) ? var.function_name : trim(substr("${var.resource_prefix}-${var.function_name}", 0, 64), "-")
}
