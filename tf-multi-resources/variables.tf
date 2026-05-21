#Creating an object variable to hold the EC2 instance configuration details. This allows us to easily manage and scale our EC2 instances by simply adding more configurations to the list.
variable "ec2-config" {
  type = list(object({
    ami = string
    instance_type = string
  }))
}

variable "ec2-map" {
    #key=value object({ami, inst})
  type = map(object({
    ami = string
    instance_type = string 
  }))
}