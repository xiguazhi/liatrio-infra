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


#resource "azurerm_key_vault_access_policy" "k8s-policy" {
#    key_vault_id = azurerm_key_vault.liatrio.id
#    tenant_id    = data.azurerm_client_config.current.tenant_id
#    object_id    = data.azurerm_client_config.current.object_id
#}