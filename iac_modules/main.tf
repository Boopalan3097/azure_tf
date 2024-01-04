resource "azurerm_databricks_access_connector" "dbx_access_connector" {
  source                    = "./modules/dbx_access_connector"
  bdx_access_connector_name = var.bdx_access_connector_name
  resource_group_name       = var.resource_group_name
  location                  = var.location

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}