# Astro Frontend Template Repository Files
# This file contains all file resources specific to the Astro Frontend template

# .gitignore file
resource "github_repository_file" "astro_frontend_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/astro-frontend/.gitignore.tpl")
  commit_message      = "Add Astro frontend skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Package.json file
resource "github_repository_file" "astro_frontend_package" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/package.json"
  content             = file("${path.module}/templates/astro-frontend/skeleton/package.json.tpl")
  commit_message      = "Add Astro frontend skeleton package.json"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Astro configuration
resource "github_repository_file" "astro_frontend_config" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/astro.config.mjs"
  content             = file("${path.module}/templates/astro-frontend/skeleton/astro.config.mjs.tpl")
  commit_message      = "Add Astro frontend skeleton configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# README file
resource "github_repository_file" "astro_frontend_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/astro-frontend/skeleton/README.md.tpl")
  commit_message      = "Add Astro frontend skeleton README"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# API tests file
resource "github_repository_file" "astro_frontend_api_tests" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/api-tests.http"
  content             = file("${path.module}/templates/astro-frontend/skeleton/api-tests.http.tpl")
  commit_message      = "Add Astro frontend skeleton API tests"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# DevContainer configuration
resource "github_repository_file" "astro_frontend_devcontainer" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.devcontainer/devcontainer.json"
  content             = file("${path.module}/templates/astro-frontend/skeleton/.devcontainer/devcontainer.json.tpl")
  commit_message      = "Add Astro Frontend devcontainer configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration
resource "github_repository_file" "astro_frontend_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/templates/astro-frontend/skeleton/.github/dependabot.yml")
  commit_message      = "Add Dependabot configuration for npm dependencies"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template catalog-info.yaml (for Backstage template itself)
resource "github_repository_file" "astro_frontend_template_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "catalog-info.yaml"
  content = templatefile(
    "${path.module}/templates/astro-frontend/catalog-info.yaml.tpl",
    {
      github_organization = var.github_organization
    }
  )
  commit_message      = "Add Astro frontend template catalog-info.yaml for Backstage"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton catalog-info.yaml (for generated projects)
resource "github_repository_file" "astro_frontend_skeleton_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/catalog-info.yaml"
  content             = file("${path.module}/templates/astro-frontend/skeleton/catalog-info.yaml")
  commit_message      = "Add Astro frontend skeleton catalog-info.yaml"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template README (documentation)
resource "github_repository_file" "astro_frontend_template_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-astro-frontend"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = file("${path.module}/templates/astro-frontend/README.md")
  commit_message      = "Add Astro frontend template documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
