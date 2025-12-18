variable "mssql_database" {
  type = map(object({
    mssqldb_name       = string
    mssqlserver_id_key = string
    collation          = string
    license_type       = string
    max_size_gb        = number
    sku_name           = string
    enclave_type       = string
    tags               = map(string)
  }))
}

variable "mssqlserver_id" {
  type = map(string)
}
