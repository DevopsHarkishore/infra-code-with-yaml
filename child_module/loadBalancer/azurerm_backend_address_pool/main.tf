data "azurerm_lb" "azurerm_lb_db" {
  for_each = var.backend_ap

  name                = each.value.lb_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_lb_backend_address_pool" "backend_ap" {
  for_each = var.backend_ap

  name            = each.value.backend_pool_name
  loadbalancer_id = data.azurerm_lb.azurerm_lb_db[each.key].id
}
