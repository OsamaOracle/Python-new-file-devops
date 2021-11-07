terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

}

provider "aws" {
  profile = "default"
  region = var.region
}


resource "aws_s3_bucket" "bucket" {
  count = length(var.namespaces)
  bucket = join("-", [var.namespaces[count.index],var.firstName,var.lastName,"platform","challenge"])
  #force_destroy = true
  #acl   = "private"
  lifecycle_rule {
    id      = "Delete Rule"
    enabled = true

    tags = {
      source      = "script"
    }

    expiration {
      days = 1
    }
  }

}
