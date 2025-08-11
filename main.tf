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
}