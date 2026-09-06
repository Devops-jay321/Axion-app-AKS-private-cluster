data "azurerm_network_interface" "net_front" {
  name                = "nic-jumpbox"
  resource_group_name = "jaydeep_rg2"
}
    