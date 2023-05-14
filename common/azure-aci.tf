resource "azurerm_container_registry" "acr" {
  name                = "Liatrio-Demo"
  resource_group_name = azurerm_resource_group.liatrio.name
  location            = azurerm_resource_group.liatrio.location
  sku                 = "Standard"
  admin_enabled       = false

  encryption {
    enabled = true
    key_vault_key_id = azurerm_key_vault.liatrio.id
  }
}
