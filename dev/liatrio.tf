terraform {
  required_providers {
    azurerm {
      source = "hashicorp/azurerm"
      version = "~> 3.55"
    }
  }
  backend "azurerm" {
    resource_group_name = "bsore-wy-hub-rgrp"
    storage_account_name = "bsorewyhubsa"
    container_name = "tfstate"
    key = "liatrio.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "liatrio-demo" {
  resource_prefix = "BSORE-WY"
  environment     = "dev"
  subnets = [
    {
      name = "k8s-cluster"
      prefix = "10.1.10.0/24"
      services = [ "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.EventHub", "Microsoft.ContainerRegistry"]
      service_delegaation = false
    },
    {
      name = "aci-vnet"
      prefix = "10.2.10.0/24"
      services = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.EventHub", "Microsoft.ContainerRegistry"]
      service_delegaation = true

    }
  ]
}  
