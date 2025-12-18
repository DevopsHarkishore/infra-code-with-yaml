module "rg" {
  source = "../../child_module/rg"
  rgs    = var.rgs
}

module "virtual_network" {

  depends_on = [module.rg]
  source     = "../../child_module/vnet"
  vnets      = var.vnets
}

module "subnet" {
  depends_on = [module.virtual_network, module.nsg] # Add NSG explicitly
  source     = "../../child_module/subnet"
  subnets    = var.subnets
  nsg_ids    = module.nsg.nsg_ids
}

module "network_interface" {
  depends_on = [module.subnet, module.public_ip, module.rg]
  source     = "../../child_module/nic"
  nics       = var.nics
  subnet_ids = module.subnet.subnet_id
  pip_ids    = module.public_ip.pip_ids
}

module "nsg" {
  depends_on = [module.rg]

  source = "../../child_module/nsg"
  nsgs   = var.nsgs
}

module "public_ip" {
  depends_on = [module.rg]
  source     = "../../child_module/pip"
  pips       = var.pips
}

module "virtual_machine" {
  depends_on      = [module.rg, module.nsg, module.subnet, module.public_ip, module.network_interface, module.key_vaults, module.key_vault_secret]
  source          = "../../child_module/vm"
  virtual_machine = var.virtual_machine
  nic_id          = module.network_interface.nic_ids
}

module "key_vaults" {
  depends_on = [module.rg]
  source     = "../../child_module/kv"
  key_vaults = var.key_vaults
}

module "key_vault_secret" {
  depends_on = [module.key_vaults]
  source     = "../../child_module/key_vault_secret"
  secrets    = var.secrets
}

module "mssql_server" {
  depends_on   = [module.rg, module.key_vaults, module.key_vault_secret]
  source       = "../../child_module/mssql_server"
  mssql_server = var.mssql_server
}
module "mssql_database" {
  depends_on     = [module.mssql_server]
  source         = "../../child_module/mssql_database"
  mssql_database = var.mssql_database
  mssqlserver_id = module.mssql_server.mssqlserver_id
}

module "load_balancer" {
  depends_on  = [module.rg, module.public_ip]
  source      = "../../child_module/loadBalancer/azurerm_lb"
  lbs_details = var.lbs_details
}

module "lb_backend_address_pool" {
  depends_on = [module.load_balancer, module.rg]
  source     = "../../child_module/loadBalancer/azurerm_backend_address_pool"
  backend_ap = var.backend_ap
}
module "lb_probe" {
  depends_on = [module.load_balancer, module.rg]
  source     = "../../child_module/loadBalancer/azurerm_lb_probe"
  lb_probe   = var.lb_probe
}
module "lb_rule" {
  depends_on   = [module.load_balancer, module.lb_backend_address_pool, module.lb_probe, module.rg]
  source       = "../../child_module/loadBalancer/azurerm_lb_rule"
  lb_rule      = var.lb_rule
  lb_probe_ids = module.lb_probe.lb_probe_ids
}

module "nic_bp_association" {
  depends_on         = [module.network_interface, module.lb_backend_address_pool, module.rg]
  source             = "../../child_module/loadBalancer/azurerm_nic_bp_association"
  nic_bp_association = var.nic_bp_association
}