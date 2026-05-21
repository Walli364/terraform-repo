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


#Create a VPC
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc"
    }

}

#Creating security group
resource "aws_security_group" "main" {
  
}
resource "aws_instance" "myserver" {
  ami = "ami-0f8faa29480e7e6de"
  instance_type = "t3.micro"

  #Optional
  tags = {
    Name = "SampleServer"
  }

  depends_on = [ aws_vpc.my-vpc ]   #create VPC before creating EC2 instance
  lifecycle {
    # create_before_destroy = true  
    # prevent_destroy = true
    # replace_triggered_by = [ aws_vpc.my-vpc ]  

    precondition {
      condition = aws_vpc.my-vpc.id != ""
      error_message = "VPC ID must not be empty"
    }

    postcondition {
      condition = aws_vpc.my-vpc.region != ""
      error_message = "VPC region must not be empty"
    }
  }
}