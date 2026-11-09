terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  #need to change this to the real data after applying bootstrap stage
  backend "azurerm" {
    resource_group_name  = "<BOOTSTRAP_OUTPUT_RG_NAME>"
    storage_account_name = "<BOOTSTRAP_OUTPUT_STORAGE_ACCOUNT>"
    container_name       = "tfstate"
    key                  = "workload.hubspoke.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

