# GitHub Organization Variables
variable "github_organization" {
  description = "GitHub organization name"
  type        = string
}

# GitHub App Authentication Variables
variable "github_app_id" {
  description = "GitHub App ID for authentication"
  type        = string
  sensitive   = true
}

variable "github_app_installation_id" {
  description = "GitHub App Installation ID for the organization"
  type        = string
  sensitive   = true
}

variable "github_app_pem_file" {
  description = "Path to the GitHub App private key PEM file"
  type        = string
  sensitive   = true

  validation {
    condition     = fileexists(abspath(var.github_app_pem_file))
    error_message = "The GitHub App PEM file path is invalid or not readable."
  }
}

# Team Configuration Variables
variable "parent_team_name" {
  description = "Name of the parent team for all sub-teams"
  type        = string
  default     = "canary-trips"
}

variable "platform_team_members" {
  description = "List of platform team members (GitHub usernames)"
  type        = list(string)
  default     = []
}

variable "platform_team_maintainers" {
  description = "List of platform team maintainers (GitHub usernames)"
  type        = list(string)
  default     = []
}

variable "template_approvers_members" {
  description = "List of template approvers team members (GitHub usernames)"
  type        = list(string)
  default     = []
}

# New: Template approvers maintainers (users with elevated rights on the team)
variable "template_approvers_maintainers" {
  description = "List of template approvers team maintainers (GitHub usernames)"
  type        = list(string)
  default     = []
}

variable "security_team_members" {
  description = "List of security team members (GitHub usernames)"
  type        = list(string)
  default     = []
}

variable "read_only_team_members" {
  description = "List of read-only team members (GitHub usernames)"
  type        = list(string)
  default     = []
}

# Developers Team Variables
variable "developers_team_maintainers" {
  description = "List of developers team maintainers (GitHub usernames)"
  type        = list(string)
  default     = []
}

# Repository Configuration Variables
variable "template_repositories" {
  description = "Map of template repositories to create"
  type = map(object({
    description = string
    topics      = list(string)
    type        = string
  }))
  default = {
    "backstage-template-system" = {
      description = "Backstage template for System entities"
      topics      = ["backstage", "template", "catalog", "system"]
      type        = "system"
    }
    "backstage-template-domain" = {
      description = "Backstage template for Domain entities"
      topics      = ["backstage", "template", "catalog", "domain"]
      type        = "domain"
    }
    "backstage-template-node-service" = {
      description = "Backstage template for Node.js services"
      topics      = ["backstage", "template", "nodejs", "service"]
      type        = "service"
    }
    "backstage-template-fastapi-service" = {
      description = "Backstage template for FastAPI services"
      topics      = ["backstage", "template", "fastapi", "python", "service"]
      type        = "service"
    }
    "backstage-template-dotnet-service" = {
      description = "Backstage template for .NET services"
      topics      = ["backstage", "template", "dotnet", "csharp", "service"]
      type        = "service"
    }
    "backstage-template-gateway" = {
      description = "Backstage template for API Gateway"
      topics      = ["backstage", "template", "gateway", "api"]
      type        = "service"
    }
    "backstage-template-ai-assistant" = {
      description = "Backstage template for AI Assistant services"
      topics      = ["backstage", "template", "ai", "assistant", "service"]
      type        = "service"
    }
    "backstage-template-astro-frontend" = {
      description = "Backstage template for Astro frontend applications"
      topics      = ["backstage", "template", "astro", "frontend"]
      type        = "website"
    }
    "backstage-template-helm-base" = {
      description = "Backstage template for Helm charts"
      topics      = ["backstage", "template", "helm", "kubernetes"]
      type        = "resource"
    }
    "backstage-template-env-live" = {
      description = "Backstage template for environment configurations"
      topics      = ["backstage", "template", "environment", "config"]
      type        = "resource"
    }
  }
}

# Backstage IDP Repository Configuration
variable "backstage_repository" {
  description = "Configuration for the main Backstage IDP repository"
  type = object({
    name        = string
    description = string
    topics      = list(string)
  })
  default = {
    name        = "backstage"
    description = "Organization's Internal Developer Platform (IDP) powered by Backstage"
    topics      = ["backstage", "idp", "developer-platform", "portal"]
  }
}

# Reusable Workflows Repository Configuration
variable "reusable_workflows_repository" {
  description = "Configuration for the reusable workflows repository"
  type = object({
    name        = string
    description = string
    topics      = list(string)
  })
  default = {
    name        = "reusable-workflows"
    description = "Centralized repository for reusable GitHub Actions workflows"
    topics      = ["github-actions", "workflows", "ci-cd", "reusable"]
  }
}

# Branch Protection Variables
variable "required_status_checks" {
  description = "List of required status checks for branch protection"
  type        = list(string)
  default     = ["ci-template", "lint", "docs-build"]
}

variable "required_pull_request_reviews" {
  description = "Number of required pull request reviews"
  type        = number
  default     = 1
}

# Feature toggle: manage workflow files (.github/workflows)
variable "manage_workflow_files" {
  description = "Whether to manage CI workflow files in template repositories. Set false if the GitHub App lacks Actions: Read & write temporarily."
  type        = bool
  default     = true
}

# Optional: Organization Codespaces access control
variable "enable_codespaces_org_access" {
  description = "Enable managing organization-wide Codespaces access via GitHub REST API (requires appropriate token permissions)."
  type        = bool
  default     = false
}

variable "codespaces_visibility" {
  description = "Who can access Codespaces in the organization. One of: disabled, selected_members, all_members, all_members_and_outside_collaborators"
  type        = string
  default     = "all_members"

  validation {
    condition = contains([
      "disabled",
      "selected_members",
      "all_members",
      "all_members_and_outside_collaborators"
    ], var.codespaces_visibility)
    error_message = "codespaces_visibility must be one of: disabled, selected_members, all_members, all_members_and_outside_collaborators."
  }
}

variable "codespaces_selected_usernames" {
  description = "Usernames to grant Codespaces access when visibility = selected_members. Ignored otherwise."
  type        = list(string)
  default     = []
}

# Organization Security Settings Variables
variable "advanced_security_enabled_for_new_repositories" {
  description = "Whether or not GitHub Advanced Security is enabled for new repositories by default"
  type        = bool
  default     = true
}

variable "dependabot_alerts_enabled_for_new_repositories" {
  description = "Whether or not Dependabot alerts are enabled for new repositories by default"
  type        = bool
  default     = true
}

variable "dependabot_security_updates_enabled_for_new_repositories" {
  description = "Whether or not Dependabot security updates are enabled for new repositories by default"
  type        = bool
  default     = true
}

variable "dependency_graph_enabled_for_new_repositories" {
  description = "Whether or not dependency graph is enabled for new repositories by default"
  type        = bool
  default     = true
}

variable "secret_scanning_enabled_for_new_repositories" {
  description = "Whether or not secret scanning is enabled for new repositories by default"
  type        = bool
  default     = true
}

variable "secret_scanning_push_protection_enabled_for_new_repositories" {
  description = "Whether or not secret scanning push protection is enabled for new repositories by default"
  type        = bool
  default     = true
}

# Organization billing email (required for organization settings)
variable "github_organization_billing_email" {
  description = "Billing email address for the GitHub organization"
  type        = string
  default     = ""
}
