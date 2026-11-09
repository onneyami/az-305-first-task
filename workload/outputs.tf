output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Target workload resource group."
}

output "app_service_default_hostname" {
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
  description = "Public URL of the deployed App Service."
}

output "sql_server_fqdn" {
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
  description = "Fully qualified domain name of Azure SQL."
}

output "sql_private_endpoint_ip" {
  value       = azurerm_private_endpoint.sql_pe.private_service_connection[0].private_ip_address
  description = "Private IP address resolved through the Spoke Private Endpoint."
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "Azure Key Vault URI."
}

output "private_dns_zone_id" {
  value       = azurerm_private_dns_zone.example.id
  description = "Private DNS zone ID"
}