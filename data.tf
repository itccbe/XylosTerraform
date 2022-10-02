data "azurerm_resource_group" "terraform" {
  name = "terraform"
}

data "azurerm_client_config" "current" {}