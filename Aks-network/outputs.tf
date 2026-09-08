output "vnet_ids" {
  description = "Map of Virtual Network IDs"

  value = {
    for key, vnet in azurerm_virtual_network.aks_vnet :
    key => vnet.id
  }
}