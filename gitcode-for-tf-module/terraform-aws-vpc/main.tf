resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.name
  }

}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id

  for_each = var.subnet_config #key = {cidr, az} each.key each.value 

  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.key
  }
}

locals {
  public_subnet = {
    #key={} if public is true in subnet_config
    for key, config in var.subnet_config : key => config if config.public
  }
  private_subnet = {
    #key={} if public is false in subnet_config
    for key, config in var.subnet_config : key => config if !config.public
  } 
}

#If there is at lease one public subnet, create an Internet Gateway and route table for it
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet) > 0 ? 1 : 0  #Turnery operator used here
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet) > 0 ? 1 : 0

  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.main[0].id
}
}

resource "aws_route_table_association" "main" {
  for_each = local.public_subnet  #public_subnet = {} private_subnet = {} in this format

  subnet_id = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id
}