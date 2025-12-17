resource "azurerm_mssql_database" "mssql_db" {
    for_each = var.mssql_database
  name         = each.value.mssqldb_name
  server_id    = var.mssqlserver_id[each.value.mssqlserver_id_key]
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type
  tags         = each.value.tags
}
