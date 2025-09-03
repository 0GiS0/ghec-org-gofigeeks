# Node.js Service Template Repository Files
# This file contains all file resources specific to the Node.js Service template

# .gitignore file for Node.js Service template
resource "github_repository_file" "node_service_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-node-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/node-service/.gitignore.tpl")
  commit_message      = "Add Node.js service skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Package.json file
resource "github_repository_file" "node_service_package" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-node-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/package.json"
  content             = file("${path.module}/templates/node-service/package.json.tpl")
  commit_message      = "Add Node.js service skeleton package.json"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Main application file
resource "github_repository_file" "node_service_main" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-node-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/index.js"
  content             = file("${path.module}/templates/node-service/src/index.js.tpl")
  commit_message      = "Add Node.js service skeleton main file"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# DevContainer configuration
resource "github_repository_file" "node_service_devcontainer" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-node-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.devcontainer/devcontainer.json"
  content             = file("${path.module}/templates/node-service/.devcontainer/devcontainer.json.tpl")
  commit_message      = "Add Node.js service devcontainer configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Excursion model
resource "github_repository_file" "node_service_excursion_model" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-node-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/models/Excursion.js"
  content             = file("${path.module}/templates/node-service/src/models/Excursion.js.tpl")
  commit_message      = "Add Node.js service skeleton Excursion model"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Excursion controller
resource "github_repository_file" "node_service_excursion_controller" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-node-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/controllers/ExcursionController.js"
  content             = file("${path.module}/templates/node-service/src/controllers/ExcursionController.js.tpl")
  commit_message      = "Add Node.js service skeleton Excursion controller"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Excursion routes
resource "github_repository_file" "node_service_excursion_routes" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-node-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/routes/excursions.js"
  content             = file("${path.module}/templates/node-service/src/routes/excursions.js.tpl")
  commit_message      = "Add Node.js service skeleton excursions routes"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration for Node.js Service
resource "github_repository_file" "node_service_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-node-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/templates/node-service/.github/dependabot.yml")
  commit_message      = "Add Dependabot configuration for npm dependencies"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
