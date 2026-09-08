variable "dns_resolver" {
  description = "Map of Azure DNS Private Resolvers"

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    virtual_network_id  = string

    inbound_endpoint = object({
      name       = string
      subnet_id  = string
    })
  }))
}