resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone" "example" {
  name                = "://mydomain.com"
  resource_group_name = "rg-dns-networks"
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_spoke" {
  private_dns_zone_id   = azurerm_private_dns_zone.example.id
  name                  = "dnslink-spoke"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = azurerm_virtual_network.spoke.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_hub" {
  name                  = "dnslink-hub"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = azurerm_virtual_network.hub.id
  registration_enabled  = false
}