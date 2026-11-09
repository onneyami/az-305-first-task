resource "azurerm_service_plan" "plan" {
  name                = "asp-${var.project_name}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                      = "app-${var.project_name}-${random_string.suffix.result}"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  service_plan_id           = azurerm_service_plan.plan.id
  virtual_network_subnet_id = azurerm_subnet.spoke_app.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = false
    application_stack {
      dotnet_version = "8.0"
    }
  }

  app_settings = {
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "SQL_SERVER_HOST"        = azurerm_mssql_server.sql.fully_qualified_domain_name
    "SQL_ADMIN_USER"         = var.sql_admin_username
    "SQL_ADMIN_PASSWORD"     = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.sql_password.versionless_id})"
  }
}