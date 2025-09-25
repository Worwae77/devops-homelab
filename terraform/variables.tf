# Input variables for EC2 deployment

variable "aws_region" {
  description = "AWS region to deploy EC2 instance"
  type        = string
  default     = "ap-southeast-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0df7a207adb9748c7"  # Amazon Linux 2023 AMI in ap-southeast-1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
