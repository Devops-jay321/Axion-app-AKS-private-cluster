variable "kv_admin_roles" {
  description = "Map of Key Vault admin roles"
  type = map(object({
    role_definition_name = string
  }))
  
}