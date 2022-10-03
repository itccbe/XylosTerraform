output "law-id" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.workspace_id
}

output "law-key" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.primary_shared_key
}

output "law-name" {
  value = azurerm_log_analytics_workspace.loganalyticsworkspace.name
}

output "vault-name" {
  value = azurerm_recovery_services_vault.keyvault.name
}

output "aa-name" {
  value = azurerm_automation_account.automationaccount.name
}

output "rg-name" {
  value = azurerm_resource_group.terraform.name
}

output "rg-id" {
  value = azurerm_resource_group.terraform.id
}

output "diagblob_endpoint" {
  value = azurerm_storage_account.bootdiags.primary_blob_endpoint
}

output "diagnostics-sa-id" {
  value = azurerm_storage_account.gendiags.id
}