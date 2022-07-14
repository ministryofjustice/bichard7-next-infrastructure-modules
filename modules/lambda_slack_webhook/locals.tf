locals {
  is_production = (terraform.workspace == "production" || terraform.workspace == "pathtolive-ci") ? true : false
}
