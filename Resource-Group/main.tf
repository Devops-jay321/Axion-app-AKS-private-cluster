resource "azurerm_resource_group" "jaydeep_rg2" {
  for_each = var.rg_name
    name     = each.value.name
    location = each.value.location
    
}