terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "main" {
  
}
