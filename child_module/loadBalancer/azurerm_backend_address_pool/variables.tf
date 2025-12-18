variable "backend_ap" {
  type = map(object({
    resource_group_name  = string
    lb_name  = string
    backend_pool_name = string
  }))
}
