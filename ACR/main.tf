resource "azurerm_container_registry" "acr" {
    for_each = var.acr
  name                     = each.value.name      # globally unique hona chahiye
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  sku                      = each.value.sku             # options: Basic, Standard, Premium
  admin_enabled            = each.value.admin_enabled                 # admin user enable kare


  
}
