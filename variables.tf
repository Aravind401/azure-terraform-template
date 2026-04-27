# ==============================================================================
# RESOURCE GROUP VARIABLES
# ==============================================================================

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-_.]{1,88}[a-zA-Z0-9]$", var.resource_group_name))
    error_message = "Resource group name must be 3-90 characters long and can only contain alphanumeric characters, underscores, periods, and hyphens."
  }
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  
  validation {
    condition     = contains(["East US", "West US", "West Europe", "Southeast Asia", "East Asia"], var.location)
    error_message = "Location must be a standard Azure region like 'East US', 'West US', 'West Europe', etc."
  }
}

# ==============================================================================
# VNET VARIABLES
# ==============================================================================

variable "vnet_config" {
  description = "Virtual Network configuration"
  type = object({
    name          = string
    address_space = list(string)
  })
  
  validation {
    condition     = length(var.vnet_config.address_space) > 0
    error_message = "VNet address space cannot be empty."
  }
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-_.]{1,62}[a-zA-Z0-9]$", var.vnet_config.name))
    error_message = "VNet name must be 3-64 characters and can only contain alphanumeric characters, underscores, periods, and hyphens."
  }
}

# ==============================================================================
# SUBNET VARIABLES
# ==============================================================================

variable "subnet_configs" {
  description = "Map of subnet configurations"
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
    delegation = optional(map(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string), [])
      })
    })), {})
  }))
  
  validation {
    condition = alltrue([
      for k, v in var.subnet_configs : length(v.address_prefixes) > 0
    ])
    error_message = "Each subnet must have at least one address prefix."
  }
}

# ==============================================================================
# TAGS VARIABLES
# ==============================================================================

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}