# FastAPI Service Template Repository Files
# This file contains all file resources specific to the FastAPI Service template

# .gitignore file for FastAPI Service template
resource "github_repository_file" "fastapi_service_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/fastapi-service/.gitignore.tpl")
  commit_message      = "Add FastAPI service skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Main application file
resource "github_repository_file" "fastapi_service_main" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/app/main.py"
  content             = file("${path.module}/templates/fastapi-service/app/main.py.tpl")
  commit_message      = "Add FastAPI service skeleton main file"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Requirements file
resource "github_repository_file" "fastapi_service_requirements" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "skeleton/requirements.txt"
  content = templatefile("${path.module}/templates/fastapi-service/requirements.txt.tpl", {
  })
  commit_message      = "Add FastAPI service skeleton requirements"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Development requirements file
resource "github_repository_file" "fastapi_service_requirements_dev" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/requirements-dev.txt"
  content             = file("${path.module}/templates/fastapi-service/requirements-dev.txt.tpl")
  commit_message      = "Add FastAPI service skeleton dev requirements"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Environment example file
resource "github_repository_file" "fastapi_service_env_example" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.env.example"
  content             = file("${path.module}/templates/fastapi-service/.env.example.tpl")
  commit_message      = "Add FastAPI service skeleton .env.example"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# README file
resource "github_repository_file" "fastapi_service_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/fastapi-service/README.md.tpl")
  commit_message      = "Add FastAPI service skeleton README"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# API tests file
resource "github_repository_file" "fastapi_service_api_http" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/api.http"
  content             = file("${path.module}/templates/fastapi-service/api.http.tpl")
  commit_message      = "Add FastAPI service skeleton API tests"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# AI agents documentation
resource "github_repository_file" "fastapi_service_agents_md" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/AGENTS.md"
  content             = file("${path.module}/templates/fastapi-service/AGENTS.md.tpl")
  commit_message      = "Add FastAPI service skeleton AI agents documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Backstage catalog info
resource "github_repository_file" "fastapi_service_catalog_info" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/catalog-info.yaml"
  content             = file("${path.module}/templates/fastapi-service/catalog-info.yaml.tpl")
  commit_message      = "Add FastAPI service skeleton Backstage catalog info"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# MkDocs configuration
resource "github_repository_file" "fastapi_service_mkdocs_yml" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/mkdocs.yml"
  content             = file("${path.module}/templates/fastapi-service/mkdocs.yml.tpl")
  commit_message      = "Add FastAPI service skeleton MkDocs configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# DevContainer configuration
resource "github_repository_file" "fastapi_service_devcontainer" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.devcontainer/devcontainer.json"
  content             = file("${path.module}/templates/fastapi-service/.devcontainer/devcontainer.json.tpl")
  commit_message      = "Add FastAPI service devcontainer configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Application structure
resource "github_repository_file" "fastapi_service_app_init" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/app/__init__.py"
  content             = file("${path.module}/templates/fastapi-service/app/__init__.py.tpl")
  commit_message      = "Add FastAPI service skeleton app __init__.py"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Models
resource "github_repository_file" "fastapi_service_models_init" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/app/models/__init__.py"
  content             = file("${path.module}/templates/fastapi-service/app/models/__init__.py.tpl")
  commit_message      = "Add FastAPI service skeleton models __init__.py"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "fastapi_service_excursion_model" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/app/models/excursion.py"
  content             = file("${path.module}/templates/fastapi-service/app/models/excursion.py.tpl")
  commit_message      = "Add FastAPI service skeleton excursion model"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Routers
resource "github_repository_file" "fastapi_service_routers_init" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/app/routers/__init__.py"
  content             = file("${path.module}/templates/fastapi-service/app/routers/__init__.py.tpl")
  commit_message      = "Add FastAPI service skeleton routers __init__.py"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "fastapi_service_excursion_router" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/app/routers/excursions.py"
  content             = file("${path.module}/templates/fastapi-service/app/routers/excursions.py.tpl")
  commit_message      = "Add FastAPI service skeleton excursions router"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Tests
resource "github_repository_file" "fastapi_service_test_api" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/tests/test_api.py"
  content             = file("${path.module}/templates/fastapi-service/tests/test_api.py.tpl")
  commit_message      = "Add FastAPI service skeleton tests"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Documentation
resource "github_repository_file" "fastapi_service_docs_index" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/docs/index.md"
  content             = file("${path.module}/templates/fastapi-service/docs/index.md.tpl")
  commit_message      = "Add FastAPI service skeleton documentation index"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "fastapi_service_docs_api_reference" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/docs/api-reference.md"
  content             = file("${path.module}/templates/fastapi-service/docs/api-reference.md.tpl")
  commit_message      = "Add FastAPI service skeleton API reference documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "fastapi_service_docs_getting_started" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/docs/getting-started.md"
  content             = file("${path.module}/templates/fastapi-service/docs/getting-started.md.tpl")
  commit_message      = "Add FastAPI service skeleton getting started documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# CI workflow
resource "github_repository_file" "fastapi_service_ci_workflow" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.github/workflows/ci.yml"
  content             = file("${path.module}/templates/fastapi-service/.github/workflows/ci.yml")
  commit_message      = "Add FastAPI service skeleton CI workflow"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration
resource "github_repository_file" "fastapi_service_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-fastapi-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/templates/fastapi-service/.github/dependabot.yml")
  commit_message      = "Add Dependabot configuration for pip dependencies"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
