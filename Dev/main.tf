module "rg" {
  source  = "../Resource-Group"
  rg_name = var.rg_name_x
}

module "vnet" {
  source = "../Aks-network"

  vnet_config = var.vnet_config_x
  depends_on  = [module.rg]

}

module "subnet" {
  source        = "../Aks_subnet"
  subnet_config = var.subnet_config_x
  depends_on    = [module.vnet]
}

module "aks" {
  source      = "../Aks_cluster"
  aks_cluster = var.aks_cluster_x
  depends_on  = [module.subnet]
}
module "public_ip" {
  source     = "../publicIP"
  public_ip  = var.public_ip_x
  depends_on = [module.rg]
}
# module "bastion" {
#   source       = "../azure-bastion"
#   bastion-host = var.bastion-host_x
#   depends_on   = [module.public_ip, module.subnet]
# }
# module "nic" {
#   source     = "../nic"
#   nic_config = var.nic_config_x
#   depends_on = [module.subnet]

# }
# module "jumpbox" {
#   source     = "../Jump-box"
#   jumpbox    = var.jumpbox_x
#   depends_on = [module.nic]

# }
module "iam" {
  source     = "../IAM-Role"
  depends_on = [module.aks,module.KV]
}
module "KV" {
  source     = "../Keyvault"
  key_vaults = var.key_vaults_x
  depends_on = [module.rg]
}
module "kvrole" {
  source         = "../keyvault-role"
  kv_admin_roles = var.kv_admin_roles_x
  depends_on     = [module.KV]
}
module "dnslink" {
  source     = "../Privatednslink"
  dnslink    = var.dnslink_x
  depends_on = [module.dnszone]
}
module "dnszone" {
  source     = "../private_DNS_zone"
  dnszone    = var.dnszone_x
  depends_on = [module.rg]
}
module "privateendpoint" {
  source     = "../privateendpoint"
  kv_pe      = var.kv_pe_x
  depends_on = [module.KV,module.subnet]
}
module "vpn_gateway" {
  source     = "../VPN_Gateway"
  depends_on = [module.subnet, module.public_ip]
}

module "acr" {
  source     = "../ACR"
  acr        = var.acr_x
  depends_on = [module.rg]
}

module "postgresql" {

  source = "../Postgress_Flexi_server"

  postgresql = {
    for key, postgres in var.postgresql_x : key => merge(
      postgres,
      {
        delegated_subnet_id = module.subnet.subnet_ids["postgres_subnet"]

        private_dns_zone_id = module.dnszone.private_dns_zone_ids["postgresql"]
      }
    )
  }
  postgresql_databases = var.postgresql_databases_x
  extensions           = var.extensions_x

  depends_on = [
    module.subnet,
    module.dnszone,
    module.dnslink
  ]
}

module "dns_resolver" {
  source = "../DNS-Resolver"

  dns_resolver = {
    for key, resolver in var.dns_resolver_x : key => merge(
      resolver,
      {
        virtual_network_id = module.vnet.vnet_ids["vnet1"]

        inbound_endpoint = merge(
          resolver.inbound_endpoint,
          {
            subnet_id = module.subnet.subnet_ids["dns_resolver_subnet"]
          }
        )
      }
    )
  }

  depends_on = [
    module.subnet
  ]
}
resource "azurerm_virtual_network_dns_servers" "aks_vnet_dns" {
  virtual_network_id = module.vnet.vnet_ids["vnet1"]

  dns_servers = [
    module.dns_resolver.inbound_endpoint_ips["resolver1"]
  ]

  depends_on = [
    module.dns_resolver
  ]
}