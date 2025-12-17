variable "rgs" {
  description = "Map of resource groups to create"
  type = map(object({
    resource_group_name = string
    location            = string
    managed_by          = optional(string)
    tags                = optional(map(string))
  }))
}

variable "vnets" {
  type = map(object({
    resource_group_name = string
    location            = string
    vnet_name           = string
    address_space       = list(string)
    tags                = map(string)
  }))
}


variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    subnet_name         = string
    resource_group_name = string
    vnet_name           = string
    address_prefixes    = optional(list(string))
    nsg_key             = string

    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    default_outbound_access_enabled               = optional(bool)
    sharing_scope                                 = optional(string)

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



variable "nsgs" {
  type = map(object({
    nsg_name            = string
    location            = string
    resource_group_name = string
    tags                = map(string)
    security_rule = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "pips" {
  type = map(object({
    pip_name            = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    tags                = map(string)
  }))
}

variable "nics" {
  type = map(object({
    nic_name            = string
    location            = string
    resource_group_name = string
    ip_config = list(object({
      name                          = string
      private_ip_address_allocation = string
      subnet_key                    = optional(string)
      pip_key                       = optional(string)
    }))

  }))
}


variable "virtual_machine" {
  description = "Map of Linux virtual machine configurations"
  type = map(object({
    vm_name                         = string
    resource_group_name             = string
    location                        = string
    size                            = string
    vm_username_secret_name         = string
    vm_password_secret_name         = string
    disable_password_authentication = bool
    caching                         = string
    storage_account_type            = string
    publisher                       = string
    offer                           = string
    sku                             = string
    version                         = string
    nic_key                         = string
    kv_name                         = string
    script_name                     = string
  }))
}


variable "key_vaults" {
  type = map(object({
    kv_name                     = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
  }))
}

variable "mssql_server" {
  type = map(object({
    mssql_server_name              = string
    resource_group_name            = string
    location                       = string
    version                        = string
    minimum_tls_version            = string
    sqlserver_password_secret_name = string
    sqlserver_username_secret_name = string
    kv_name                        = string
    tags                           = map(string)
  }))
}

variable "mssql_database" {
  type = map(object({
    mssqldb_name       = string
    mssqlserver_id_key = string
    collation          = string
    license_type       = string
    max_size_gb        = number
    sku_name           = string
    enclave_type       = string
    tags               = map(string)
  }))
}

variable "lbs_details" {
  type = map(object({
    pip_name            = string
    resource_group_name = string
    lb_name             = string
    location            = string
    sku                 = string
    frontend_ip_config = list(object({ # Ensure name same as used in main.tf
      name = string
    }))
  }))
}

variable "secrets" {
  type = map(object({
    key_vault_name      = string
    secret_name         = string
    secret_value        = string
    resource_group_name = string
  }))
}

variable "backend_ap" {
  type = map(object({
    resource_group_name = string
    lb_name             = string
    backend_pool_name   = string
  }))
}

variable "lb_probe" {
  type = map(object({
    probe_name          = string
    probe_protocol      = string
    probe_port          = number
    resource_group_name = string
    lb_name             = string
  }))
}

variable "lb_rule" {
  type = map(object({
    lb_name                        = string
    resource_group_name            = string
    backend_address_pool_db_name   = string
    lb_rule_name                   = string
    protocol                       = string
    frontend_port                  = number
    backend_port                   = number
    frontend_ip_configuration_name = string
    probe_key                      = string
  }))
}

variable "nic_bp_association" {
  type = map(object({
    nic_name                  = string
    lb_name                   = string
    resource_group_name       = string
    backend_address_pool_name = string
    nic_ka_ip_config_name     = string
  }))
}





