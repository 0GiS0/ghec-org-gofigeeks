# Main configuration file for GHEC Organization as Code
# This file serves as the entry point and includes data sources and locals

# Data source to get current organization information
data "github_organization" "current" {
  name = var.github_organization
}

# Local values for reusable configurations
locals {
  # Common tags for all resources
  common_topics = ["ghec", "terraform", "iac"]

  # Team names
  team_names = {
    parent             = var.parent_team_name
    platform           = "platform-team"
    template_approvers = "template-approvers"
    security           = "security"
    read_only          = "read-only"
  }

  # Repository permissions for teams
  repository_permissions = {
    platform_team      = "admin"
    template_approvers = "maintain"
    security           = "pull"
    read_only          = "pull"
  }

  # Template type mapping for catalog-info.yaml
  template_type_mapping = {
    "backstage-template-node-service"    = "service"
    "backstage-template-fastapi-service" = "service"
    "backstage-template-dotnet-service"  = "service"
    "backstage-template-gateway"         = "service"
    "backstage-template-ai-assistant"    = "service"
    "backstage-template-astro-frontend"  = "website"
    "backstage-template-helm-base"       = "library"
    "backstage-template-env-live"        = "resource"
  }

  # Helper function to convert repository name to template name
  template_name_mapping = {
    for key, value in var.template_repositories :
    key => replace(key, "backstage-template-", "")
  }

  # Helper function to create template titles
  template_title_mapping = {
    "backstage-template-node-service"    = "Node.js Service"
    "backstage-template-fastapi-service" = "FastAPI Service"
    "backstage-template-dotnet-service"  = ".NET Service"
    "backstage-template-gateway"         = "API Gateway"
    "backstage-template-ai-assistant"    = "AI Assistant Service"
    "backstage-template-astro-frontend"  = "Astro Frontend"
    "backstage-template-helm-base"       = "Helm Chart"
    "backstage-template-env-live"        = "Environment Configuration"
  }
}