output "pip_ids" {
  value = {for keys, pip in azurerm_public_ip.pip: keys=> pip.id}
}