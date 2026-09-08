output "postgresql_ids" {
  value = {
    for key, postgres in azurerm_postgresql_flexible_server.postgres :
    key => postgres.id
  }
}

output "postgresql_fqdns" {
  value = {
    for key, postgres in azurerm_postgresql_flexible_server.postgres :
    key => postgres.fqdn
  }
}