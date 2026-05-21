ec2-config = [ {
  ami = "ami-0478d64d580a0c8e5" #ubuntu 
  instance_type = "t3.micro"
}, {
    ami = "ami-02b4c35921bac197b" #Amazon Linux
    instance_type = "t3.micro"
} ]

ec2-map = {
  "ubuntu" = {
     ami = "ami-0478d64d580a0c8e5" #ubuntu 
     instance_type = "t3.micro"
  },
  "amazon-linux" = {
     ami = "ami-02b4c35921bac197b" #Amazon Linux
     instance_type = "t3.micro"
  }
}