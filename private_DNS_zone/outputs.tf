output "private_dns_zone_ids" {
  description = "Map of private DNS zone names to zone IDs"

  value = {
    for key, zone in azurerm_private_dns_zone.dns_zone :
    key => zone.id
  }
}