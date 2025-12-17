output "nic_ids" {
  value = {for keys , nic in azurerm_network_interface.nic: keys => nic.id}
}
