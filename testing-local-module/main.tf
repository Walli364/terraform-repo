provider "aws" {
  region = "ap-northeast-1"
}
module "vpc" {
source  = "Walli364/vpc/aws"
version = "1.0.0"

# insert the 2 required variables here        
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "main-vpc"
  }

  subnet_config = {
    public-1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-northeast-1a"
      public            = true
    }

}
}

