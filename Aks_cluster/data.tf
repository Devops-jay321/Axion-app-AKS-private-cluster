data "azurerm_subnet" "subnets" {
  name                 = "jaydeep-aks-subnet"
  virtual_network_name = "jaydeep-aks-vnet"
  resource_group_name  = "jaydeep_rg2"
}
