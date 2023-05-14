provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_key_vaults = false
      purge_soft_deleted_keys_on_destroy = true
      recover_soft_deleted_keys = false
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets = false
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "liatrio" {
  name = format("%s-%s-kv", var.resource_prefix, var.kv_name)
  location = azurerm_resource_group.liatrio.location
  resource_group_name = azurerm_resource_group.liatrio.name
  enabled_for_disk_encryption = true
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "Standard"

  network_acls {
    bypass = "AzureServices"
    default_action = Deny
    ip_rules = ["199.192.99.26"]
    virtual_network_subnet_ids = azurerm_subnet.sub[*].id
  }
}

resource "azurerm_key_vault_access_policy" "SP-poliy" {
  key_vault_id = azurerm_key_vault.liatrio.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

}

resource "azurerm_key_vault_key" "encryption" {
  name = "encryption-cert"
  key_vault_id = azurerm_key_vault.liatrio.id
  key_type = "RSA"
  key_size = 4096
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    expire_after  = "P90D"
    notify_before_expiry = "P29D"
    }
}


#resource "azurerm_key_vault_access_policy" "k8s-policy" {
#    key_vault_id = azurerm_key_vault.liatrio.id
#    tenant_id    = data.azurerm_client_config.current.tenant_id
#    object_id    = data.azurerm_client_config.current.object_id
#}