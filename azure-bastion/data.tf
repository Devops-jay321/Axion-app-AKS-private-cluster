data "azurerm_subnet" "subnets" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "jaydeep-aks-vnet"
  resource_group_name  = "jaydeep_rg2"
}

data "azurerm_public_ip" "ips" {
  name                = "bastion-public-ip"
  resource_group_name = "jaydeep_rg2"
}