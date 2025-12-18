data "azurerm_lb" "azurerm_lb_db" {
  for_each = var.lb_probe

  name                = each.value.lb_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_lb_probe" "lb_probe" {
  for_each = var.lb_probe

  name                = each.value.probe_name
  loadbalancer_id     = data.azurerm_lb.azurerm_lb_db[each.key].id
  protocol            = each.value.probe_protocol
  port                = each.value.probe_port
  interval_in_seconds = 5
  number_of_probes    = 2
}
