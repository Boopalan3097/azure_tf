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


resource "azurerm_virtual_machine" "example" {
  # ... other configurations ...

  dynamic "custom_data" {
    for_each = var.custom_data_scripts

    content {
      name     = custom_data.value.name
      script   = custom_data.value.script
    }
  }
}


resource "azurerm_network_security_group" "example" {
  # ... other configurations ...

  dynamic "security_rule" {
    for_each = var.environment == "prod" ? var.prod_security_rules : var.dev_security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
