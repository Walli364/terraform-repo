terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
  backend "s3" {
      bucket = "my-demo-bucket-ead4134612e00f05"
      key    = "terraform.tfstate"
      region = "ap-northeast-1"
  }
}

provider "aws" {
  # Configuration options
  region = "ap-northeast-1"
}

resource "aws_instance" "myserver" {
  ami = "ami-0f8faa29480e7e6de"
  instance_type = "t3.micro"

  #Optional
  tags = {
    Name = "SampleServer"
  }
}