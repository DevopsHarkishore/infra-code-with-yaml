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
