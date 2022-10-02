terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-statefile"
    storage_account_name = "statefilestorage002"
    container_name       = "statefile"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.92.0"
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