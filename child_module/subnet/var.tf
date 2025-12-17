variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    subnet_name         = string
    resource_group_name = string
    vnet_name           = string
    address_prefixes    = optional(list(string))
    nsg_key             = string

    service_endpoints                     = optional(list(string))
    service_endpoint_policy_ids           = optional(list(string))
    private_endpoint_network_policies     = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    default_outbound_access_enabled       = optional(bool)
    sharing_scope                         = optional(string)

    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    }))

    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))
  }))
}

variable "nsg_ids" {
  description = "Map of NSG IDs to associate with subnets"
  type        = map(string)
}

