
module "ec2-instance" {
source  = "terraform-aws-modules/ec2-instance/aws"
version = "6.4.0"

name = "single-instance"

  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnets[0]
  ami = "ami-0e668174d57c64015"

  tags = {
    Name = "single-instance"
    Environment = "dev"
  }

}