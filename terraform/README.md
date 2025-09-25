# Terraform: EC2 Deployment

This module provisions a single EC2 instance on AWS. Edit `variables.tf` to set your AMI and instance type.

## Usage

- Run `terraform init` to initialize.
- Run `terraform apply` to deploy.
- Outputs: instance ID and public IP.

## Files

- `main.tf`: Core resources
- `variables.tf`: Input variables
- `outputs.tf`: Outputs
