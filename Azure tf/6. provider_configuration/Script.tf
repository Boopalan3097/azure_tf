terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}


provider "azurerm" {
  features = {}
  subscription_id = "your-subscription-id"
  client_id       = "your-client-id"
  client_secret   = "your-client-secret"
  tenant_id       = "your-tenant-id"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
