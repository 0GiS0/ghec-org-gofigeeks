# Common Template Repository Files
# This file contains common file resources for all Backstage template repositories

# CODEOWNERS file for each template repository
resource "github_repository_file" "codeowners" {
  for_each = var.template_repositories

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = ".github/CODEOWNERS"
  content = templatefile("${path.module}/templates/CODEOWNERS.tpl", {
    platform_team      = "@${github_team.platform.slug}"
    template_approvers = "@${github_team.template_approvers.slug}"
  })
  commit_message      = "Add CODEOWNERS file for template protection"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# CODEOWNERS file for Backstage repository
resource "github_repository_file" "backstage_codeowners" {
  repository = github_repository.backstage.name
  branch     = "main"
  file       = ".github/CODEOWNERS"
  content = templatefile("${path.module}/templates/CODEOWNERS-backstage.tpl", {
    platform_team      = "@${github_team.platform.slug}"
    template_approvers = "@${github_team.template_approvers.slug}"
  })
  commit_message      = "Add CODEOWNERS file for Backstage repository protection"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.backstage]
}

# README file for Backstage repository with setup instructions
resource "github_repository_file" "backstage_readme" {
  repository = github_repository.backstage.name
  branch     = "main"
  file       = "README.md"
  content = templatefile("${path.module}/templates/backstage-README.md.tpl", {
    organization = var.github_organization
  })
  commit_message      = "Add README with Backstage setup instructions"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.backstage]
}

# Reusable workflow file in the reusable-workflows repository
resource "github_repository_file" "reusable_ci_workflow" {
  repository          = github_repository.reusable_workflows.name
  branch              = "main"
  file                = ".github/workflows/ci-template.yml"
  content             = file("${path.module}/templates/reusable-ci-template.yml")
  commit_message      = "Add reusable CI/CD workflow for template validation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.reusable_workflows]
}

# README file for the reusable-workflows repository
resource "github_repository_file" "reusable_workflows_readme" {
  repository = github_repository.reusable_workflows.name
  branch     = "main"
  file       = "README.md"
  content = templatefile("${path.module}/templates/reusable-workflows-README.md.tpl", {
    organization = var.github_organization
  })
  commit_message      = "Add README with reusable workflows documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.reusable_workflows]
}

# CODEOWNERS file for the reusable-workflows repository
resource "github_repository_file" "reusable_workflows_codeowners" {
  repository = github_repository.reusable_workflows.name
  branch     = "main"
  file       = ".github/CODEOWNERS"
  content = templatefile("${path.module}/templates/CODEOWNERS.tpl", {
    platform_team      = "@${github_team.platform.slug}"
    template_approvers = "@${var.github_organization}/${github_team.template_approvers.slug}"
  })
  commit_message      = "Add CODEOWNERS file for workflow protection"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.reusable_workflows]
}

# GitHub Actions workflow for CI/CD in template repositories
resource "github_repository_file" "template_ci" {
  for_each = var.manage_workflow_files ? var.template_repositories : {}

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = ".github/workflows/ci-template.yml"
  content = templatefile("${path.module}/templates/ci-template-caller.yml", {
    organization = var.github_organization
  })
  commit_message      = "Add CI/CD workflow caller for template validation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates, github_repository_file.reusable_ci_workflow]
}

# Catalog info file for each template repository
resource "github_repository_file" "catalog_info" {
  for_each = var.template_repositories

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "catalog-info.yaml"
  content = templatefile("${path.module}/templates/catalog-info.yaml.tpl", {
    template_name        = each.key
    template_title       = each.value.description
    template_description = each.value.description
    template_tags        = each.value.topics
    template_type        = "service"
    organization         = var.github_organization
  })
  commit_message      = "Add Backstage catalog-info.yaml for template registration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# MkDocs configuration file for each template repository
resource "github_repository_file" "template_mkdocs" {
  for_each = var.template_repositories

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "mkdocs.yml"
  content = templatefile("${path.module}/templates/mkdocs.yml.tpl", {
    template_name        = each.key
    template_title       = each.value.description
    template_description = each.value.description
    organization         = var.github_organization
    repo_url             = "https://github.com/${var.github_organization}/${each.key}"
    repo_name            = "${var.github_organization}/${each.key}"
  })
  commit_message      = "Add TechDocs MkDocs configuration for template repository"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
