variable "kms_master_key_arn" {}
variable "name" {}

module "s3_bucket_2" {
  source = "cloudposse/s3-bucket/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"
  name = var.name

  enabled = true

  s3_object_ownership = "BucketOwnerEnforced"
  versioning_enabled  = true

  logging = [{
    bucket_name = "app"
    prefix      = "logs/"
  }]

  kms_master_key_arn = var.kms_master_key_arn
}

module "s3_bucket_3" {
  source = "cloudposse/s3-bucket/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"
  name = var.name

  enabled = true

  s3_object_ownership = "BucketOwnerEnforced"
  versioning_enabled  = true

  logging = [{
    bucket_name = "app"
    prefix      = "logs/"
  }]

  kms_master_key_arn = var.kms_master_key_arn
}
