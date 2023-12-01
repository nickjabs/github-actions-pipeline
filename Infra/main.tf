
# MAIN
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

# Create a VPC
resource "aws_vpc" "Dev-Nick-VPC-ABC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev-Nick-VPC-ABC"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.Dev-Nick-VPC-ABC.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Ensure instances launched here get public IPs

  tags = {
    Name = "Public Subnet"
  }
}


# Create an internet gateway
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.Dev-Nick-VPC-ABC.id
}

# Create a route table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.Dev-Nick-VPC-ABC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

module "my_security_group" {
  source = "./module/security-group"

  name        = "DEV-Security-1"
  description = "DEV-Security-1"
  vpc_id      = aws_vpc.Dev-Nick-VPC-ABC.id
}


resource "aws_instance" "EC2-for-DOCKER" {
  ami                    = "ami-06dd92ecc74fdfb36"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [module.my_security_group.security_group_id]

  tags = {
    Name = "EC2-for-DOCKER"
  }
}

# Output the public IP of the EC2 instance
output "public_ip" {
  value = aws_instance.EC2-for-DOCKER.public_ip
}
