# Helm Base Template Repository Files
# This file contains all file resources specific to the Helm Base template

# .gitignore file
resource "github_repository_file" "helm_base_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-helm-base"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/helm-base/.gitignore.tpl")
  commit_message      = "Add Helm base skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Chart.yaml file
resource "github_repository_file" "helm_base_chart" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-helm-base"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/Chart.yaml"
  content             = file("${path.module}/templates/helm-base/skeleton/Chart.yaml.tpl")
  commit_message      = "Add Helm base skeleton Chart.yaml"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Values.yaml file
resource "github_repository_file" "helm_base_values" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-helm-base"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/values.yaml"
  content             = file("${path.module}/templates/helm-base/skeleton/values.yaml.tpl")
  commit_message      = "Add Helm base skeleton values.yaml"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# README file
resource "github_repository_file" "helm_base_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-helm-base"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/helm-base/skeleton/README.md.tpl")
  commit_message      = "Add Helm base skeleton README"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# DevContainer configuration
resource "github_repository_file" "helm_base_devcontainer" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-helm-base"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.devcontainer/devcontainer.json"
  content             = file("${path.module}/templates/helm-base/skeleton/.devcontainer/devcontainer.json.tpl")
  commit_message      = "Add Helm Base devcontainer configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration (basic for GitHub Actions)
resource "github_repository_file" "helm_base_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-helm-base"
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
