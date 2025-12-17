data "azurerm_public_ip" "lb_pip_db" {
  for_each = var.lbs_details

  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_lb" "azurerm_lb" {
  for_each = var.lbs_details

  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_config
    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = data.azurerm_public_ip.lb_pip_db[each.key].id
    }
  }
}
