locals {
  tags_without_name = {
    for key, value in var.tags :
    key => value
    if key != "Name"
  }
}
