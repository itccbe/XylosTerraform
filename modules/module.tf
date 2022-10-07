locals {
  # add a '-' to the project variable if it exists
  # don't use this local in storage accounts, as dashes aren't allowed
  project = var.project == "" ? "" : "-${var.project}"
}

# create log analytics workspace
resource "azurerm_log_analytics_workspace" "loganalyticsworkspace" {
  name                = "law-services-${var.customer_abbreviation}-${var.environment}${local.project}-shared"
  resource_group_name = azurerm_resource_group.services.name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 360
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# resource "azurerm_management_lock" "lock-law-services" {
#   name       = "Delete"
#   scope      = azurerm_log_analytics_workspace.law-services.id
#   lock_level = "CanNotDelete"
# }

# create automation account which will be linked to the LAW
resource "azurerm_automation_account" "automationaccount" {
  name                = "aa-services-${var.customer_abbreviation}-${var.environment}${local.project}-shared"
  location            = var.location
  resource_group_name = azurerm_resource_group.services.name

  sku_name = "Basic"

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# link the automation account to the LAW
resource "azurerm_log_analytics_linked_service" "loganalyticsworkspacelinkedservice" {
  resource_group_name = azurerm_resource_group.services.name
  workspace_id        = azurerm_log_analytics_workspace.law-services.id
  read_access_id      = azurerm_automation_account.aa-services.id
}


# add updates workspace solution to log analytics
resource "azurerm_log_analytics_solution" "loganalyticsworkspacesolution" {
  resource_group_name   = azurerm_resource_group.services.name
  location              = var.location
  solution_name         = "Updates"
  workspace_resource_id = azurerm_log_analytics_workspace.law-services.id
  workspace_name        = azurerm_log_analytics_workspace.law-services.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Updates"
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# below is the correct code for performance counter
resource "azurerm_log_analytics_datasource_windows_performance_counter" "LogicalDisk_Read" {
  name                = "LogicalDisk_Read"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Avg. Disk sec/Read"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "LogicalDisk_Write" {
  name                = "LogicalDisk_Write"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Avg. Disk sec/Write"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "LogicalDisk_QueueLenght" {
  name                = "LogicalDisk_QueueLenght"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Current Disk Queue Length"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "LogicalDisk_ReadsPerSec" {
  name                = "LogicalDisk_ReadsPerSec"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Disk Reads/sec"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "LogicalDisk_TransfersPerSec" {
  name                = "LogicalDisk_TransfersPerSec"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Disk Transfers/sec"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "LogicalDisk_WritesPerSec" {
  name                = "LogicalDisk_WritesPerSec"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Disk Writes/sec"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "LogicalDisk_FreeMB" {
  name                = "LogicalDisk_FreeMB"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Free Megabytes"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "LogicalDisk_FreeSpace" {
  name                = "LogicalDisk_FreeSpace"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "% Free Space"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "Memory_AvailMbytes" {
  name                = "Memory_AvailMbytes"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "Memory"
  instance_name       = "*"
  counter_name        = "Available MBytes"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "Committed_BytesInUse" {
  name                = "Committed_BytesInUse"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "Memory"
  instance_name       = "*"
  counter_name        = "% Committed Bytes In Use"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "Bytes_Received_PerSec" {
  name                = "Bytes_Received_PerSec"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "Network Adapter"
  instance_name       = "*"
  counter_name        = "Bytes Received/sec"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "Bytes_Sent_PerSec" {
  name                = "Bytes_Sent_PerSec"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "Network Adapter"
  instance_name       = "*"
  counter_name        = "Bytes Sent/sec"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "Bytes_Total_PerSec" {
  name                = "Bytes_Total_PerSec"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "Network Interface"
  instance_name       = "*"
  counter_name        = "Bytes Total/sec"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "CPU_Time" {
  name                = "CPU_Time"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "Processor"
  instance_name       = "*"
  counter_name        = "% Processor Time"
  interval_seconds    = 10
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "CPU_QUEUE_Length" {
  name                = "CPU_QUEUE_Length"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  object_name         = "system"
  instance_name       = "*"
  counter_name        = "Processor Queue Length"
  interval_seconds    = 10
}

# activate windows event log datasource (application)
resource "azurerm_log_analytics_datasource_windows_event" "law-services-data-win-event-sec" {
  name                = "law-services-data-win-event-sec"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  event_log_name      = "Application"
  event_types         = ["Error"]
}

# activate windows event log datasource (system)
resource "azurerm_log_analytics_datasource_windows_event" "law-services-data-win-event-sys" {
  name                = "law-services-data-win-event-sys"
  resource_group_name = azurerm_resource_group.services.name
  workspace_name      = azurerm_log_analytics_workspace.law-services.name
  event_log_name      = "system"
  event_types         = ["Error"]
}

resource "azurerm_log_analytics_solution" "law_solution_changetracking" {
  resource_group_name   = azurerm_resource_group.services.name
  location              = var.location
  solution_name         = "ChangeTracking"
  workspace_resource_id = azurerm_log_analytics_workspace.law-services.id
  workspace_name        = azurerm_log_analytics_workspace.law-services.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ChangeTracking"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_log_analytics_solution" "law_solution_vminsights" {
  resource_group_name   = azurerm_resource_group.services.name
  location              = var.location
  solution_name         = "VMInsights"
  workspace_resource_id = azurerm_log_analytics_workspace.law-services.id
  workspace_name        = azurerm_log_analytics_workspace.law-services.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}