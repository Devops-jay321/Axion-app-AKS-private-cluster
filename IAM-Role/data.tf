data "azurerm_virtual_machine" "jumpbox" {
  name                = "jumpbox-vm"
  resource_group_name = "jaydeep_rg2"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "jaydeep-aks-cluster-private"
  resource_group_name = "jaydeep_rg2"
}
data "azurerm_key_vault" "kvi" {
  name                = "jaydeep-key-vault1"
  resource_group_name = "jaydeep_rg2"
}
data "azurerm_user_assigned_identity" "kv_csi" {
  name                = "azurekeyvaultsecretsprovider-jaydeep-aks-cluster-private"
  resource_group_name = "MC_jaydeep_rg2_jaydeep-aks-cluster-private_centralindia"
}