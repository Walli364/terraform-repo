terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-northeast-1"
}

resource "random_id" "rand_id" {
  byte_length = 10
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "tf-cloud-bucket-${random_id.rand_id.hex}"
}


output "random" {
  value = random_id.rand_id.hex
}