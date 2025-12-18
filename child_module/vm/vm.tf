data "azurerm_key_vault" "kv" {
  for_each            = var.virtual_machine
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "vm_username" {
  for_each     = var.virtual_machine
  name         = each.value.vm_username_secret_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "vm_password" {
  for_each     = var.virtual_machine
  name         = each.value.vm_password_secret_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}


resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = var.virtual_machine

  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.vm_username[each.key].value
  admin_password      = data.azurerm_key_vault_secret.vm_password[each.key].value
  custom_data         = base64encode(file(each.value.script_name))
  
  
  network_interface_ids = [var.nic_id[each.value.nic_key]]
  disable_password_authentication = each.value.disable_password_authentication
  
  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}



