variable "vpc_config" {
    description = "To get cidr and name from user"
  type = object({
    cidr_block = string
    name = string 
  })

  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR format - ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
#   sub1 = {cidr = "" az = ""} sub2{} sub3{}  in this format
    description = "To get cidr and availability zone for each subnet"
    type = map(object({
        cidr_block = string
        availability_zone = string
        public = optional(bool, false)
    }))

    validation {
      #sub1 = {cidr = ""} sub2{}, [true, true, false]   in this format 
    condition = alltrue([for config in var.subnet_config : can (cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR format"
  }
}