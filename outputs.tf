output "law-id" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.workspace_id
}

output "law-key" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.primary_shared_key
}

output "law-name" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.name
}

output "aa-name" {
  value = azurerm_automation_account.automationaccount.name
}