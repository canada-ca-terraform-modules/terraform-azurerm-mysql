resource "azurerm_key_vault" "mysql" {
  name                        = var.kv_db_name
  location                    = var.location
  resource_group_name         = var.kv_db_rg
  enabled_for_disk_encryption = true
  tenant_id                   = var.kv_db_tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  soft_delete_enabled         = true

  sku_name = "standard"

  access_policy {
    tenant_id = azurerm_mysql_server.mysql.identity[0].tenant_id
    object_id = azurerm_mysql_server.mysql.identity[0].principal_id

    key_permissions = [
      "get",
      "list",
      "update",
      "create",
      "import",
      "delete",
      "recover",
      "backup",
      "restore",
      "wrapKey",
      "unwrapKey",
    ]

    secret_permissions = []

    storage_permissions = []
  }

  access_policy {
    tenant_id = var.kv_db_tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "list",
      "update",
      "create",
      "import",
      "delete",
      "recover",
      "backup",
      "restore",
      "wrapKey",
      "unwrapKey",
    ]

    secret_permissions = []

    storage_permissions = []
  }
  tags = {}
}
