output "nsg_ids" {
  value = {for keys, nsg in azurerm_network_security_group.nsg: keys => nsg.id }
}