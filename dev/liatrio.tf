terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.56"
    }
    provider "tls" {
  source = "hashicorp/tls"
  }
  }
  backend "azurerm" {
    resource_group_name  = "bsore-wy-hub-rgrp"
    storage_account_name = "bsorewyhubsa"
    container_name       = "tfstate"
    key                  = "liatrio.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "liatrio-demo" {
  source              = "../common"
  resource_prefix     = "BSORE-WY"
  resource_group_name = "liatrio"
  key_vault_name      = "liatrio"

  environment = "dev"
  subnets = [
    {
      name               = "k8s-cluster"
      prefix             = "10.1.10.0/24"
      services           = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.EventHub", "Microsoft.ContainerRegistry"]
      service_delegation = false
    },
    {
      name               = "aci-vnet"
      prefix             = "10.2.10.0/24"
      services           = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.EventHub", "Microsoft.ContainerRegistry"]
      service_delegation = true

    }
  ]
}
