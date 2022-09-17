
# Create AWS Internet Gateway

resource "aws_internet_gateway" "prod-igw" {

  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    "Name" = "prod-igw"
  }
}

# Create Custom Route table for Public Subnet

resource "aws_route_table" "prod-public-crt" {

  vpc_id = aws_vpc.prod-vpc.id

  route {

    // Associated Subnet can reach everywhere
    cidr_block = "0.0.0.0/0"

    // Route table uses this IGW to reach the Internet
    gateway_id = aws_internet_gateway.prod-igw.id
  }

  tags = {
    "Name" = "prod-public-crt"
  }
}

# Associate the Public Route Table and the Subnet

resource "aws_route_table_association" "prod-crta-public-subnet-1" {

  subnet_id      = aws_subnet.prod-subnet-public-1.id
  route_table_id = aws_route_table.prod-public-crt.id
}


# Create a Security Group

# We'll use this Security Group for our EC2 Instance

resource "aws_security_group" "ssh-allowed" {

  vpc_id = aws_vpc.prod-vpc.id

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    // this means All IP Addresses are allowed to SSH into the server
    // Do Not Do this Production
    // Put your Office or Home Address in it

    cidr_blocks = ["0.0.0.0/0"]
  }


  // If you Do Not Add this Rule, you can not reach the NGINX Server

  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-allowed"
  }
}
