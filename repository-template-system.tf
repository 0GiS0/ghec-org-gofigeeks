# System Template Repository Files
# This file contains all file resources specific to the System template

# Template catalog-info.yaml (main template file)
resource "github_repository_file" "system_template_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-system"
  }

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "catalog-info.yaml"
  content = templatefile("${path.module}/templates/system/catalog-info.yaml.tpl", {
    github_organization = var.github_organization
  })
  commit_message      = "Add System template catalog-info.yaml for Backstage"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton catalog-info.yaml (for generated repositories)
resource "github_repository_file" "system_template_skeleton_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-system"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/catalog-info.yaml"
  content             = file("${path.module}/templates/system/skeleton/catalog-info.yaml")
  commit_message      = "Add System skeleton catalog-info.yaml"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template README.md (main template documentation)
resource "github_repository_file" "system_template_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-system"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = file("${path.module}/templates/system/README.md")
  commit_message      = "Add System template documentation"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton README.md (for generated repositories)
resource "github_repository_file" "system_template_skeleton_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-system"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/system/skeleton/README.md")
  commit_message      = "Add System skeleton README"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton .gitignore
resource "github_repository_file" "system_template_skeleton_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-system"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/system/skeleton/.gitignore")
  commit_message      = "Add System skeleton .gitignore"
  commit_author       = "Terraform"
  commit_email        = "terraform@${var.github_organization}.com"
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
