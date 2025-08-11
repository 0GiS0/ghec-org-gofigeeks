# Template Repository Definitions
# This file contains all template repository configurations for Backstage

# Template repositories
resource "github_repository" "templates" {
  for_each = var.template_repositories

  name        = each.key
  description = each.value.description
  visibility  = "private"
  auto_init   = true

  # Repository topics
  topics = concat(each.value.topics, local.common_topics)

  # Template repository settings
  is_template            = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = false
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = false
  has_wiki               = false
  has_downloads          = false
  vulnerability_alerts   = true

  # Security settings
  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
    advanced_security {
      status = "enabled"
    }
  }
}

# Repository collaborators - Team permissions
resource "github_team_repository" "platform_admin" {
  for_each = var.template_repositories

  team_id    = github_team.platform.id
  repository = github_repository.templates[each.key].name
  permission = local.repository_permissions.platform_team
}

resource "github_team_repository" "template_approvers_maintain" {
  for_each = var.template_repositories

  team_id    = github_team.template_approvers.id
  repository = github_repository.templates[each.key].name
  permission = local.repository_permissions.template_approvers
}

resource "github_team_repository" "security_pull" {
  for_each = var.template_repositories

  team_id    = github_team.security.id
  repository = github_repository.templates[each.key].name
  permission = local.repository_permissions.security
}

resource "github_team_repository" "read_only_pull" {
  for_each = var.template_repositories

  team_id    = github_team.read_only.id
  repository = github_repository.templates[each.key].name
  permission = local.repository_permissions.read_only
}

# Branch protection rules for main branch
resource "github_branch_protection" "main" {
  for_each = var.template_repositories

  repository_id  = github_repository.templates[each.key].name
  pattern        = "main"
  enforce_admins = false

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks
  }

  required_pull_request_reviews {
    required_approving_review_count = var.required_pull_request_reviews
    dismiss_stale_reviews           = true
    restrict_dismissals             = true
    dismissal_restrictions = [
      github_team.platform.slug,
      github_team.template_approvers.slug
    ]
  }

  # Block force pushes
  allows_force_pushes = false
  allows_deletions    = false
}

# CODEOWNERS file for each repository
resource "github_repository_file" "codeowners" {
  for_each = var.template_repositories

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = ".github/CODEOWNERS"
  content = templatefile("${path.module}/templates/CODEOWNERS.tpl", {
    platform_team      = "@${var.github_organization}/${github_team.platform.slug}"
    template_approvers = "@${var.github_organization}/${github_team.template_approvers.slug}"
  })
  commit_message      = "Add CODEOWNERS file for template protection"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# GitHub Actions workflow for CI/CD in template repositories
resource "github_repository_file" "template_ci" {
  for_each = var.template_repositories

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = ".github/workflows/ci-template.yml"
  content             = file("${path.module}/templates/ci-template.yml")
  commit_message      = "Add CI/CD workflow for template validation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}