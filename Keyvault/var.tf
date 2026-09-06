variable "key_vaults" {
  description = "Map of Key Vault configurations"
  type        = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku_name            = string
    tenant_id           = string
    tags                = map(string)
  }))
}