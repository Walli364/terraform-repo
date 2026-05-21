terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
}

data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}
output "aws_ami" {
  value = data.aws_ami.name.id
}

#security Group data source
data "aws_security_group" "name" {
  tags = {
    Name = "my-sg"
  }
}
output "security_group" {
  value = data.aws_security_group.name.id
}

#VPC data source
data "aws_vpc" "name" {
  tags = {
    Name = "my-vpc"
  }
}
output "vpc_id" {
  value = data.aws_vpc.name.id
}

#Availability Zone data source
data "aws_availability_zones" "name" {
  state = "available"
}
output "availability_zones" {
  value = data.aws_availability_zones.name
}

#To get the account details
data "aws_caller_identity" "name" {
     
}
output "caller_identity" {
  value = data.aws_caller_identity.name
}

#To get the region details
data "aws_region" "name" {
  
}
output "region" {
  value = data.aws_region.name
}

#AWS Subnet data source
data "aws_subnet" "name" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.name.id ]
  }
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_instance" "ubuntu-server" {
  ami = "ami-0f18986364089c4ab"
  instance_type = "t3.micro"
  subnet_id = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]

  #Optional
  tags = {
    Name = "ubuntu-server"
  }
}