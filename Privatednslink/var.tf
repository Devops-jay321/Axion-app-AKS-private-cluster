variable "dnslink" {
  description = "Map of DNS zone virtual network links"
  type        = map(object({
    name                  = string
    
       
  }))
  
}