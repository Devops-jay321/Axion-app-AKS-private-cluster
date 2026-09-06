data "azurerm_virtual_network" "vnetd" {
    name                = "Jaydeep-aks-vnet"
    resource_group_name = "jaydeep_rg2"
}
data "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "jaydeep_rg2"
}