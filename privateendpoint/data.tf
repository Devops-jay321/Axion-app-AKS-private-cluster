data "azurerm_key_vault" "kvi" {
  name                = "jaydeep-key-vault1"
  resource_group_name = "jaydeep_rg2"
}


data "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "jaydeep_rg2"
}

data "azurerm_subnet" "subnetd" {
  name                 = "jaydeep-aks-subnet"
  virtual_network_name = "Jaydeep-aks-vnet"
  resource_group_name  = "jaydeep_rg2"
}
