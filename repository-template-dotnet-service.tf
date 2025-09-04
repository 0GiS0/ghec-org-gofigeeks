# .NET Service Template Repository Files
# This file contains all file resources specific to the .NET Service template

# .gitignore file
resource "github_repository_file" "dotnet_service_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/dotnet-service/skeleton/.gitignore.tpl")
  commit_message      = "Add .NET service skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Main program file
resource "github_repository_file" "dotnet_service_program" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/Program.cs"
  content             = file("${path.module}/templates/dotnet-service/skeleton/src/Program.cs.tpl")
  commit_message      = "Add .NET service skeleton Program.cs"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Project file
resource "github_repository_file" "dotnet_service_csproj" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/Service.csproj"
  content             = file("${path.module}/templates/dotnet-service/skeleton/src/Service.csproj.tpl")
  commit_message      = "Add .NET service skeleton project file"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# README file
resource "github_repository_file" "dotnet_service_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/dotnet-service/skeleton/README.md.tpl")
  commit_message      = "Add .NET service skeleton README"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Controllers
resource "github_repository_file" "dotnet_service_hello_controller" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/Controllers/HelloController.cs"
  content             = file("${path.module}/templates/dotnet-service/skeleton/src/Controllers/HelloController.cs.tpl")
  commit_message      = "Add .NET service skeleton Hello controller"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "dotnet_service_status_controller" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/Controllers/StatusController.cs"
  content             = file("${path.module}/templates/dotnet-service/skeleton/src/Controllers/StatusController.cs.tpl")
  commit_message      = "Add .NET service skeleton Status controller"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "dotnet_service_excursions_controller" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/Controllers/ExcursionsController.cs"
  content             = file("${path.module}/templates/dotnet-service/skeleton/src/Controllers/ExcursionsController.cs.tpl")
  commit_message      = "Add .NET service skeleton Excursions controller"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "dotnet_service_health_controller" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/Controllers/HealthController.cs"
  content             = file("${path.module}/templates/dotnet-service/skeleton/src/Controllers/HealthController.cs.tpl")
  commit_message      = "Add .NET service skeleton health controller"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Models
resource "github_repository_file" "dotnet_service_models" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/src/Models/ApiModels.cs"
  content             = file("${path.module}/templates/dotnet-service/skeleton/src/Models/ApiModels.cs.tpl")
  commit_message      = "Add .NET service skeleton API models"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# DevContainer configuration
resource "github_repository_file" "dotnet_service_devcontainer" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.devcontainer/devcontainer.json"
  content             = file("${path.module}/templates/dotnet-service/skeleton/.devcontainer/devcontainer.json.tpl")
  commit_message      = "Add .NET service skeleton devcontainer configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Test project
resource "github_repository_file" "dotnet_service_test_project" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/tests/Service.Tests.csproj"
  content             = file("${path.module}/templates/dotnet-service/skeleton/tests/Service.Tests.csproj.tpl")
  commit_message      = "Add .NET service skeleton test project file"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# API tests
resource "github_repository_file" "dotnet_service_api_tests" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/tests/ApiTests.cs"
  content             = file("${path.module}/templates/dotnet-service/skeleton/tests/ApiTests.cs.tpl")
  commit_message      = "Add .NET service skeleton API tests"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration
resource "github_repository_file" "dotnet_service_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/templates/dotnet-service/skeleton/.github/dependabot.yml")
  commit_message      = "Add Dependabot configuration for NuGet dependencies"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template catalog-info.yaml (for Backstage template itself)
resource "github_repository_file" "dotnet_service_template_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "catalog-info.yaml"
  content = templatefile(
    "${path.module}/templates/dotnet-service/catalog-info.yaml.tpl",
    {
      github_organization = var.github_organization
    }
  )
  commit_message      = "Add .NET service template catalog-info.yaml for Backstage"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton catalog-info.yaml (for generated projects)
resource "github_repository_file" "dotnet_service_skeleton_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/catalog-info.yaml"
  content             = file("${path.module}/templates/dotnet-service/skeleton/catalog-info.yaml")
  commit_message      = "Add .NET service skeleton catalog-info.yaml"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template README (documentation)
resource "github_repository_file" "dotnet_service_template_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-dotnet-service"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = file("${path.module}/templates/dotnet-service/README.md")
  commit_message      = "Add .NET service template documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
