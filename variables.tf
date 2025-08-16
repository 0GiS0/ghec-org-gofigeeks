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

# Repository Configuration Variables
variable "template_repositories" {
  description = "Map of template repositories to create"
  type = map(object({
    description = string
    topics      = list(string)
  }))
  default = {
    "backstage-template-node-service" = {
      description = "Backstage template for Node.js services"
      topics      = ["backstage", "template", "nodejs", "service"]
    }
    "backstage-template-fastapi-service" = {
      description = "Backstage template for FastAPI services"
      topics      = ["backstage", "template", "fastapi", "python", "service"]
    }
    "backstage-template-dotnet-service" = {
      description = "Backstage template for .NET services"
      topics      = ["backstage", "template", "dotnet", "csharp", "service"]
    }
    "backstage-template-gateway" = {
      description = "Backstage template for API Gateway"
      topics      = ["backstage", "template", "gateway", "api"]
    }
    "backstage-template-ai-assistant" = {
      description = "Backstage template for AI Assistant services"
      topics      = ["backstage", "template", "ai", "assistant", "service"]
    }
    "backstage-template-astro-frontend" = {
      description = "Backstage template for Astro frontend applications"
      topics      = ["backstage", "template", "astro", "frontend"]
    }
    "backstage-template-helm-base" = {
      description = "Backstage template for Helm charts"
      topics      = ["backstage", "template", "helm", "kubernetes"]
    }
    "backstage-template-env-live" = {
      description = "Backstage template for environment configurations"
      topics      = ["backstage", "template", "environment", "config"]
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

# Branch Protection Variables
variable "required_status_checks" {
  description = "List of required status checks for branch protection"
  type        = list(string)
  default     = ["ci-template", "lint", "docs-build", "codeql"]
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
