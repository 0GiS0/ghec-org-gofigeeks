terraform {
  required_version = ">= 1.6"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
  }

  # Backend configuration for remote state
  # This should be configured based on your infrastructure
  # Example for Terraform Cloud:
  # cloud {
  #   organization = "your-org"
  #   workspaces {
  #     name = "ghec-org-as-code"
  #   }
  # }

  # Example for S3 backend:
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "ghec-org-as-code/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

# Configure the GitHub Provider with GitHub App authentication
provider "github" {
  # GitHub App configuration
  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_pem_file
  }

  # Organization to manage
  owner = var.github_organization

  # Optional: Set base URL for GitHub Enterprise Server
  # base_url = "https://github.yourcompany.com/api/v3/"
}