# Create the VPC

resource "aws_vpc" "prod-vpc" {

  cidr_block = "10.0.0.0/16"

  # gives an Internal Domain Name
  enable_dns_support = true

  # gives an Internal Host Name
  enable_dns_hostnames = true

  # this is deprecated and will be removed in the future
  // enable_classiclink = false

  instance_tenancy = "default"


  tags = {

    Name = "prod_vpc"
  }
}

resource "aws_subnet" "prod-subnet-public-1" {

  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "10.0.1.0/24"

  # makes this a public subnet
  # the only difference between a public and a private 
  # is this argument

  map_public_ip_on_launch = "true"

  availability_zone = "us-east-1a"
}
