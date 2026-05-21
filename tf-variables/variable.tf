variable "aws_instance_type" {
  description = "Which type of instance you want to create"
  type = string 
  validation {
    condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
    error_message = "aws_instance_type must be t2.micro or t3.micro"
  }
}

# variable "root_volume_size" {
#   type = number
#   default = 20
# }

# variable "root_volume_type" {
#   type = string
#   default = "gp2"
# }

variable "ec2-config" {
  type = object({
    v_size = number
    v_type = string
  })
  default = {
    v_size = 20
    v_type = "gp2"
  }
}

variable "additional_tags" {
  type = map(string)  #expecting a map of string key-value pairs
  default = {}

}