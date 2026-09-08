resource "azurerm_private_dns_zone_virtual_network_link" "dnslink" {
  for_each = var.dnslink

  name                 = each.value.name
  private_dns_zone_id  = data.azurerm_private_dns_zone.dns_zone[each.key].id
  virtual_network_id   = data.azurerm_virtual_network.vnetd.id
}