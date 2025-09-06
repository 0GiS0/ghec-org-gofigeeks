terraform {
  required_version = ">= 1.6"

  # backend "remote" {
  #   organization = "returngisorg"

  #   workspaces {
  #     name = "ghec-org-as-code"
  #   }
  # }

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0"
    }

  }

  # Backend configuration for remote state
  # This should be configured based on your infrastructure
  # Example for Azure Storage backend:
  # backend "azurerm" {
  #   resource_group_name  = "your-terraform-rg"
  #   storage_account_name = "yourtfstatestorage"
  #   container_name       = "tfstate"
  #   key                  = "ghec-org-as-code.terraform.tfstate"
  # }
}

# Configure the GitHub Provider with GitHub App authentication
provider "github" {
  # GitHub App configuration
  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_private_key
  }

  # Organization to manage
  owner = var.github_organization

  # Optional: Set base URL for GitHub Enterprise Server
  # base_url = "https://github.yourcompany.com/api/v3/"
}
