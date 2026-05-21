aws_instance_type = "t3.micro"
ec2-config = {
  v_size = 30
  v_type = "gp3"
} 

additional_tags = {
  Environment = "Production"
  Owner = "Waleed"
}