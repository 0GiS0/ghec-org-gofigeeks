# Generic Templates (System and Domain) Repository Files
# This file contains shared file resources for System and Domain templates

# CODEOWNERS file for generic templates
resource "github_repository_file" "generic_template_codeowners" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if contains(["backstage-template-system", "backstage-template-domain"], key)
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.github/CODEOWNERS"
  content             = file("${path.module}/templates/common/CODEOWNERS.tpl")
  commit_message      = "Add generic skeleton CODEOWNERS"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# MkDocs configuration for generic templates
resource "github_repository_file" "generic_template_mkdocs" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if contains(["backstage-template-system", "backstage-template-domain"], key)
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/mkdocs.yml"
  content             = file("${path.module}/templates/common/mkdocs.yml.tpl")
  commit_message      = "Add generic skeleton MkDocs configuration"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Documentation files for generic templates
resource "github_repository_file" "generic_template_docs_index" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if contains(["backstage-template-system", "backstage-template-domain"], key)
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/docs/index.md"
  content             = file("${path.module}/templates/common/docs/index.md.tpl")
  commit_message      = "Add generic skeleton documentation index"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "generic_template_docs_architecture" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if contains(["backstage-template-system", "backstage-template-domain"], key)
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/docs/architecture.md"
  content             = file("${path.module}/templates/common/docs/architecture.md.tpl")
  commit_message      = "Add generic skeleton architecture documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

resource "github_repository_file" "generic_template_docs_contributing" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if contains(["backstage-template-system", "backstage-template-domain"], key)
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/docs/contributing.md"
  content             = file("${path.module}/templates/common/docs/contributing.md.tpl")
  commit_message      = "Add generic skeleton contributing documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Dependabot configuration (basic for GitHub Actions)
resource "github_repository_file" "generic_template_dependabot" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if contains(["backstage-template-system", "backstage-template-domain"], key)
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
