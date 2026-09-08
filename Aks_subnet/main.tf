resource "azurerm_subnet" "aks_subnet" {

  for_each = var.subnet_config

  name                  = each.value.name
  resource_group_name   = each.value.resource_group_name
  virtual_network_name  = each.value.virtual_network_name
  address_prefixes      = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }
}