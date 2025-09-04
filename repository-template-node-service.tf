# Node.js Service Template Repository Files
# This file contains all file resources specific to the Node.js Service template

locals {
  # Template-specific configuration
  node_service_key = "backstage-template-node-service"

  # Check if the Node.js service template is enabled
  node_service_enabled = contains(keys(var.template_repositories), local.node_service_key)

  # Common commit configuration
  commit_config = {
    commit_author = "Terraform"
    commit_email  = "terraform@${var.github_organization}.com"
  }

  # Template-specific file mappings
  node_service_files = local.node_service_enabled ? {
    # Dependabot configurations
    "skeleton/.github/dependabot.yml" = {
      source_file    = "${path.module}/templates/node-service/skeleton/.github/dependabot.yml"
      commit_message = "Add Dependabot configuration for npm dependencies to skeleton"
    }
    ".github/dependabot.yml" = {
      source_file    = "${path.module}/templates/node-service/.github/dependabot.yml"
      commit_message = "Add Dependabot configuration for template repository"
    }

    # CI/CD workflow
    "skeleton/.github/workflows/ci.yml" = {
      source_file    = "${path.module}/templates/node-service/skeleton/.github/workflows/ci.yml"
      commit_message = "Add CI workflow for Node.js service template to skeleton"
    }

    # Development configuration
    "skeleton/.gitignore" = {
      source_file    = "${path.module}/templates/node-service/skeleton/.gitignore"
      commit_message = "Add Node.js service skeleton .gitignore"
    }

    # Application files
    "skeleton/package.json" = {
      source_file    = "${path.module}/templates/node-service/skeleton/package.json"
      commit_message = "Add Node.js service skeleton package.json"
    }
    "skeleton/package-lock.json" = {
      source_file    = "${path.module}/templates/node-service/skeleton/package-lock.json"
      commit_message = "Add Node.js service skeleton package-lock.json"
    }
    "skeleton/src/index.js" = {
      source_file    = "${path.module}/templates/node-service/skeleton/src/index.js"
      commit_message = "Add Node.js service skeleton main file"
    }

    # API and testing files
    "skeleton/api.http" = {
      source_file    = "${path.module}/templates/node-service/skeleton/api.http"
      commit_message = "Add Node.js service skeleton API testing file"
    }

    # Business logic files
    "skeleton/src/models/Excursion.js" = {
      source_file    = "${path.module}/templates/node-service/skeleton/src/models/Excursion.js"
      commit_message = "Add Node.js service skeleton Excursion model"
    }
    "skeleton/src/controllers/ExcursionController.js" = {
      source_file    = "${path.module}/templates/node-service/skeleton/src/controllers/ExcursionController.js"
      commit_message = "Add Node.js service skeleton Excursion controller"
    }
    "skeleton/src/routes/excursions.js" = {
      source_file    = "${path.module}/templates/node-service/skeleton/src/routes/excursions.js"
      commit_message = "Add Node.js service skeleton excursions routes"
    }

    # Documentation and metadata
    "README.md" = {
      source_file    = "${path.module}/templates/node-service/README.md"
      commit_message = "Add Node.js service template documentation"
    }
    "docs/index.md" = {
      source_file    = "${path.module}/templates/node-service/docs/index.md"
      commit_message = "Add Node.js service template documentation index"
    }
    "docs/template-usage.md" = {
      source_file    = "${path.module}/templates/node-service/docs/template-usage.md"
      commit_message = "Add Node.js service template usage guide"
    }
    "mkdocs.yml" = {
      source_file    = "${path.module}/templates/node-service/mkdocs.yml"
      commit_message = "Add Node.js service template mkdocs configuration"
    }
  } : {}

  # Template files that need template processing - using consistent structure
  node_service_template_files = local.node_service_enabled ? {
    # Skeleton template files that need variable substitution
    "skeleton/.env.example" = {
      source_file      = "${path.module}/templates/node-service/skeleton/.env.example.tpl"
      commit_message   = "Add Node.js service skeleton environment variables template"
      use_templatefile = false
      template_vars    = {}
    }
    "skeleton/README.md" = {
      source_file      = "${path.module}/templates/node-service/skeleton/README.md"
      commit_message   = "Add Node.js service skeleton README"
      use_templatefile = false
      template_vars    = {}
    }
    "skeleton/tests/api.test.js" = {
      source_file      = "${path.module}/templates/node-service/skeleton/tests/api.test.js"
      commit_message   = "Add Node.js service skeleton API tests"
      use_templatefile = false
      template_vars    = {}
    }

    # Devcontainer configuration template
    "skeleton/.devcontainer/devcontainer.json" = {
      source_file      = "${path.module}/templates/node-service/skeleton/.devcontainer/devcontainer.json"
      commit_message   = "Add Node.js service devcontainer configuration"
      use_templatefile = false
      template_vars    = {}
    }

    # Catalog info files
    "skeleton/catalog-info.yaml" = {
      source_file      = "${path.module}/templates/node-service/skeleton/catalog-info.yaml"
      commit_message   = "Add Node.js service skeleton catalog-info.yaml"
      use_templatefile = false
      template_vars    = {}
    }
    "catalog-info.yaml" = {
      source_file      = "${path.module}/templates/node-service/catalog-info.yaml.tpl"
      commit_message   = "Add Node.js service template catalog-info.yaml for Backstage"
      use_templatefile = true
      template_vars = {
        github_organization = var.github_organization
      }
    }
  } : {}
}

# Regular file resources (direct file content)
resource "github_repository_file" "node_service_files" {
  for_each = local.node_service_files

  repository          = github_repository.templates[local.node_service_key].name
  branch              = "main"
  file                = each.key
  content             = file(each.value.source_file)
  commit_message      = each.value.commit_message
  commit_author       = local.commit_config.commit_author
  commit_email        = local.commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template file resources (files that need template processing)
resource "github_repository_file" "node_service_template_files" {
  for_each = local.node_service_template_files

  repository = github_repository.templates[local.node_service_key].name
  branch     = "main"
  file       = each.key
  content = each.value.use_templatefile ? templatefile(
    each.value.source_file,
    each.value.template_vars
  ) : file(each.value.source_file)
  commit_message      = each.value.commit_message
  commit_author       = local.commit_config.commit_author
  commit_email        = local.commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
