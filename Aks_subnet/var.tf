variable "subnet_config" {
  type = map(object({
    name                  = string
    resource_group_name   = string
    virtual_network_name = string
    address_prefixes      = list(string)

    delegation = optional(object({
      name         = string
      service_name = string
      actions      = list(string)
    }))
  }))
}