variable "lb_rule" {
  type = map(object({
    lb_name                         = string
    resource_group_name             = string
    backend_address_pool_db_name    = string
    lb_rule_name                    = string
    protocol                        = string
    frontend_port                   = number
    backend_port                    = number
    frontend_ip_configuration_name  = string
    probe_key                      = string
  }))
}

variable "lb_probe_ids" {
  type = map(string)
}
