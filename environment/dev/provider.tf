terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.55.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "dev-aks-rg"
    storage_account_name = "infrastorage4480143"
    container_name       = "infracontainer"
    key                  = "dev1-terraform.tfstate"

  }
}
provider "azurerm" {
  features {}
  subscription_id = "635e9286-14d1-435f-b7e1-af1ebf689f4e"
}