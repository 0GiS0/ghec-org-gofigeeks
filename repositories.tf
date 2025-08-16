# Repository Definitions
# This file contains all repository configurations for Backstage (templates and main IDP)

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

# Main Backstage IDP Repository
resource "github_repository" "backstage" {
  name        = var.backstage_repository.name
  description = var.backstage_repository.description
  visibility  = "private"
  auto_init   = true

  # Repository topics
  topics = concat(var.backstage_repository.topics, local.common_topics)

  # Regular repository settings (NOT a template)
  is_template            = false
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

# Backstage IDP Repository - Team permissions
resource "github_team_repository" "backstage_platform_admin" {
  team_id    = github_team.platform.id
  repository = github_repository.backstage.name
  permission = local.repository_permissions.platform_team
}

resource "github_team_repository" "backstage_template_approvers_maintain" {
  team_id    = github_team.template_approvers.id
  repository = github_repository.backstage.name
  permission = local.repository_permissions.template_approvers
}

resource "github_team_repository" "backstage_security_pull" {
  team_id    = github_team.security.id
  repository = github_repository.backstage.name
  permission = local.repository_permissions.security
}

resource "github_team_repository" "backstage_read_only_pull" {
  team_id    = github_team.read_only.id
  repository = github_repository.backstage.name
  permission = local.repository_permissions.read_only
}

# Branch protection rules for main branch
resource "github_branch_protection" "main" {
  for_each = var.template_repositories

  repository_id  = github_repository.templates[each.key].name
  pattern        = "main"
  enforce_admins = false

  # Ensure required files/workflows exist before enforcing protection
  depends_on = [
    github_repository_file.codeowners,
    github_repository_file.template_ci,
    github_repository_file.catalog_info
  ]

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks
  }

  required_pull_request_reviews {
    required_approving_review_count = var.required_pull_request_reviews
    dismiss_stale_reviews           = true
    restrict_dismissals             = true
    # Use node_id per provider docs to satisfy GraphQL API
    dismissal_restrictions = [
      github_team.platform.node_id,
      github_team.template_approvers.node_id
    ]
  }

  # Block force pushes
  allows_force_pushes = false
  allows_deletions    = false
}

# Branch protection rules for Backstage repository main branch
resource "github_branch_protection" "backstage_main" {
  repository_id  = github_repository.backstage.name
  pattern        = "main"
  enforce_admins = false

  # Ensure CODEOWNERS/README are created before protection
  depends_on = [
    github_repository_file.backstage_codeowners,
    github_repository_file.backstage_readme
  ]

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks
  }

  required_pull_request_reviews {
    required_approving_review_count = var.required_pull_request_reviews
    dismiss_stale_reviews           = true
    restrict_dismissals             = true
    dismissal_restrictions = [
      github_team.platform.node_id,
      github_team.template_approvers.node_id
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

# CODEOWNERS file for Backstage repository
resource "github_repository_file" "backstage_codeowners" {
  repository = github_repository.backstage.name
  branch     = "main"
  file       = ".github/CODEOWNERS"
  content = templatefile("${path.module}/templates/CODEOWNERS-backstage.tpl", {
    platform_team      = "@${var.github_organization}/${github_team.platform.slug}"
    template_approvers = "@${var.github_organization}/${github_team.template_approvers.slug}"
  })
  commit_message      = "Add CODEOWNERS file for Backstage repository protection"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.backstage]
}

# README file for Backstage repository with setup instructions
resource "github_repository_file" "backstage_readme" {
  repository = github_repository.backstage.name
  branch     = "main"
  file       = "README.md"
  content = templatefile("${path.module}/templates/backstage-README.md.tpl", {
    organization = var.github_organization
  })
  commit_message      = "Add README with Backstage setup instructions"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.backstage]
}

# GitHub Actions workflow for CI/CD in template repositories
resource "github_repository_file" "template_ci" {
  for_each = var.manage_workflow_files ? var.template_repositories : {}

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

# Catalog info file for each template repository
resource "github_repository_file" "catalog_info" {
  for_each = var.template_repositories

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "catalog-info.yaml"
  content = templatefile("${path.module}/templates/catalog-info.yaml.tpl", {
    template_name        = local.template_name_mapping[each.key]
    template_title       = local.template_title_mapping[each.key]
    template_description = each.value.description
    template_tags        = each.value.topics
    template_type        = local.template_type_mapping[each.key]
    organization         = var.github_organization
  })
  commit_message      = "Add Backstage catalog-info.yaml for template registration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}