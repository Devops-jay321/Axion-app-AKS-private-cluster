resource "azurerm_private_dns_resolver" "resolver" {
  for_each = var.dns_resolver

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  virtual_network_id  = each.value.virtual_network_id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound" {
  for_each = var.dns_resolver

  name                    = each.value.inbound_endpoint.name
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver[each.key].id
  location                = each.value.location

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = each.value.inbound_endpoint.subnet_id
  }
}