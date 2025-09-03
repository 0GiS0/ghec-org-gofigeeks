# Gateway Template Repository Files
# This file contains all file resources specific to the Gateway template

# .gitignore file
resource "github_repository_file" "gateway_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-gateway"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/gateway/.gitignore.tpl")
  commit_message      = "Add gateway skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Kong configuration file
resource "github_repository_file" "gateway_kong_config" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-gateway"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/config/kong.yml"
  content             = file("${path.module}/templates/gateway/config/kong.yml.tpl")
  commit_message      = "Add gateway skeleton Kong configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Docker Compose file
resource "github_repository_file" "gateway_docker_compose" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-gateway"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/docker-compose.yml"
  content             = file("${path.module}/templates/gateway/skeleton/docker-compose.yml.tpl")
  commit_message      = "Add gateway skeleton Docker Compose file"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# README file
resource "github_repository_file" "gateway_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-gateway"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/gateway/skeleton/README.md.tpl")
  commit_message      = "Add gateway skeleton README"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# DevContainer configuration
resource "github_repository_file" "gateway_devcontainer" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-gateway"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.devcontainer/devcontainer.json"
  content             = file("${path.module}/templates/gateway/skeleton/.devcontainer/devcontainer.json.tpl")
  commit_message      = "Add Gateway devcontainer configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration
resource "github_repository_file" "gateway_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-gateway"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/templates/gateway/skeleton/.github/dependabot.yml")
  commit_message      = "Add Dependabot configuration for Docker dependencies"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
