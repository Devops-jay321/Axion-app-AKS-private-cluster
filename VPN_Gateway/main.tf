resource "azurerm_virtual_network_gateway" "p2s_vpn" {
  name                = "jaydeep-p2s-vpn"
  location            = "Central India"
  resource_group_name = "jaydeep_rg2"

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  sku           = "VpnGw1AZ"

  ip_configuration {
    name                          = "vpn-gateway-ipconfig"
    public_ip_address_id          = data.azurerm_public_ip.ips.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.subnets.id
  }

  vpn_client_configuration {
    address_space = ["172.16.0.0/24"]

    vpn_client_protocols = [
      "OpenVPN"
    ]


    vpn_auth_types = [
      "AAD"
    ]
    aad_tenant   = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/"
    aad_audience = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
    aad_issuer   = "https://sts.windows.net/${data.azurerm_client_config.current.tenant_id}/"

  
  }
}