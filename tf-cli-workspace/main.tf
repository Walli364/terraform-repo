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
  byte_length = 8
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "my-demo-bucket-${terraform.workspace}-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "bucket-data" {
  source = "myfile.txt"
  key    = "myfile.txt"
  bucket = aws_s3_bucket.demo-bucket.bucket

}

output "random" {
  value = random_id.rand_id.hex
}