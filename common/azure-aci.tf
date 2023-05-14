resource "azurerm_container_registry" "liatrio" {
  name                = "liatrioacr"
  resource_group_name = azurerm_resource_group.liatrio.name
  location            = azurerm_resource_group.liatrio.location
  sku                 = "Standard"
  admin_enabled       = false
}
