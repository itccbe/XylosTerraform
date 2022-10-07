output "law-workspace-id" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.workspace_id
}

output "law-id" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.id
}

output "law-name" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.name
}

output "aa-name" {
  value = azurerm_automation_account.automationaccount.name
}