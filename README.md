# azure-terraform-template# Azure Networking Terraform Module

## Overview
This Terraform project creates Azure Virtual Network and Subnets using a modular approach.

## Prerequisites
- Terraform >= 1.0
- Azure subscription with Contributor access
- Azure CLI installed (optional)

## Quick Start

### 1. Clone and Configure
```bash
# Copy the example configuration
#cp terraform.tfvars.example terraform.tfvars

# Edit with your values
#vim terraform.tfvars

# Initialize Terraform
# export the below cmd to powershell
$env:ARM_SUBSCRIPTION_ID="######################"
$env:ARM_TENANT_ID="############################"
$env:ARM_CLIENT_ID="############################"
$env:ARM_CLIENT_SECRET="########################"
terraform init

# Review changes
terraform plan

# Apply configuration
terraform apply -auto-approve