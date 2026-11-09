output "resource_group_name" {
  value       = azurerm_resource_group.tfstate.name
  description = "State storage resource group name."
}

output "storage_account_name" {
  value       = azurerm_storage_account.tfstate.name
  description = "State storage account name."
}

output "storage_account_id" {
  value       = azurerm_storage_account.tfstate.id
  description = "State storage account ID"
}

output "container_name" {
  value       = azurerm_storage_container.tfstate.name
  description = "State container name."
}

output "backend_config_instructions" {
  description = "Backend block values to place into workload/providers.tf"
  value = {
    resource_group_name  = azurerm_resource_group.tfstate.name
    storage_account_name = azurerm_storage_account.tfstate.name
    container_name       = azurerm_storage_container.tfstate.name
    key                  = "workload.hubspoke.tfstate"
  }
}