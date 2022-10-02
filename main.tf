resource "azurerm_key_vault" "keyvault" {
  name                        = "itcckeyvault002"
  location                    = data.azurerm_resource_group.terraform.location
  resource_group_name         = data.azurerm_resource_group.terraform.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
      "Delete",
      "List",
      "Set",
      "Purge"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_storage_account" "storageaccount" {
  name                      = "itccstorageaccountfa002"
  resource_group_name       = data.azurerm_resource_group.terraform.name
  location                  = data.azurerm_resource_group.terraform.location
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  enable_https_traffic_only = "true"
  min_tls_version           = "TLS1_2"
  access_tier               = "Hot"

  network_rules {
    default_action = "Allow"
  }
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_storage_share" "azureshare" {
  name                 = "share1"
  storage_account_name = azurerm_storage_account.storageaccount.name
}

resource "azurerm_automation_account" "automationaccount" {
  name                = "itccautomation001"
  location            = data.azurerm_resource_group.terraform.location
  resource_group_name = data.azurerm_resource_group.terraform.name
  sku_name            = "Basic"
}

resource "azurerm_log_analytics_workspace" "loganalyticsworkspace" {
  name                = "itccworkspace001"
  location            = data.azurerm_resource_group.terraform.location
  resource_group_name = data.azurerm_resource_group.terraform.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_management_lock" "loganalyticsworkspacelock" {
  name       = "MyLAWlock"
  scope      = azurerm_log_analytics_workspace.loganalyticsworkspace.id
  lock_level = "CanNotDelete"
  notes      = "Locked created for tet purposes"
}

resource "azurerm_log_analytics_linked_service" "loganalyticsworkspacelinkedservice" {
  resource_group_name = data.azurerm_resource_group.terraform.name
  workspace_id        = var.lawid
  read_access_id      = azurerm_automation_account.automationaccount.id
}

resource "azurerm_log_analytics_solution" "loganalyticsworkspacesolution" {
  solution_name         = "VMInsights"
  location              = data.azurerm_resource_group.terraform.location
  resource_group_name   = data.azurerm_resource_group.terraform.name
  workspace_resource_id = azurerm_log_analytics_workspace.loganalyticsworkspace.id
  workspace_name        = azurerm_log_analytics_workspace.loganalyticsworkspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }
}