variable "aks_cluster" {
  type = map(object({

    name                = string
    location            = string
    resource_group_name = string
    kubernetes_version  = string
    dns_prefix          = string
    private_cluster_enabled = bool


    default_node_pool = map(object({
      name                  = string
      auto_scaling_enabled  = bool
      min_count             = number
      max_count             = number
      vm_size               = string
    }))

    network_profile = map(object({
      network_plugin    = string
      network_policy    = string
      load_balancer_sku = string
    }))
  }))
}