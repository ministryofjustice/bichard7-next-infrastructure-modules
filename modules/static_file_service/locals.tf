locals {
  static_files_bucket_name = (length("${var.name}-static-files") > 63) ? trim(substr("${var.name}-static-files", 0, 63), "-") : "${var.name}-static-files"
}
