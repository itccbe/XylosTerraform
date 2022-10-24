# data "azurerm_resource_group" "terraform" {
#   name = "terraform"
# }

# data "azurerm_subnet" "subnet1" {
#   name                 = "subnet1"
#   virtual_network_name = azurerm_virtual_network.virtualnetwork.name
#   resource_group_name  = data.azurerm_resource_group.terraform.name
# }

data "azurerm_client_config" "current" {}