variable "secrets" {
  type = map(object({
    key_vault_name = string
    secret_name    = string
    secret_value   = string
    resource_group_name = string
  }))
}