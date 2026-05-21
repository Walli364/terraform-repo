variable "region" {
  description = "Value of region"
  type = string
  default     = "ap-northeast-1"
}

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
  # region = "ap-northeast-1"
  region = var.region  # here we use the variable defined above
}

resource "aws_instance" "myserver" {
  ami = "ami-0f8faa29480e7e6de"
  instance_type = "t3.micro"

  #Optional
  tags = {
    Name = "SampleServer"
  }
}