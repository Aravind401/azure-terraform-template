# ==============================================================================
# RESOURCE GROUP OUTPUTS
# ==============================================================================

output "resource_group_info" {
  description = "Information about the created resource group"
  value = {
    id       = azurerm_resource_group.this.id
    name     = azurerm_resource_group.this.name
    location = azurerm_resource_group.this.location
  }
}

# ==============================================================================
# VNET OUTPUTS
# ==============================================================================

output "vnet_info" {
  description = "Information about the created Virtual Network"
  value = {
    id            = module.networking.vnet_id
    name          = module.networking.vnet_name
    address_space = module.networking.vnet_address_space
  }
}

# ==============================================================================
# SUBNET OUTPUTS
# ==============================================================================

output "subnet_info" {
  description = "Information about all created subnets"
  value = {
    ids              = module.networking.subnet_ids
    names            = module.networking.subnet_names
    address_prefixes = module.networking.subnet_address_prefixes
  }
}

# ==============================================================================
# CONVENIENCE OUTPUTS
# ==============================================================================

output "subnet_ids_map" {
  description = "Map of subnet names to their IDs for easy reference"
  value       = module.networking.subnet_ids
}

output "first_subnet_id" {
  description = "ID of the first subnet (useful for quick testing)"
  value       = values(module.networking.subnet_ids)[0]
}