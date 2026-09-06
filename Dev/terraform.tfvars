rg_name_x = {  
  "rg1" = {
    name     = "jaydeep_rg2"
    location = "Central india"

  }

}
vnet_config_x = {
  "vnet1" = {
    name                = "jaydeep-aks-vnet"
    location            = "Central india"
    resource_group_name = "jaydeep_rg2"
    address_space       = ["10.10.0.0/16"]
    
  }
}

subnet_config_x = {
  "aks_subnet" = {
    name                 = "jaydeep-aks-subnet"
    resource_group_name  = "jaydeep_rg2"
    virtual_network_name = "jaydeep-aks-vnet"
    address_prefixes     = ["10.10.1.0/24"]
  }
    "bastion_subnet" = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "jaydeep_rg2"
    virtual_network_name = "jaydeep-aks-vnet"
    address_prefixes     = ["10.10.2.0/24"]
  }
    "jumpbox-subnet" = {
    name                 = "JumpBoxSubnet"
    resource_group_name  = "jaydeep_rg2"
    virtual_network_name = "jaydeep-aks-vnet"
    address_prefixes     = ["10.10.3.0/24"]
  }
  "GatewaySubnet" = {
  name                 = "GatewaySubnet"
  resource_group_name  = "jaydeep_rg2"
  virtual_network_name = "jaydeep-aks-vnet"
  address_prefixes     = ["10.10.254.0/27"]
}
}
aks_cluster_x = {

  "aks_cluster" = {

    name                = "jaydeep-aks-cluster-private"
    location            = "Central india"
    resource_group_name = "jaydeep_rg2"

    kubernetes_version = "1.35.5"
    dns_prefix         = "jaydeep-aks"
    private_cluster_enabled = true


    default_node_pool = {

      "nodepool1" = {

        name                  = "k8vms"
        auto_scaling_enabled  = true
        min_count             = 1
        max_count             = 4
        vm_size               = "standard_b2s_v2"
      }
    }

    network_profile = {

      "networkprofile1" = {

        network_plugin    = "azure"
        network_policy    = "calico"
        load_balancer_sku = "standard"
      }
    }
  }
}
public_ip_x = {
  "pub-ip_bastion" = {
    name                = "bastion-public-ip"
    resource_group_name = "jaydeep_rg2"
    location            = "Central india"
    allocation_method   = "Static"
    sku                 = "Standard"

  }
    "pub-ip_vpn_gateway" = {
    name                = "vpn-gateway-public-ip"
    resource_group_name = "jaydeep_rg2"
    location            = "Central india"
    allocation_method   = "Static"
    sku                 = "Standard"
    zones               = ["1", "2", "3"]

  }
}
bastion-host_x = {
  "bastion-host" = {
    name                 = "bastion-host-jay"
    location             = "Central india"
    resource_group_name  = "jaydeep_rg2"
    virtual_network_name = "jaydeep-aks-vnet"
    ip_configuration = {
      "ipconfig1" = {
        name = "bastion-ipconfig"
      }
    }
  }
}
nic_config_x = {
  "nic_jumpbox" = {
    name                = "nic-jumpbox"
    location            = "Central india"
    resource_group_name = "jaydeep_rg2"
    subnet_name         = "jumpbox_subnet"
    ip_configuration = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
}
jumpbox_x = {
  "jumpbox" = {
    name                            = "jumpbox-vm"
    location                        = "Central india"
    resource_group_name             = "jaydeep_rg2"
    size                            = "Standard_D2s_v5"
    admin_username                  = "jaydeepc1985"
    admin_password                  = "Oneday@3211985"
    network_interface_name          = "nic-jumpbox"
    disable_password_authentication = false
    os_disk = {
      "osdisk1" = {
        name    = "jumpbox-osdisk"
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
      }
    }
    source_image_reference = {
      "image1" = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    }
  }
}

key_vaults_x = {
  "key-vault" = {
    name                = "jaydeep-key-vault1"
    resource_group_name = "jaydeep_rg2"
    location            = "Central india"
    sku_name            = "standard"
    tenant_id           = "8ec50a22-571a-45d8-a7f3-72b599797c26"  # Replace with your actual tenant ID
    tags = {
      environment = "dev"
      project     = "KeyVaultProject"
    }
  }
}

kv_admin_roles_x = {
  "kv_admin" = { 
    role_definition_name = "Key Vault Administrator"
  }
}

dnszone_x = {
   "DNSzone1" = {
    name                = "privatelink.vaultcore.azure.net"
    resource_group_name = "jaydeep_rg2"
  }
}

dnslink_x = {
  "kv" = {
    name                  = "kv-dns-link"
  }
}

kv_pe_x = {
  "kv-pe" = {
    name                 = "kv-pe"
    resource_group_name  = "jaydeep_rg2"
    location            = "Central india"
    subnet_name          = "aks_subnet"
    key_vault_name      = "jaydeep-key-vault1"

    private_service_connection = {
        "psc1" = {
      name                           = "kv-privatelink"
      private_connection_resource_id = "kvi"  # Replace with actual resource ID
      is_manual_connection          = false
      subresource_names             = ["vault"]
    }
    }
    private_dns_zone_group = {
      "pdzg1" = {
        name                 = "pdzg-kv1"
        private_dns_zone_ids = ["kv"]  # Replace with actual DNS zone IDs
      }
    
  }
}
}