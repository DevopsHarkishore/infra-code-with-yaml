data "azurerm_key_vault" "kv" {
  for_each            = var.mssql_server
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "sqlserver_username" {
  for_each     = var.mssql_server
  name         = each.value.sqlserver_username_secret_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "sqlserver_password" {
  for_each     = var.mssql_server
  name         = each.value.sqlserver_password_secret_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}


resource "azurerm_mssql_server" "sql-server" {
  for_each                     = var.mssql_server
  name                         = each.value.mssql_server_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.sqlserver_username[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.sqlserver_password[each.key].value
  minimum_tls_version          = each.value.minimum_tls_version
  tags                         = each.value.tags
}

