resource "azurerm_key_vault" "kv_jay1" {
    for_each = var.key_vaults
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  tenant_id                   = each.value.tenant_id
  sku_name                    = each.value.sku_name
  rbac_authorization_enabled   = true  # <-- RBAC enabled
  public_network_access_enabled = false  # <-- Public network access disabled
  soft_delete_retention_days  = 7
  purge_protection_enabled       = true
  tags = each.value.tags

}