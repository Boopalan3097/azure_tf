terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "network" {
  source               = "./modules/network"
  resource_group_name  = "example-rg"
  location             = "East US"
  virtual_network_name = "example-vnet"
  address_space        = ["10.0.0.0/16"]
}
