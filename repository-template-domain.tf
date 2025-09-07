# Domain Template Repository Files
# This file contains all file resources specific to the Domain template

# Template catalog-info.yaml (main template file)
resource "github_repository_file" "domain_template_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-domain"
  }

  repository = github_repository.templates[each.key].name
  branch     = "main"
  file       = "catalog-info.yaml"
  content = templatefile("${path.module}/templates/domain/catalog-info.yaml.tpl", {
    github_organization = var.github_organization
  })
  commit_message      = "Add Domain template catalog-info.yaml for Backstage"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton catalog-info.yaml (for generated repositories)
resource "github_repository_file" "domain_template_skeleton_catalog" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-domain"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/catalog-info.yaml"
  content             = file("${path.module}/templates/domain/skeleton/catalog-info.yaml")
  commit_message      = "Add Domain skeleton catalog-info.yaml"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template README.md (main template documentation)
resource "github_repository_file" "domain_template_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-domain"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = file("${path.module}/templates/domain/README.md")
  commit_message      = "Add Domain template documentation"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton README.md (for generated repositories)
resource "github_repository_file" "domain_template_skeleton_readme" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-domain"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/README.md"
  content             = file("${path.module}/templates/domain/skeleton/README.md")
  commit_message      = "Add Domain skeleton README"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Skeleton .gitignore
resource "github_repository_file" "domain_template_skeleton_gitignore" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-domain"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "skeleton/.gitignore"
  content             = file("${path.module}/templates/domain/skeleton/.gitignore")
  commit_message      = "Add Domain skeleton .gitignore"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template documentation - main index
resource "github_repository_file" "domain_docs_index" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-domain"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "docs/index.md"
  content             = file("${path.module}/templates/domain/docs/index.md")
  commit_message      = "Add Domain template documentation index"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template documentation - usage guide
resource "github_repository_file" "domain_docs_usage" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-domain"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "docs/template-usage.md"
  content             = file("${path.module}/templates/domain/docs/template-usage.md")
  commit_message      = "Add Domain template usage guide"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template mkdocs.yml configuration
resource "github_repository_file" "domain_mkdocs" {
  for_each = {
    for key, value in var.template_repositories : key => value
    if key == "backstage-template-domain"
  }

  repository          = github_repository.templates[each.key].name
  branch              = "main"
  file                = "mkdocs.yml"
  content             = file("${path.module}/templates/domain/mkdocs.yml")
  commit_message      = "Add Domain template mkdocs configuration"
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
