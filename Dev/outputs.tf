output "dns_resolver_inbound_endpoint_ips" {
  description = "Private IP addresses of DNS Private Resolver inbound endpoints"

  value = module.dns_resolver.inbound_endpoint_ips
}