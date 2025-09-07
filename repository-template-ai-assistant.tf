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
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
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
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
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
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
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
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
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
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
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
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
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
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template catalog-info.yaml (for Backstage template itself)
resource "github_repository_file" "ai_assistant_template_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "catalog-info.yaml"
  content = templatefile(
    "${path.module}/templates/ai-assistant/catalog-info.yaml.tpl",
    {
      github_organization = var.github_organization
    }
  )
  commit_message      = "Add AI assistant template catalog-info.yaml for Backstage"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton catalog-info.yaml (for generated projects)
resource "github_repository_file" "ai_assistant_skeleton_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/catalog-info.yaml"
  content             = file("${path.module}/templates/ai-assistant/skeleton/catalog-info.yaml")
  commit_message      = "Add AI assistant skeleton catalog-info.yaml"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template README (documentation)
resource "github_repository_file" "ai_assistant_template_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = file("${path.module}/templates/ai-assistant/README.md")
  commit_message      = "Add AI assistant template documentation"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template documentation - main index
resource "github_repository_file" "ai_assistant_docs_index" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "docs/index.md"
  content             = file("${path.module}/templates/ai-assistant/docs/index.md")
  commit_message      = "Add AI assistant template documentation index"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template documentation - usage guide
resource "github_repository_file" "ai_assistant_docs_usage" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "docs/template-usage.md"
  content             = file("${path.module}/templates/ai-assistant/docs/template-usage.md")
  commit_message      = "Add AI assistant template usage guide"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template mkdocs.yml configuration
resource "github_repository_file" "ai_assistant_mkdocs" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-ai-assistant"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "mkdocs.yml"
  content             = file("${path.module}/templates/ai-assistant/mkdocs.yml")
  commit_message      = "Add AI assistant template mkdocs configuration"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
