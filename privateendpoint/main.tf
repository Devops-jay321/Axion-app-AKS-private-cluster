resource "azurerm_private_endpoint" "kv_pe" {
  for_each            = var.kv_pe
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = data.azurerm_subnet.subnetd.id

  dynamic "private_service_connection" {
    for_each = each.value.private_service_connection
    content {
      name                           = private_service_connection.value.name
      private_connection_resource_id = data.azurerm_key_vault.kvi.id
      subresource_names              = private_service_connection.value.subresource_names
      is_manual_connection           = private_service_connection.value.is_manual_connection
    }
  }

  dynamic "private_dns_zone_group" {
    for_each = each.value.private_dns_zone_group
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = [data.azurerm_private_dns_zone.kv.id]
    }
  }
}

