# ==============================================================================
# VIRTUAL NETWORK
# ==============================================================================

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# ==============================================================================
# SUBNETS
# ==============================================================================

resource "azurerm_subnet" "this" {
  for_each = var.subnets
  
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = lookup(each.value, "service_endpoints", null)
  
  # Dynamic block for delegation configuration
  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", {})
    
    content {
      name = delegation.value.name
      
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = lookup(delegation.value.service_delegation, "actions", null)
      }
    }
  }
}

# ==============================================================================
# LOCAL VALUES FOR CONVENIENCE
# ==============================================================================

locals {
  subnet_names = keys(azurerm_subnet.this)
}