# ==============================================================================
# VNET OUTPUTS
# ==============================================================================

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "vnet_address_space" {
  description = "Address space of the Virtual Network"
  value       = azurerm_virtual_network.this.address_space
}

# ==============================================================================
# SUBNET OUTPUTS
# ==============================================================================

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value = {
    for name, subnet in azurerm_subnet.this : name => subnet.id
  }
}

output "subnet_names" {
  description = "List of all subnet names"
  value       = local.subnet_names
}

output "subnet_address_prefixes" {
  description = "Map of subnet names to their address prefixes"
  value = {
    for name, subnet in azurerm_subnet.this : name => subnet.address_prefixes
  }
}

# ==============================================================================
# HELPER OUTPUTS
# ==============================================================================

output "subnet_id_list" {
  description = "List of all subnet IDs"
  value       = values(azurerm_subnet.this)[*].id
}