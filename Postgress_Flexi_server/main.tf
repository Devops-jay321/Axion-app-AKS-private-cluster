resource "azurerm_postgresql_flexible_server" "postgres" {

  for_each = var.postgresql

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  version = each.value.version

  administrator_login    = each.value.administrator_login
  administrator_password = each.value.administrator_password

  sku_name   = each.value.sku_name
  storage_mb = each.value.storage_mb

  public_network_access_enabled = false

  backup_retention_days = each.value.backup_retention_days
  zone = each.value.zone

  delegated_subnet_id = each.value.delegated_subnet_id
  private_dns_zone_id = each.value.private_dns_zone_id
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  for_each = var.postgresql_databases

  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.postgres[each.value.server_key].id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

resource "azurerm_postgresql_flexible_server_configuration" "extensions" {
    for_each = var.extensions
  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.postgres[each.value.server_key].id
  value     = "pgcrypto"
}