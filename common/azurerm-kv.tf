provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy          = true
      recover_soft_deleted_key_vaults       = false
      purge_soft_deleted_keys_on_destroy    = true
      recover_soft_deleted_keys             = false
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = false
    }
  }
}

data "azurerm_client_config" "current" {}


resource "azure_key_vault" "liatrio" {
  name                        = format("%s-%s-KV", var.resource_prefix, var.key_vault_name)
  location                    = azurerm_resource_group.liatrio.location
  resource_group_name         = azurerm_resource_group.liatrio.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  sku_name                    = "standard"
}

resource "azurerm_key_vault_access_policy" "k8s-policy" {
  key_vault_id = azurerm_key_vault.liatrio.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "Create",
    "Decrypt",
    "Delete",
    "Import",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
    "Release",
    "Rotate",
    "GetRotationPolicy",
    "SetRotationPolicy"
  ]
  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Restore",
    "Set"
  ]
}


resource "azurerm_Key_vault_secret" "k8s" {
  name         = "K8s-Private-Key"
  value        = tls_private_key.liatrio.private_key_pem
  key_vault_id = azurerm_key_vault.liatrio.id
}
#resource "azurerm_key_vault_access_policy" "k8s-policy" {
#    key_vault_id = azurerm_key_vault.liatrio.id
#    tenant_id    = data.azurerm_client_config.current.tenant_id
#    object_id    = data.azurerm_client_config.current.object_id
#}