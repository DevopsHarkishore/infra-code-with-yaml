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

variable "nic_id" {
  description = "Map of network interface IDs for the virtual machines"
  type        = map(string)
}
