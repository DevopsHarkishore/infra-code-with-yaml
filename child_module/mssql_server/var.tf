variable "mssql_server" {
  type = map(object({
    mssql_server_name              = string
    resource_group_name            = string
    location                       = string
    version                        = string
    minimum_tls_version            = string
    sqlserver_password_secret_name = string
    sqlserver_username_secret_name = string
    kv_name                        = string
    tags                           = map(string)
  }))
}

output "mssqlserver_id" {
  value = {for keys, server in azurerm_mssql_server.sql-server : keys => server.id}
}