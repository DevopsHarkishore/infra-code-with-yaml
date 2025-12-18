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


variable "subnet_ids" {}
variable "pip_ids" {}