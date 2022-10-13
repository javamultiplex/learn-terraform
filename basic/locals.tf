resource "random_integer" "rand" {
  min = 10000
  max = 99999
}


locals {
  tags = {
    "project" : var.PROJECT_NAME
    "company" : "javamultiplex"
    "environment" : terraform.workspace
  }

  s3_bucket_name = lower("${local.name_prefix}-${random_integer.rand.result}")
  name_prefix    = "${var.NAME_PREFIX}-${terraform.workspace}"
}