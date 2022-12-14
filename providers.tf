terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-statefile"
    storage_account_name = "statefilestorage001"
    container_name       = "statefile"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "azurerm" {
  features {}
}
