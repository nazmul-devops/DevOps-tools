terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "region" {
  description = "region"
}

variable "cidr_blocks" {
  description = "cidr blocks for vpc and subnets"
  type = list(string)
}
variable "availability_zones" {
  description = "availability zones for subnets"
  type = list(string)
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "test_vpc" {
  cidr_block = var.cidr_blocks[0]
  tags = {
    Name = "Test vpc with terraform"
  }
}


resource "aws_subnet" "test_subnet_1" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = var.cidr_blocks[1]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "Test subnet 1 with terraform"
  }
}

resource "aws_subnet" "test_subnet_2" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = var.cidr_blocks[2]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "Test subnet 2 with terraform"
  }
}
resource "aws_subnet" "test_subnet_3" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = var.cidr_blocks[3]
  availability_zone = var.availability_zones[2]

  tags = {
    Name = "Test subnet 3 with terraform"
  }
}
