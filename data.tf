# data "azurerm_subnet" "subnet1" {
#   name                 = "subnet1"
#   virtual_network_name = azurerm_virtual_network.virtualnetwork.name
#   resource_group_name  = var.resource_group_name
# }

data "azurerm_client_config" "current" {}