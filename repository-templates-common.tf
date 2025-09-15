# Common Template Repository Files
# This file contains common file resources for all Backstage template repositories

# Shared commit configuration for all templates
locals {

  required_wf_files = fileset(path.module, "required_workflows/**")

  template_commit_config = {
    commit_author = "Terraform"
    commit_email  = "terraform@${var.github_organization}.com"
  }
}

# CODEOWNERS file for each template repository
resource "github_repository_file" "codeowners" {
  for_each = var.template_repositories

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = ".github/CODEOWNERS"
  content = templatefile("${path.module}/software_templates/CODEOWNERS.tpl", {
    platform_team      = "@${github_team.platform.slug}"
    template_approvers = "@${github_team.template_approvers.slug}"
  })
  commit_message      = "Add CODEOWNERS file for template protection"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}


# Reusable workflow file in the reusable-workflows repository
resource "github_repository_file" "reusable_ci_workflow" {
  repository          = github_repository.reusable_workflows.name
  branch              = "main"
  file                = ".github/workflows/ci-template.yml"
  content             = file("${path.module}/software_templates/reusable-ci-template.yml")
  commit_message      = "Add reusable CI/CD workflow for template validation"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.reusable_workflows]
}

# README file for the reusable-workflows repository
resource "github_repository_file" "reusable_workflows_readme" {
  repository = github_repository.reusable_workflows.name
  branch     = "main"
  file       = "README.md"
  content = templatefile("${path.module}/software_templates/reusable-workflows-README.md.tpl", {
    organization = var.github_organization
  })
  commit_message      = "Add README with reusable workflows documentation"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.reusable_workflows]
}

# CODEOWNERS file for the reusable-workflows repository
resource "github_repository_file" "reusable_workflows_codeowners" {
  repository = github_repository.reusable_workflows.name
  branch     = "main"
  file       = ".github/CODEOWNERS"
  content = templatefile("${path.module}/software_templates/CODEOWNERS.tpl", {
    platform_team      = "@${github_team.platform.slug}"
    template_approvers = "@${var.github_organization}/${github_team.template_approvers.slug}"
  })
  commit_message      = "Add CODEOWNERS file for workflow protection"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.reusable_workflows]
}

# GitHub Actions workflow for CI/CD in template repositories
resource "github_repository_file" "template_ci" {
  for_each = var.manage_workflow_files ? var.template_repositories : {}

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = ".github/workflows/ci-template.yml"
  content = templatefile("${path.module}/software_templates/ci-template-caller.yml", {
    organization = var.github_organization
  })
  commit_message      = "Add CI/CD workflow caller for template validation"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates, github_repository_file.reusable_ci_workflow]
}


# MkDocs configuration file for each template repository
resource "github_repository_file" "template_mkdocs" {
  # Excluimos backstage-template-node-service porque tiene un mkdocs.yml especializado
  for_each = { for k, v in var.template_repositories : k => v if k != "backstage-template-node-service" }

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "mkdocs.yml"
  content = templatefile("${path.module}/software_templates/mkdocs.yml.tpl", {
    template_name        = each.key
    template_title       = each.value.description
    template_description = each.value.description
    organization         = var.github_organization
    repo_url             = "https://github.com/${var.github_organization}/${each.key}"
    repo_name            = "${var.github_organization}/${each.key}"
  })
  commit_message      = "Add TechDocs MkDocs configuration for template repository"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}


# The folder required_workflow should be replicated inside the required_workflows repo
resource "github_repository_file" "required_wf_files" {
  for_each   = { for f in local.required_wf_files : f => f } # map file_path -> file_path
  repository = github_repository.required_workflows.name

  # destino en el repo: quitar el prefijo local "required_workflows/"
  file = replace(each.value, "required_workflows/", "")

  # contenido leído del archivo local
  content = file("${path.module}/${each.value}")

  branch         = "main"
  commit_message = "chore: add required workflow ${replace(each.value, "required_workflows/", "")}"
}
