output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"

  value = {
    for key, subnet in azurerm_subnet.aks_subnet :
    key => subnet.id
  }
}