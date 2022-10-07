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

# resource "azurerm_automation_account" "automationaccount" {
#   name                = "itccautomation001"
#   location            = data.azurerm_resource_group.terraform.location
#   resource_group_name = data.azurerm_resource_group.terraform.name
#   sku_name            = "Basic"
# }

# resource "azurerm_log_analytics_workspace" "loganalyticsworkspace" {
#   name                = "itccworkspace001"
#   location            = data.azurerm_resource_group.terraform.location
#   resource_group_name = data.azurerm_resource_group.terraform.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }

# resource "azurerm_management_lock" "loganalyticsworkspacelock" {
#   name       = "MyLAWlock"
#   scope      = azurerm_log_analytics_workspace.loganalyticsworkspace.id
#   lock_level = "CanNotDelete"
#   notes      = "Locked created for tet purposes"
# }

# resource "azurerm_log_analytics_linked_service" "loganalyticsworkspacelinkedservice" {
#   resource_group_name = data.azurerm_resource_group.terraform.name
#   workspace_id        = azurerm_log_analytics_workspace.loganalyticsworkspace.id
#   read_access_id      = azurerm_automation_account.automationaccount.id
# }

# resource "azurerm_log_analytics_solution" "loganalyticsworkspacesolution" {
#   solution_name         = "VMInsights"
#   location              = data.azurerm_resource_group.terraform.location
#   resource_group_name   = data.azurerm_resource_group.terraform.name
#   workspace_resource_id = azurerm_log_analytics_workspace.loganalyticsworkspace.id
#   workspace_name        = azurerm_log_analytics_workspace.loganalyticsworkspace.name

#   plan {
#     publisher = "Microsoft"
#     product   = "OMSGallery/VMInsights"
#   }
# }

module "services" {
  source = "./modules"
  customer_abbreviation    = var.customer_abbreviation
  location                 = var.location
  environment              = var.environment
  resource_group           = data.azurerm_resource_group.terraform.name
}