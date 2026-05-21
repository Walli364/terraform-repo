resource "aws_security_group" "nginx-sg" {
  vpc_id = aws_vpc.my-vpc.id

  #Inbound rule to allow HTTP traffic
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outbound rule 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"  #used to allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}