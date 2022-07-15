locals {
  is_production = (terraform.workspace == "production" || terraform.workspace == "pathtolive-ci-monitoring") ? true : false
}
