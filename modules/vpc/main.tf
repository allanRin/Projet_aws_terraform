terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0, < 7.0"
    }
  }
}

resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                 = aws_vpc.this.id
  cidr_block             = "10.0.1.0/24"
  availability_zone      = "eu-west-3a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-public-a"
  }
}

resource "aws_subnet" "private" {
  vpc_id                 = aws_vpc.this.id
  cidr_block             = "10.0.11.0/24"
  availability_zone      = "eu-west-3a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name_prefix}-prive-a"
  }
}
