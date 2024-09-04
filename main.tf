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

resource "aws_s3_bucket" "default" {
  bucket        = "test"
}

variable "sg_cidr" {
  description = "CIDR block for security group ingress rule"
  type        = string
  default     = "0.0.0.0/0"
}

resource "aws_security_group" "trivy" {
  name        = "trivy"
  description = "trivy"
  vpc_id      = "vpc-woohoo"

  tags = {
    Name = "trivy"
  }
}

resource "aws_vpc_security_group_ingress_rule" "trivy" {
  security_group_id = aws_security_group.trivy.id
  cidr_ipv4         = var.sg_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
