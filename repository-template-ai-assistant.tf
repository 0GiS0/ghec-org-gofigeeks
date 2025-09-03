# AI Assistant Template Repository Files
# This file contains all file resources specific to the AI Assistant template

# .gitignore file
resource "github_repository_file" "ai_assistant_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/ai-assistant/.gitignore.tpl")
  commit_message      = "Add AI assistant skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Main application file
resource "github_repository_file" "ai_assistant_main" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/main.py"
  content             = file("${path.module}/templates/ai-assistant/skeleton/src/main.py.tpl")
  commit_message      = "Add AI assistant skeleton main file"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Requirements file
resource "github_repository_file" "ai_assistant_requirements" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/requirements.txt"
  content             = file("${path.module}/templates/ai-assistant/skeleton/requirements.txt.tpl")
  commit_message      = "Add AI assistant skeleton requirements"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# README file
resource "github_repository_file" "ai_assistant_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/ai-assistant/skeleton/README.md.tpl")
  commit_message      = "Add AI assistant skeleton README"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# API tests file
resource "github_repository_file" "ai_assistant_api_tests" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/api-tests.http"
  content             = file("${path.module}/templates/ai-assistant/skeleton/api-tests.http.tpl")
  commit_message      = "Add AI assistant skeleton API tests"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# DevContainer configuration
resource "github_repository_file" "ai_assistant_devcontainer" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.devcontainer/devcontainer.json"
  content             = file("${path.module}/templates/ai-assistant/skeleton/.devcontainer/devcontainer.json.tpl")
  commit_message      = "Add AI Assistant devcontainer configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration
resource "github_repository_file" "ai_assistant_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/templates/ai-assistant/skeleton/.github/dependabot.yml")
  commit_message      = "Add Dependabot configuration for pip dependencies"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
