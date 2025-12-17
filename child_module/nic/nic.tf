resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_config
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = var.subnet_ids[ip_configuration.value.subnet_key]
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation

      public_ip_address_id = (ip_configuration.value.pip_key == null ? null : var.pip_ids[ip_configuration.value.pip_key])
      
      # public_ip_address_id          = var.public_ip_ids[ip_configuration.value.pip_key]
      # Safe conditional logic for optional PIP
      # public_ip_address_id = (
      #   ip_configuration.value.pip_key != null && contains(keys(var.pip_ids), ip_configuration.value.pip_key)
      #   ? var.pip_ids[ip_configuration.value.pip_key]
      #   : null
      # )
    }
  }
}
