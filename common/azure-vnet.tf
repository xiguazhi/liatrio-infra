locals {
  # To allow for more traditional inputs of Subnets we do a list of objects so we need to transform that into by adding a key in front of each item.
  subnets = { for s in var.subnets : s.name => { name = s.name, prefix = s.prefix, services = s.services, service_delegation = s.service_delegation } }
  #  To allow for more traditional inputs of Subnets so we create a list of just the  prefixes for input into the VNET
  prefixes = [for s in var.subnets : s.prefix]
}

resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-vnet", var.resource_prefix)
  location            = azurerm_resource_group.liatrio.location
  resource_group_name = azurerm_resource_group.liatrio.name
  address_space       = local.prefixes
}

resource "azurerm_subnet" "sub" {
  for_each             = local.subnets
  name                 = format("%s-%s-sub", var.resource_prefix, each.value.name)
  resource_group_name  = azurerm_resource_group.liatrio.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.prefix]
  service_endpoints    = each.value.services
  dynamic "delegation" {
    for_each = each.value.service_delegation == "true" ? [1] : []
    content {
      name = "aciDelegation"
      service_delegation {
        name    = "Microsoft.ContainerInstance/containerGroups"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }

}

