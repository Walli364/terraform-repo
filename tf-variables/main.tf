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
#   region = var.region  # here we use the variable defined above
}

resource "aws_instance" "my-server" {
  ami = "ami-0f8faa29480e7e6de"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2-config.v_size
    volume_type = var.ec2-config.v_type
  }

  #Optional
  tags = merge(var.additional_tags, {
    Name = "MyServer"
  })
}