terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "YakovBiton-dev-vpc" {
  cidr_block = "10.0.0.0/21"
  tags = {
    "Name" = "YakovBiton-dev-vpc"
  }
}
resource "aws_subnet" "YakovBiton-k8s-subnet" {
  cidr_block = "10.0.0.0/22"
  vpc_id     = aws_vpc.YakovBiton-dev-vpc.id
  tags = {
    "Name" = "YakovBiton-k8s-subnet"
  }
  availability_zone = "us-east-1a"

}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.YakovBiton-dev-vpc.id
  tags = {
    Name = "instance-gateway"
  }
}
resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.YakovBiton-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}
