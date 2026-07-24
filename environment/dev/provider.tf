terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-aks-test"
    storage_account_name = "storagaks120726"
    container_name       = "infracontainer"
    key                  = "dev1-terraform.tfstate"

  }
}
provider "azurerm" {
  features {}
subscription_id =  "873c59ab-f0c9-4625-badc-4c3d50c3cd19"
}
