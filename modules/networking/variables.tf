# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region location"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create"
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
}

# ==============================================================================
# OPTIONAL VARIABLES
# ==============================================================================

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}