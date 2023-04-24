# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  # Store remote state for future co-working. Additional st acc needed.
  # backend "azurerm" {
  #   storage_account_name = "<storage_account_name>"
  #   container_name       = "<container_name>"
  #   key                  = "terraform.tfstate"
  # }
  required_version = ">= 0.14.5"
}
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  # alternative approach to access ARM(az-cli)
  subscription_id= "f21f6baa-17bb-46c4-9f0c-82ebdb3a7412"
}
