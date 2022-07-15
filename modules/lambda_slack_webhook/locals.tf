locals {
  is_production = (terraform.workspace == "production" || terraform.workspace == "pathtolive") ? true : false
}
