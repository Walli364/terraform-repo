# variable "region" {
#   description = "Value of region"
#   type = string
#   default     = "ap-northeast-1"
# }

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "6.40.0"
#     }
#   }
# }

# locals {
#   project = "project-01"
# }

# provider "aws" {
#   region = var.region
# }

# resource "aws_vpc" "main-vpc" {
#   cidr_block = "10.0.0.0/16"
#     tags = {
#         Name = "${local.project}-vpc"
#     }
# }


# resource "aws_subnet" "main-subnet" {
#   vpc_id = aws_vpc.main-vpc.id
#   cidr_block = "10.0.${count.index}.0/24"
#   count = 2
#     tags = {
#         Name = "${local.project}-subnet-${count.index}"
#     }
# }

# #Create 4 EC2 instances 2 in each subnet
# resource "aws_instance" "main" {
#   ami = "ami-02b4c35921bac197b" #Amazon Linux 
#   instance_type = "t3.micro"
#   count = 4
#   subnet_id = element(aws_subnet.main-subnet[*].id, count.index % length(aws_subnet.main-subnet)) # This will distribute instances across the two subnets
#   # 0%2 = 0 
#   # 1%2 = 1
#   # 2%2 = 0
#   # 3%2 = 1
#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }

# }


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

locals {
  project = "project-01"
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${local.project}-vpc"
    }
}


resource "aws_subnet" "main-subnet" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
    tags = {
        Name = "${local.project}-subnet-${count.index}"
    }
}

#Create 2 EC2 instances 
resource "aws_instance" "main" {
  ami = each.value.ami 
  instance_type = each.value.instance_type 

  for_each = var.ec2-map  #We will get each.key and each.value 

  subnet_id = element(aws_subnet.main-subnet[*].id, index(keys(var.ec2-map), each.key) % length(aws_subnet.main-subnet)) # This will distribute instances across the two subnets
  # 0%2 = 0 
  # 1%2 = 1
  tags = {
    Name = "${local.project}-instance-${each.key}"
  }

}