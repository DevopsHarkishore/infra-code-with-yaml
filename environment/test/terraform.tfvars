rgs = {
  "rg1" = {
    resource_group_name = "dev-rg1-001"
    location            = "centralindia"
  }
}

vnets = {
  "vnet1" = {
    resource_group_name = "dev-rg1-001"
    location            = "centralindia"
    vnet_name           = "dev-vnet1-001"
    address_space       = ["10.0.0.0/16"]
    tags = {
      environment = "Dev"
    }
  }
}

subnets = {
  "subnet1" = {
    subnet_name         = "dev-subnet1-001"
    resource_group_name = "dev-rg1-001"
    vnet_name           = "dev-vnet1-001"
    address_prefixes    = ["10.0.1.0/24"]
    nsg_key             = "nsg1"
  }

  "subnet2" = {
    subnet_name         = "dev-subnet2-002"
    resource_group_name = "dev-rg1-001"
    vnet_name           = "dev-vnet1-001"
    address_prefixes    = ["10.0.2.0/24"]
    nsg_key             = "nsg2"
  }
}

nsgs = {
  nsg1 = {
    nsg_name            = "dev-nsg1-001"
    location            = "centralindia"
    resource_group_name = "dev-rg1-001"
    tags = {
      environment = "Dev"
    }
    security_rule = [
      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg2 = {
    nsg_name            = "dev-nsg2-002"
    location            = "centralindia"
    resource_group_name = "dev-rg1-001"
    tags = {
      environment = "Dev"
    }
    security_rule = [
      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

pips = {
  "pip1" = {
    pip_name            = "dev-pip1-001"
    resource_group_name = "dev-rg1-001"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      environment = "Dev"
    }
  }
  "pip2" = {
    pip_name            = "dev-pip2-002"
    resource_group_name = "dev-rg1-001"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      environment = "Dev"
    }
  }
  "pip3" = {
    pip_name            = "dev-pip3-003"
    resource_group_name = "dev-rg1-001"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      environment = "Dev"
    }
  }
}

nics = {
  "nic1" = {
    nic_name            = "dev-nic1-001"
    location            = "centralindia"
    resource_group_name = "dev-rg1-001"
    ip_config = [
      {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet1"
        pip_key                       = "pip1"
      }
    ]
  }

  "nic2" = {
    nic_name            = "dev-nic2-002"
    location            = "centralindia"
    resource_group_name = "dev-rg1-001"
    ip_config = [
      {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet2"
        pip_key                       = "pip2"
      }
    ]
  }
}

virtual_machine = {
  "vm1" = {
    vm_name                         = "dev-vm1-001"
    resource_group_name             = "dev-rg1-001"
    location                        = "centralindia"
    size                            = "Standard_D2_v3"
    vm_username_secret_name         = "vm-username"
    vm_password_secret_name         = "vm-password"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    nic_key                         = "nic1"
    kv_name                         = "dev-keyvault-4480"
    script_name                     = "scripts/install_setup.sh"

  }
  "vm2" = {
    vm_name                         = "dev-vm2-002"
    resource_group_name             = "dev-rg1-001"
    location                        = "centralindia"
    size                            = "Standard_D2_v3"
    vm_username_secret_name         = "vm-username"
    vm_password_secret_name         = "vm-password"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    nic_key                         = "nic2"
    kv_name                         = "dev-keyvault-4480"
    script_name                     = "scripts/install_setup.sh"
  }
}

key_vaults = {
  kv1 = {
    kv_name                     = "dev-keyvault-4480"
    location                    = "centralindia"
    resource_group_name         = "dev-rg1-001"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"

  }
}

mssql_server = {
  sql_server1 = {
    mssql_server_name              = "dev-mssqlserver-001"
    resource_group_name            = "dev-rg1-001"
    location                       = "centralindia"
    version                        = "12.0"
    kv_name                        = "dev-keyvault-4480"
    minimum_tls_version            = "1.2"
    sqlserver_username_secret_name = "sqlserver-username"
    sqlserver_password_secret_name = "sqlserver-password"
    tags = {
      environment = "dev"
    }
  }
}

mssql_database = {
  mssqldb1 = {
    mssqldb_name       = "dev-mssqldb-001"
    mssqlserver_id_key = "sql_server1"
    collation          = "SQL_Latin1_General_CP1_CI_AS"
    license_type       = "LicenseIncluded"
    max_size_gb        = 10
    sku_name           = "S0"
    enclave_type       = "VBS"
    tags = {
      environment = "dev"
    }
  }
}

secrets = {
  secret1 = {
    key_vault_name      = "dev-keyvault-4480"
    resource_group_name = "dev-rg1-001"
    secret_name         = "vm-username"
    secret_value        = "adminuser"
  }

  secret2 = {
    key_vault_name      = "dev-keyvault-4480"
    resource_group_name = "dev-rg1-001"
    secret_name         = "vm-password"
    secret_value        = "Avaya!@#321"
  }
  secret3 = {
    key_vault_name      = "dev-keyvault-4480"
    resource_group_name = "dev-rg1-001"
    secret_name         = "sqlserver-username"
    secret_value        = "sqladminuser"
  }

  secret4 = {
    key_vault_name      = "dev-keyvault-4480"
    resource_group_name = "dev-rg1-001"
    secret_name         = "sqlserver-password"
    secret_value        = "SqlAdmin!@#321"
  }
}

backend_ap = {
  "backendpool1" = {
    resource_group_name = "dev-rg1-001"
    lb_name             = "dev-lb1-001"
    backend_pool_name   = "dev-backendpool1"
  }
}

lb_probe = {
  "probe1" = {
    lb_name             = "dev-lb1-001"
    resource_group_name = "dev-rg1-001"
    probe_name          = "dev-lb-probe1"
    probe_protocol      = "Tcp"
    probe_port          = 80
  }

  "probe2" = {
    lb_name             = "dev-lb1-001"
    resource_group_name = "dev-rg1-001"
    probe_name          = "dev-lb-probe2"
    probe_protocol      = "Tcp"
    probe_port          = 22
  }
}

lbs_details = {
  "lb1" = {
    lb_name             = "dev-lb1-001"
    pip_name            = "dev-pip3-003"
    location            = "centralindia"
    resource_group_name = "dev-rg1-001"
    sku                 = "Standard"
    frontend_ip_config = [
      {
        name          = "PublicIPAddress"
        public_ip_key = "pip3"
      }
    ]
    tags = {
      environment = "Dev"
    }
  }
}

lb_rule = {
  "lbrule1" = {
    lb_name                        = "dev-lb1-001"
    resource_group_name            = "dev-rg1-001"
    backend_address_pool_db_name   = "dev-backendpool1"
    lb_rule_name                   = "dev-lb-rule1"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "PublicIPAddress"
    probe_key                      = "probe1"
  }

  "lbrule2" = {
    lb_name                        = "dev-lb1-001"
    resource_group_name            = "dev-rg1-001"
    backend_address_pool_db_name   = "dev-backendpool1"
    lb_rule_name                   = "dev-lb-rule2"
    protocol                       = "Tcp"
    frontend_port                  = 22
    backend_port                   = 22
    frontend_ip_configuration_name = "PublicIPAddress"
    probe_key                      = "probe2"
  }
}
nic_bp_association = {
  "nicbp1" = {
    nic_name                  = "dev-nic1-001"
    resource_group_name       = "dev-rg1-001"
    nic_ka_ip_config_name     = "internal"
    backend_address_pool_name = "dev-backendpool1"
    lb_name                   = "dev-lb1-001"
  }

  "nicbp2" = {
    nic_name                  = "dev-nic2-002"
    resource_group_name       = "dev-rg1-001"
    nic_ka_ip_config_name     = "internal"
    backend_address_pool_name = "dev-backendpool1"
    lb_name                   = "dev-lb1-001"
  }
}


# keyvaults main username and password set krne ki command
#az keyvault secret set --vault-name dev-keyvault-4480 --name vm-username --value "adminuser"
#az keyvault secret set --vault-name dev-keyvault-4480 --name vm-password --value "Avaya!@#321"
