data "azurerm_key_vault" "kvi" {
  name                = "jaydeep-key-vault1"
  resource_group_name = "jaydeep_rg2"
}
data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "kv_admin" {
  for_each             = var.kv_admin_roles
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = each.value.role_definition_name
  scope                = data.azurerm_key_vault.kvi.id
}

