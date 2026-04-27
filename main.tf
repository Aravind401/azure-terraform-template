# Configure the Azure provider
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


# ==============================================================================
# RESOURCE GROUP
# ==============================================================================

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}


# ==============================================================================
# NETWORKING MODULE
# ==============================================================================

module "networking" {
  source = "./modules/networking"
  
  # Resource Group Information
  resource_group_name = azurerm_resource_group.this.name
  location           = azurerm_resource_group.this.location
  
  # Virtual Network Configuration
  vnet_name          = var.vnet_config.name
  vnet_address_space = var.vnet_config.address_space
  
  # Subnet Configuration
  subnets = var.subnet_configs
  
  # Tags
  tags = var.tags
}