variable "postgresql" {
  description = "Map of PostgreSQL Flexible Servers"

  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
    version               = string
    administrator_login   = string
    administrator_password = string

    sku_name              = string
    storage_mb            = number
    backup_retention_days = number
    zone = string

    delegated_subnet_id = string
    private_dns_zone_id = string
  }))
}

variable "postgresql_databases" {
  description = "Map of PostgreSQL databases"

  type = map(object({
    name       = string
    server_key = string
  }))
}

variable "extensions" {
  description = "Map of PostgreSQL extensions"

  type = map(object({
    name = string
    server_key = string
  }))
}