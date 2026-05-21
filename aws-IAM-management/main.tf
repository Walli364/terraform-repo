terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-northeast-1"
}

locals {
  users_data = yamldecode(file("./users.yaml")).users

  user_role_pair = flatten([for user in local.users_data : [for role in user.roles : {
    username = user.username
    role = role
  }]])
}

output "outputs" {
  value = local.user_role_pair
}

output "output" {
  value = local.users_data[*].username 
}

#Creating users 
resource "aws_iam_user" "users" {
  for_each = toset(local.users_data[*].username)
  name = each.value 
}

#Password Creation
resource "aws_iam_user_login_profile" "profile" {
  for_each = aws_iam_user.users
  user = each.value.name 
  password_length = 10

  lifecycle {
    ignore_changes = [ 
      password_length,
      password_reset_required,
      pgp_key,
     ]
  }
}

#Attaching policies to users
resource "aws_iam_user_policy_attachment" "main" {
  for_each = { for pair in local.user_role_pair : "${pair.username}-${pair.role}" => pair } # Creating a unique key for each user-role pair  
  #chaudary-EC2FullAccess = {username = "chaudary", role = "AmazonEC2FullAccess"}
  #chaudary-S3ReadOnlyAccess = {username = "chaudary", role = "AmazonS3ReadOnlyAccess"}

   user = aws_iam_user.users[each.value.username].name
   policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}
