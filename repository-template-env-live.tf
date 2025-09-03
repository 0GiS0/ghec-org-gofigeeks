# Environment Live Template Repository Files
# This file contains all file resources specific to the Environment Live template

# .gitignore file
resource "github_repository_file" "env_live_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-env-live"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/env-live/.gitignore.tpl")
  commit_message      = "Add environment live skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Development environment configuration
resource "github_repository_file" "env_live_dev_config" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-env-live"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/environments/dev/config.yaml"
  content             = file("${path.module}/templates/env-live/skeleton/environments/dev/config.yaml.tpl")
  commit_message      = "Add environment live skeleton dev config"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Validation script
resource "github_repository_file" "env_live_validate_config" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-env-live"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/validate_config.py"
  content             = file("${path.module}/templates/env-live/skeleton/validate_config.py.tpl")
  commit_message      = "Add environment live skeleton validation script"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# README file
resource "github_repository_file" "env_live_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-env-live"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/env-live/skeleton/README.md.tpl")
  commit_message      = "Add environment live skeleton README"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# DevContainer configuration
resource "github_repository_file" "env_live_devcontainer" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-env-live"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.devcontainer/devcontainer.json"
  content             = file("${path.module}/templates/env-live/skeleton/.devcontainer/devcontainer.json.tpl")
  commit_message      = "Add Environment Live devcontainer configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration (basic for GitHub Actions)
resource "github_repository_file" "env_live_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-env-live"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/templates/common/docs/.github/dependabot.yml")
  commit_message      = "Add Dependabot configuration for GitHub Actions dependencies"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
