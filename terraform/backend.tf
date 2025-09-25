terraform {
  backend "s3" {
    bucket         = "devops-homelab-tfstate"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}