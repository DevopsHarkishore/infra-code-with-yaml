
data "azurerm_key_vault" "key_vault" {
  for_each = var.secrets
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_key_vault_secret" "secret" {
  for_each    = var.secrets
  name         = each.value.secret_name
  value        = each.value.secret_value
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}