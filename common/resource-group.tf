resource "azurerm_resource_group" "liatrio" {
  name = format("bsore-wy-%s-liatrio",var.rgrp_name)
  location = "West Central US"
}