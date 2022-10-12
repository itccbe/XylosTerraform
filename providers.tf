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
      version = "=2.99.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = "~> 1.3.2"
}

provider "azurerm" {
  features {}
}