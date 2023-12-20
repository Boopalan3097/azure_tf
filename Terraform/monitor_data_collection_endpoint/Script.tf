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

resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe"
}

resource "azurerm_monitor_data_collection_endpoint" "example" {
  name                          = "example-mdce"
  resource_group_name           = azurerm_resource_group.example.name
  location                      = azurerm_resource_group.example.location
  kind                          = "Windows"
  public_network_access_enabled = true
  description                   = "monitor_data_collection_endpoint example"
  tags = {
    foo = "bar"
  }
}