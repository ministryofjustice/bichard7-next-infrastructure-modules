locals {
  is_production = (terraform.workspace == "production") ? true : false
}
