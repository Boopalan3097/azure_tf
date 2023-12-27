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
  name     = "example-resources"
  location = "West Europe"
}


variable "environment" {
  type    = string
  default = "dev"
}

resource "azurerm_storage_account" "example" {
  name                     = "storageaccount"
  resource_group_name      = "example-rg"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Enable soft delete for production environment
  lifecycle {
    prevent_destroy = var.environment == "prod" ? true : false
  }

  # Configure a custom SKU for non-production environments
  sku {
    name = var.environment == "prod" ? "Standard_GRS" : "Standard_LRS"
  }
}
