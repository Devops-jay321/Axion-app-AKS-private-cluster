variable "subscription_id" {
  type = string
  default = "9e00a7ac-bf84-4246-8d3d-d785b7f6e78b"  # Replace with your actual subscription ID
}
variable "rg_name_x" {
    type = map(object({
        name = string
        location = string
    }))

}

variable "vnet_config_x" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
}

variable "subnet_config_x" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

variable "aks_cluster_x" {
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
variable "public_ip_x" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
    zones               = optional(list(string))
  }))
  
}
variable "bastion-host_x" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    virtual_network_name = string
    ip_configuration = map(object({
    name = string
    }))

  }))
  
}
variable "nic_config_x" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_name         = string
    # public_ip_name      = string
    ip_configuration    = list(object({
      name                          = string
      private_ip_address_allocation = string
    }))
  }))
}
variable "jumpbox_x" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    size                            = string
    admin_username                  = string
    admin_password                  = string
    network_interface_name          = string
    disable_password_authentication = bool
    os_disk = map(object({
      name                 = string
      caching              = string
      storage_account_type = string
      disk_size_gb         = number
    }))
    source_image_reference = map(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))

  }))

}
variable "key_vaults_x" {
  description = "Map of Key Vault configurations"
  type        = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku_name            = string
    tenant_id           = string
    tags                = map(string)
  }))
}

variable "kv_admin_roles_x" {
  description = "Map of Key Vault admin roles"
  type = map(object({
    role_definition_name = string
  }))
  
}


variable "dnszone_x" {
  description = "Map of private DNS zones"
  type        = map(object({
    name                = string
    resource_group_name = string
  }))
}

variable "dnslink_x" {
  description = "Map of DNS zone virtual network links"
  type        = map(object({
    name                  = string
    
  }))
  
}

variable "kv_pe_x" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_name         = string
    key_vault_name      = string

    private_service_connection = map(object({
      name                           = string
      private_connection_resource_id = string
      subresource_names              = list(string)
      is_manual_connection           = bool
    }))

    private_dns_zone_group = map(object({
      name                 = string
      private_dns_zone_ids = list(string)
    }))
  }))
}