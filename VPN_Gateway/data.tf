data "azurerm_subnet" "subnets" {
  name                 = "GatewaySubnet"
  virtual_network_name = "jaydeep-aks-vnet"
  resource_group_name  = "jaydeep_rg2"
}

data "azurerm_public_ip" "ips" {
  name                = "vpn-gateway-public-ip"
  resource_group_name = "jaydeep_rg2"
}

data "azurerm_client_config" "current" {}