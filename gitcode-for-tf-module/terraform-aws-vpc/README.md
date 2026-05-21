# AWS VPC Terraform Module

This module provides a reusable Terraform configuration for creating an AWS VPC with subnets, internet gateway, and route tables.

## Overview

The VPC module creates:
- **VPC**: A Virtual Private Cloud with a configurable CIDR block
- **Subnets**: Multiple subnets (public and private) across different availability zones
- **Internet Gateway**: Automatically created if at least one public subnet is defined
- **Route Tables**: Routes public subnets to the internet gateway
- **Route Table Associations**: Associates public subnets with the route table

## Requirements

- Terraform >= 1.0
- AWS Provider >= 6.40.0
- AWS Account with appropriate permissions

## Input Variables

### `vpc_config`

Configuration for the VPC.

**Type:** `object`

**Properties:**
- `cidr_block` (string, required): CIDR block for the VPC (e.g., "10.0.0.0/16")
- `name` (string, required): Name tag for the VPC

**Validation:** CIDR block must be in valid CIDR format

### `subnet_config`

Configuration for subnets.

**Type:** `map(object)`

**Properties:**
- `cidr_block` (string, required): CIDR block for the subnet (e.g., "10.0.1.0/24")
- `availability_zone` (string, required): AWS availability zone for the subnet (e.g., "ap-northeast-1a")
- `public` (bool, optional): Whether the subnet is public (default: false)

**Validation:** All CIDR blocks must be in valid CIDR format

## Outputs

### `vpc_id`

The ID of the created VPC.

**Type:** `string`

### `public_subnets`

A map of public subnets with their IDs and availability zones.

**Type:** `map(object)`

**Properties:**
- `subnet_id`: The ID of the public subnet
- `az`: The availability zone of the subnet

### `private_subnets`

A map of private subnets with their IDs and availability zones.

**Type:** `map(object)`

**Properties:**
- `subnet_id`: The ID of the private subnet
- `az`: The availability zone of the subnet

## Usage Example

```hcl
module "vpc" {
  source = "./module/vpc"

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
    public-2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-northeast-1c"
      public            = true
    }
    private-1 = {
      cidr_block        = "10.0.10.0/24"
      availability_zone = "ap-northeast-1a"
      public            = false
    }
    private-2 = {
      cidr_block        = "10.0.11.0/24"
      availability_zone = "ap-northeast-1c"
      public            = false
    }
  }
}
```

## Features

- **Dynamic Resource Creation**: Internet Gateway and Route Tables are created conditionally based on the presence of public subnets
- **Input Validation**: Built-in validation for CIDR blocks
- **Flexible Configuration**: Supports unlimited subnets across multiple availability zones
- **Public/Private Separation**: Automatically categorizes and routes subnets based on the public flag

## Notes

- If no public subnets are defined, the Internet Gateway and Route Tables will not be created
- Public subnets will be automatically associated with the Internet Gateway route table
- Private subnets remain isolated and cannot reach the internet directly
