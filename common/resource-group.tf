resource "azurerm_resource_group" "liatrio" {
  name     = format("%s-%s", var.resource_prefix, var.resource_group_name)
  location = "West Central US"
}