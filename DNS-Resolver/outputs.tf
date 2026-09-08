output "resolver_ids" {
  description = "Map of DNS Private Resolver IDs"

  value = {
    for key, resolver in azurerm_private_dns_resolver.resolver :
    key => resolver.id
  }
}

output "inbound_endpoint_ids" {
  description = "Map of DNS Resolver inbound endpoint IDs"

  value = {
    for key, endpoint in azurerm_private_dns_resolver_inbound_endpoint.inbound :
    key => endpoint.id
  }
}

output "inbound_endpoint_ips" {
  description = "Map of DNS Resolver inbound endpoint private IPs"

  value = {
    for key, endpoint in azurerm_private_dns_resolver_inbound_endpoint.inbound :
    key => one(endpoint.ip_configurations).private_ip_address
  }
}