resource "azurerm_kubernetes_cluster" "aks" {

  for_each = var.aks_cluster

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  kubernetes_version  = each.value.kubernetes_version
  dns_prefix          = each.value.dns_prefix
  private_cluster_enabled = each.value.private_cluster_enabled

  dynamic "default_node_pool" {

    for_each = each.value.default_node_pool

    content {

      name                 = default_node_pool.value.name
      vm_size              = default_node_pool.value.vm_size

      auto_scaling_enabled = default_node_pool.value.auto_scaling_enabled
      min_count            = default_node_pool.value.min_count
      max_count            = default_node_pool.value.max_count

      vnet_subnet_id       = data.azurerm_subnet.subnets.id
    }
  }

  identity {
    type = "SystemAssigned"
  }

  node_provisioning_profile {
    mode = "Manual"
  }

  key_vault_secrets_provider {
   secret_rotation_enabled = true
  
  }

  dynamic "network_profile" {

    for_each = each.value.network_profile

    content {

      network_plugin    = network_profile.value.network_plugin
      network_plugin_mode = network_profile.value.network_plugin_mode
      network_policy    = network_profile.value.network_policy
      load_balancer_sku = network_profile.value.load_balancer_sku

      # Azure CNI
      # Nodes will use the AKS subnet
    }
  }

  # ==========================================
  # PRIVATE AKS
  # ==========================================



  tags = {
    environment = "Dev"
  }
}