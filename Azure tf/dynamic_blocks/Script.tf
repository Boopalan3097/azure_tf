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


variable "storage_accounts" {
  type = map(object({
    account_tier             = string
    account_replication_type = string
  }))
  default = {
    storage1 = {
      account_tier             = "Standard"
      account_replication_type = "LRS"
    },
    storage2 = {
      account_tier             = "Premium"
      account_replication_type = "GRS"
    },
    storage3 = {
      account_tier             = "Standard"
      account_replication_type = "ZRS"
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  for_each = var.storage_accounts

  name                     = "storage${each.key}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}
