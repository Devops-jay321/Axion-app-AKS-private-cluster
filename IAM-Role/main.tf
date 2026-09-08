# resource "azurerm_role_assignment" "jumpbox_aks_user" {

#   scope = data.azurerm_kubernetes_cluster.aks.id

#   role_definition_name = "Azure Kubernetes Service Cluster User Role"

#   principal_id = data.azurerm_virtual_machine.jumpbox.identity[0].principal_id
# }

resource "azurerm_role_assignment" "aks_kv_secret_user" {
  scope                = data.azurerm_key_vault.kvi.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = data.azurerm_user_assigned_identity.kv_csi.principal_id
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = data.azurerm_container_registry.acr.id

  role_definition_name = "AcrPull"

  principal_id         = data.azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}