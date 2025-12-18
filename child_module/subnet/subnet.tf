resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name

  # Exactly one of address_prefixes or ip_address_pool
  address_prefixes = (
    each.value.address_prefixes == null ? null : each.value.address_prefixes
  )

  dynamic "ip_address_pool" {
    for_each = (
      each.value.ip_address_pool == null ? [] : [each.value.ip_address_pool]
    )
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  service_endpoints = (
    each.value.service_endpoints == null ? null : each.value.service_endpoints
  )

  service_endpoint_policy_ids = (
    each.value.service_endpoint_policy_ids == null ? null : each.value.service_endpoint_policy_ids
  )

  private_endpoint_network_policies = (
    each.value.private_endpoint_network_policies == null ? null : each.value.private_endpoint_network_policies
  )

  private_link_service_network_policies_enabled = (
    each.value.private_link_service_network_policies_enabled == null ? null : each.value.private_link_service_network_policies_enabled
  )

  default_outbound_access_enabled = (
    each.value.default_outbound_access_enabled == null ? null : each.value.default_outbound_access_enabled
  )

  dynamic "delegation" {
    for_each = (
      each.value.delegation == null ? [] : [each.value.delegation]
    )
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = (
          delegation.value.service_delegation.actions == null ? null : delegation.value.service_delegation.actions
        )
      }
    }
  }
}



resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = var.nsg_ids[each.value.nsg_key]
}


