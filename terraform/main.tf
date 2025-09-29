# Terraform configuration for deploying an EC2 instance on AWS

provider "aws" {
  region = "ap-southeast-1"  # Singapore region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "devops-homelab-vpc"
  }
}

# Create public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "devops-homelab-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "devops-homelab-igw"
  }
}

# Create Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "devops-homelab-rt"
  }
}

# Associate subnet with route table
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.main.id
}

# Create Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-homelab-sg"
  }
}

# Generate key pair for SSH access
resource "aws_key_pair" "deployer" {
  key_name   = "devops-homelab-key-v2"
  public_key = file(var.ssh_public_key_path)
}

# Create EC2 instance
resource "aws_instance" "example" {
  ami                         = var.ami_id
  instance_type              = var.instance_type
  subnet_id                  = aws_subnet.public.id
  vpc_security_group_ids     = [aws_security_group.allow_ssh.id]
  key_name                   = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  tags = {
    Name = "devops-homelab-ec2"
  }
}
