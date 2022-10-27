resource "azurerm_storage_account" "storageaccount" {
  name                      = "itccsafa${var.environment}001"
  resource_group_name       = var.resource_group_name
  location                  = var.location
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

resource "azurerm_key_vault" "keyvault" {
  name                        = "itcckeyvault${var.environment}33"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
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
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_virtual_network" "virtualnetwork" {
  name                = "xylosvnet001"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
}

# resource "random_password" "sftp" {
#   length           = 16
#   special          = true
#   override_special = "!#$%&*()-_=+[]{}<>:?"
# }

# resource "azurerm_network_interface" "sftp" {
#   name                = "${var.customer_abbreviation}-${var.environment}-sftp-nic"
#   location            = data.azurerm_resource_group.terraform.location
#   resource_group_name = data.azurerm_resource_group.terraform.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = data.azurerm_subnet.subnet1.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "sftp" {
#   name                = "${var.customer_abbreviation}-${var.environment}-sftp-vm"
#   location            = data.azurerm_resource_group.terraform.location
#   resource_group_name = data.azurerm_resource_group.terraform.name
#   size                = "Standard_D2s_v3"
#   admin_username      = var.environment
#   admin_password = random_password.sftp.result
#   disable_password_authentication = false

#   network_interface_ids = [
#     azurerm_network_interface.sftp.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Premium_LRS"
#     disk_size_gb = 128
#     name = "${var.customer_abbreviation}-${var.environment}-sftp-osdisk"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts"
#     version   = "latest"
#   }
# }

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

# module "services" {
#   source = "./modules"
#   customer_abbreviation    = var.customer_abbreviation
#   location                 = var.location
#   environment              = var.environment
#   resource_group           = data.azurerm_resource_group.terraform.name
# }